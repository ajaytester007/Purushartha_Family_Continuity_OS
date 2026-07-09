$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v3.1 consultancy workbench ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
$content = Get-Content $app -Raw
if ($content -notmatch "Relationship Consultancy") { throw "Relationship Consultancy tab not found." }
if ($content -notmatch "Correspondence Analyzer") { throw "Correspondence Analyzer not found." }
if ($content -notmatch "analyze_correspondence_v31") { throw "Analyzer function not found." }
Write-Host "Streamlit v3.1 consultancy workbench validated." -ForegroundColor Green
