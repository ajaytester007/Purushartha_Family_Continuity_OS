$ErrorActionPreference = "Stop"
Write-Host "== Validating branch-based Pages assets ==" -ForegroundColor Cyan
if (-not (Test-Path "docs\index.html")) { throw "Missing docs\index.html" }
if (Test-Path ".github\workflows\pages.yml") { throw "pages.yml still exists; remove it for branch-based deployment." }
if (-not (Test-Path "64_Pages_Branch_Deployment\GitHub_Pages_Branch_Deployment.md")) { throw "Missing branch deployment guide." }
Write-Host "Branch-based Pages validation passed." -ForegroundColor Green
