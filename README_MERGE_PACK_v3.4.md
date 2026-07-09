# v3.4 Feed Forward Journey Studio + Genie Companion
```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
$Zip=".\Purushartha_Family_Continuity_OS_v3.4_Merge_Pack.zip"; $Temp=".\_merge_temp_v3.4"
Expand-Archive $Zip $Temp -Force
Copy-Item "$Temp\Purushartha_Family_Continuity_OS_v3.4_Merge_Pack\*" . -Recurse -Force
Remove-Item $Temp -Recurse -Force; Remove-Item $Zip -Force
.\merge_scripts\run_v3_4_full_flow.ps1
```
