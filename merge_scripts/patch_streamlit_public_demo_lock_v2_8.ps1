$ErrorActionPreference = "Stop"
Write-Host "== Patching Streamlit app for v2.8 public demo lock ==" -ForegroundColor Cyan

$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }

$content = Get-Content $app -Raw

if ($content -notmatch "PURUSHARTHA_DEPLOYMENT_MODE") {
    if ($content -notmatch "import os") {
        $content = $content.Replace("import streamlit as st", "import streamlit as st`nimport os")
    }

    $needle = 'st.set_page_config(page_title="Purushartha OS Workbench", layout="wide")'
    $add = @'
st.set_page_config(page_title="Purushartha OS Workbench", layout="wide")

DEPLOYMENT_MODE = os.environ.get("PURUSHARTHA_DEPLOYMENT_MODE", "public_demo").lower()
ALLOW_PRIVATE_MODE = os.environ.get("PURUSHARTHA_ALLOW_PRIVATE_MODE", "false").lower() == "true"
PUBLIC_DEMO_LOCKED = DEPLOYMENT_MODE != "private_local" or not ALLOW_PRIVATE_MODE
'@
    $content = $content.Replace($needle, $add)
}

if ($content -notmatch "PUBLIC DEMO LOCK ACTIVE") {
    $needle = 'st.caption("Consent-first relationship, family, resilience, wealth, and legacy intelligence workbench.")'
    $add = @'
st.caption("Consent-first relationship, family, resilience, wealth, and legacy intelligence workbench.")

if PUBLIC_DEMO_LOCKED:
    st.error("PUBLIC DEMO LOCK ACTIVE: Use synthetic or sanitized data only. Do not enter private relationship, health, or third-party information.")
else:
    st.success("PRIVATE LOCAL MODE ENABLED: Keep outputs local unless sanitized and explicitly approved.")
'@
    $content = $content.Replace($needle, $add)
}

if ($content -notmatch "Private Local mode is disabled in public deployment") {
    $needle = 'mode = st.radio("Workbench Mode", ["Public Demo", "Private Local"], index=0)'
    $add = @'
available_modes = ["Public Demo"] if PUBLIC_DEMO_LOCKED else ["Public Demo", "Private Local"]
mode = st.radio("Workbench Mode", available_modes, index=0)
if PUBLIC_DEMO_LOCKED:
    st.warning("Private Local mode is disabled in public deployment.")
'@
    $content = $content.Replace($needle, $add)
}

if ($content -notmatch "Report generation is public-demo locked") {
    $needle = 'if st.button("Generate Report"):'
    $add = @'
if PUBLIC_DEMO_LOCKED:
        st.warning("Report generation is public-demo locked. Output must remain synthetic/sanitized.")
    if st.button("Generate Report"):
'@
    $content = $content.Replace($needle, $add)
}

$content | Set-Content -Encoding UTF8 $app
Write-Host "Streamlit public demo lock patch complete." -ForegroundColor Green
