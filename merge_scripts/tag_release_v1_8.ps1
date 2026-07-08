$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo
git tag -f v1.8
git push origin v1.8 --force
Write-Host "Release tag v1.8 pushed." -ForegroundColor Green
