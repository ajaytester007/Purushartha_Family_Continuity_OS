$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v2.0 assets ==" -ForegroundColor Cyan

$Dirs = @(
"75_Workbench_Architecture",
"76_Governance_Cockpit",
"77_Report_Builder",
"78_Public_Private_Modes",
"79_Workbench_Operating_Model",
"80_Release_Notes",
"81_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v2.0 Local Relationship Intelligence Workbench

## Purpose

v2.0 consolidates the repo, Wiki, Pages, Streamlit MVP, case engine, event graph, SCD2 timeline, consent model, and report layer into a coherent local workbench architecture.

## Added

- Workbench architecture.
- Governance cockpit model.
- Public demo vs private local mode.
- Report builder templates.
- Graph-to-report synthesis.
- SCD2 state change protocol.
- v2.1 backlog.

## Operating Principle

The workbench is not a surveillance or blame machine. It is an explainable, consent-first decision-support system for maturity, repair, resilience, and continuity.
'@ | Set-Content -Encoding UTF8 "80_Release_Notes\v2.0_Local_Relationship_Intelligence_Workbench.md"

@'
# Workbench Architecture

## Four Layers

1. Knowledge Layer
   - Relationship etiquette bible
   - Life journey books
   - Purushartha governance
   - Playbooks and templates

2. Evidence and Consent Layer
   - Consent ledger
   - Evidence registry
   - Retention policy
   - Public/private separation

3. Intelligence Layer
   - Scoring models
   - Case engine
   - Tollgate rules
   - Event graph
   - SCD2 state timeline

4. Experience Layer
   - GitHub Pages public site
   - GitHub Wiki knowledgebase
   - Streamlit local MVP
   - Markdown reports

## Deployment Roles

- GitHub Repo: source of truth
- GitHub Wiki: knowledgebase
- GitHub Pages: public experience
- Streamlit: interactive MVP
- Local SQLite: private workbench state
'@ | Set-Content -Encoding UTF8 "75_Workbench_Architecture\Workbench_Architecture.md"

@'
# Governance Cockpit

## Purpose

The governance cockpit prevents the system from becoming invasive, punitive, or overconfident.

## Panels

1. Consent Status
2. Evidence Quality
3. Safety Override
4. Confidence Level
5. Contradiction Review
6. Retest Date
7. Professional Review Needed
8. Public/Private Classification

## Required Rule

No recommendation is complete unless it has:

- evidence basis
- confidence label
- affected parties
- recommended action
- retest date or review owner
'@ | Set-Content -Encoding UTF8 "76_Governance_Cockpit\Governance_Cockpit.md"

@'
# Report Builder

## Report Types

1. Relationship Health Report
2. Burden Skew Audit
3. Family Continuity Report
4. Parenting Load Report
5. Gifted Child Opportunity Load Report
6. New Partner Entry Report
7. Crisis Recovery Report
8. Legacy Transition Report

## Standard Sections

- Summary
- Stage
- Scores
- Graph findings
- SCD2 state
- Risks
- Repairs
- Retest plan
- Consent and evidence notes
- Professional review needed
'@ | Set-Content -Encoding UTF8 "77_Report_Builder\Report_Builder.md"

@'
# Public Demo Mode vs Private Local Mode

## Public Demo Mode

Safe for GitHub, Wiki, Pages, and public Streamlit demo.

Allowed:
- Synthetic cases
- Synthetic scores
- Generic examples
- Public documentation

Forbidden:
- Real private messages
- Health records
- intimate correspondence
- third-party private information
- secret recordings

## Private Local Mode

Runs on the user's machine with explicit consent and retention rules.

Private mode still requires:

- consent ledger
- evidence registry
- purpose statement
- retention rule
- viewer rule
'@ | Set-Content -Encoding UTF8 "78_Public_Private_Modes\Public_Private_Modes.md"

@'
# Workbench Operating Model

## Weekly Review

- New events
- New repairs
- Burden changes
- Family complexity changes
- Financial or household stress
- Relationship health trend
- Retest commitments

## Monthly Review

- Purushartha balance
- Family QoL
- Children and dependents
- Wealth resilience
- Support network
- Lifestyle and joy

## Crisis Review

- Safety
- Health
- Housing
- Liquidity
- Dependents
- Legal/professional review
- Communication floor
'@ | Set-Content -Encoding UTF8 "79_Workbench_Operating_Model\Workbench_Operating_Model.md"

@'
# v2.1 Backlog

## Theme

Streamlit Workbench Upgrade

## Candidate Enhancements

- Multi-page Streamlit app.
- Graph tab using Mermaid or network visualization.
- SCD2 state editor.
- Consent ledger editor.
- Report-builder UI.
- Case comparison dashboard.
- Export ZIP for reports.
- Private/local mode switch.
- Public demo mode lock.
'@ | Set-Content -Encoding UTF8 "81_Backlog_vNext\v2.1_Backlog.md"

Write-Host "v2.0 assets merged successfully." -ForegroundColor Green
