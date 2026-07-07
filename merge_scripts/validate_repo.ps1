$ErrorActionPreference = "Stop"
Write-Host "== Validating Purushartha OS repository ==" -ForegroundColor Cyan

if (-not (Test-Path ".git")) { throw "Run from the main repo root." }

$Required = @(
"README.md",
"00_Constitution",
"01_Knowledgebase",
"02_Life_Journey_Books",
"03_Scoring_Engines",
"04_Tollgates_and_Decision_Models",
"05_Incident_and_Tort_Library",
"06_Mind_Maps_and_Visual_Models",
"07_Ingestion_and_Evidence_Model",
"08_Playbooks",
"09_Templates"
)

$Missing = @()
foreach ($item in $Required) {
    if (-not (Test-Path $item)) { $Missing += $item }
}

if ($Missing.Count -gt 0) {
    $Missing | ForEach-Object { Write-Host "Missing: $_" -ForegroundColor Red }
    throw "Validation failed."
}

$mdCount = (Get-ChildItem -Recurse -Filter *.md | Where-Object { $_.FullName -notmatch "\\.git\\" }).Count
$mmdCount = (Get-ChildItem -Recurse -Filter *.mmd | Where-Object { $_.FullName -notmatch "\\.git\\" }).Count
$jsonCount = (Get-ChildItem -Recurse -Filter *.json | Where-Object { $_.FullName -notmatch "\\.git\\" }).Count

Write-Host "Markdown files: $mdCount"
Write-Host "Mermaid files:  $mmdCount"
Write-Host "JSON files:     $jsonCount"

if ($mdCount -lt 50) { Write-Warning "Markdown count is low. Full v1.0 content may not be restored." }

Write-Host "Validation passed." -ForegroundColor Green
