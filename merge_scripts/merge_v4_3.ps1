$ErrorActionPreference = "Stop"
Write-Host "== Merging v4.3 Anonymous Pilot Decisioning assets ==" -ForegroundColor Cyan

$dirs = @(
"209_Anonymous_Pilot_Data",
"210_Pilot_Rating_Matrix",
"211_Seer_Lens_Model",
"212_Emotional_Drama_Sanity_Check",
"213_Purushartha_Risk_Map",
"214_Wedding_Union_Staging",
"215_Relationship_Incubation_Dashboard",
"216_Decisioning_Reports",
"217_Release_Notes",
"218_Backlog_vNext"
)
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
pilot_id,couple_code,stage,partner_a_alias,partner_b_alias,family_a_alias,family_b_alias,privacy_mode
PILOT001,LOTUS-001,Engaged,Partner-A,Partner-B,Family-A,Family-B,Anonymous
PILOT002,PEACOCK-002,Dating,Partner-A,Partner-B,Family-A,Family-B,Anonymous
PILOT003,RIVER-003,Makeover,Partner-A,Partner-B,Family-A,Family-B,Anonymous
'@ | Set-Content -Encoding UTF8 "209_Anonymous_Pilot_Data\anonymous_pilot_couples.csv"

@'
# Anonymous Pilot Data

All pilot users must use aliases:
- Partner-A / Partner-B
- Family-A / Family-B
- Parent-A1 / Parent-B1
- Sibling-A1 / Friend-B1
- Seer-1 / Mentor-1

No real names, phone numbers, emails, addresses, medical details, or private identifiers should be entered into public testing.
'@ | Set-Content -Encoding UTF8 "209_Anonymous_Pilot_Data\Anonymous_Pilot_Data.md"

@'
rating_id,dimension,question,role,weight
PR001,Dharma,Do both partners act with fairness truthfulness restraint and dignity?,Partner,5
PR002,Artha,Can the partnership survive budget logistics work pressure and distance?,Partner,5
PR003,Kama,Is there joy affection companionship attraction and emotional warmth?,Partner,4
PR004,Moksha,Does the relationship support freedom growth peace and inner maturity?,Partner,4
FR001,Family Ecology,Do parents support without controlling the couple?,Family,5
FR002,Family Ecology,Can both families handle rituals gifts finances and expectations maturely?,Family,4
FR003,Family Ecology,Is the trusted circle reducing drama rather than amplifying it?,Trusted Circle,4
ER001,Emotional Safety,Can emotional dramas de-escalate without humiliation or coercion?,Partner,5
ER002,Repair,Can both partners apologize correct and retest behavior?,Partner,5
ER003,Trauma Bond Caution,Are repeated hurt-repair cycles creating unhealthy attachment?,Seer,5
MR001,Moment of Truth,Did the couple handle a difficult episode with maturity?,Seer,5
MR002,Wedding Launch,Is the relationship ready for a public family union milestone?,Seer,5
'@ | Set-Content -Encoding UTF8 "210_Pilot_Rating_Matrix\pilot_rating_matrix.csv"

@'
# Pilot Rating Matrix

Ratings are collected across:
- partners
- parents
- siblings
- close friends
- mentors / seers
- trusted observers

The matrix is anonymous and intended for constructive decision support.
'@ | Set-Content -Encoding UTF8 "210_Pilot_Rating_Matrix\Pilot_Rating_Matrix.md"

@'
seer_lens_id,lens_name,focus_area,example_question
SL001,Dharma Lens,Ethics and duty,What is the dharmic action that protects dignity and truth?
SL002,Artha Lens,Resources and logistics,Can the relationship survive budget distance time and responsibility?
SL003,Kama Lens,Joy and bonding,Is affection companionship and excitement being nourished?
SL004,Moksha Lens,Freedom and maturity,Does the partnership make both souls more peaceful and mature?
SL005,Family Ecosystem Lens,Family integration,Are the two family ecosystems supporting or destabilizing the union?
SL006,Modern Life Lens,America modern demands,Can the couple handle high demand careers cost time and mobility?
SL007,Recovery Lens,Sickness and repair,Can the bond allow rest recovery and compassionate support?
SL008,Wedding Launch Lens,Milestone readiness,Is the public union ready or does it need more incubation?
'@ | Set-Content -Encoding UTF8 "211_Seer_Lens_Model\seer_lens_catalog.csv"

@'
# Seer Lens Model

A seer is any trusted observer who can view the relationship through a constructive lens.

Seer guidance should:
- reduce drama
- clarify dharmic action
- protect dignity
- reveal blind spots
- preserve agency
- support maturity
- avoid gossip and coercion
'@ | Set-Content -Encoding UTF8 "211_Seer_Lens_Model\Seer_Lens_Model.md"

@'
signal_id,signal_name,description,weight
ED001,Escalation Spike,Conflict becomes louder faster or more public than needed,5
ED002,Humiliation Risk,One side feels shamed cornered or publicly reduced,5
ED003,Triangulation,Parents friends or siblings amplify rather than clarify,4
ED004,Withdrawal Freeze,One partner shuts down and cannot participate,4
ED005,Repair Attempt,Someone offers apology clarification correction or reassurance,-5
ED006,Reality Check,Facts are separated from feelings and assumptions,-4
ED007,Trauma Loop,Repeated hurt-repair-high attachment cycle appears,5
ED008,Boundaries Stated,Healthy boundary is stated without cruelty,-4
'@ | Set-Content -Encoding UTF8 "212_Emotional_Drama_Sanity_Check\emotional_drama_signals.csv"

@'
# Emotional Drama Sanity Check

The app should help users pause before confusing intensity with truth.

It asks:
- What are the facts?
- What are the feelings?
- What assumptions are being made?
- What old wound may be activated?
- What boundary is needed?
- What repair action is visible?
- What should be retested?
'@ | Set-Content -Encoding UTF8 "212_Emotional_Drama_Sanity_Check\Emotional_Drama_Sanity_Check.md"

@'
quadrant,definition,green_signal,yellow_signal,red_signal
Dharma,Duty ethics truth dignity,Accountability and fairness,Confusion and defensiveness,Coercion humiliation dishonesty
Artha,Resources logistics finance responsibility,Budget realism and teamwork,Stress but planning exists,Unsustainable cost distance or burden skew
Kama,Joy affection companionship bonding,Warmth humor attraction,Reduced joy but repairable,Contempt emotional coldness chronic resentment
Moksha,Freedom growth peace maturity,Both grow freer and wiser,One feels constrained but hopeful,Control fear loss of self or spiritual exhaustion
'@ | Set-Content -Encoding UTF8 "213_Purushartha_Risk_Map\purushartha_quadrants.csv"

@'
# Purushartha Risk Map

Every major relationship decision is evaluated through:
- Dharma
- Artha
- Kama
- Moksha

The app should not merely maximize romance. It should protect dharmic maturity, logistical realism, joy, and inner freedom together.
'@ | Set-Content -Encoding UTF8 "213_Purushartha_Risk_Map\Purushartha_Risk_Map.md"

@'
stage_id,stage_name,description,gate_question
WU001,Seed Chemistry,Initial attraction and curiosity,Is interest respectful and mutual?
WU002,Early Alignment,Values and direction,Do the partners want compatible futures?
WU003,Family Awareness,Family ecosystem enters,Can families observe without controlling?
WU004,Role Play Incubation,Stress tests and practical episodes,Can the couple handle real-life pressure?
WU005,Repair Retest,Correction after conflict,Does repair become visible behavior?
WU006,Budget Logistics Gate,Costs distance roles and relocation,Can the union survive real constraints?
WU007,Wedding Launch Gate,Public milestone readiness,Is the ecosystem ready to bless not burden?
WU008,Household Takeoff,Post-union stabilization,Can the couple operate as Team Us?
'@ | Set-Content -Encoding UTF8 "214_Wedding_Union_Staging\wedding_union_stages.csv"

@'
# Wedding Union Staging

A marital union is treated as a staged launch:
- seed
- incubation
- role play
- retest
- budget/logistics
- family blessing
- launch
- stabilization

No stage should be rushed merely for appearances.
'@ | Set-Content -Encoding UTF8 "214_Wedding_Union_Staging\Wedding_Union_Staging.md"

@'
# Relationship Incubation Dashboard

The dashboard tracks whether the relationship needs:
- nourishment
- time
- retest
- family boundary reset
- logistics planning
- budget substitution
- recovery rest
- exit review

The goal is to help the relationship blossom if it has dharmic viability.
'@ | Set-Content -Encoding UTF8 "215_Relationship_Incubation_Dashboard\Relationship_Incubation_Dashboard.md"

@'
# Decisioning Reports

Reports should include:
- anonymous pilot ID
- stage
- Purushartha quadrant scores
- emotional drama sanity score
- family ecosystem score
- role-play maturity
- wedding launch readiness
- continue / incubate / pause / exit recommendation
- coaching gaps
- retest plan
'@ | Set-Content -Encoding UTF8 "216_Decisioning_Reports\Decisioning_Reports.md"

@'
# v4.3 Release Notes

Adds anonymous pilot data, pilot rating matrix, seer lens model, emotional drama sanity check, Purushartha risk map, wedding union staging, relationship incubation dashboard, and decisioning reports.
'@ | Set-Content -Encoding UTF8 "217_Release_Notes\v4.3_Anonymous_Pilot_Decisioning.md"

@'
# v4.4 Backlog

## Theme

Real Anonymous Seed Data and Multi-Rater Engine

## Candidate Enhancements

- CSV upload for anonymous pilot data
- Multi-rater trusted-circle forms
- Seer lens selection
- Moment-of-truth episode logger
- Purushartha radar chart
- Incubation timeline
- Decision report export
- Game-mode transition from stage to stage
'@ | Set-Content -Encoding UTF8 "218_Backlog_vNext\v4.4_Backlog.md"

Write-Host "v4.3 assets merged." -ForegroundColor Green
