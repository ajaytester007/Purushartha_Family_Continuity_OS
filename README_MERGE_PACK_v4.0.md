# Purushartha Family Continuity OS v4.0

Theme: Mobile App Readiness Suite.

This major release prepares the product for a real iPhone / Android app path.

## Adds
- Mobile App Readiness Suite
- App Store / Google Play preparation model
- Mobile onboarding wizard
- Couple profile setup
- Relationship stage router
- Daily companion home
- Journey quest center
- Report center
- Reminder preference center
- Privacy and consent center
- Export center
- Mobile screen inventory
- Native app architecture
- PWA bridge plan
- App Store metadata draft
- Safety / crisis guardrails
- Release safety gate

## Run
```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v4.0_Merge_Pack.zip"
$Temp = ".\_merge_temp_v4.0"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v4.0_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v4_0_full_flow.ps1
```
