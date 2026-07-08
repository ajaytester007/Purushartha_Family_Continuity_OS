$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"

function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }

Set-Location $MainRepo

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v1.7 Full Flow" -ForegroundColor Cyan
Write-Host " GitHub Pages public experience layer" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/9" "Preflight"
.\merge_scripts\preflight_check.ps1

Step "2/9" "Merge v1.7"
.\merge_scripts\merge_v1_7.ps1

Step "3/9" "Validate repo"
.\merge_scripts\validate_repo.ps1

Step "4/9" "Generate maps and dashboards"
.\merge_scripts\generate_mermaid_maps.ps1
.\merge_scripts\generate_dashboard_outputs.ps1

Step "5/9" "Validate GitHub Pages files"
.\merge_scripts\validate_pages_v1_7.ps1

Step "6/9" "Publish Wiki"
.\merge_scripts\publish_wiki_v1_7.ps1

Set-Location $MainRepo

Step "7/9" "Publish main repo"
.\merge_scripts\git_publish_main_only_v1_7.ps1

Step "8/9" "Tag release"
.\merge_scripts\tag_release_v1_7.ps1

Step "9/9" "Show next steps"
.\merge_scripts\show_pages_next_steps_v1_7.ps1

Write-Host "v1.7 full flow complete." -ForegroundColor Green
