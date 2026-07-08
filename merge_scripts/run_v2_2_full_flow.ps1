$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }
Set-Location $MainRepo

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v2.2 Full Flow" -ForegroundColor Cyan
Write-Host " Interactive Reports Cockpit + Roadmap to v3.0" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/10" "Preflight"
.\merge_scripts\preflight_check.ps1

Step "2/10" "Merge v2.2 assets"
.\merge_scripts\merge_v2_2.ps1

Step "3/10" "Validate repo"
.\merge_scripts\validate_repo.ps1

Step "4/10" "Generate base reports"
.\merge_scripts\generate_workbench_reports_v2_0.ps1
.\merge_scripts\generate_graph_report_v1_9.ps1
.\merge_scripts\generate_family_continuity_report_v1_8.ps1

Step "5/10" "Generate manifest and report index"
.\merge_scripts\generate_report_manifest_v2_1.ps1
.\merge_scripts\generate_report_index_v2_1.ps1

Step "6/10" "Generate roadmap assets"
.\merge_scripts\generate_roadmap_v2_2.ps1

Step "7/10" "Validate Streamlit app upgrade"
.\merge_scripts\validate_streamlit_v2_2.ps1

Step "8/10" "Update Pages and publish Wiki"
.\merge_scripts\update_pages_v2_2.ps1
.\merge_scripts\publish_wiki_v2_2.ps1

Set-Location $MainRepo

Step "9/10" "Publish main repo"
.\merge_scripts\git_publish_main_only_v2_2.ps1

Step "10/10" "Tag release"
.\merge_scripts\tag_release_v2_2.ps1

Write-Host "v2.2 full flow complete. Streamlit Cloud should redeploy from main." -ForegroundColor Green
