$ErrorActionPreference = "Stop"

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v1.3 Full Flow" -ForegroundColor Cyan
Write-Host " merge -> validate -> maps -> wiki -> git push" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"

if ((Get-Location).Path -ne $MainRepo) {
    Write-Host "Switching to main repo: $MainRepo" -ForegroundColor Yellow
    Set-Location $MainRepo
}

if (-not (Test-Path ".git")) {
    throw "Main repo .git folder not found. Run from $MainRepo."
}

if (-not (Test-Path $WikiRepo)) {
    throw "Wiki repo not found: $WikiRepo"
}

if (-not (Test-Path (Join-Path $WikiRepo ".git"))) {
    throw "Wiki repo .git folder not found: $WikiRepo"
}

Write-Host "`n[1/6] Merging v1.3 assets..." -ForegroundColor Cyan
.\merge_scripts\merge_v1_3.ps1

Write-Host "`n[2/6] Validating repository..." -ForegroundColor Cyan
.\merge_scripts\validate_repo.ps1

Write-Host "`n[3/6] Generating Mermaid maps..." -ForegroundColor Cyan
.\merge_scripts\generate_mermaid_maps.ps1

Write-Host "`n[4/6] Generating dashboard outputs..." -ForegroundColor Cyan
.\merge_scripts\generate_dashboard_outputs.ps1

Write-Host "`n[5/6] Publishing Wiki..." -ForegroundColor Cyan
.\merge_scripts\publish_wiki.ps1

Write-Host "`n[6/6] Publishing main repo..." -ForegroundColor Cyan
.\merge_scripts\git_publish_main_only.ps1

Write-Host "`n====================================================" -ForegroundColor Green
Write-Host " v1.3 full flow complete." -ForegroundColor Green
Write-Host " Main repo: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS" -ForegroundColor Green
Write-Host " Wiki:      https://github.com/ajaytester007/Purushartha_Family_Continuity_OS/wiki" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green
