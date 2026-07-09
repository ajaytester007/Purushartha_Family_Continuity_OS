$ErrorActionPreference = "Stop"
Write-Host "== Merging Purushartha OS v3.2 assets ==" -ForegroundColor Cyan

$Dirs = @(
"142_Daily_Companion",
"143_Grievance_Report_Workbench",
"144_Fidelity_Prospect_Scoring",
"145_Corrective_Action_Plans",
"146_Mobile_Readiness",
"147_Reminders_Rewards_Rituals",
"148_Release_Notes",
"149_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Daily Companion

A friendly daily check-in layer for relationship energy, gratitude, concerns, special encounters, bonding rituals, stars, rewards, and gentle repair nudges.

Public mode: use only synthetic, anonymized, or sanitized details.
'@ | Set-Content -Encoding UTF8 "142_Daily_Companion\Daily_Companion.md"

@'
# Grievance Report Workbench

Turns a concern into a calm report with facts, emotional impact, desired change, fidelity score, relationship prospect score, corrective action plan, suggested conversation starter, and retest plan.
'@ | Set-Content -Encoding UTF8 "143_Grievance_Report_Workbench\Grievance_Report_Workbench.md"

@'
# Fidelity and Prospect Scoring

Fidelity score considers trust consistency, honesty, transparency, boundary respect, conflict integrity, accountability, and repair willingness.

Relationship prospect score considers maturity trend, repair capacity, shared vision, burden fairness, family-boundary strength, joy, and long-term resilience.
'@ | Set-Content -Encoding UTF8 "144_Fidelity_Prospect_Scoring\Fidelity_Prospect_Scoring.md"

@'
# Corrective Action Plans

Plan types include clarification, boundary reset, accountability request, household rebalance, family influence containment, trust rebuilding, joyful reconnection, pause and retest, or mediated conversation.
'@ | Set-Content -Encoding UTF8 "145_Corrective_Action_Plans\Corrective_Action_Plans.md"

@'
# Mobile Readiness

Future iPhone/Android path:

1. Responsive Streamlit web app.
2. Progressive Web App shell.
3. Mobile-friendly daily log forms.
4. Reminder model.
5. Local/private mode.
6. Optional native wrapper.

Mobile UX should support quick daily logs, encounter logs, companion cards, reports, private photo/vlog prompts, and privacy warnings.
'@ | Set-Content -Encoding UTF8 "146_Mobile_Readiness\Mobile_Readiness.md"

@'
# Reminders, Rewards, and Rituals

Companion ideas:

- daily log reminders
- after-meeting reflection reminders
- stars and kindness streaks
- repair streaks
- gratitude prompts
- lucky color prompt
- crystal or symbolic object prompt
- photo gallery / memory cue placeholder
- bonding rituals like walks, tea, music, prayer, reading, cooking, gardening, or shared planning

Symbolic rituals are optional encouragement tools; they do not replace respect, communication, or accountability.
'@ | Set-Content -Encoding UTF8 "147_Reminders_Rewards_Rituals\Reminders_Rewards_Rituals.md"

@'
# Release Notes - v3.2 Daily Companion and Grievance Report Workbench

Adds Daily Companion, Grievance Report Builder, fidelity/prospect scoring, corrective action plans, mobile readiness, rewards, rituals, and reminder design.
'@ | Set-Content -Encoding UTF8 "148_Release_Notes\v3.2_Daily_Companion_and_Grievance_Report_Workbench.md"

@'
# v3.3 Backlog

Persistent daily logs, saved grievance reports, trend charts, calendar view, reminder scheduling, PWA manifest, mobile icon, privacy lock, and photo/vlog placeholder workflow.
'@ | Set-Content -Encoding UTF8 "149_Backlog_vNext\v3.3_Backlog.md"

Write-Host "v3.2 assets merged successfully." -ForegroundColor Green
