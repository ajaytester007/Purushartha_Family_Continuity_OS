$ErrorActionPreference = "Stop"
Write-Host "== Generating scenario comparison report v2.9 ==" -ForegroundColor Cyan

$csv = "122_Scenario_Simulator\scenario_seed.csv"
$outDir = "124_Scenario_Reports"
$out = Join-Path $outDir "scenario_comparison_report_v2_9.md"

if (-not (Test-Path $csv)) { throw "Missing scenario seed CSV." }
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$rows = Import-Csv $csv
$best = $rows | Sort-Object {[int]$_.continuity_score} -Descending | Select-Object -First 1
$risky = $rows | Sort-Object {[int]$_.risk_score} -Descending | Select-Object -First 1

$lines = @()
$lines += "# Scenario Comparison Report v2.9"
$lines += ""
$lines += "| Path | Health Delta | Burden Delta | Repair Effort | Continuity | Risk | Retest Days | Recommendation |"
$lines += "|---|---:|---:|---:|---:|---:|---:|---|"
foreach ($r in $rows) {
    $lines += "| $($r.path) | $($r.relationship_health_delta) | $($r.burden_skew_delta) | $($r.repair_effort) | $($r.continuity_score) | $($r.risk_score) | $($r.retest_days) | $($r.recommendation) |"
}
$lines += ""
$lines += "## Best Continuity Path"
$lines += "- $($best.path): continuity score $($best.continuity_score)"
$lines += ""
$lines += "## Highest Risk Path"
$lines += "- $($risky.path): risk score $($risky.risk_score)"
$lines += ""
$lines += "## Guardrail"
$lines += "Scenario simulation is decision support only."

$lines | Set-Content -Encoding UTF8 $out
Write-Host "Generated $out" -ForegroundColor Green
