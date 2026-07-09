$ErrorActionPreference = "Stop"
Write-Host "== Merging v4.6 Checklist Intake assets ==" -ForegroundColor Cyan

$dirs = @(
"238_Checklist_Intake_Engine",
"239_Bride_Parent_Lens",
"240_Family_Life_Coach_Inference",
"241_Relationship_Mending_Playbooks",
"242_Beyond_Repair_Thresholds",
"243_Two_Family_Advisory_Report",
"244_Mobile_Evaluation_v4_6",
"245_Release_Notes",
"246_Backlog_vNext"
)
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Checklist Intake Engine

The app can ingest completed anonymous checklist rows from:
- bride-side parent
- prospective bride
- prospective groom
- groom-side parent
- trusted circle
- seer/mentor

## Required CSV Columns

role,dimension,score,note

## Optional CSV Columns

pilot_id,stage,episode,timestamp,weight

## Privacy Rule

Use aliases only. Do not use real names, phone numbers, emails, addresses, or identifying details.
'@ | Set-Content -Encoding UTF8 "238_Checklist_Intake_Engine\Checklist_Intake_Engine.md"

@'
role,dimension,score,note
Bride Parent,Dharma,72,Concerned about accountability and respectful family communication
Bride Parent,Artha,64,Cost distance and logistics need clearer planning
Bride Parent,Kama,70,There is warmth but emotional drama reduces joy
Bride Parent,Moksha,66,Needs more space dignity and maturity
Bride Parent,Family Ecology,58,Family boundaries and tone need reset
Bride Parent,Repair,52,Repair needs visible behavior not just words
Bride Parent,Wedding Launch,55,Needs incubation before public milestone
Bride,Trust,68,Wants reassurance and consistent actions
Bride,Communication,60,Needs calmer hard conversations
Bride,Happiness,74,Feels connection but wants less emotional volatility
Bride,Role Play,62,Stress episodes need better teamwork
Bride,Exit Risk,45,Not hopeless but risk is present if repair does not improve
'@ | Set-Content -Encoding UTF8 "238_Checklist_Intake_Engine\sample_bride_parent_checklist_v4_6.csv"

@'
# Bride / Parent Lens

This lens represents the concern set often coming from the parent of a girl / prospective bride.

The app must separate:
- protective instinct
- real compatibility concern
- family image concern
- logistics concern
- cultural/traditional concern
- emotional injury concern
- repair/retest requirement

The goal is not to make one family win. The goal is to help both families mature around the couple.
'@ | Set-Content -Encoding UTF8 "239_Bride_Parent_Lens\Bride_Parent_Lens.md"

@'
# Family Life-Coach Inference Engine

The app should infer:
- what is working
- what needs mending
- what both families should stop doing
- what both families should start doing
- what the couple must own themselves
- what should be retested before the next milestone
- when pause/incubation is advised
- when exit review is healthier than forced continuation
'@ | Set-Content -Encoding UTF8 "240_Family_Life_Coach_Inference\Family_Life_Coach_Inference.md"

@'
# Relationship Mending Playbooks

## Playbooks

- Tone Reset
- Boundary Reset
- Accountability Repair
- Budget and Logistics Clarity
- Family Image Pressure Reduction
- Couple Ownership Reset
- Trusted Circle Noise Reduction
- Incubation Before Milestone
- Wedding Launch Delay with Dignity
'@ | Set-Content -Encoding UTF8 "241_Relationship_Mending_Playbooks\Relationship_Mending_Playbooks.md"

@'
# Beyond Repair Thresholds

Beyond-repair guidance should be careful and dignified.

## High-Risk Indicators

- repeated non-repair
- humiliation or coercion
- chronic contempt
- safety fear
- severe family interference
- values mismatch
- unsustainable logistics
- no ownership by the couple
- emotional trauma loop dominating the bond

## Recommendation

The app should coach first when safe. If hope is very low, it should recommend an exit report that preserves maturity gained.
'@ | Set-Content -Encoding UTF8 "242_Beyond_Repair_Thresholds\Beyond_Repair_Thresholds.md"

@'
# Two-Family Advisory Report

The report addresses:
- couple
- bride-side family
- groom-side family
- trusted circle

## Sections

- score summary
- inferred concern themes
- mending actions
- family conduct guidance
- couple ownership guidance
- milestone readiness
- pause/incubate/continue/exit guidance
- retest plan
'@ | Set-Content -Encoding UTF8 "243_Two_Family_Advisory_Report\Two_Family_Advisory_Report.md"

@'
feature,check_from_iphone,pass_criteria
Checklist Intake,Streamlit v4.6 section,Can paste CSV-like checklist data
Inference Engine,Streamlit v4.6 section,Shows inferred themes and recommendation
Mending Playbook,Streamlit v4.6 section,Shows actions for couple and both families
Beyond Repair,Extreme low scores,Shows dignified exit-review guidance
Two-Family Report,Download button,Downloads advisory report
Mobile Shell,Home Screen icon,Shows v4.6 update after Pages deploy
'@ | Set-Content -Encoding UTF8 "244_Mobile_Evaluation_v4_6\mobile_evaluation_v4_6.csv"

@'
# v4.6 Release Notes

Adds checklist intake, bride/parent lens, family life-coach inference, mending playbooks, beyond-repair thresholds, and two-family advisory report.
'@ | Set-Content -Encoding UTF8 "245_Release_Notes\v4.6_Checklist_Intake_Life_Coach.md"

@'
# v4.7 Backlog

## Theme

Persistent Multi-Rater Intake + Saved Anonymous Case Library

## Candidate Enhancements

- Save intake submissions
- Upload CSV file
- Compare bride/groom/family ratings
- Generate heatmap
- Role-based mending instructions
- Family meeting agenda generator
- Exit report generator
'@ | Set-Content -Encoding UTF8 "246_Backlog_vNext\v4.7_Backlog.md"

Write-Host "v4.6 assets merged." -ForegroundColor Green
