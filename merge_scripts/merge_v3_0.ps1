$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v3.0 assets ==" -ForegroundColor Cyan

$Dirs = @(
"127_Family_Continuity_Intelligence_Suite",
"128_Suite_Architecture",
"129_Release_Dashboard",
"130_Capability_Matrix",
"131_Maturity_Model",
"132_Release_Notes",
"133_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v3.0 Family Continuity Intelligence Suite

## Purpose

v3.0 consolidates the Purushartha Family Continuity OS into an integrated intelligence suite.

## Integrated Capabilities

- Relationship etiquette knowledgebase
- Life journey books
- Case engine
- Tollgate rules
- Repair plans
- Retest scheduling
- Reports cockpit
- Interactive report builder
- Consent ledger
- Evidence governance
- Graph explorer
- SCD2 state editor
- Public demo lock
- Private local mode
- Scenario simulator
- GitHub Wiki publishing
- GitHub Pages public site
- Streamlit workbench

## Operating Principle

The suite is a consent-first continuity workbench. It supports maturity, repair, resilience, and decision clarity. It is not a surveillance, punishment, diagnosis, or legal decision system.
'@ | Set-Content -Encoding UTF8 "132_Release_Notes\v3.0_Family_Continuity_Intelligence_Suite.md"

@'
# Family Continuity Intelligence Suite

## Purpose

The v3.0 suite helps a household or relationship steward manage continuity across relationship, marriage, parenting, crisis, recovery, wealth, and legacy phases.

## Suite Pillars

1. Knowledge
2. Governance
3. Scoring
4. Case Reasoning
5. Graph Intelligence
6. State History
7. Reports
8. Simulation
9. Public/Private Deployment

## Suite Question

How do we preserve dignity, safety, repair, clarity, continuity, and family flourishing across time?
'@ | Set-Content -Encoding UTF8 "127_Family_Continuity_Intelligence_Suite\Family_Continuity_Intelligence_Suite.md"

@'
# Suite Architecture v3.0

## Source Layer

- Synthetic cases
- Consent ledger
- Evidence registry
- Local event log
- SCD2 state history
- Event graph seeds
- Scenario seed data

## Intelligence Layer

- Scoring engines
- Tollgate rules
- Scenario simulator
- Graph explorer
- State transition model
- Repair plan generator

## Experience Layer

- Streamlit workbench
- GitHub Wiki
- GitHub Pages
- Markdown reports
- Mermaid maps

## Governance Layer

- Public demo lock
- Private local mode
- Publication approval gate
- Sanitization checklist
- Consent-aware ingestion rules
'@ | Set-Content -Encoding UTF8 "128_Suite_Architecture\Suite_Architecture_v3_0.md"

@'
# v3.0 Release Dashboard

## Live Surfaces

- GitHub Repo
- GitHub Wiki
- GitHub Pages
- Streamlit App

## Major Workbench Screens

- Dashboard
- Event Entry
- Cases
- Scores
- Reports Cockpit
- Report Builder
- Roadmap
- Graph Explorer
- SCD2 State Editor
- Scenario Simulator
- Governance
- Consent Ledger

## Release Status

v3.0 completes the first integrated suite milestone.
'@ | Set-Content -Encoding UTF8 "129_Release_Dashboard\v3_0_Release_Dashboard.md"

@'
capability,status,public_demo_ready,private_local_ready,notes
Knowledgebase,Complete,Yes,Yes,Relationship etiquette and life journey books
Case Engine,Complete,Yes,Yes,Synthetic case reasoning
Reports Cockpit,Complete,Yes,Yes,Manifest and report previews
Report Builder,Complete,Yes,Yes,Markdown report generation
Consent Ledger,Foundation,Demo,Yes,Cloud persistence limited
Evidence Governance,Foundation,Demo,Yes,Requires local/private use for real data
Graph Explorer,Complete,Yes,Yes,Filters and Mermaid export
SCD2 State Editor,Foundation,Demo,Yes,Controlled state transitions
Scenario Simulator,Foundation,Yes,Yes,Path comparison model
Public Demo Lock,Foundation,Yes,N/A,Synthetic-only online safety
Private Local Mode,Foundation,N/A,Yes,Do not commit private data
'@ | Set-Content -Encoding UTF8 "130_Capability_Matrix\v3_0_capability_matrix.csv"

@'
# Capability Matrix v3.0

The capability matrix summarizes what the suite can do and whether it is appropriate for public demo or private local use.
'@ | Set-Content -Encoding UTF8 "130_Capability_Matrix\Capability_Matrix_v3_0.md"

@'
# Maturity Model v3.0

## Level 1 - Knowledgebase

The system documents relationship principles, etiquette, and journey maps.

## Level 2 - Structured Decision Support

The system supports cases, scoring, tollgates, repair plans, and retest schedules.

## Level 3 - Interactive Workbench

The system supports Streamlit screens for reports, graph, SCD2 state, consent, and scenarios.

## Level 4 - Governed Local Intelligence

The system enforces consent, public/private boundaries, publication gates, and local privacy.

## Level 5 - Family Continuity Suite

The system integrates relationship maturity, household continuity, parenting complexity, wealth resilience, crisis recovery, and legacy planning.
'@ | Set-Content -Encoding UTF8 "131_Maturity_Model\Maturity_Model_v3_0.md"

@'
# v3.1 Backlog

## Theme

Production Hardening and Test Automation

## Candidate Enhancements

- Unit tests for scoring functions.
- App smoke tests.
- GitHub Actions validation workflow.
- Streamlit app health check.
- CSV schema validation.
- Report snapshot tests.
- Public demo lock test.
- Wiki publish dry-run mode.
- Release checklist automation.
'@ | Set-Content -Encoding UTF8 "133_Backlog_vNext\v3.1_Backlog.md"

Write-Host "v3.0 assets merged successfully." -ForegroundColor Green
