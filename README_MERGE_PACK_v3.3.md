# Purushartha Family Continuity OS - v3.3 Merge Pack

Theme: Persistent Daily Logs + Saved Grievance Reports + App Stabilization.

## Adds

- Streamlit duplicate-key auto-fixer.
- Streamlit duplicate-key validator.
- Daily log persistence model.
- Grievance report persistence model.
- Relationship trend dashboard design.
- Daily log CSV seed.
- Grievance report CSV seed.
- Streamlit patch for saved logs/reports.
- Pages and Wiki updates.
- v3.4 backlog for reminders/PWA/mobile readiness.

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v3.3_Merge_Pack.zip"
$Temp = ".\_merge_temp_v3.3"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v3.3_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v3_3_full_flow.ps1
```
