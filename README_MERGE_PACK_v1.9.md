# Purushartha Family Continuity OS - v1.9 Merge Pack

Theme: Event Graph Visualizer and SCD2 State Engine.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- Event graph CSV seed.
- Graph-to-Mermaid generator.
- SCD2 state updater model.
- Streamlit graph documentation.
- Consent-aware ingestion rules v1.9.
- Graph report generator.
- Pages update with graph layer section.
- Wiki publishing update.
- v2.0 backlog toward local intelligence workbench.

## Run after placing ZIP in repo root

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v1.9_Merge_Pack.zip"
$Temp = ".\_merge_temp_v1.9"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v1.9_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v1_9_full_flow.ps1
```
