$ErrorActionPreference = "Stop"

Write-Host "== Generating repair plans ==" -ForegroundColor Cyan

$casesPath = "41_Case_Engine\synthetic_case_library_50.csv"
$outDir = "44_Repair_Plans"
$outFile = Join-Path $outDir "repair_plan_outputs.md"
$scheduleOut = "45_Retest_Scheduler\generated_retest_schedule.csv"

if (-not (Test-Path $casesPath)) { throw "Missing $casesPath" }
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
New-Item -ItemType Directory -Force -Path "45_Retest_Scheduler" | Out-Null

$cases = Import-Csv $casesPath
$lines = @("# Repair Plan Outputs", "", "Generated from synthetic cases.", "")
$schedule = @()

foreach ($c in $cases) {
    $harm = [int]$c.harm_level
    $retestDays = if ($c.safety_override -eq "true") { 0 } elseif ($harm -ge 4) { 90 } elseif ($harm -ge 3) { 60 } elseif ($harm -ge 2) { 30 } else { 14 }

    $repair = switch -Regex ($c.domain) {
        "Communication" { "Create explicit communication cadence and retest in $retestDays days." }
        "Household" { "Run household burden audit and assign visible initiative actions." }
        "Gifted Child|Sibling" { "Protect sibling fairness and couple floors; review opportunity load." }
        "Money|Wealth|Planning" { "Create financial transparency review and resilience plan." }
        "Family|Boundaries|Family Interference" { "Hold boundary meeting and define decision rights." }
        "Safety" { "Safety override. Seek appropriate immediate support." }
        default { "Acknowledge impact, define replacement behavior, observe recurrence, and retest." }
    }

    $lines += "## $($c.case_id) — $($c.title)"
    $lines += ""
    $lines += "- Repair Plan: $repair"
    $lines += "- Retest Days: $retestDays"
    $lines += ""

    $schedule += [PSCustomObject]@{
        case_id = $c.case_id
        title = $c.title
        retest_days = $retestDays
        success_metric = "Observed behavior change and reduced recurrence"
        status = "pending"
    }
}

$lines | Set-Content -Encoding UTF8 $outFile
$schedule | Export-Csv $scheduleOut -NoTypeInformation

Write-Host "Repair plans generated: $outFile" -ForegroundColor Green
Write-Host "Retest schedule generated: $scheduleOut" -ForegroundColor Green
