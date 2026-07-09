$ErrorActionPreference = "Stop"
Write-Host "== Merging Purushartha OS v3.1 assets ==" -ForegroundColor Cyan

$Dirs = @("134_Relationship_Consultancy_Workbench","135_Correspondence_Analyzer","136_Maturity_Scoring_Rubric","137_Course_of_Action_Engine","138_Response_Coach","139_Relationship_Accumulator","140_Release_Notes","141_Backlog_vNext")
foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Relationship Consultancy Workbench

Guided intake, sanitized correspondence review, maturity scoring, course-of-action guidance, response coaching, and accumulator foundation.

Public app rule: use synthetic, anonymized, or sanitized text only.
'@ | Set-Content -Encoding UTF8 "134_Relationship_Consultancy_Workbench\Relationship_Consultancy_Workbench.md"

@'
# Correspondence Analyzer

Evaluates communication patterns such as respect, empathy, accountability, clarity, escalation risk, blame shifting, repair attempt, boundary respect, family interference, and emotional safety.
'@ | Set-Content -Encoding UTF8 "135_Correspondence_Analyzer\Correspondence_Analyzer.md"

@'
# Maturity Scoring Rubric

Positive signals: accountability, repair, respect, calm tone, clarity, future-oriented problem solving.

Negative signals: contempt, threats, blame, minimization, pressure tactics, refusal to repair.
'@ | Set-Content -Encoding UTF8 "136_Maturity_Scoring_Rubric\Maturity_Scoring_Rubric.md"

@'
# Course of Action Engine

Actions: Continue, Clarify, Correct, Pause, Mediate, Escalate Support, Reconsider, Exit.

Safety and dignity override relationship optimization.
'@ | Set-Content -Encoding UTF8 "137_Course_of_Action_Engine\Course_of_Action_Engine.md"

@'
# Response Coach

Creates calm clarification, boundary-setting, repair-invitation, accountability-request, pause-request, mediated-conversation, or no-response guidance.
'@ | Set-Content -Encoding UTF8 "138_Response_Coach\Response_Coach.md"

@'
# Relationship Accumulator

Tracks trust trend, repair trend, accountability trend, burden skew, emotional baggage, repeated patterns, family interference, and maturity trajectory.
'@ | Set-Content -Encoding UTF8 "139_Relationship_Accumulator\Relationship_Accumulator.md"

@'
# Release Notes - v3.1 Interactive Relationship Consultancy Workbench

Adds guided intake, sanitized correspondence analyzer, maturity scoring, course-of-action engine, response coach, and relationship accumulator foundation.
'@ | Set-Content -Encoding UTF8 "140_Release_Notes\v3.1_Interactive_Relationship_Consultancy_Workbench.md"

@'
# v3.2 Backlog

Persistent relationship accumulator, saved interaction history, trend charts, recurrence detection, retest reminders, and consultancy report export.
'@ | Set-Content -Encoding UTF8 "141_Backlog_vNext\v3.2_Backlog.md"

Write-Host "v3.1 assets merged successfully." -ForegroundColor Green
