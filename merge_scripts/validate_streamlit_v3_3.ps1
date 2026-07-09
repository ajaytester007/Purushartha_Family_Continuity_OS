$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v3.3 persistent logs ==" -ForegroundColor Cyan

$app = "51_Streamlit_MVP\app.py"
$content = Get-Content $app -Raw

if ($content -notmatch "DAILY_LOG_PATH") { throw "DAILY_LOG_PATH not found." }
if ($content -notmatch "GRIEVANCE_REPORTS_PATH") { throw "GRIEVANCE_REPORTS_PATH not found." }
if ($content -notmatch "Relationship Trend Dashboard") { throw "Relationship Trend Dashboard not found." }
if ($content -notmatch "Save Daily Companion Log") { throw "Daily log save button not found." }

python .\merge_scripts\validate_no_duplicate_streamlit_keys_v3_3.py

Write-Host "Streamlit v3.3 persistent logs validated." -ForegroundColor Green
