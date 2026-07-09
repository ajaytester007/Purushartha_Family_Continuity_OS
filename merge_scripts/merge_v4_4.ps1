$ErrorActionPreference = "Stop"
Write-Host "== Merging v4.4 Real Anonymous Pilot Lab assets ==" -ForegroundColor Cyan

$dirs = @(
"219_Real_Anonymous_Pilot_Lab",
"220_Multi_Rater_Engine",
"221_Decision_Maze",
"222_Perspective_Pivots",
"223_Moment_of_Truth_Log",
"224_Coaching_Quest_Retest",
"225_Mobile_Feature_Evaluation",
"226_Release_Notes",
"227_Backlog_vNext"
)
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Real Anonymous Pilot Lab

The pilot lab allows synthetic or anonymized relationship cases to be tested without exposing identities.

## Flow

1. Create pilot code.
2. Select stage.
3. Enter anonymous episode.
4. Rate from multiple roles.
5. Review disagreement gaps.
6. Navigate first decision maze.
7. Generate coaching quest.
8. Retest after behavior change.
9. Produce anonymous decision report.
'@ | Set-Content -Encoding UTF8 "219_Real_Anonymous_Pilot_Lab\Real_Anonymous_Pilot_Lab.md"

@'
pilot_case_id,stage,episode_title,primary_question
LOTUS-001,Engaged,Seattle Weekend Friction,Is the couple ready to continue toward wedding launch or should they incubate?
PEACOCK-002,Dating,Family Expectations Clash,Can family boundaries be reset without harming the relationship?
RIVER-003,Makeover,Repeated Repair Loop,Is repair becoming real behavior or a trauma loop?
'@ | Set-Content -Encoding UTF8 "219_Real_Anonymous_Pilot_Lab\anonymous_pilot_seed_cases_v4_4.csv"

@'
# Multi-Rater Engine

Roles:
- Partner-A
- Partner-B
- Parent-A
- Parent-B
- Sibling/Friend
- Seer/Mentor
- Support System

Outputs:
- average score
- role gap
- disagreement risk
- blind spot hints
- coaching focus
'@ | Set-Content -Encoding UTF8 "220_Multi_Rater_Engine\Multi_Rater_Engine.md"

@'
role,dimension,question
Partner-A,Self View,What did I intend?
Partner-B,Partner View,What did I experience?
Parent-A,Family Lens,What family concern surfaced?
Parent-B,Family Lens,What family concern surfaced?
Sibling/Friend,Trusted Circle,Did trusted circle reduce or amplify drama?
Seer/Mentor,Seer Lens,What dharmic correction is needed?
Support System,Logistics Lens,What practical constraint is being ignored?
'@ | Set-Content -Encoding UTF8 "220_Multi_Rater_Engine\multi_rater_questions_v4_4.csv"

@'
# Decision Maze

The maze is the first playable path through a difficult relationship episode.

## Path

My intention -> Partner experience -> Family influence -> Practical constraints -> Emotional wound activation -> Facts vs assumptions -> Purushartha view -> Repair choices -> Consequence preview -> Next tollgate

## Purpose

Users must pivot across perspectives before making a decision.
'@ | Set-Content -Encoding UTF8 "221_Decision_Maze\Decision_Maze.md"

@'
maze_node,next_node,question
My Intention,Partner Experience,What was I trying to do?
Partner Experience,Family Influence,How might my partner have experienced it?
Family Influence,Practical Constraints,What family pressure or expectation entered?
Practical Constraints,Emotional Activation,What cost time distance health or logistics constraint mattered?
Emotional Activation,Facts vs Assumptions,What old wound or fear may have been activated?
Facts vs Assumptions,Purushartha View,What are facts feelings and assumptions?
Purushartha View,Repair Choices,What do Dharma Artha Kama and Moksha reveal?
Repair Choices,Consequence Preview,What repair choices are available?
Consequence Preview,Next Tollgate,What happens if we continue pause incubate or exit?
'@ | Set-Content -Encoding UTF8 "221_Decision_Maze\decision_maze_nodes_v4_4.csv"

@'
# Perspective Pivots

Perspective pivots help reveal the bigger picture:
- my lens
- partner lens
- parent lens
- sibling/friend lens
- child/future-child lens
- pet/care ecosystem lens
- colleague/work-life lens
- seer lens
- dharma/artha/kama/moksha lens
'@ | Set-Content -Encoding UTF8 "222_Perspective_Pivots\Perspective_Pivots.md"

@'
# Moment of Truth Log

A moment of truth is a meaningful episode that reveals maturity, repair capacity, family influence, or practical feasibility.

## Capture

- what happened
- what each side intended
- what each side felt
- what facts are known
- what assumptions appeared
- what repair was attempted
- what should be retested
'@ | Set-Content -Encoding UTF8 "223_Moment_of_Truth_Log\Moment_of_Truth_Log.md"

@'
# Coaching Quest and Retest

Every low-score area produces a coaching quest and retest window.

Examples:
- Boundary Reset Quest
- Repair Proof Quest
- Budget Reality Quest
- Distance Logistics Quest
- Trusted Circle Noise Reduction
- Happiness Substitution Quest
- Recovery Support Quest
'@ | Set-Content -Encoding UTF8 "224_Coaching_Quest_Retest\Coaching_Quest_Retest.md"

@'
feature,where_to_check,pass_criteria
Mobile shell,GitHub Pages mobile.html,Opens on iPhone and can be added to Home Screen
Streamlit workbench,Open Interactive Workbench button,Loads from mobile shell
Anonymous pilot lab,Streamlit v4.4 section,Can enter pilot code and episode
Multi-rater engine,Streamlit v4.4 sliders,Each role score moves independently
Disagreement gap,Streamlit decision dashboard,Gap changes based on role ratings
Decision maze,Streamlit maze expander,Shows all maze nodes and questions
Perspective pivots,Streamlit perspective section,Shows partner family seer and support-system angles
Decision report,Download button,Downloads anonymous report
Safety guardrail,Report and screen,Does not encourage unsafe continuation
'@ | Set-Content -Encoding UTF8 "225_Mobile_Feature_Evaluation\mobile_feature_evaluation_v4_4.csv"

@'
# Mobile Feature Evaluation

For each version, verify both surfaces:
1. GitHub Pages mobile shell
2. Streamlit interactive workbench

A feature is only pilot-ready when it works on iPhone portrait mode, has clear labels, avoids private identity exposure, and produces a useful next action.
'@ | Set-Content -Encoding UTF8 "225_Mobile_Feature_Evaluation\Mobile_Feature_Evaluation.md"

@'
# v4.4 Release Notes

Adds real anonymous pilot lab, multi-rater engine, first decision maze, perspective pivots, moment-of-truth log, coaching quest/retest plan, and mobile feature evaluation checklist.
'@ | Set-Content -Encoding UTF8 "226_Release_Notes\v4.4_Real_Anonymous_Pilot_Lab.md"

@'
# v4.5 Backlog

## Theme

Sacred Maze + Mind Map Game Engine v1

## Candidate Enhancements

- Mind-map visual decision paths
- Sacred symbolic skins as optional metaphor
- Shiva/Ganesha/Devi/nature/secular journey skins
- Chakra/tollgate progression model
- Seer wisdom library
- Karma-imprint loosening tasks as reflective sadhana
- Avatar and theme selector
- Animated roadmap signposts
'@ | Set-Content -Encoding UTF8 "227_Backlog_vNext\v4.5_Backlog.md"

Write-Host "v4.4 assets merged." -ForegroundColor Green
