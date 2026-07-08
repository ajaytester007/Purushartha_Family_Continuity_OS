$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }
Set-Location $MainRepo

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v1.8 Full Flow" -ForegroundColor Cyan
Write-Host " Pages branch deployment + app UX/state upgrade" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/9" "Preflight"
.\merge_scripts\preflight_check.ps1

Step "2/9" "Merge v1.8"
.\merge_scripts\merge_v1_8.ps1

Step "3/9" "Disable Pages Actions workflow"
.\merge_scripts\disable_pages_actions_v1_8.ps1

Step "4/9" "Validate repo and Pages branch assets"
.\merge_scripts\validate_repo.ps1
.\merge_scripts\validate_pages_branch_v1_8.ps1

Step "5/9" "Generate case outputs"
.\merge_scripts\run_tollgate_simulator.ps1
.\merge_scripts\generate_repair_plans.ps1

Step "6/9" "Generate state, maps, dashboards, reports"
.\merge_scripts\seed_scd2_state_v1_8.ps1
.\merge_scripts\generate_mermaid_maps.ps1
.\merge_scripts\generate_dashboard_outputs.ps1
.\merge_scripts\generate_family_continuity_report_v1_8.ps1

Step "7/9" "Publish Wiki"
.\merge_scripts\publish_wiki_v1_8.ps1

Set-Location $MainRepo

Step "8/9" "Publish main repo"
.\merge_scripts\git_publish_main_only_v1_8.ps1

Step "9/9" "Tag release"
.\merge_scripts\tag_release_v1_8.ps1

Write-Host "v1.8 full flow complete." -ForegroundColor Green
Write-Host "GitHub Pages setting: Source = Deploy from a branch, Branch = main, Folder = /docs." -ForegroundColor Yellow
