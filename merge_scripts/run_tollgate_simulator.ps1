$ErrorActionPreference = "Stop"

Write-Host "== Running tollgate simulator ==" -ForegroundColor Cyan

$casesPath = "41_Case_Engine\synthetic_case_library_50.csv"
$outDir = "43_Decision_Explanations"
$outFile = Join-Path $outDir "decision_explanations.md"

if (-not (Test-Path $casesPath)) { throw "Missing $casesPath" }
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$cases = Import-Csv $casesPath
$lines = @()
$lines += "# Decision Explanations"
$lines += ""
$lines += "Generated from synthetic cases."
$lines += ""

foreach ($c in $cases) {
    $harm = [int]$c.harm_level
    $impact = [int]$c.impact_score
    $repair = [int]$c.repair_score
    $learning = [int]$c.learning_score
    $recurrence = [int]$c.recurrence_count
    $safety = $c.safety_override -eq "true"

    if ($safety) {
        $zone = "Red"
        $action = "Safety protection override. Do not optimize relationship continuity."
    } elseif ($harm -ge 4 -or $impact -ge 85) {
        $zone = "Orange/Red"
        $action = "Reconsider, protect, or seek structured recovery support."
    } elseif ($recurrence -ge 4 -and $repair -lt 60) {
        $zone = "Orange"
        $action = "Pattern concern. Escalate from simple correction to reconsideration."
    } elseif ($repair -ge 65 -and $learning -ge 65) {
        $zone = "Yellow/Green"
        $action = "Correct with retest; learning appears plausible."
    } else {
        $zone = "Yellow"
        $action = "Clarify expectations, repair, and retest."
    }

    $lines += "## $($c.case_id) - $($c.title)"
    $lines += ""
    $lines += "- Stage: $($c.stage)"
    $lines += "- Domain: $($c.domain)"
    $lines += "- Harm Level: $($c.harm_level)"
    $lines += "- Recommended Tollgate: $($c.recommended_tollgate)"
    $lines += "- Zone: $zone"
    $lines += "- Action: $action"
    $lines += "- Summary: $($c.summary)"
    $lines += ""
}

$lines | Set-Content -Encoding UTF8 $outFile

Write-Host "Decision explanations generated: $outFile" -ForegroundColor Green
