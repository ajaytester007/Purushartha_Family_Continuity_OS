$ErrorActionPreference = "Stop"
Write-Host "== Patching Streamlit app for v2.9 Scenario Simulator ==" -ForegroundColor Cyan

$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }
$content = Get-Content $app -Raw

if ($content -notmatch "SCENARIO_PATH") {
    $needle = 'GRAPH_EDGES = ROOT / "68_Event_Graph_Engine" / "event_graph_edges.csv"'
    $add = @'
GRAPH_EDGES = ROOT / "68_Event_Graph_Engine" / "event_graph_edges.csv"
SCENARIO_PATH = ROOT / "122_Scenario_Simulator" / "scenario_seed.csv"
SCENARIO_REPORT_PATH = ROOT / "124_Scenario_Reports" / "scenario_comparison_report_v2_9.md"
'@
    $content = $content.Replace($needle, $add)
}

if ($content -notmatch '"Scenario Simulator"') {
    $content = $content.Replace('"Consent Ledger"', '"Scenario Simulator",' + "`n" + '    "Consent Ledger"')
}

if ($content -notmatch "Scenario Comparison") {
    $append = @'

with tabs[-2]:
    st.header("Scenario Simulator")
    scenarios = load_csv(SCENARIO_PATH)
    if scenarios.empty:
        st.warning("Scenario seed not found. Run v2.9 full flow.")
    else:
        st.subheader("Scenario Comparison")
        st.dataframe(scenarios, use_container_width=True)
        path = st.selectbox("Select path", scenarios["path"])
        row = scenarios[scenarios["path"] == path].iloc[0]
        c1, c2, c3, c4 = st.columns(4)
        c1.metric("Health Delta", row["relationship_health_delta"])
        c2.metric("Burden Delta", row["burden_skew_delta"])
        c3.metric("Continuity", row["continuity_score"])
        c4.metric("Risk", row["risk_score"])
        st.info(row["recommendation"])
        st.subheader("Tradeoff Chart")
        chart = scenarios[["path","continuity_score","risk_score","repair_effort"]].set_index("path")
        st.bar_chart(chart)
        if SCENARIO_REPORT_PATH.exists():
            report = SCENARIO_REPORT_PATH.read_text(encoding="utf-8")
            st.subheader("Scenario Report")
            st.markdown(report)
            st.download_button("Download Scenario Report", report, "scenario_comparison_report_v2_9.md", "text/markdown")
        st.warning("Scenario simulation is decision support only. Safety and professional review override optimization.")
'@
    $content = $content + "`n" + $append
}

$content | Set-Content -Encoding UTF8 $app
Write-Host "Streamlit Scenario Simulator patch complete." -ForegroundColor Green
