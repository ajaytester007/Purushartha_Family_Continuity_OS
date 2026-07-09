$ErrorActionPreference = "Stop"
Set-Location "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
git tag -f v3.5
git push origin v3.5 --force
Write-Host "Release tag v3.5 pushed." -ForegroundColor Green
