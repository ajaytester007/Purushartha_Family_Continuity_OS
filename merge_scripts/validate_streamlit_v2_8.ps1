$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v2.8 public demo lock ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }
$content = Get-Content $app -Raw
if ($content -notmatch "PUBLIC_DEMO_LOCKED") { throw "PUBLIC_DEMO_LOCKED not found." }
if ($content -notmatch "PURUSHARTHA_DEPLOYMENT_MODE") { throw "Deployment mode env var not found." }
if ($content -notmatch "PUBLIC DEMO LOCK ACTIVE") { throw "Public demo lock banner not found." }
Write-Host "Streamlit v2.8 public demo lock validated." -ForegroundColor Green
