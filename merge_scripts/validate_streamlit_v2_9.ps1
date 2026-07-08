$ErrorActionPreference = "Stop"
Write-Host "== Validating Streamlit v2.9 Scenario Simulator ==" -ForegroundColor Cyan
$app = "51_Streamlit_MVP\app.py"
$content = Get-Content $app -Raw
if ($content -notmatch "Scenario Simulator") { throw "Scenario Simulator not found." }
if ($content -notmatch "SCENARIO_PATH") { throw "SCENARIO_PATH not found." }
if ($content -notmatch "Scenario Comparison") { throw "Scenario Comparison not found." }
Write-Host "Streamlit v2.9 Scenario Simulator validated." -ForegroundColor Green
