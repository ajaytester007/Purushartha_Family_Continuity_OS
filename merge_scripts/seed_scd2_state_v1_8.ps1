$ErrorActionPreference = "Stop"
Write-Host "== Seeding SCD2 state outputs ==" -ForegroundColor Cyan
if (-not (Test-Path "62_SCD2_State\relationship_state_seed.csv")) { throw "Missing SCD2 seed CSV." }
Copy-Item "62_SCD2_State\relationship_state_seed.csv" "29_Dashboard_Outputs\relationship_state_seed.csv" -Force
Write-Host "SCD2 seed copied to dashboard outputs." -ForegroundColor Green
