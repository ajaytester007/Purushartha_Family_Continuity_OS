$ErrorActionPreference = "Stop"
Write-Host "== Patching Streamlit app for v2.7 mode controls ==" -ForegroundColor Cyan

$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }

$content = Get-Content $app -Raw

if ($content -notmatch "import os") {
    $content = $content.Replace("import streamlit as st", "import streamlit as st`nimport os")
}

if ($content -notmatch "WORKBENCH_MODE") {
    $needle = "GENERATED_REPORT_DIR = ROOT / `"92_Generated_Reports`""
    $add = @"
GENERATED_REPORT_DIR = ROOT / "92_Generated_Reports"
WORKBENCH_MODE = os.environ.get("PURUSHARTHA_WORKBENCH_MODE", "Public Demo")
PRIVATE_REPORT_DIR = ROOT / "114_Private_Reports"
"@
    $content = $content.Replace($needle, $add)
}

if ($content -notmatch "Workbench Mode") {
    $needle = 'st.warning("Decision support only. Do not use for surveillance, diagnosis, punishment, or publishing private evidence without consent.")'
    $add = @"
st.warning("Decision support only. Do not use for surveillance, diagnosis, punishment, or publishing private evidence without consent.")
st.markdown("---")
mode = st.radio("Workbench Mode", ["Public Demo", "Private Local"], index=0)
st.session_state["workbench_mode"] = mode
if mode == "Public Demo":
    st.success("Public Demo Mode: synthetic/sanitized data only.")
else:
    st.error("Private Local Mode: keep outputs local; do not publish private reports.")
"@
    $content = $content.Replace($needle, $add)
}

if ($content -notmatch "Private mode outputs must not be committed") {
    $needle = 'st.header("Interactive Report Builder")'
    $add = @"
st.header("Interactive Report Builder")
current_mode = st.session_state.get("workbench_mode", "Public Demo")
if current_mode == "Private Local":
    st.error("Private mode outputs must not be committed or published unless sanitized.")
else:
    st.success("Public Demo Mode: generated reports must remain synthetic/sanitized.")
"@
    $content = $content.Replace($needle, $add)
}

$content | Set-Content -Encoding UTF8 $app
Write-Host "Streamlit private mode patch complete." -ForegroundColor Green
