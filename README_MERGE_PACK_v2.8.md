# Purushartha Family Continuity OS - v2.8 Merge Pack

Theme: Public Demo Mode Lock Hardening.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- Streamlit Cloud/Public Demo lock.
- Environment-aware deployment mode detection.
- Private Local Mode disabled by default in public deployment.
- Public/private badge on every major workflow.
- Private report generation block in public mode.
- Publication approval gate warning.
- Public demo lock docs.
- v2.9 backlog for Scenario Simulator.

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v2.8_Merge_Pack.zip"
$Temp = ".\_merge_temp_v2.8"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v2.8_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v2_8_full_flow.ps1
```
