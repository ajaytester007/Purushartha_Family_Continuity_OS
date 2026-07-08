$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"

function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }

Set-Location $MainRepo

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v1.9 Full Flow" -ForegroundColor Cyan
Write-Host " Event Graph Visualizer + SCD2 State Engine" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/10" "Preflight"
.\merge_scripts\preflight_check.ps1

Step "2/10" "Merge v1.9"
.\merge_scripts\merge_v1_9.ps1

Step "3/10" "Validate repo"
.\merge_scripts\validate_repo.ps1

Step "4/10" "Validate event graph"
.\merge_scripts\validate_event_graph_v1_9.ps1

Step "5/10" "Generate event graph Mermaid"
.\merge_scripts\generate_event_graph_v1_9.ps1

Step "6/10" "Run SCD2 state updater"
.\merge_scripts\run_scd2_state_update_v1_9.ps1

Step "7/10" "Generate graph report and dashboard outputs"
.\merge_scripts\generate_graph_report_v1_9.ps1
.\merge_scripts\generate_dashboard_outputs.ps1

Step "8/10" "Publish Wiki"
.\merge_scripts\publish_wiki_v1_9.ps1

Set-Location $MainRepo

Step "9/10" "Publish main repo"
.\merge_scripts\git_publish_main_only_v1_9.ps1

Step "10/10" "Tag release"
.\merge_scripts\tag_release_v1_9.ps1

Write-Host "v1.9 full flow complete." -ForegroundColor Green
