$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }
Set-Location $MainRepo

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v2.0 Full Flow" -ForegroundColor Cyan
Write-Host " Local Relationship Intelligence Workbench" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/10" "Preflight"
.\merge_scripts\preflight_check.ps1

Step "2/10" "Merge v2.0"
.\merge_scripts\merge_v2_0.ps1

Step "3/10" "Validate repo"
.\merge_scripts\validate_repo.ps1

Step "4/10" "Validate event graph"
.\merge_scripts\validate_event_graph_v1_9.ps1

Step "5/10" "Generate graph and state outputs"
.\merge_scripts\generate_event_graph_v1_9.ps1
.\merge_scripts\run_scd2_state_update_v1_9.ps1

Step "6/10" "Generate v2.0 workbench reports"
.\merge_scripts\generate_workbench_reports_v2_0.ps1

Step "7/10" "Generate dashboard and Pages updates"
.\merge_scripts\generate_dashboard_outputs.ps1
.\merge_scripts\update_pages_v2_0.ps1

Step "8/10" "Publish Wiki"
.\merge_scripts\publish_wiki_v2_0.ps1

Set-Location $MainRepo

Step "9/10" "Publish main repo"
.\merge_scripts\git_publish_main_only_v2_0.ps1

Step "10/10" "Tag release"
.\merge_scripts\tag_release_v2_0.ps1

Write-Host "v2.0 full flow complete." -ForegroundColor Green
