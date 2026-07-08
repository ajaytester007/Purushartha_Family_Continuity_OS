$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"

function Step($n, $text) {
    Write-Host "`n[$n] $text" -ForegroundColor Cyan
}

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v1.5 Full Flow" -ForegroundColor Cyan
Write-Host " preflight -> merge -> validate -> cases -> maps -> dashboards -> wiki -> main push -> tag" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Set-Location $MainRepo

Step "1/10" "Running preflight checks"
.\merge_scripts\preflight_check.ps1

Step "2/10" "Merging v1.5 assets"
.\merge_scripts\merge_v1_5.ps1

Step "3/10" "Validating repository"
.\merge_scripts\validate_repo.ps1

Step "4/10" "Validating case engine assets"
.\merge_scripts\validate_case_engine.ps1

Step "5/10" "Running tollgate simulator"
.\merge_scripts\run_tollgate_simulator.ps1

Step "6/10" "Generating repair plans"
.\merge_scripts\generate_repair_plans.ps1

Step "7/10" "Generating Mermaid maps"
.\merge_scripts\generate_mermaid_maps.ps1

Step "8/10" "Generating dashboard outputs"
.\merge_scripts\generate_dashboard_outputs.ps1

Step "9/10" "Publishing Wiki"
.\merge_scripts\publish_wiki_v1_5.ps1

Set-Location $MainRepo

Step "10/10" "Publishing main repository and tagging release"
.\merge_scripts\git_publish_main_only_v1_5.ps1
.\merge_scripts\tag_release_v1_5.ps1

Write-Host "`n====================================================" -ForegroundColor Green
Write-Host " v1.5 full flow complete." -ForegroundColor Green
Write-Host " Main repo: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS" -ForegroundColor Green
Write-Host " Wiki:      https://github.com/ajaytester007/Purushartha_Family_Continuity_OS/wiki" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green
