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
$lines = @()
$lines += "# Repair Plan Outputs"
$lines += ""
$lines += "Generated from synthetic cases."
$lines += ""

$schedule = @()

foreach ($c in $cases) {
    $harm = [int]$c.harm_level

    if ($c.safety_override -eq "true") {
        $retestDays = 0
    } elseif ($harm -ge 4) {
        $retestDays = 90
    } elseif ($harm -ge 3) {
        $retestDays = 60
    } elseif ($harm -ge 2) {
        $retestDays = 30
    } else {
        $retestDays = 14
    }

    switch -Regex ($c.domain) {
        "Communication" {
            $repair = "Create explicit communication cadence and retest in $retestDays days."
            break
        }
        "Household" {
            $repair = "Run household burden audit and assign visible initiative actions."
            break
        }
        "Gifted Child|Sibling" {
            $repair = "Protect sibling fairness and couple floors; review opportunity load."
            break
        }
        "Money|Wealth|Planning" {
            $repair = "Create financial transparency review and resilience plan."
            break
        }
        "Family|Boundaries|Family Interference" {
            $repair = "Hold boundary meeting and define decision rights."
            break
        }
        "Safety" {
            $repair = "Safety override. Seek appropriate immediate support."
            break
        }
        default {
            $repair = "Acknowledge impact, define replacement behavior, observe recurrence, and retest."
        }
    }

    $lines += "## $($c.case_id) - $($c.title)"
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
