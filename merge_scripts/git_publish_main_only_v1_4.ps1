$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo

Write-Host "== Publishing main repository v1.4 ==" -ForegroundColor Cyan

Get-ChildItem -Path $MainRepo -Filter "*Merge_Pack*.zip" -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "Removing ZIP before commit: $($_.Name)" -ForegroundColor Yellow
    Remove-Item $_.FullName -Force
}

Get-ChildItem -Path $MainRepo -Directory -Filter "_merge_temp*" -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "Removing temp folder before commit: $($_.Name)" -ForegroundColor Yellow
    Remove-Item $_.FullName -Recurse -Force
}

git status | Out-Host
git add -A

git commit -m "Add v1.4 operator automation and flow stabilization"
if ($LASTEXITCODE -ne 0) {
    Write-Host "No main repo changes to commit." -ForegroundColor Yellow
}

git push | Out-Host
Write-Host "Main repo publish complete." -ForegroundColor Green
