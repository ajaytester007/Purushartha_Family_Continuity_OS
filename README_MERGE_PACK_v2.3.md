# Purushartha Family Continuity OS - v2.3 Merge Pack

Theme: Interactive Report Builder UI.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- Streamlit Report Builder tab.
- Select report type.
- Select report sections.
- Generate a Markdown report from inside app.
- Preview generated report.
- Download generated report.
- Save generated report locally to `92_Generated_Reports`.
- Report freshness indicator.
- v2.4 backlog for Consent Ledger UI.

## Run after placing ZIP in repo root

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v2.3_Merge_Pack.zip"
$Temp = ".\_merge_temp_v2.3"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v2.3_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v2_3_full_flow.ps1
```

After push, Streamlit Cloud should redeploy automatically from `main`.
