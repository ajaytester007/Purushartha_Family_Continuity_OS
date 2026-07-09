# Purushartha Family Continuity OS v4.2

Theme: Interactive Journey Activation.

This release turns v4.1 placeholders into real pilot behavior:
- Couple profile
- Relationship stage
- Dynamic compatibility checklist cards
- XP / stars
- Chapter completion
- Dynamic feed-forward prompts
- Local session progress
- Health-check report
- Journey roadmap with milestone signposts

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v4.2_Merge_Pack.zip"
$Temp = ".\_merge_temp_v4.2"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v4.2_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v4_2_full_flow.ps1
```
