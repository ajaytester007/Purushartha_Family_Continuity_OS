$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo

Write-Host "== Tagging release v1.5 ==" -ForegroundColor Cyan
git tag -f v1.5
git push origin v1.5 --force
Write-Host "Release tag v1.5 pushed." -ForegroundColor Green
