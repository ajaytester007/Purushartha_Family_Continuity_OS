$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }
Set-Location $MainRepo
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v3.1 Full Flow" -ForegroundColor Cyan
Write-Host " Relationship Consultancy Workbench" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Step "1/8" "Preflight"; .\merge_scripts\preflight_check.ps1
Step "2/8" "Merge v3.1 assets"; .\merge_scripts\merge_v3_1.ps1
Step "3/8" "Patch and validate Streamlit"; .\merge_scripts\patch_streamlit_consultancy_v3_1.ps1; .\merge_scripts\validate_streamlit_v3_1.ps1
Step "4/8" "Validate repo"; .\merge_scripts\validate_repo.ps1
Step "5/8" "Update Pages"; .\merge_scripts\update_pages_v3_1.ps1
Step "6/8" "Publish Wiki"; .\merge_scripts\publish_wiki_v3_1.ps1
Set-Location $MainRepo
Step "7/8" "Publish main repo"; .\merge_scripts\git_publish_main_only_v3_1.ps1
Step "8/8" "Tag release"; .\merge_scripts\tag_release_v3_1.ps1
Write-Host "v3.1 full flow complete. Streamlit Cloud should redeploy from main." -ForegroundColor Green
