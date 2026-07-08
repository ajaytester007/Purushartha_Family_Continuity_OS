$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
Set-Location $MainRepo
function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v1.6 Full Flow" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/10" "Preflight"
.\merge_scripts\preflight_check.ps1
Step "2/10" "Merge v1.6"
.\merge_scripts\merge_v1_6.ps1
Step "3/10" "Validate repo"
.\merge_scripts\validate_repo.ps1
Step "4/10" "Validate cases"
.\merge_scripts\validate_case_engine.ps1
Step "5/10" "Simulator and repair plans"
.\merge_scripts\run_tollgate_simulator.ps1
.\merge_scripts\generate_repair_plans.ps1
Step "6/10" "Initialize SQLite"
.\merge_scripts\init_sqlite_mvp.ps1
Step "7/10" "Maps and dashboards"
.\merge_scripts\generate_mermaid_maps.ps1
.\merge_scripts\generate_dashboard_outputs.ps1
Step "8/10" "Publish Wiki"
.\merge_scripts\publish_wiki_v1_6.ps1
Set-Location $MainRepo
Step "9/10" "Publish main repo"
.\merge_scripts\git_publish_main_only_v1_6.ps1
Step "10/10" "Tag release"
.\merge_scripts\tag_release_v1_6.ps1
Write-Host "v1.6 full flow complete. Launch app with .\merge_scripts\launch_streamlit_mvp.ps1" -ForegroundColor Green
