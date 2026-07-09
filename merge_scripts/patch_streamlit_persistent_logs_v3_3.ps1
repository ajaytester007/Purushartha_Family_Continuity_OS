$ErrorActionPreference = "Stop"
Write-Host "== Patching Streamlit app for v3.3 persistent logs ==" -ForegroundColor Cyan

$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }

$content = Get-Content $app -Raw

if ($content -notmatch "DAILY_LOG_PATH") {
    $needle = 'GENERATED_REPORT_DIR = ROOT / "92_Generated_Reports"'
    $add = @'
GENERATED_REPORT_DIR = ROOT / "92_Generated_Reports"
DAILY_LOG_PATH = ROOT / "150_Daily_Log_Persistence" / "daily_logs.csv"
GRIEVANCE_REPORTS_PATH = ROOT / "151_Grievance_Report_Persistence" / "grievance_reports.csv"
'@
    $content = $content.Replace($needle, $add)
}

if ($content -notmatch "def append_csv_row_v33") {
$helper = @'

def append_csv_row_v33(path, row):
    path.parent.mkdir(parents=True, exist_ok=True)
    existing = load_csv(path)
    new_df = pd.DataFrame([row])
    combined = pd.concat([existing, new_df], ignore_index=True) if not existing.empty else new_df
    combined.to_csv(path, index=False)
    return combined
'@
    $content = $content + "`n" + $helper
}

if ($content -notmatch '"Relationship Trends"') {
    $content = $content.Replace('"Grievance Report"', '"Grievance Report",' + "`n" + '    "Relationship Trends"')
}

if ($content -notmatch "Save Daily Companion Log") {
    $needle = 'st.subheader("Memory / Vlog Prompt")'
    $insert = @'
        if st.button("Save Daily Companion Log", key="save_daily_companion_log_v33"):
            append_csv_row_v33(DAILY_LOG_PATH, {
                "log_id": f"DL{datetime.utcnow().strftime('%Y%m%d%H%M%S')}",
                "created_at": datetime.utcnow().isoformat(),
                "mood": mood,
                "relationship_energy": energy,
                "partner_effort": partner_effort,
                "self_effort": self_effort,
                "unresolved": unresolved,
                "special_encounter": special_encounter,
                "gratitude_note": gratitude_text,
                "concern_note": concern_text,
                "daily_nudge": nudge
            })
            st.success("Daily companion log saved.")
        st.subheader("Memory / Vlog Prompt")
'@
    $content = $content.Replace($needle, $insert)
}

if ($content -notmatch "Save Grievance Report Index") {
    $needle = 'st.download_button("Download Grievance Report", report, "relationship_grievance_report.md", "text/markdown")'
    $insert = @'
        st.download_button("Download Grievance Report", report, "relationship_grievance_report.md", "text/markdown")
        if st.button("Save Grievance Report Index", key="save_grievance_report_index_v33"):
            append_csv_row_v33(GRIEVANCE_REPORTS_PATH, {
                "report_id": f"GR{datetime.utcnow().strftime('%Y%m%d%H%M%S')}",
                "created_at": datetime.utcnow().isoformat(),
                "summary": summary,
                "fidelity_score": fidelity,
                "prospect_score": prospect,
                "recommended_action": action,
                "retest_days": 14 if prospect >= 55 else 7,
                "report_path": "generated_in_app"
            })
            st.success("Grievance report index saved.")
'@
    $content = $content.Replace($needle, $insert)
}

if ($content -notmatch "Relationship Trend Dashboard") {
$append = @'

with tabs[2]:
    st.header("📈 Relationship Trend Dashboard")
    st.caption("Review saved daily logs and grievance report trends.")

    daily_logs = load_csv(DAILY_LOG_PATH)
    grievance_logs = load_csv(GRIEVANCE_REPORTS_PATH)

    st.subheader("Daily Logs")
    if daily_logs.empty:
        st.info("No daily logs saved yet.")
    else:
        st.dataframe(daily_logs, width="stretch")
        if "created_at" in daily_logs.columns and "relationship_energy" in daily_logs.columns:
            chart_df = daily_logs.copy()
            chart_df["created_at"] = pd.to_datetime(chart_df["created_at"], errors="coerce")
            chart_df["relationship_energy"] = pd.to_numeric(chart_df["relationship_energy"], errors="coerce")
            chart_df = chart_df.dropna(subset=["created_at", "relationship_energy"])
            if not chart_df.empty:
                st.line_chart(chart_df.set_index("created_at")[["relationship_energy"]])
        st.download_button("Download Daily Logs CSV", daily_logs.to_csv(index=False), "daily_logs.csv", "text/csv")

    st.subheader("Grievance Reports")
    if grievance_logs.empty:
        st.info("No grievance report indexes saved yet.")
    else:
        st.dataframe(grievance_logs, width="stretch")
        if "fidelity_score" in grievance_logs.columns and "prospect_score" in grievance_logs.columns:
            score_df = grievance_logs[["report_id","fidelity_score","prospect_score"]].copy()
            score_df["fidelity_score"] = pd.to_numeric(score_df["fidelity_score"], errors="coerce")
            score_df["prospect_score"] = pd.to_numeric(score_df["prospect_score"], errors="coerce")
            st.bar_chart(score_df.set_index("report_id"))
        st.download_button("Download Grievance Reports CSV", grievance_logs.to_csv(index=False), "grievance_reports.csv", "text/csv")

    st.warning("Public deployment should use synthetic/sanitized logs only. Use private local mode for real personal records.")
'@
    $content = $content + "`n" + $append
}

$content | Set-Content -Encoding UTF8 $app
Write-Host "Streamlit v3.3 persistent logs patch complete." -ForegroundColor Green
