$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v1.4 assets ==" -ForegroundColor Cyan

$Dirs = @(
"35_Operator_Runbook",
"36_Health_Checks",
"37_Release_Automation",
"38_Local_App_Launcher",
"39_Wiki_QA",
"40_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@"
# Release Notes — v1.4 Operator Automation and Flow Stabilization

## Purpose

v1.4 stabilizes the scripted release flow and improves operator usability.

## Added

- Full flow script that returns to the main repo after Wiki publishing.
- Preflight checks for main repo, Wiki repo, remotes, branch names, ZIPs, and temp folders.
- Safer main repository publisher.
- Release tagging script.
- Local app launcher.
- Wiki QA checklist.
- Operator runbook.
- v1.5 backlog.

## Fixed

- v1.3 flow could fail at main repo publish because PowerShell remained inside the Wiki repo after Wiki publishing.
"@ | Set-Content -Encoding UTF8 "33_Release_Notes\v1.4_Operator_Automation_and_Flow_Stabilization.md"

@"
# Operator Runbook

## Standard Release Flow

1. Download merge pack ZIP into the main repo root.
2. Extract into a temporary folder.
3. Copy extracted contents into repo root.
4. Delete ZIP and temp folder.
5. Run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\merge_scripts\run_v1_4_full_flow.ps1
```

## Expected Output

- Preflight passed
- Validation passed
- Mermaid maps generated
- Dashboard outputs generated
- Wiki published
- Main repo pushed
- Release tag v1.4 created/pushed
"@ | Set-Content -Encoding UTF8 "35_Operator_Runbook\Operator_Runbook.md"

@"
# Health Check Model

## Checks

- Main repo exists
- Wiki repo exists
- Both are Git repositories
- Both have remotes
- Main branch is known
- Wiki branch is known
- Markdown count is high enough
- No private raw evidence is staged
- No merge-pack ZIP is committed
- Wiki Home exists after publish

## Future Enhancements

- Validate internal Wiki links
- Validate Mermaid syntax
- Validate JSON schemas
- Validate CSV headers
"@ | Set-Content -Encoding UTF8 "36_Health_Checks\Health_Check_Model.md"

@"
# Release Automation

## Current Release

v1.4

## Command

```powershell
.\merge_scripts\run_v1_4_full_flow.ps1
```

## Tagging

The script creates or updates the local tag `v1.4` and pushes it to origin.
"@ | Set-Content -Encoding UTF8 "37_Release_Automation\Release_Automation.md"

@"
# Local App Launcher

The launcher starts the Streamlit app from the main repo.

## Command

```powershell
.\merge_scripts\launch_local_app.ps1
```
"@ | Set-Content -Encoding UTF8 "38_Local_App_Launcher\Local_App_Launcher.md"

@"
# Wiki QA Checklist

After publishing the Wiki, verify:

- Home page opens.
- Sidebar appears.
- Master Index link works.
- Life Vision Charter link works.
- Relationship Etiquette Bible link works.
- Karma Bond Accumulator link works.
- v1.4 Release Notes page exists.
- No private or real personal logs are published.
- Wiki repo status is clean.

URL:

https://github.com/ajaytester007/Purushartha_Family_Continuity_OS/wiki
"@ | Set-Content -Encoding UTF8 "39_Wiki_QA\Wiki_QA_Checklist.md"

@"
# v1.5 Backlog

## Candidate Theme

Case Engine and Tollgate Simulator

## Enhancements

- 50 synthetic relationship cases
- Tollgate rules as JSON
- Case simulator runner
- Decision explanation generator
- Repair plan generator
- Retest scheduler template
- Case-to-Wiki publisher
- Score confidence model

## v1.6 Candidate

Streamlit MVP with form input and score calculations.

## v2.0 Candidate

Local relationship intelligence workbench with SQLite persistence.
"@ | Set-Content -Encoding UTF8 "40_Backlog_vNext\v1.5_Backlog.md"

Write-Host "v1.4 assets merged successfully." -ForegroundColor Green
