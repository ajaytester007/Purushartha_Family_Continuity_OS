$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v1.3 assets ==" -ForegroundColor Cyan

$Dirs = @(
"26_Local_App",
"27_SQLite_Event_Graph",
"28_Score_Calculator",
"29_Dashboard_Outputs",
"30_Evidence_Consent_Registry",
"31_Case_Simulator",
"32_Reports",
"33_Release_Notes",
"34_Test_Plan"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@"
# Release Notes — v1.3 Local Intelligence Foundation

## Purpose

v1.3 moves the project from documentation and publishing into a local intelligence foundation.

## Added

- One-command full flow
- Streamlit local app starter
- SQLite event graph schema
- SCD2 state schema
- Python score calculator
- Dashboard output generator
- Evidence registry template
- Consent ledger template
- Case simulator seed
- Family continuity report template
- Test plan

## Guardrail

This remains a consent-first decision-support system. It is not surveillance, diagnosis, legal advice, financial advice, or a substitute for professional support.
"@ | Set-Content -Encoding UTF8 "33_Release_Notes\v1.3_Local_Intelligence_Foundation.md"

@"
# Local App Overview

The local app is intended to run privately on the user's machine.

## Suggested Stack

- Python 3.11+
- Streamlit
- SQLite
- Pandas
- Mermaid Markdown export

## MVP Screens

1. Event Log
2. Relationship Score Calculator
3. Family Complexity Dashboard
4. Purushartha Balance Dashboard
5. Tollgate Recommendation
6. Wiki Export Summary

## Privacy Rule

Do not ingest private messages, health records, or media without explicit consent and purpose labeling.
"@ | Set-Content -Encoding UTF8 "26_Local_App\Local_App_Overview.md"

@"
import streamlit as st
import pandas as pd
from pathlib import Path

st.set_page_config(page_title='Purushartha OS Local App', layout='wide')

st.title('Purushartha Family Continuity OS')
st.caption('Consent-first relationship, family, wealth, resilience and legacy intelligence.')

root = Path(__file__).resolve().parents[1]
events_path = root / '20_Dashboard_Data' / 'synthetic_lifetime_events.csv'
metrics_path = root / '20_Dashboard_Data' / 'dashboard_metrics_seed.csv'

tab1, tab2, tab3 = st.tabs(['Journey Events', 'Metrics', 'Guidance'])

with tab1:
    st.header('Synthetic Lifetime Events')
    if events_path.exists():
        df = pd.read_csv(events_path)
        st.dataframe(df, use_container_width=True)
    else:
        st.warning('No synthetic_lifetime_events.csv found. Run merge scripts first.')

with tab2:
    st.header('Dashboard Metrics')
    if metrics_path.exists():
        df = pd.read_csv(metrics_path)
        st.dataframe(df, use_container_width=True)
        st.bar_chart(df.set_index('metric')['value'])
    else:
        st.warning('No dashboard_metrics_seed.csv found.')

with tab3:
    st.header('Operating Guardrail')
    st.write('This is decision support only. Do not use it for secret surveillance, diagnosis, or punishment.')
    st.write('Every score needs evidence, confidence, contradiction review, and a retest date.')
"@ | Set-Content -Encoding UTF8 "26_Local_App\app.py"

@"
# How to Run the Local App

From the main repo:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install streamlit pandas
streamlit run .\26_Local_App\app.py
```

The first version uses synthetic data only.
"@ | Set-Content -Encoding UTF8 "26_Local_App\Run_Local_App.md"

@"
-- Purushartha OS SQLite Event Graph Schema

CREATE TABLE IF NOT EXISTS person (
    person_id TEXT PRIMARY KEY,
    display_name TEXT,
    role_type TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS relationship_event (
    event_id TEXT PRIMARY KEY,
    timestamp TEXT NOT NULL,
    stage TEXT,
    domain TEXT,
    harm_level INTEGER,
    impact_score REAL,
    repair_score REAL,
    learning_score REAL,
    summary TEXT,
    confidence TEXT,
    consent_class TEXT
);

CREATE TABLE IF NOT EXISTS event_participant (
    event_id TEXT,
    person_id TEXT,
    participant_role TEXT,
    PRIMARY KEY (event_id, person_id),
    FOREIGN KEY (event_id) REFERENCES relationship_event(event_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE IF NOT EXISTS graph_edge (
    edge_id TEXT PRIMARY KEY,
    from_node TEXT,
    to_node TEXT,
    edge_type TEXT,
    source_event_id TEXT,
    confidence TEXT
);

CREATE TABLE IF NOT EXISTS scd2_relationship_state (
    state_id TEXT PRIMARY KEY,
    relationship_id TEXT,
    valid_from TEXT,
    valid_to TEXT,
    is_current INTEGER,
    relationship_health_score REAL,
    burden_skew_score REAL,
    karma_bond_score REAL,
    purushartha_balance_score REAL,
    source_event_ids TEXT,
    confidence TEXT
);
"@ | Set-Content -Encoding UTF8 "27_SQLite_Event_Graph\schema.sql"

@"
# SQLite Event Graph

## Purpose

The SQLite schema supports a local, auditable event graph.

## Tables

- person
- relationship_event
- event_participant
- graph_edge
- scd2_relationship_state

## SCD2 Rule

Never overwrite a major state change. Close the old state row and create a new current row.
"@ | Set-Content -Encoding UTF8 "27_SQLite_Event_Graph\SQLite_Event_Graph_Model.md"

@"
from __future__ import annotations
from dataclasses import dataclass
from math import prod
from typing import Iterable

@dataclass
class ScoreResult:
    name: str
    score: float
    interpretation: str

def geometric_mean(values: Iterable[float]) -> float:
    vals = [max(float(v), 0.01) for v in values]
    return prod(vals) ** (1 / len(vals))

def relationship_health_score(
    safety: float,
    trust: float,
    reciprocity: float,
    affection: float,
    respect: float,
    teamwork: float,
    repair: float,
    growth: float
) -> ScoreResult:
    values = [safety, trust, reciprocity, affection, respect, teamwork, repair, growth]
    score = geometric_mean(values)

    if safety < 40:
        interpretation = 'Safety override: route to protection review.'
    elif score >= 85:
        interpretation = 'Flourishing'
    elif score >= 70:
        interpretation = 'Healthy with work'
    elif score >= 55:
        interpretation = 'Strained'
    elif score >= 40:
        interpretation = 'High-risk deterioration'
    else:
        interpretation = 'Critical review'

    return ScoreResult('Relationship Health Score', round(score, 2), interpretation)

def burden_skew_score(actual_share_a: float, expected_share_a: float, duration_multiplier: float = 1.0,
                      involuntary_multiplier: float = 1.0, recognition_recovery_factor: float = 1.0) -> ScoreResult:
    skew = abs(actual_share_a - expected_share_a)
    adjusted = skew * duration_multiplier * involuntary_multiplier / max(recognition_recovery_factor, 0.1)

    if adjusted >= 50:
        interpretation = 'Structural imbalance'
    elif adjusted >= 35:
        interpretation = 'Intervention needed'
    elif adjusted >= 20:
        interpretation = 'Review needed'
    else:
        interpretation = 'Within workable range'

    return ScoreResult('Burden Skew Score', round(adjusted, 2), interpretation)

if __name__ == '__main__':
    print(relationship_health_score(80, 75, 70, 72, 85, 78, 65, 74))
    print(burden_skew_score(80, 50, 1.2, 1.3, 0.8))
"@ | Set-Content -Encoding UTF8 "28_Score_Calculator\score_calculator.py"

@"
# Score Calculator

## Functions

- relationship_health_score
- burden_skew_score

## Next Functions

- karma_bond_accumulator
- family_complexity_adjusted_qol
- gifted_child_opportunity_load
- purushartha_balance
"@ | Set-Content -Encoding UTF8 "28_Score_Calculator\Score_Calculator.md"

@"
# Dashboard Outputs

This folder contains generated dashboard summaries.

The v1.3 script creates:

- dashboard_summary.md
- relationship_health_snapshot.csv
- metric_status_summary.csv
"@ | Set-Content -Encoding UTF8 "29_Dashboard_Outputs\Dashboard_Outputs.md"

@"
registry_id,source_type,source_name,owner,consent_class,purpose,allowed_analysis,retention_status,notes
R001,synthetic_csv,synthetic_lifetime_events,project,A,testing,dashboard_and_maps,retain,Synthetic only
R002,synthetic_csv,dashboard_metrics_seed,project,A,testing,dashboard,retain,Synthetic only
"@ | Set-Content -Encoding UTF8 "30_Evidence_Consent_Registry\evidence_registry.csv"

@"
consent_id,participant,record_id,status,allowed_viewers,allowed_analysis,retention_until,revoked_at
C001,synthetic_user,R001,active,project_team,dashboard_and_maps,, 
C002,synthetic_user,R002,active,project_team,dashboard,, 
"@ | Set-Content -Encoding UTF8 "30_Evidence_Consent_Registry\consent_ledger.csv"

@"
# Evidence and Consent Registry

## Rule

No evidence enters the system without:

- source type
- owner
- consent class
- purpose
- allowed analysis
- retention status

Synthetic data is explicitly labeled synthetic.
"@ | Set-Content -Encoding UTF8 "30_Evidence_Consent_Registry\Evidence_Consent_Registry.md"

@"
case_id,title,stage,primary_domain,harm_level,recommended_tollgate,expected_action
CASE001,Family Boundary Bypass,Family Integration,Boundaries,3,Continue Correct Reconsider Exit,Boundary meeting and retest
CASE002,Household Burden Skew,Marriage,Household,2,Continue Correct Reconsider Exit,30-day rebalance
CASE003,Gifted Child Capture,Parenting,Gifted Child,2,Pregnancy or Parenting Readiness,Protect sibling and couple floors
CASE004,Midlife Drift,Midlife,Lifestyle Drift,2,Crisis Mode or Renewal,Second spring reset
CASE005,New Partner Coauthorship,Recovery,Continuity,1,New Partner Entry,Continuity brief and renegotiation window
"@ | Set-Content -Encoding UTF8 "31_Case_Simulator\case_simulator_seed.csv"

@"
# Case Simulator

The case simulator will test the decision engine using synthetic relationship and family events.

## Required Output Per Case

- facts
- harm level
- affected domains
- confidence
- tollgate
- recommended action
- retest period
"@ | Set-Content -Encoding UTF8 "31_Case_Simulator\Case_Simulator.md"

@"
# Family Continuity Report Template

## Executive Summary

## Current Life Stage

## Relationship Health

## Burden Skew

## Family Complexity

## Wealth and Resilience

## Purushartha Balance

## Active Risks

## Repair Actions

## Continuity Actions

## Review Date

## Professional Review Needed
Legal:
Medical:
Financial:
Mental health:
Child development:
"@ | Set-Content -Encoding UTF8 "32_Reports\Family_Continuity_Report_Template.md"

@"
# v1.3 Test Plan

## Tests

1. Run full flow from main repo.
2. Validate 100+ Markdown files.
3. Generate Mermaid map.
4. Generate dashboard outputs.
5. Publish Wiki.
6. Push main repo.
7. Confirm Wiki Home page renders.
8. Confirm sidebar includes v1.3 release notes.
9. Confirm no ZIP files are committed.
10. Confirm no private real data is published.

## Pass Criteria

All scripts complete without fatal error. GitHub main repo and Wiki both show v1.3 changes.
"@ | Set-Content -Encoding UTF8 "34_Test_Plan\v1.3_Test_Plan.md"

Write-Host "v1.3 assets merged successfully." -ForegroundColor Green
