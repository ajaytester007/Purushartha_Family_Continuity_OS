$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo

Write-Host "== Launching Purushartha OS Local App ==" -ForegroundColor Cyan

if (-not (Test-Path ".\26_Local_App\app.py")) {
    throw "Local app not found. Run v1.3 or later merge first."
}

try {
    python --version | Out-Host
} catch {
    throw "Python not found on PATH."
}

if (-not (Test-Path ".\.venv")) {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv .venv
}

.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install streamlit pandas
streamlit run .\26_Local_App\app.py
