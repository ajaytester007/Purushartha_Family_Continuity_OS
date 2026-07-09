# Purushartha Family Continuity OS v4.3

Theme: Anonymous Pilot Decisioning + Seer Lens + Purushartha Risk Map.

This release enables many more real pilot-style features while keeping identities anonymous:
- Anonymous couple seed data
- Pilot user IDs
- Partner rating matrix
- Family ecosystem rating matrix
- Trusted-circle / seer lens ratings
- Emotional drama sanity check
- Trauma-bond caution indicators
- Rational vs irrational pattern classification
- Moment-of-truth decision log
- Purushartha quadrant risk map: Dharma, Artha, Kama, Moksha
- Wedding union gestational staging
- Relationship incubation dashboard
- Compatibility decision report
- Exit / continue / pause / incubate recommendation
- Anonymous seed files for testing

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v4.3_Merge_Pack.zip"
$Temp = ".\_merge_temp_v4.3"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v4.3_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v4_3_full_flow.ps1
```
