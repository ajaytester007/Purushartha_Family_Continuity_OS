#!/usr/bin/env bash
set -euo pipefail

echo "== Purushartha Family Continuity OS: merging v1.1 assets =="

ROOT="$(pwd)"
mkdir -p \
  13_Publishing \
  14_Dashboards \
  15_Event_Graph \
  16_Scoring_Formulas \
  17_Synthetic_Datasets \
  18_Local_App_Blueprint \
  docs \
  .github/workflows

cat > CHANGELOG.md <<'EOF'
# Changelog

## v1.1 — Publishing and Intelligence Foundation

Added:
- Master documentation index
- Publishing snapshot workflow
- Relationship intelligence event graph model
- Scoring formula starter pack
- Dashboard specification
- Synthetic dataset seed
- Local app blueprint
- Repository validation script
- GitHub Pages docs entry point

This version keeps v1.0 intact and adds publish-ready operational layers.
EOF

cat > 13_Publishing/Master_Index.md <<'EOF'
# Master Index

## Constitution
- Life Vision Charter
- Privacy and Consent Policy
- Partner Handoff Protocol
- Children and Dependents Rights
- Exit, Divorce, Death, Disaster Continuity
- Purushartha Governance Model

## Intelligence Core
- Scoring Engines
- Tollgates
- Incident and Tort Library
- Evidence Models
- SCD2 State Model
- Decision Engine

## Journey Books
Books 01–20 cover self-readiness through ancestral legacy.

## Operating Use
Start with:
1. Relationship Event Log
2. Partner Maturity Assessment
3. Monthly Couple Review
4. Family QoL Dashboard
5. Purushartha Life Audit
EOF

cat > 13_Publishing/Publishing_Guide.md <<'EOF'
# Publishing Guide

## Local Publishing

Use the publish script:

```bash
bash merge_scripts/publish_snapshot.sh
```

It creates a timestamped snapshot under `_published/`.

## Git Publishing

Recommended commands:

```bash
git add .
git commit -m "Add v1.1 publishing and intelligence foundation"
git tag v1.1
git push origin main --tags
```

## GitHub Pages

The `docs/index.md` file can be used as a GitHub Pages entry point.
EOF

cat > docs/index.md <<'EOF'
# Purushartha Family Continuity OS

A consent-first relationship, family continuity, wealth, and legacy intelligence framework.

## Start Here

- [Master Index](../13_Publishing/Master_Index.md)
- [Life Vision Charter](../00_Constitution/Life_Vision_Charter.md)
- [Relationship Etiquette Bible](../01_Knowledgebase/Relationship_Etiquette_Bible.md)
- [Karma Bond Accumulator](../03_Scoring_Engines/Karma_Bond_Accumulator.md)
- [Continue Correct Reconsider Exit](../04_Tollgates_and_Decision_Models/Continue_Correct_Reconsider_Exit.md)
EOF

cat > 15_Event_Graph/Event_Graph_Model.md <<'EOF'
# Relationship Event Graph Model

## Node Types

- Person
- Relationship
- Household
- Child
- Dependent
- Event
- Obligation
- Incident
- Repair
- Tollgate
- Asset
- Risk
- Tradition
- Support Source
- Influence Source

## Edge Types

- supports
- harms
- depends_on
- influences
- repairs
- repeats
- escalates
- deescalates
- replaces_role_context
- coauthors_future
- creates_obligation
- consumes_capacity
- protects_floor

## Principle

A new partner may connect to the life graph through coauthorship edges, not by inheriting the predecessor's identity or private archive.
EOF

cat > 16_Scoring_Formulas/Formula_Index.md <<'EOF'
# Scoring Formula Index

All formulas are decision-support indicators, not verdicts.

## Core Formulas

1. Individual Partnership Maturity Score
2. Relationship Health Score
3. Trust Damage and Repair Score
4. Karma Bond Accumulator
5. Emotional Baggage Index
6. Burden Skew Index
7. Family Complexity-Adjusted QoL
8. Gifted Child Opportunity Load
9. Wealth and Resilience Score
10. Purushartha Balance Quadrant

## Universal Output

Every score must include:
- score
- confidence
- source events
- contradictions
- trend
- next action
- retest date
EOF

cat > 16_Scoring_Formulas/Relationship_Health_Formula.md <<'EOF'
# Relationship Health Formula

## Dimensions

Safety, Trust, Reciprocity, Affection, Respect, Teamwork, Repair, Growth.

Each dimension: 0–100.

## Formula

Use geometric mean:

```text
RHS = (Safety × Trust × Reciprocity × Affection × Respect × Teamwork × Repair × Growth)^(1/8)
```

## Safety Override

If Safety < 40, the composite is not used for continue decisions. Route to protection review.

## Interpretation

85–100 Flourishing  
70–84 Healthy with work  
55–69 Strained  
40–54 High-risk deterioration  
Below 40 Critical review
EOF

cat > 16_Scoring_Formulas/Burden_Skew_Formula.md <<'EOF'
# Burden Skew Formula

## Inputs

For each household domain:
- expected share
- actual share
- voluntariness
- duration
- recognition
- recovery opportunity

## Formula

```text
Skew = abs(actual_share_A - expected_share_A)
Adjusted_Skew = Skew × Duration_Multiplier × Involuntary_Multiplier ÷ Recognition_Recovery_Factor
```

## Flags

- Above 20: review
- Above 35: intervention
- Above 50: structural imbalance
EOF

cat > 16_Scoring_Formulas/Family_Complexity_QoL_Formula.md <<'EOF'
# Family Complexity-Adjusted Quality of Life Formula

## Raw QoL Domains

Health, Rest, Couple Connection, Children/Dependents, Finance, Home Environment, Joy, Community.

## Interpretation

```text
Raw_QoL = average(domain_scores)
Complexity_Load = weighted_sum(care_needs, gifted_opportunity, illness, eldercare, crisis, work_intensity)
Adjusted_Interpretation = Raw_QoL contextualized by Complexity_Load and Protected_Floors
```

## Required Warning

Do not use complexity adjustment to hide suffering. Protected floors must be shown separately.
EOF

cat > 14_Dashboards/Dashboard_Specification.md <<'EOF'
# Dashboard Specification

## Views

1. Life Journey Timeline
2. Relationship Health
3. Karma Bond Accumulator
4. Burden Skew
5. Family Complexity QoL
6. Children and Opportunity Load
7. Wealth and Resilience
8. Purushartha Quadrant
9. Crisis Mode
10. New Partner Entry

## Design Rule

Every chart must answer:
- What changed?
- Why might it matter?
- What evidence supports it?
- What action is recommended?
- When will it be reviewed?
EOF

cat > 17_Synthetic_Datasets/synthetic_relationship_events.csv <<'EOF'
event_id,timestamp,stage,participants,harm_level,domain,summary,repair_status,confidence
E001,2026-01-05T19:00:00,New Relationship,A|B,1,communication,Delayed reply caused anxiety; expectation not yet explicit,discussed,medium
E002,2026-02-14T20:00:00,Exclusivity,A|B,2,effort,One partner failed to plan agreed celebration,partial_repair,medium
E003,2026-04-01T21:00:00,Family Integration,A|B|Family,3,boundaries,Family pressure bypassed couple decision rights,open,medium
E004,2027-05-10T09:00:00,Marriage,A|B,2,household,Chronic uneven chore initiation,repair_plan,high
E005,2030-09-01T08:00:00,Parenting,A|B|Child1,2,gifted_child,Training schedule created sibling fairness concern,intervention_started,medium
EOF

cat > 18_Local_App_Blueprint/Local_App_Blueprint.md <<'EOF'
# Local App Blueprint

## MVP Stack

- Python
- SQLite
- Markdown repository as knowledgebase
- Mermaid for diagrams
- Streamlit or FastAPI UI
- JSON schemas for validation

## MVP Features

1. Create relationship event
2. Link event to stage
3. Classify harm level
4. Calculate starter scores
5. Generate Mermaid map
6. Produce tollgate recommendation
7. Export monthly review
8. Publish static docs snapshot

## Guardrails

- No secret ingestion
- Consent ledger required
- Confidence labels mandatory
- Safety override mandatory
EOF

cat > .github/workflows/validate.yml <<'EOF'
name: Validate Repository

on:
  push:
  pull_request:

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Validate markdown and required structure
        run: bash merge_scripts/validate_repo.sh
EOF

echo "v1.1 merge complete."
echo "Next:"
echo "  bash merge_scripts/validate_repo.sh"
echo "  bash merge_scripts/publish_snapshot.sh"
