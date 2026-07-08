$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo

Write-Host "== Publishing main repository only ==" -ForegroundColor Cyan

# Prevent package zips from being accidentally committed
Get-ChildItem -Path $MainRepo -Filter "*Merge_Pack*.zip" -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "Removing merge pack zip before commit: $($_.Name)" -ForegroundColor Yellow
    Remove-Item $_.FullName -Force
}

git status | Out-Host
git add -A

git commit -m "Add v1.3 local intelligence foundation"
if ($LASTEXITCODE -ne 0) {
    Write-Host "No main repo changes to commit." -ForegroundColor Yellow
}

git push | Out-Host
Write-Host "Main repo publish complete." -ForegroundColor Green
