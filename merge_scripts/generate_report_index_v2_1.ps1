$ErrorActionPreference = "Stop"

Write-Host "== Generating report index v2.1 ==" -ForegroundColor Cyan

$manifestPath = "83_Report_Manifest\report_manifest.csv"
$outDir = "82_Reports_Cockpit"
$out = Join-Path $outDir "Report_Index_v2_1.md"

if (-not (Test-Path $manifestPath)) { throw "Missing report manifest. Run generate_report_manifest_v2_1.ps1 first." }

$reports = Import-Csv $manifestPath
$lines = @()
$lines += "# Report Index v2.1"
$lines += ""
$lines += "Generated from the report manifest."
$lines += ""
$lines += "| Report | Type | Local Path | Mode | Guardrail |"
$lines += "|---|---|---|---|---|"

foreach ($r in $reports) {
    $lines += "| $($r.report_name) | $($r.report_type) | `$($r.local_path)` | $($r.public_private_mode) | $($r.guardrail_status) |"
}

$lines += ""
$lines += "## Guardrail"
$lines += ""
$lines += "Only synthetic or sanitized reports should be public. Private real-life reports should remain in local private mode unless explicitly approved."

$lines | Set-Content -Encoding UTF8 $out
Write-Host "Generated $out" -ForegroundColor Green
