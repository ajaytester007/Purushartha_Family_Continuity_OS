$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"

Write-Host "== Preflight Check ==" -ForegroundColor Cyan

if (-not (Test-Path $MainRepo)) { throw "Main repo not found: $MainRepo" }
if (-not (Test-Path (Join-Path $MainRepo ".git"))) { throw "Main repo is not a Git repo: $MainRepo" }
if (-not (Test-Path $WikiRepo)) { throw "Wiki repo not found: $WikiRepo" }
if (-not (Test-Path (Join-Path $WikiRepo ".git"))) { throw "Wiki repo is not a Git repo: $WikiRepo" }

Set-Location $MainRepo
$mainBranch = git branch --show-current
$mainRemote = git remote -v
if (-not $mainRemote) { throw "Main repo has no remote." }

Set-Location $WikiRepo
$wikiBranch = git branch --show-current
$wikiRemote = git remote -v
if (-not $wikiRemote) { throw "Wiki repo has no remote." }

Set-Location $MainRepo

$zipCount = (Get-ChildItem -Path $MainRepo -Filter "*.zip" -ErrorAction SilentlyContinue).Count
$tempCount = (Get-ChildItem -Path $MainRepo -Directory -Filter "_merge_temp*" -ErrorAction SilentlyContinue).Count

Write-Host "Main branch: $mainBranch"
Write-Host "Wiki branch: $wikiBranch"
Write-Host "ZIP files in root: $zipCount"
Write-Host "Temp merge folders in root: $tempCount"

if ($zipCount -gt 0) {
    Write-Warning "ZIP files are present in repo root. v1.4 publish script will remove merge pack ZIPs before commit."
}

Write-Host "Preflight passed." -ForegroundColor Green
