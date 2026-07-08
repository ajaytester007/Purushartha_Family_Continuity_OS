# Purushartha Family Continuity OS - v2.6 Merge Pack

Theme: SCD2 State Editor.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- Streamlit SCD2 State Editor upgrade.
- Controlled state transition form.
- Close current state and create new current state logic.
- State change reason and source event fields.
- State transition audit seed.
- SCD2 transition report.
- Pages and Wiki updates.
- v2.7 backlog for Private Local Mode.

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v2.6_Merge_Pack.zip"
$Temp = ".\_merge_temp_v2.6"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v2.6_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v2_6_full_flow.ps1
```
