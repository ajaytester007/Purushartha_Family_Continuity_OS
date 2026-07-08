$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v2.4 consent UI ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }
$content = Get-Content $app -Raw
if ($content -notmatch "Consent Ledger") { throw "Consent Ledger tab not found in app." }
if ($content -notmatch "data_editor") { throw "Editable consent table not found in app." }
if ($content -notmatch "Evidence Registry") { throw "Evidence Registry display not found in app." }
Write-Host "Streamlit v2.4 consent UI validated." -ForegroundColor Green
