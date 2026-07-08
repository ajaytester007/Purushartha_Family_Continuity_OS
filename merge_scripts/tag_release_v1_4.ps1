$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo

Write-Host "== Tagging release v1.4 ==" -ForegroundColor Cyan

git tag -f v1.4
git push origin v1.4 --force

Write-Host "Release tag v1.4 pushed." -ForegroundColor Green
