$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo

Write-Host "== Launching Purushartha OS Streamlit MVP ==" -ForegroundColor Cyan

if (-not (Test-Path ".\51_Streamlit_MVP\app.py")) {
    throw "Streamlit MVP not found. Run v1.6 merge first."
}

python --version | Out-Host

if (-not (Test-Path ".\.venv")) {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv .venv
}

.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install streamlit pandas tabulate
streamlit run .\51_Streamlit_MVP\app.py
