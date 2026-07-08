$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }
Set-Location $MainRepo

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v2.1 Full Flow" -ForegroundColor Cyan
Write-Host " Streamlit Workbench Reports Cockpit" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/9" "Preflight"
.\merge_scripts\preflight_check.ps1

Step "2/9" "Merge v2.1"
.\merge_scripts\merge_v2_1.ps1

Step "3/9" "Validate repo"
.\merge_scripts\validate_repo.ps1

Step "4/9" "Generate workbench and graph reports"
.\merge_scripts\generate_workbench_reports_v2_0.ps1
.\merge_scripts\generate_graph_report_v1_9.ps1
.\merge_scripts\generate_family_continuity_report_v1_8.ps1

Step "5/9" "Generate report manifest and index"
.\merge_scripts\generate_report_manifest_v2_1.ps1
.\merge_scripts\generate_report_index_v2_1.ps1

Step "6/9" "Update Pages"
.\merge_scripts\update_pages_v2_1.ps1

Step "7/9" "Publish Wiki"
.\merge_scripts\publish_wiki_v2_1.ps1

Set-Location $MainRepo

Step "8/9" "Publish main repo"
.\merge_scripts\git_publish_main_only_v2_1.ps1

Step "9/9" "Tag release"
.\merge_scripts\tag_release_v2_1.ps1

Write-Host "v2.1 full flow complete." -ForegroundColor Green
