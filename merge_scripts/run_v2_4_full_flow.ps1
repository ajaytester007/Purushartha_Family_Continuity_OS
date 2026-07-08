$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }
Set-Location $MainRepo

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v2.4 Full Flow" -ForegroundColor Cyan
Write-Host " Consent Ledger UI and Evidence Governance" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/8" "Preflight"
.\merge_scripts\preflight_check.ps1
Step "2/8" "Merge v2.4 assets"
.\merge_scripts\merge_v2_4.ps1
Step "3/8" "Validate repo and Streamlit"
.\merge_scripts\validate_repo.ps1
.\merge_scripts\validate_streamlit_v2_4.ps1
Step "4/8" "Generate report assets"
.\merge_scripts\generate_report_manifest_v2_1.ps1
.\merge_scripts\generate_report_index_v2_1.ps1
Step "5/8" "Update Pages"
.\merge_scripts\update_pages_v2_4.ps1
Step "6/8" "Publish Wiki"
.\merge_scripts\publish_wiki_v2_4.ps1
Set-Location $MainRepo
Step "7/8" "Publish main repo"
.\merge_scripts\git_publish_main_only_v2_4.ps1
Step "8/8" "Tag release"
.\merge_scripts\tag_release_v2_4.ps1
Write-Host "v2.4 full flow complete. Streamlit Cloud should redeploy from main." -ForegroundColor Green
