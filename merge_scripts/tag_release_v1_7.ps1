$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo
git tag -f v1.7
git push origin v1.7 --force
Write-Host "Release tag v1.7 pushed." -ForegroundColor Green
