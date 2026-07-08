$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo
Get-ChildItem -Path $MainRepo -Filter "*Merge_Pack*.zip" -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem -Path $MainRepo -Directory -Filter "_merge_temp*" -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force
git status | Out-Host
git add -A
git commit -m "Add v2.7 private local mode and public demo lock"
if ($LASTEXITCODE -ne 0) { Write-Host "No main repo changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Write-Host "Main repo publish complete." -ForegroundColor Green
