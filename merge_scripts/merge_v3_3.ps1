$ErrorActionPreference = "Stop"
Write-Host "== Merging Purushartha OS v3.3 assets ==" -ForegroundColor Cyan

$Dirs = @(
"150_Daily_Log_Persistence",
"151_Grievance_Report_Persistence",
"152_Relationship_Trend_Dashboard",
"153_App_Stabilization",
"154_Release_Notes",
"155_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Daily Log Persistence

## Purpose

Store daily companion entries so the relationship can be reviewed over time.

## Fields

- log_id
- created_at
- mood
- relationship_energy
- partner_effort
- self_effort
- unresolved
- special_encounter
- gratitude_note
- concern_note
- daily_nudge

## Guardrail

Public deployment should use synthetic or sanitized entries only.
'@ | Set-Content -Encoding UTF8 "150_Daily_Log_Persistence\Daily_Log_Persistence.md"

@'
log_id,created_at,mood,relationship_energy,partner_effort,self_effort,unresolved,special_encounter,gratitude_note,concern_note,daily_nudge
DL001,2026-01-01T00:00:00Z,7,78,6,7,false,false,Synthetic gratitude,Synthetic concern,Offer one appreciation today
'@ | Set-Content -Encoding UTF8 "150_Daily_Log_Persistence\daily_logs.csv"

@'
# Grievance Report Persistence

## Purpose

Store generated grievance reports and scores for later review.

## Fields

- report_id
- created_at
- summary
- fidelity_score
- prospect_score
- recommended_action
- retest_days
- report_path

## Guardrail

Do not store private identifying details in public deployment.
'@ | Set-Content -Encoding UTF8 "151_Grievance_Report_Persistence\Grievance_Report_Persistence.md"

@'
report_id,created_at,summary,fidelity_score,prospect_score,recommended_action,retest_days,report_path
GR001,2026-01-01T00:00:00Z,Synthetic grievance,75,78,Correct and retest,14,synthetic
'@ | Set-Content -Encoding UTF8 "151_Grievance_Report_Persistence\grievance_reports.csv"

@'
# Relationship Trend Dashboard

## Purpose

Show relationship energy, fidelity, prospect, repair, and unresolved concern trends.

## v3.3 Scope

- Daily log table
- Energy trend line
- Grievance report table
- Fidelity/prospect comparison
- Downloadable CSVs

## Future

v3.4 can add reminder scheduling and PWA/mobile readiness.
'@ | Set-Content -Encoding UTF8 "152_Relationship_Trend_Dashboard\Relationship_Trend_Dashboard.md"

@'
# App Stabilization

## v3.3 Stabilization

- Auto-fix duplicate Streamlit keys.
- Validate duplicate keys before publish.
- Avoid duplicate generated widget IDs.
- Prepare for future migration from use_container_width to width="stretch".

## Rule

No release should be published if duplicate widget keys exist.
'@ | Set-Content -Encoding UTF8 "153_App_Stabilization\App_Stabilization.md"

@'
# Release Notes - v3.3 Persistent Logs and App Stabilization

## Added

- Daily log persistence.
- Grievance report persistence.
- Trend dashboard design.
- Duplicate Streamlit key auto-fixer.
- Duplicate key validator.
- Streamlit patch for saved logs and report trend view.

## Guardrail

Public mode remains synthetic/sanitized only.
'@ | Set-Content -Encoding UTF8 "154_Release_Notes\v3.3_Persistent_Logs_and_App_Stabilization.md"

@'
# v3.4 Backlog

## Theme

Reminders, PWA, and Mobile Companion Readiness

## Candidate Enhancements

- PWA manifest.
- App icon.
- Mobile landing screen.
- Reminder scheduler design.
- Daily notification text library.
- Streak tracking.
- Calendar view.
- Photo/vlog prompt placeholders.
'@ | Set-Content -Encoding UTF8 "155_Backlog_vNext\v3.4_Backlog.md"

Write-Host "v3.3 assets merged successfully." -ForegroundColor Green
