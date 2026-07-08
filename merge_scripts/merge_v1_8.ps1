$ErrorActionPreference = "Stop"
Write-Host "== Merging Purushartha OS v1.8 assets ==" -ForegroundColor Cyan

$Dirs = @(
"62_SCD2_State",
"63_Event_Graph_Views",
"64_Pages_Branch_Deployment",
"65_App_UX_Upgrade",
"66_Release_Notes",
"67_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v1.8 Pages Deployment and App UX Upgrade

## Purpose

v1.8 fixes the Pages deployment model by using branch-based deployment from `/docs`, and upgrades the Streamlit MVP direction with dashboard and persistent-state preview assets.

## Added

- Branch-based GitHub Pages deployment guidance.
- Removal of GitHub Actions Pages workflow.
- SCD2 timeline seed.
- Event graph preview model.
- Family continuity report generation.
- App UX upgrade notes.
- v1.9 backlog.

## Required GitHub Pages Setting

Settings -> Pages -> Source: Deploy from a branch -> Branch: main -> Folder: /docs.
'@ | Set-Content -Encoding UTF8 "66_Release_Notes\v1.8_Pages_and_App_UX_Upgrade.md"

@'
# v1.9 Backlog

## Theme

Event Graph Visualizer and SCD2 State Engine

## Candidate Enhancements

- SQLite event graph query layer.
- Graph-to-Mermaid generator.
- Person, relationship, household SCD2 state updater.
- Confidence and consent-aware event ingestion.
- Interactive graph tab in Streamlit.
- Exportable graph report.
'@ | Set-Content -Encoding UTF8 "67_Backlog_vNext\v1.9_Backlog.md"

@'
state_id,relationship_id,valid_from,valid_to,is_current,relationship_health_score,burden_skew_score,karma_bond_score,purushartha_balance_score,confidence,notes
S001,R001,2026-01-01,2026-06-30,false,78,20,72,74,medium,Early relationship stable with unclear cadence
S002,R001,2026-07-01,2027-12-31,false,68,35,63,66,medium,Family integration and burden skew emerged
S003,R001,2028-01-01,2032-12-31,false,74,32,70,72,medium,Marriage operating model improved
S004,R001,2033-01-01,2038-12-31,false,62,48,58,64,medium,Parenting and gifted child load increased
S005,R001,2039-01-01,,true,82,24,80,86,medium,Renewal routines restored balance
'@ | Set-Content -Encoding UTF8 "62_SCD2_State\relationship_state_seed.csv"

@'
# SCD2 State Model Preview

This folder contains a seed relationship state timeline.

SCD2 state helps preserve history instead of overwriting it.

The seed tracks relationship health, burden skew, karma bond, Purushartha balance, confidence, and notes.
'@ | Set-Content -Encoding UTF8 "62_SCD2_State\SCD2_State_Model_Preview.md"

@'
# Event Graph View Model

## Node Types

Person, Relationship, Event, Obligation, Repair, Tollgate, Child, Asset, Risk, Support Source.

## Edge Types

supports, harms, repairs, escalates, deescalates, depends_on, consumes_capacity, protects_floor.

## v1.9 Goal

Generate this graph from SQLite and render it in Streamlit and Mermaid.
'@ | Set-Content -Encoding UTF8 "63_Event_Graph_Views\Event_Graph_View_Model.md"

@'
# GitHub Pages Branch Deployment

Use this setting instead of GitHub Actions for the current static site.

## GitHub UI

Settings -> Pages

- Source: Deploy from a branch
- Branch: main
- Folder: /docs

## Expected URL

https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/

## Reason

The site is static HTML under `/docs`, so branch deployment is simpler and avoids Pages Actions initialization issues.
'@ | Set-Content -Encoding UTF8 "64_Pages_Branch_Deployment\GitHub_Pages_Branch_Deployment.md"

@'
# App UX Upgrade

v1.8 improves the Streamlit MVP direction with:

- dashboard overview
- case filtering
- SCD2 timeline preview
- consent ledger viewer
- expanded report export
- public links in sidebar
'@ | Set-Content -Encoding UTF8 "65_App_UX_Upgrade\App_UX_Upgrade.md"

$DocsIndex = "docs\index.html"
if (Test-Path $DocsIndex) {
    $html = Get-Content $DocsIndex -Raw
    if ($html -notmatch "branch deployment from") {
        $insert = @'
<section>
  <h2>Deployment Note</h2>
  <p>This public site is designed for GitHub Pages branch deployment from <strong>main /docs</strong>.</p>
</section>
'@
        $html = $html -replace "</main>", "$insert`n</main>"
        $html | Set-Content -Encoding UTF8 $DocsIndex
    }
}

Write-Host "v1.8 assets merged successfully." -ForegroundColor Green
