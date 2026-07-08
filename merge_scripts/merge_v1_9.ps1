$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v1.9 assets ==" -ForegroundColor Cyan

$Dirs = @(
"68_Event_Graph_Engine",
"69_SCD2_State_Engine",
"70_Consent_Aware_Ingestion",
"71_Graph_Reports",
"72_Streamlit_Graph_Upgrade",
"73_Release_Notes",
"74_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v1.9 Event Graph Visualizer and SCD2 State Engine

## Purpose

v1.9 adds a graph layer that turns relationship and family events into nodes, edges, and visual maps. It also introduces an SCD2-style state updater model.

## Added

- Event graph node seed.
- Event graph edge seed.
- Graph-to-Mermaid generator.
- Graph validation script.
- SCD2 state updater model.
- Consent-aware ingestion rules.
- Graph report generator.
- Streamlit graph upgrade documentation.
- v2.0 local intelligence workbench backlog.

## Guardrail

Graph edges are not judgments. They are explainable relationships between events, risks, obligations, repairs, and support sources.
'@ | Set-Content -Encoding UTF8 "73_Release_Notes\v1.9_Event_Graph_and_SCD2_State_Engine.md"

@'
node_id,node_type,label,stage,domain,confidence,notes
N001,Person,Partner A,All,Person,medium,Synthetic person node
N002,Person,Partner B,All,Person,medium,Synthetic person node
N003,Relationship,Primary Relationship,All,Relationship,medium,Synthetic relationship node
N004,Event,Family Boundary Bypass,Family Integration,Boundaries,medium,Synthetic case event
N005,Event,Household Burden Skew,Marriage,Household,high,Synthetic burden event
N006,Event,Gifted Child Overload,Parenting,Gifted Child,medium,Synthetic parenting event
N007,Repair,Boundary Meeting,Family Integration,Repair,medium,Repair action
N008,Repair,Household Rebalance,Marriage,Repair,medium,Repair action
N009,Tollgate,Continue Correct Reconsider Exit,All,Tollgate,high,Decision model
N010,Tollgate,Parenting Load Tollgate,Parenting,Tollgate,medium,Parenting load decision model
N011,Risk,Sibling Fairness Risk,Parenting,Sibling Fairness,medium,Risk created by opportunity load
N012,Support,Family Support Network,All,Support,medium,Support source
N013,Asset,Household Resilience,All,Wealth,medium,Resilience asset
N014,Obligation,Pet Care Obligation,Expanded Household,Pet Care,medium,Household obligation
N015,State,SCD2 Relationship State,All,State,medium,State history node
'@ | Set-Content -Encoding UTF8 "68_Event_Graph_Engine\event_graph_nodes.csv"

@'
edge_id,from_node,to_node,edge_type,source_event_id,confidence,notes
E001,N001,N003,participates_in,,medium,Partner A participates in relationship
E002,N002,N003,participates_in,,medium,Partner B participates in relationship
E003,N004,N009,routes_to,CASE004,medium,Boundary bypass routes to tollgate
E004,N005,N009,routes_to,CASE007,high,Burden skew routes to correction model
E005,N006,N010,routes_to,CASE012,medium,Gifted child overload routes to parenting load review
E006,N007,N004,repairs,CASE004,medium,Boundary meeting repairs family bypass
E007,N008,N005,repairs,CASE007,medium,Household rebalance repairs burden skew
E008,N006,N011,creates_risk,CASE012,medium,Gifted child load creates sibling fairness risk
E009,N012,N003,supports,,medium,Support network supports relationship
E010,N013,N003,protects_floor,,medium,Household resilience protects relationship
E011,N014,N005,consumes_capacity,CASE014,medium,Pet care obligation contributes to capacity load
E012,N015,N003,describes_state,,medium,SCD2 state describes relationship
'@ | Set-Content -Encoding UTF8 "68_Event_Graph_Engine\event_graph_edges.csv"

@'
# Event Graph Engine

## Purpose

The event graph makes relationship intelligence navigable.

## Nodes

Person, Relationship, Event, Repair, Tollgate, Risk, Support, Asset, Obligation, State.

## Edges

participates_in, routes_to, repairs, creates_risk, supports, protects_floor, consumes_capacity, describes_state.

## Interpretation Rule

Edges indicate a traceable relationship between concepts. They are not moral verdicts.
'@ | Set-Content -Encoding UTF8 "68_Event_Graph_Engine\Event_Graph_Engine.md"

@'
# SCD2 State Engine

## Purpose

SCD2 state preserves a history of changing relationship and household conditions.

## Operation

When a material event changes a tracked state:

1. Close the current state row with valid_to.
2. Create a new current row.
3. Preserve source events and confidence.
4. Never overwrite history.

## v1.9 Scope

This version generates a simulated updated state output.
'@ | Set-Content -Encoding UTF8 "69_SCD2_State_Engine\SCD2_State_Engine.md"

@'
# Consent-Aware Ingestion Rules

## Required Before Ingestion

- Source owner
- Participant awareness where applicable
- Purpose
- Consent class
- Allowed analysis
- Retention rule
- Viewer rule

## Prohibited for Public Repo

- Private real relationship logs
- Health records
- Intimate correspondence
- Third-party private information
- Secret recordings

## Graph Rule

Every graph node and edge must cite a source event or be labeled synthetic.
'@ | Set-Content -Encoding UTF8 "70_Consent_Aware_Ingestion\Consent_Aware_Ingestion_Rules.md"

@'
# Streamlit Graph Upgrade

## v1.9 Direction

Add a graph tab to the Streamlit MVP.

## Future UI Elements

- Node table
- Edge table
- Mermaid graph preview
- Graph filtering by domain
- Graph filtering by stage
- Risk and repair path view
- Relationship state timeline

## Guardrail

Graph views should explain context, not amplify blame.
'@ | Set-Content -Encoding UTF8 "72_Streamlit_Graph_Upgrade\Streamlit_Graph_Upgrade.md"

@'
# v2.0 Backlog

## Theme

Local Relationship Intelligence Workbench

## Candidate Enhancements

- SQLite-backed event graph explorer.
- SCD2 relationship state editor.
- Consent ledger UI enforcement.
- Report builder.
- Case comparison matrix.
- Graph-to-Wiki publisher.
- Local-only private data mode.
- Public demo mode with synthetic data.
'@ | Set-Content -Encoding UTF8 "74_Backlog_vNext\v2.0_Backlog.md"

# Update docs public page
$DocsIndex = "docs\index.html"
if (Test-Path $DocsIndex) {
    $html = Get-Content $DocsIndex -Raw
    if ($html -notmatch "Event Graph Layer") {
        $insert = @'
<section>
  <h2>Event Graph Layer</h2>
  <p>v1.9 adds graph-based relationship intelligence: nodes for people, events, repairs, risks, supports, assets, tollgates, and SCD2 state, with explainable edges between them.</p>
</section>
'@
        $html = $html -replace "</main>", "$insert`n</main>"
        $html | Set-Content -Encoding UTF8 $DocsIndex
    }
}

Write-Host "v1.9 assets merged successfully." -ForegroundColor Green
