# Purushartha Family Continuity OS v4.6

Theme: Checklist Intake + Bride/Parent Lens + Family Life-Coach Inference Engine.

## Adds

- Anonymous checklist intake model
- Bride-side parent checklist seed
- Prospective bride checklist seed
- CSV upload/paste-style Streamlit analyzer
- Family life-coach inference engine
- Relationship mending guidance
- Beyond-repair threshold guidance
- Couple outcome recommendation
- Two-family advisory report
- Mobile shell update

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v4.6_Merge_Pack.zip"
$Temp = ".\_merge_temp_v4.6"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v4.6_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v4_6_full_flow.ps1
```
