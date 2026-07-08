# Purushartha Family Continuity OS - v2.7 Merge Pack

Theme: Private Local Mode and Public Demo Lock.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- Streamlit Private Local Mode / Public Demo Mode switch.
- Private mode warning banner.
- Public demo lock policy.
- Private generated reports folder with `.gitignore`.
- Sanitization checklist.
- Consent gate before private report generation.
- Pages and Wiki updates.
- v2.8 backlog for Public Demo Mode Lock hardening.

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v2.7_Merge_Pack.zip"
$Temp = ".\_merge_temp_v2.7"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v2.7_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v2_7_full_flow.ps1
```
