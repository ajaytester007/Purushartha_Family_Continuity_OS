$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v3.2 daily companion ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
$content = Get-Content $app -Raw
if ($content -notmatch "Daily Companion") { throw "Daily Companion tab not found." }
if ($content -notmatch "Grievance Report") { throw "Grievance Report tab not found." }
if ($content -notmatch "score_daily_companion_v32") { throw "Daily companion scorer not found." }
if ($content -notmatch "build_grievance_report_v32") { throw "Grievance report builder not found." }
Write-Host "Streamlit v3.2 daily companion validated." -ForegroundColor Green
