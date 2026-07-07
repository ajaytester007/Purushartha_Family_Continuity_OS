# Purushartha Family Continuity OS — v1.2 Merge Pack

Designed to merge into the same existing repository:

`C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`

Wiki repo expected at:

`C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Run

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\merge_scripts\merge_v1_2.ps1
.\merge_scripts\validate_repo.ps1
.\merge_scripts\generate_mermaid_maps.ps1
.\merge_scripts\publish_wiki.ps1
.\merge_scripts\git_publish_all.ps1
```
