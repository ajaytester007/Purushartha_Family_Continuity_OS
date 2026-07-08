# Purushartha Family Continuity OS — v1.3 Merge Pack

This version keeps the same locations:

Main repo:
`C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`

Wiki repo:
`C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## What v1.3 Adds

- One-command PowerShell flow: merge, validate, generate maps, publish Wiki, commit/push main repo.
- Streamlit local app blueprint and starter app.
- SQLite schema for event graph and SCD2 state.
- Score calculator Python module.
- Sample dashboard generator.
- Case simulator seed.
- Evidence and consent registry templates.
- Safer publishing pipeline with preflight checks.

## Recommended Flow

Copy/extract this pack into the existing main repo root, then run:

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\merge_scripts\run_v1_3_full_flow.ps1
```

This runs the entire scripted flow.
