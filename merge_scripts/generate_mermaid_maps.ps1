$ErrorActionPreference = "Stop"
Write-Host "== Generating Mermaid maps from synthetic data ==" -ForegroundColor Cyan

$csv = "20_Dashboard_Data\synthetic_lifetime_events.csv"
$out = "21_Auto_Maps\generated_event_timeline.mmd"

if (-not (Test-Path $csv)) { throw "Run merge_v1_2.ps1 first." }

$events = Import-Csv $csv
$lines = @("flowchart LR")

for ($i = 0; $i -lt $events.Count; $i++) {
    $id = "E$($i+1)"
    $label = "$($events[$i].stage): $($events[$i].domain)" -replace '"', "'"
    $lines += "  $id[`"$label`"]"
    if ($i -gt 0) {
        $prev = "E$($i)"
        $lines += "  $prev --> $id"
    }
}

$lines | Set-Content -Encoding UTF8 $out
Write-Host "Generated $out" -ForegroundColor Green
