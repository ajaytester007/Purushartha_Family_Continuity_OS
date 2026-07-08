$ErrorActionPreference = "Stop"

Write-Host "== Validating case engine ==" -ForegroundColor Cyan

$cases = "41_Case_Engine\synthetic_case_library_50.csv"
$rules = "42_Tollgate_Rules\tollgate_rules.json"

if (-not (Test-Path $cases)) { throw "Missing $cases" }
if (-not (Test-Path $rules)) { throw "Missing $rules" }

$data = Import-Csv $cases
if ($data.Count -lt 50) { throw "Expected at least 50 cases; found $($data.Count)" }

$required = @("case_id","title","stage","domain","harm_level","impact_score","repair_score","learning_score","recurrence_count","safety_override","recommended_tollgate","summary")
$headers = ($data | Select-Object -First 1).PSObject.Properties.Name

foreach ($h in $required) {
    if ($headers -notcontains $h) { throw "Missing case CSV header: $h" }
}

$rulesJson = Get-Content $rules -Raw | ConvertFrom-Json
if (-not $rulesJson) { throw "Rules JSON could not be parsed." }

$safetyCases = $data | Where-Object { $_.safety_override -eq "true" }
foreach ($c in $safetyCases) {
    if ($c.recommended_tollgate -ne "Safety_Protection_Tollgate") {
        throw "Safety override case $($c.case_id) is not routed to Safety_Protection_Tollgate."
    }
}

Write-Host "Case engine validation passed. Cases: $($data.Count)" -ForegroundColor Green
