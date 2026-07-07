$ErrorActionPreference = "Stop"
Write-Host "== Merging Purushartha OS v1.2 assets ==" -ForegroundColor Cyan

$Dirs = @(
"19_Scoring_Workbook",
"20_Dashboard_Data",
"21_Auto_Maps",
"22_Wiki_Publishing",
"23_Case_Library",
"24_Release_Notes",
"25_Quality_Gates"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@"
# Release Notes — v1.2 Publisher and Dashboard Foundation

v1.2 turns the knowledgebase into a repeatable publishing and dashboard-ready foundation.

## Added

- PowerShell-only repository validation
- PowerShell-only Wiki publisher
- Scoring workbook CSVs
- Synthetic lifetime event dataset
- Dashboard seed data
- Auto-generated Mermaid maps
- Wiki Home and Sidebar regeneration
- Git publish helper for main repo and Wiki repo
"@ | Set-Content -Encoding UTF8 "24_Release_Notes\v1.2_Publisher_Dashboard_Foundation.md"

@"
# v1.2 to v2.0 Roadmap

## v1.3
- Streamlit local application
- SQLite event graph
- Score calculator
- Tollgate recommendation engine

## v2.0
- Full relationship intelligence workbench
- Consent ledger enforcement
- SCD2 state history
- Case simulator
- Exportable family continuity reports
"@ | Set-Content -Encoding UTF8 "24_Release_Notes\Roadmap_v1.2_to_v2.0.md"

@"
score_name,dimension,weight,max_score,description
Individual Partnership Maturity,Self Awareness,10,100,Ability to notice own motives and patterns
Individual Partnership Maturity,Empathy,10,100,Ability to understand partner impact
Individual Partnership Maturity,Honesty,10,100,Truthfulness and transparency
Individual Partnership Maturity,Accountability,15,100,Ownership without blame shifting
Individual Partnership Maturity,Repair Ability,15,100,Specific apology and changed behavior
Individual Partnership Maturity,Boundary Competence,10,100,Respect for personal and couple boundaries
Individual Partnership Maturity,Reliability,10,100,Follow-through and consistency
Individual Partnership Maturity,Emotional Regulation,10,100,Ability to remain proportionate
Individual Partnership Maturity,Adaptability,10,100,Visible learning after feedback
Relationship Health,Safety,20,100,Physical emotional and relational safety
Relationship Health,Trust,15,100,Confidence in words actions and transparency
Relationship Health,Reciprocity,10,100,Mutual effort and fairness
Relationship Health,Affection,10,100,Warmth tenderness and closeness
Relationship Health,Respect,15,100,Dignity during ease and conflict
Relationship Health,Teamwork,10,100,Shared problem solving
Relationship Health,Repair,10,100,Quality of rupture repair
Relationship Health,Growth,10,100,Upward maturity trend
"@ | Set-Content -Encoding UTF8 "19_Scoring_Workbook\scoring_dimensions.csv"

@"
event_id,timestamp,stage,participants,domain,harm_level,impact_score,repair_score,learning_score,summary
E001,2026-01-05T19:00:00,New Relationship,A|B,Communication,1,20,55,60,Delayed reply exposed unclear cadence expectations
E002,2026-02-14T20:00:00,Exclusivity,A|B,Effort,2,45,40,50,One partner failed to plan agreed celebration
E003,2026-04-01T21:00:00,Family Integration,A|B|Family,Boundaries,3,70,20,30,Family pressure bypassed couple decision rights
E004,2027-05-10T09:00:00,Marriage,A|B,Household,2,50,65,70,Chronic uneven chore initiation entered repair plan
E005,2030-09-01T08:00:00,Parenting,A|B|Child1,Gifted Child,2,60,70,75,Training pathway created sibling fairness concern
E006,2036-06-15T18:30:00,Midlife,A|B,Lifestyle Drift,2,55,45,40,Shared activities declined and clutter rose
E007,2042-03-08T17:00:00,Renewal,A|B,Second Spring,0,10,85,90,Couple restarted health and shared play routines
E008,2058-11-20T10:00:00,Aging,A|B,Caregiving,1,35,80,85,Role changes required dignity-centered support plan
"@ | Set-Content -Encoding UTF8 "20_Dashboard_Data\synthetic_lifetime_events.csv"

@"
metric,stage,value,threshold,status
Relationship Health,New Relationship,78,70,Healthy
Relationship Health,Family Integration,61,70,Needs Review
Burden Skew,Marriage,38,35,Intervention
Gifted Opportunity Load,Parenting,82,75,High Opportunity Load
Family QoL,Midlife,64,70,Needs Support
Purushartha Balance,Renewal,86,75,Flourishing
Wealth Resilience,Aging,79,70,Stable
"@ | Set-Content -Encoding UTF8 "20_Dashboard_Data\dashboard_metrics_seed.csv"

@"
# Dashboard Data Dictionary

## synthetic_lifetime_events.csv
Synthetic events across life stages for testing dashboards, maps, and scoring.

## dashboard_metrics_seed.csv
Stage-level metrics for quick visualization.

## Future Required Columns
confidence, consent_class, source_event_ids, reviewer_status, retest_date, safety_override.
"@ | Set-Content -Encoding UTF8 "20_Dashboard_Data\Data_Dictionary.md"

@"
flowchart LR
A[New Relationship] --> B[Exclusivity]
B --> C[Family Integration]
C --> D[Marriage]
D --> E[Parenting]
E --> F[Midlife]
F --> G[Renewal]
G --> H[Aging]
C -. boundary injury .-> C1[Repair Tollgate]
D -. burden skew .-> D1[Household Rebalance]
E -. gifted child load .-> E1[Family QoL Review]
F -. drift .-> F1[Second Spring Reset]
"@ | Set-Content -Encoding UTF8 "21_Auto_Maps\synthetic_lifetime_journey.mmd"

@"
flowchart TD
HH[Household Capacity] --> P1[Partner A]
HH --> P2[Partner B]
HH --> C1[Child 1 Gifted Pathway]
HH --> C2[Child 2 Sibling Fairness]
C1 --> L1[Opportunity Load]
L1 --> B1[Budget]
L1 --> T1[Travel]
L1 --> TIME[Parental Time]
TIME --> CC[Couple Connection Floor]
TIME --> SF[Sibling Fairness Floor]
SF --> QOL[Complexity Adjusted QoL]
CC --> QOL
"@ | Set-Content -Encoding UTF8 "21_Auto_Maps\gifted_child_load_map.mmd"

@"
# Wiki Publishing Model

Main source repository:

`C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`

Wiki repository:

`C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

The publish script copies selected Markdown files, flattens names, regenerates Home, Sidebar, and Footer, commits, and pushes the Wiki.
"@ | Set-Content -Encoding UTF8 "22_Wiki_Publishing\Wiki_Publishing_Model.md"

@"
# Quality Gates

Before publishing:
- Main repo must be a Git repository.
- Wiki repo must be a Git repository.
- README.md must exist.
- Core folders must exist.
- Markdown count should be greater than 50 for full publication.
- Wiki Home and Sidebar must regenerate.
- Git status should be reviewed before push.

Safety gates:
- Do not publish private real relationship logs.
- Do not publish real names without consent.
- Do not publish health records or intimate correspondence.
"@ | Set-Content -Encoding UTF8 "25_Quality_Gates\Quality_Gates.md"

@"
# Case Library Index

## Synthetic Cases

1. First Failure and Repair
2. Gifted Child Family Capture
3. Bereavement and New Partner Entry
4. Family Boundary Bypass
5. Household Burden Skew
6. Midlife Drift and Second Spring
7. Financial Secrecy and Recovery
8. Ex-Boundary Stress
9. Elder Care Load Shift
10. New Partner Coauthorship
"@ | Set-Content -Encoding UTF8 "23_Case_Library\Case_Library_Index.md"

Write-Host "v1.2 assets merged successfully." -ForegroundColor Green
