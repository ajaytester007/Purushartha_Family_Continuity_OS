$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"

Write-Host "== Publishing main repo and Wiki ==" -ForegroundColor Cyan

cd $MainRepo
git add -A
git commit -m "Add v1.2 publisher and dashboard foundation"
if ($LASTEXITCODE -ne 0) { Write-Host "No main repo changes to commit." -ForegroundColor Yellow }
git push | Out-Host

if (Test-Path $WikiRepo) {
    cd $WikiRepo
    git push | Out-Host
}

Write-Host "Publish helper complete." -ForegroundColor Green
