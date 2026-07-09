$ErrorActionPreference = "Stop"
Set-Location "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
git tag -f v4.0
git push origin v4.0 --force
Write-Host "Release tag v4.0 pushed." -ForegroundColor Green
