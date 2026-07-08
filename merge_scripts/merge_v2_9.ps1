$ErrorActionPreference = "Stop"
Write-Host "== Merging Purushartha OS v2.9 assets ==" -ForegroundColor Cyan

$Dirs = @("122_Scenario_Simulator","123_Decision_Path_Model","124_Scenario_Reports","125_Release_Notes","126_Backlog_vNext")
foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v2.9 Scenario Simulator

v2.9 introduces scenario comparison for future relationship decision paths.

## Added

- Scenario seed dataset.
- Continue / Correct / Reconsider / Pause / Exit path model.
- Scenario comparison report.
- Streamlit Scenario Simulator patch.
- Pages and Wiki updates.
- v3.0 backlog.

## Guardrail

Scenario simulation is decision support only. Safety and professional review override optimization.
'@ | Set-Content -Encoding UTF8 "125_Release_Notes\v2.9_Scenario_Simulator.md"

@'
scenario_id,path,relationship_health_delta,burden_skew_delta,repair_effort,continuity_score,risk_score,retest_days,recommendation
SCN001,Continue,5,-3,25,82,28,30,Continue with light monitoring
SCN002,Correct,14,-12,60,88,22,14,Best repair-and-grow path if both participate
SCN003,Reconsider,-4,5,35,62,48,21,Use if repeated non-repair continues
SCN004,Pause,-8,-2,20,55,42,14,Use for cooling-off and safety review
SCN005,Exit,-20,-18,80,50,65,7,Use if safety dignity or repeated harm thresholds are crossed
'@ | Set-Content -Encoding UTF8 "122_Scenario_Simulator\scenario_seed.csv"

@'
# Scenario Simulator

Compares Continue, Correct, Reconsider, Pause, and Exit paths using synthetic tradeoff scoring.
'@ | Set-Content -Encoding UTF8 "122_Scenario_Simulator\Scenario_Simulator.md"

@'
# Decision Path Model

- Continue: goodwill and repair are stable.
- Correct: relationship has promise but needs behavioral change.
- Reconsider: repeated patterns are not improving.
- Pause: facts or emotions require space.
- Exit: safety, dignity, trust, or repeated harm thresholds are crossed.
'@ | Set-Content -Encoding UTF8 "123_Decision_Path_Model\Decision_Path_Model.md"

@'
# Scenario Reports

Scenario reports compare tradeoffs across future paths.
'@ | Set-Content -Encoding UTF8 "124_Scenario_Reports\Scenario_Reports.md"

@'
# v3.0 Backlog

## Theme

Family Continuity Intelligence Suite

## Candidate Enhancements

- Integrated Scenario Simulator UI.
- Graph path impact scoring.
- SCD2 state update from selected scenario.
- Public demo lock enforcement.
- v3.0 release dashboard.
'@ | Set-Content -Encoding UTF8 "126_Backlog_vNext\v3.0_Backlog.md"

Write-Host "v2.9 assets merged successfully." -ForegroundColor Green
