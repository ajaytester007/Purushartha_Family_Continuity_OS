# Purushartha Family Continuity OS - v1.8 Merge Pack

Theme: GitHub Pages branch deployment fix + app UX/state upgrade.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Run after placing ZIP in repo root

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v1.8_Merge_Pack.zip"
$Temp = ".\_merge_temp_v1.8"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v1.8_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v1_8_full_flow.ps1
```

## GitHub Pages setting

Use:
- Source: Deploy from a branch
- Branch: main
- Folder: /docs
