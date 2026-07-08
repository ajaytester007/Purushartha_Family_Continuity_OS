# Purushartha Family Continuity OS - v2.4 Merge Pack

Theme: Consent Ledger UI and Evidence Governance Foundation.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- Streamlit Consent Ledger / Governance Cockpit tab upgrade.
- Consent and evidence editor seed model.
- Consent validation report.
- Report publication approval gate model.
- Public/private mode policy upgrade.
- Pages and Wiki updates.
- v2.5 backlog for Graph Explorer UI.

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v2.4_Merge_Pack.zip"
$Temp = ".\_merge_temp_v2.4"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v2.4_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v2_4_full_flow.ps1
```
