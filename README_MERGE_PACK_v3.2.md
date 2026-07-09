# Purushartha Family Continuity OS - v3.2 Merge Pack

Theme: Daily Companion + Grievance Report Workbench.

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v3.2_Merge_Pack.zip"
$Temp = ".\_merge_temp_v3.2"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v3.2_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v3_2_full_flow.ps1
```
