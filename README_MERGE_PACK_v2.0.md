# Purushartha Family Continuity OS - v2.0 Merge Pack

Theme: Local Relationship Intelligence Workbench.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- v2.0 workbench architecture.
- Integrated local-workbench Streamlit documentation.
- Graph-to-report synthesis.
- SCD2 state change protocol.
- Consent and governance cockpit model.
- Report builder templates.
- Public demo vs private local mode distinction.
- v2.1 backlog for richer Streamlit implementation.
- Wiki and Pages updates.

## Run after placing ZIP in repo root

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v2.0_Merge_Pack.zip"
$Temp = ".\_merge_temp_v2.0"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v2.0_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v2_0_full_flow.ps1
```
