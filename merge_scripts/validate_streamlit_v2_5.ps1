$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v2.5 graph explorer ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }
$content = Get-Content $app -Raw
if ($content -notmatch "Graph Explorer") { throw "Graph Explorer tab not found in app." }
if ($content -notmatch "Risk-to-Repair Paths") { throw "Risk-to-Repair path view not found in app." }
if ($content -notmatch "Download Mermaid Graph") { throw "Mermaid download not found in app." }
Write-Host "Streamlit v2.5 graph explorer validated." -ForegroundColor Green
