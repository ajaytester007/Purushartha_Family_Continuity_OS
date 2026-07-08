# Purushartha Family Continuity OS - v2.5 Merge Pack

Theme: Graph Explorer UI.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- Streamlit Graph Explorer tab upgrade.
- Filters by node type, stage, domain, edge type.
- Risk-to-repair path view.
- Tollgate path view.
- Mermaid graph preview and download from the app.
- Graph Explorer docs.
- Pages and Wiki updates.
- v2.6 backlog for SCD2 State Editor.

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v2.5_Merge_Pack.zip"
$Temp = ".\_merge_temp_v2.5"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v2.5_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v2_5_full_flow.ps1
```
