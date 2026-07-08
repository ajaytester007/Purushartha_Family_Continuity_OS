$ErrorActionPreference = "Stop"
Write-Host "== Validating GitHub Pages assets ==" -ForegroundColor Cyan

$required = @(
"docs\index.html",
".github\workflows\pages.yml",
"58_GitHub_Pages\GitHub_Pages_Deployment.md",
"60_Release_Notes\v1.7_GitHub_Pages_Public_Experience.md"
)

foreach ($item in $required) {
    if (-not (Test-Path $item)) { throw "Missing required Pages asset: $item" }
}

Write-Host "GitHub Pages assets validated." -ForegroundColor Green
