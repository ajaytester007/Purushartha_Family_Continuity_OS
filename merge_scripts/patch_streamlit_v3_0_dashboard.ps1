$ErrorActionPreference = "Stop"
Write-Host "== Patching Streamlit dashboard for v3.0 ==" -ForegroundColor Cyan

$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }

$content = Get-Content $app -Raw

if ($content -notmatch "V3_CAPABILITY_MATRIX") {
    $needle = 'SCENARIO_REPORT_PATH = ROOT / "124_Scenario_Reports" / "scenario_comparison_report_v2_9.md"'
    $add = @'
SCENARIO_REPORT_PATH = ROOT / "124_Scenario_Reports" / "scenario_comparison_report_v2_9.md"
V3_CAPABILITY_MATRIX = ROOT / "130_Capability_Matrix" / "v3_0_capability_matrix.csv"
V3_RELEASE_SUMMARY = ROOT / "129_Release_Dashboard" / "v3_0_release_summary.md"
'@
    $content = $content.Replace($needle, $add)
}

if ($content -notmatch '"v3.0 Suite"') {
    $content = $content.Replace('"Dashboard"', '"v3.0 Suite",' + "`n" + '    "Dashboard"')
}

if ($content -notmatch "Family Continuity Intelligence Suite Milestone") {
    $append = @'

with tabs[0]:
    st.header("v3.0 Family Continuity Intelligence Suite Milestone")
    st.success("v3.0 integrates knowledgebase, cases, reports, consent governance, graph, SCD2 state, scenario simulation, public demo lock, and private local mode.")
    matrix = load_csv(V3_CAPABILITY_MATRIX)
    if not matrix.empty:
        st.subheader("Capability Matrix")
        st.dataframe(matrix, use_container_width=True)
        st.bar_chart(matrix.groupby("status").size())
    if V3_RELEASE_SUMMARY.exists():
        st.subheader("Release Summary")
        st.markdown(V3_RELEASE_SUMMARY.read_text(encoding="utf-8"))
'@
    $content = $content + "`n" + $append
}

$content | Set-Content -Encoding UTF8 $app
Write-Host "Streamlit v3.0 dashboard patch complete." -ForegroundColor Green
