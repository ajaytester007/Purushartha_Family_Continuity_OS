$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo
git tag -f v3.0
git push origin v3.0 --force
Write-Host "Release tag v3.0 pushed." -ForegroundColor Green
