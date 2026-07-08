$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v3.0 suite dashboard ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
$content = Get-Content $app -Raw
if ($content -notmatch "v3.0 Suite") { throw "v3.0 Suite tab not found." }
if ($content -notmatch "V3_CAPABILITY_MATRIX") { throw "V3 capability matrix not found." }
if ($content -notmatch "Family Continuity Intelligence Suite Milestone") { throw "v3.0 suite milestone not found." }
Write-Host "Streamlit v3.0 suite dashboard validated." -ForegroundColor Green
