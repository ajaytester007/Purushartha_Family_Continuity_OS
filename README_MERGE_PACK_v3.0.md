# Purushartha Family Continuity OS - v3.0 Merge Pack

Theme: Family Continuity Intelligence Suite.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- v3.0 Family Continuity Intelligence Suite release.
- v3.0 suite architecture.
- v3.0 release dashboard.
- v3.0 integrated capability matrix.
- v3.0 maturity model.
- v3.0 app/Wiki/Pages publication update.
- v3.1 backlog for production hardening.

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v3.0_Merge_Pack.zip"
$Temp = ".\_merge_temp_v3.0"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v3.0_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v3_0_full_flow.ps1
```
