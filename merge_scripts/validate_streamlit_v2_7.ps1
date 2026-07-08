$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v2.7 private mode ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
$content = Get-Content $app -Raw
if ($content -notmatch "Workbench Mode") { throw "Workbench Mode control not found." }
if ($content -notmatch "Private Local") { throw "Private Local mode not found." }
if ($content -notmatch "Public Demo") { throw "Public Demo mode not found." }
Write-Host "Streamlit v2.7 private mode validated." -ForegroundColor Green
