$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v2.3 report builder ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }
$content = Get-Content $app -Raw
if ($content -notmatch "Interactive Report Builder") { throw "Report Builder tab not found in app." }
if ($content -notmatch "Generate Report") { throw "Generate Report button not found in app." }
if ($content -notmatch "92_Generated_Reports") { throw "Generated reports folder reference not found in app." }
Write-Host "Streamlit v2.3 report builder validated." -ForegroundColor Green
