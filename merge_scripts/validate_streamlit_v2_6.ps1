$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v2.6 SCD2 State Editor ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }
$content = Get-Content $app -Raw
if ($content -notmatch "SCD2 State Editor") { throw "SCD2 State Editor tab not found." }
if ($content -notmatch "Close Current and Create New State") { throw "State transition submit button not found." }
if ($content -notmatch "State Transition Audit") { throw "State transition audit not found." }
Write-Host "Streamlit v2.6 SCD2 State Editor validated." -ForegroundColor Green
