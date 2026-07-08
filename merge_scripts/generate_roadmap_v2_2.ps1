$ErrorActionPreference = "Stop"

Write-Host "== Generating roadmap index v2.2 ==" -ForegroundColor Cyan

$out = "88_Roadmap_v3\Roadmap_Index_v2_2.md"
$csv = "88_Roadmap_v3\roadmap_to_v3.csv"

if (-not (Test-Path $csv)) { throw "Missing roadmap CSV. Run merge_v2_2.ps1 first." }

$items = Import-Csv $csv
$lines = @()
$lines += "# Roadmap Index v2.2"
$lines += ""
$lines += "| Version | Title | Theme | Status | Deliverable |"
$lines += "|---|---|---|---|---|"
foreach ($i in $items) {
    $lines += "| $($i.version) | $($i.title) | $($i.theme) | $($i.status) | $($i.deliverable) |"
}
$lines | Set-Content -Encoding UTF8 $out
Write-Host "Generated $out" -ForegroundColor Green
