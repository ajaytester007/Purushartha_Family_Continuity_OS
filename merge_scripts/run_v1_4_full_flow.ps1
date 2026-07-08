$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"

function Step($n, $text) {
    Write-Host "`n[$n] $text" -ForegroundColor Cyan
}

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v1.4 Full Flow" -ForegroundColor Cyan
Write-Host " preflight -> merge -> validate -> maps -> dashboards -> wiki -> main push -> tag" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Set-Location $MainRepo

Step "1/8" "Running preflight checks"
.\merge_scripts\preflight_check.ps1

Step "2/8" "Merging v1.4 assets"
.\merge_scripts\merge_v1_4.ps1

Step "3/8" "Validating repository"
.\merge_scripts\validate_repo.ps1

Step "4/8" "Generating Mermaid maps"
.\merge_scripts\generate_mermaid_maps.ps1

Step "5/8" "Generating dashboard outputs"
.\merge_scripts\generate_dashboard_outputs.ps1

Step "6/8" "Publishing Wiki"
.\merge_scripts\publish_wiki_v1_4.ps1

Set-Location $MainRepo

Step "7/8" "Publishing main repository"
.\merge_scripts\git_publish_main_only_v1_4.ps1

Set-Location $MainRepo

Step "8/8" "Creating/updating release tag"
.\merge_scripts\tag_release_v1_4.ps1

Write-Host "`n====================================================" -ForegroundColor Green
Write-Host " v1.4 full flow complete." -ForegroundColor Green
Write-Host " Main repo: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS" -ForegroundColor Green
Write-Host " Wiki:      https://github.com/ajaytester007/Purushartha_Family_Continuity_OS/wiki" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green
