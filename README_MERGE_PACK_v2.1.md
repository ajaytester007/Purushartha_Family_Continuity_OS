# Purushartha Family Continuity OS - v2.1 Merge Pack

Theme: Streamlit Workbench Reports Cockpit.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- Reports Cockpit documentation.
- Workbench report manifest.
- Report index generator.
- Streamlit workbench reports upgrade documentation.
- Pages update for report visibility.
- Wiki publishing update.
- v2.2 backlog for full report-builder UI.

## Run after placing ZIP in repo root

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v2.1_Merge_Pack.zip"
$Temp = ".\_merge_temp_v2.1"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v2.1_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v2_1_full_flow.ps1
```
