# Purushartha Family Continuity OS — v1.5 Merge Pack

Same existing locations:

Main repo:
`C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`

Wiki repo:
`C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## v1.5 Theme

**Case Engine and Tollgate Simulator**

## What v1.5 Adds

- Bootstrap installer that extracts the ZIP, merges contents, deletes package artifacts, and launches the full flow.
- v1.5 one-command full flow.
- Case engine with 50 synthetic relationship/family cases.
- Tollgate rules JSON.
- Decision explanation generator.
- Repair plan generator.
- Retest scheduler template.
- Case-to-Wiki publishing support.
- Score confidence model.
- CSV and JSON validation checks.
- v1.6 roadmap toward Streamlit MVP with form input.

## Simplest Run

Place this ZIP in:

`C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`

Then run:

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\bootstrap_v1_5_from_zip.ps1
```

If the bootstrap script is not yet extracted, use the extraction commands from the prior release once. Future releases will keep this bootstrap model.
