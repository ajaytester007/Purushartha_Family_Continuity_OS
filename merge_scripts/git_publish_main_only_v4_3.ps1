Set-Location "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Get-ChildItem -Filter "*Merge_Pack*.zip" -ErrorAction SilentlyContinue|Remove-Item -Force
Get-ChildItem -Directory -Filter "_merge_temp*" -ErrorAction SilentlyContinue|Remove-Item -Recurse -Force
git add -A
git commit -m "Add v4.3 anonymous pilot decisioning and seer lens model"
if($LASTEXITCODE -ne 0){Write-Host "No main repo changes to commit."}
git push|Out-Host
