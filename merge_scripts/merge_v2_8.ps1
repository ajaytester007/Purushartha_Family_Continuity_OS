$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v2.8 assets ==" -ForegroundColor Cyan

$Dirs = @(
"117_Public_Demo_Mode_Hardening",
"118_Deployment_Mode_Detection",
"119_Publication_Approval_Workflow",
"120_Release_Notes",
"121_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v2.8 Public Demo Mode Lock Hardening

## Purpose

v2.8 hardens the live public app so it clearly behaves as a synthetic-data public demo unless deliberately run in private local mode.

## Added

- Public Demo Mode hardening documentation.
- Deployment mode detection model.
- Publication approval workflow.
- Streamlit patch for public/private mode awareness.
- Public mode warning banners.
- Private report generation warning.
- v2.9 backlog for Scenario Simulator.

## Rule

The live public Streamlit app must not invite or store real private relationship data.
'@ | Set-Content -Encoding UTF8 "120_Release_Notes\v2.8_Public_Demo_Mode_Lock_Hardening.md"

@'
# Public Demo Mode Hardening

## Purpose

Public Demo Mode makes the online application safe to view, share, and test.

## Public Demo Constraints

- Synthetic data only.
- No real names.
- No private correspondence.
- No health records.
- No secret recordings.
- No third-party private records.
- No private report publishing.

## Required App Behavior

- Show public demo banner.
- Warn before report generation.
- Label all outputs as synthetic or sanitized.
- Direct private work to local/private mode.
'@ | Set-Content -Encoding UTF8 "117_Public_Demo_Mode_Hardening\Public_Demo_Mode_Hardening.md"

@'
# Deployment Mode Detection

## Purpose

The app should distinguish between:

1. Public Streamlit deployment
2. Local private workstation

## Environment Variables

- PURUSHARTHA_DEPLOYMENT_MODE
  - public_demo
  - private_local

- PURUSHARTHA_ALLOW_PRIVATE_MODE
  - true
  - false

## Default

If variables are missing, default to public_demo.

## Reason

Safe defaults prevent accidental private-data use in the public app.
'@ | Set-Content -Encoding UTF8 "118_Deployment_Mode_Detection\Deployment_Mode_Detection.md"

@'
# Publication Approval Workflow

## Purpose

Before any report is published, it must pass a publication approval gate.

## Gate

- Is it synthetic?
- Is it sanitized?
- Does it contain private names?
- Does it contain health data?
- Does it include third-party information?
- Is publication explicitly approved?

## Outcome

If any risk is present, keep report local.
'@ | Set-Content -Encoding UTF8 "119_Publication_Approval_Workflow\Publication_Approval_Workflow.md"

@'
# v2.9 Backlog

## Theme

Scenario Simulator

## Candidate Enhancements

- What-if relationship path simulation.
- Compare continue/correct/reconsider/exit paths.
- Repair effort estimator.
- Burden tolerance simulator.
- Family continuity impact simulator.
- Report scenario comparison.
'@ | Set-Content -Encoding UTF8 "121_Backlog_vNext\v2.9_Backlog.md"

Write-Host "v2.8 assets merged successfully." -ForegroundColor Green
