$ErrorActionPreference = "Stop"
Write-Host "== Merging v4.2 Interactive Journey Activation assets ==" -ForegroundColor Cyan

$dirs = @(
"201_Interactive_Journey_Activation",
"202_Checklist_Card_Engine",
"203_Journey_Roadmap_Game",
"204_Dynamic_Feed_Forward_Prompts",
"205_Local_Progress_Model",
"206_Compatibility_Health_Report",
"207_Release_Notes",
"208_Backlog_vNext"
)
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Interactive Journey Activation

v4.2 turns the earlier storyboard placeholders into working pilot behavior.

## Activated Features

- Couple journey profile
- Checklist cards
- Weighted compatibility scoring
- Chapter completion
- XP and stars
- Dynamic prompts
- Journey roadmap
- Compatibility health report
- Session-local progress

## Privacy

The pilot uses Streamlit session state. It should not store real private data publicly.
'@ | Set-Content -Encoding UTF8 "201_Interactive_Journey_Activation\Interactive_Journey_Activation.md"

@'
card_id,chapter,category,prompt,weight
C001,Preserve Strength,Primary Partners,Name one relationship strength worth protecting,5
C002,Shared Direction,Primary Partners,Rate your shared life direction,5
C003,Communication,Primary Partners,Rate your calm communication under pressure,5
C004,Family Fit,Parents,Rate family boundary support,5
C005,Trusted Circle,Siblings and Friends,Rate trusted-circle encouragement,4
C006,Budget Logistics,Modern Life,Rate cost and logistics feasibility,5
C007,Distance Logistics,Modern Life,Rate distance travel and relocation feasibility,4
C008,Health Recovery,Modern Life,Rate sickness and recovery support capacity,4
C009,Happiness Quotient,Primary Partners,Rate joy humor affection and companionship,4
C010,Role Play,Role Play,Rate how well the couple handled a practical episode,5
C011,Repair Maturity,Role Play,Rate apology correction and retest behavior,5
C012,Wedding Launch,Milestone,Rate readiness for wedding union launch,5
'@ | Set-Content -Encoding UTF8 "202_Checklist_Card_Engine\checklist_cards_v4_2.csv"

@'
# Checklist Card Engine

Each card has:
- chapter
- category
- prompt
- score
- weight
- reflection
- coaching hint

Scores generate the Compatibility Health Report.
'@ | Set-Content -Encoding UTF8 "202_Checklist_Card_Engine\Checklist_Card_Engine.md"

@'
# Journey Roadmap Game

## Milestones

1. First Chemistry
2. Communication Grove
3. Family Bridge
4. Budget Mountain
5. Distance Crossing
6. Recovery Rest Stop
7. Role-Play Arena
8. Wedding Launch Gate
9. Household Responsibility Village
10. Renewal Garden

## Rewards

- stars
- XP
- chapter badges
- progress notes
- feed-forward prompts
'@ | Set-Content -Encoding UTF8 "203_Journey_Roadmap_Game\Journey_Roadmap_Game.md"

@'
prompt_id,stage,focus,prompt
P001,Any,Gratitude,What is one strength we should preserve this week?
P002,Any,Future,What would our future selves thank us for doing today?
P003,Engaged,Family,What boundary would help both families support us better?
P004,Engaged,Budget,What lower-cost substitution could preserve joy without pressure?
P005,Married,Teamwork,What household task can we complete as Team Us?
P006,Recovery,Repair,What one apology or correction would make repair visible?
P007,Distance,Logistics,What plan would reduce distance stress this week?
P008,Health,Recovery,How can we support rest sickness or recovery with dignity?
P009,Any,Joy,What tiny memory can we create today?
P010,Any,Role Play,What episode can we practice before real pressure arrives?
'@ | Set-Content -Encoding UTF8 "204_Dynamic_Feed_Forward_Prompts\prompt_library_v4_2.csv"

@'
# Dynamic Feed Forward Prompts

Prompts adapt to stage, lowest score, current chapter, and unfinished quests.
'@ | Set-Content -Encoding UTF8 "204_Dynamic_Feed_Forward_Prompts\Dynamic_Feed_Forward_Prompts.md"

@'
# Local Progress Model

For the pilot, progress is held in Streamlit session state.

## Later

Use browser local storage, encrypted local storage, or account-based storage after privacy architecture is finalized.
'@ | Set-Content -Encoding UTF8 "205_Local_Progress_Model\Local_Progress_Model.md"

@'
# Compatibility Health Report

## Sections

- couple profile
- checklist score summary
- strongest area
- lowest growth area
- XP and stars
- milestone position
- coaching hints
- wedding launch readiness
- exit caution if necessary

## Rule

The report should coach first when safe. It should recommend exit only when safety, dignity, repeated non-repair, or no-hope thresholds appear.
'@ | Set-Content -Encoding UTF8 "206_Compatibility_Health_Report\Compatibility_Health_Report.md"

@'
# v4.2 Release Notes

Adds interactive journey activation, checklist cards, session-local progress, XP/stars, dynamic prompts, health report, and roadmap game.
'@ | Set-Content -Encoding UTF8 "207_Release_Notes\v4.2_Interactive_Journey_Activation.md"

@'
# v4.3 Backlog

## Theme

Persistent Checklist Engine and Trusted-Circle Invites

## Candidate Enhancements

- Save checklist responses to local CSV / browser storage
- Trusted-circle rating forms
- Invite code model
- Avatar and theme selector
- Countdown timers
- Animated roadmap
- Report export hardening
'@ | Set-Content -Encoding UTF8 "208_Backlog_vNext\v4.3_Backlog.md"

Write-Host "v4.2 assets merged." -ForegroundColor Green
