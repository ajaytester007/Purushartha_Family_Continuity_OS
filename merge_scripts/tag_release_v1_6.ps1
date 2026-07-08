$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo
git tag -f v1.6
git push origin v1.6 --force
Write-Host "Release tag v1.6 pushed." -ForegroundColor Green
