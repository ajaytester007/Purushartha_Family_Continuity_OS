# Purushartha Family Continuity OS — v1.4 Merge Pack

Same locations:

Main repo:
`C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`

Wiki repo:
`C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## v1.4 Enhancements

- Fixes the v1.3 flow bug where Wiki publishing left PowerShell inside the Wiki repo.
- Adds one-command full flow v1.4.
- Adds preflight environment health check.
- Adds release tagging helper.
- Adds local app launcher.
- Adds repo hygiene checks for ZIP/temp folders.
- Adds GitHub Wiki republish validation.
- Adds operator runbook.
- Adds v1.4 release notes and v1.5 roadmap.

## Run

After extracting this pack into the existing main repo root:

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\merge_scripts\run_v1_4_full_flow.ps1
```
