$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }
Set-Location $MainRepo

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v3.0 Full Flow" -ForegroundColor Cyan
Write-Host " Family Continuity Intelligence Suite" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/9" "Preflight"
.\merge_scripts\preflight_check.ps1
Step "2/9" "Merge v3.0 assets"
.\merge_scripts\merge_v3_0.ps1
Step "3/9" "Generate v3.0 release summary"
.\merge_scripts\generate_v3_0_release_summary.ps1
Step "4/9" "Patch and validate Streamlit"
.\merge_scripts\patch_streamlit_v3_0_dashboard.ps1
.\merge_scripts\validate_streamlit_v3_0.ps1
Step "5/9" "Validate repo and update Pages"
.\merge_scripts\validate_repo.ps1
.\merge_scripts\update_pages_v3_0.ps1
Step "6/9" "Publish Wiki"
.\merge_scripts\publish_wiki_v3_0.ps1
Set-Location $MainRepo
Step "7/9" "Publish main repo"
.\merge_scripts\git_publish_main_only_v3_0.ps1
Step "8/9" "Tag release"
.\merge_scripts\tag_release_v3_0.ps1
Step "9/9" "Complete"
Write-Host "v3.0 full flow complete. Streamlit Cloud should redeploy from main." -ForegroundColor Green
