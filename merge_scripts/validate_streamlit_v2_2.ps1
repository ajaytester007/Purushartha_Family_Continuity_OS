$ErrorActionPreference = "Stop"

Write-Host "== Validating Streamlit v2.2 upgrade ==" -ForegroundColor Cyan

$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }

$content = Get-Content $app -Raw
if ($content -notmatch "Reports Cockpit") { throw "Streamlit app does not contain Reports Cockpit tab." }
if ($content -notmatch "Roadmap to v3.0") { throw "Streamlit app does not contain Roadmap to v3.0 tab." }
if (-not (Test-Path "88_Roadmap_v3\roadmap_to_v3.csv")) { throw "Missing roadmap CSV." }

Write-Host "Streamlit v2.2 upgrade validated." -ForegroundColor Green
