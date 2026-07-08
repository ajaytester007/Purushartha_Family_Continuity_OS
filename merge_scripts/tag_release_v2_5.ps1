$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo
git tag -f v2.5
git push origin v2.5 --force
Write-Host "Release tag v2.5 pushed." -ForegroundColor Green
