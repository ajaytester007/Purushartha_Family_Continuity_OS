$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$ZipName = "Purushartha_Family_Continuity_OS_v1.6_Merge_Pack.zip"
$PackFolder = "Purushartha_Family_Continuity_OS_v1.6_Merge_Pack"
$Temp = "_merge_temp_v1.6"
Set-Location $MainRepo
if (-not (Test-Path ".\$ZipName")) { throw "ZIP not found in repo root: $ZipName" }
if (Test-Path ".\$Temp") { Remove-Item ".\$Temp" -Recurse -Force }
Expand-Archive -Path ".\$ZipName" -DestinationPath ".\$Temp" -Force
Copy-Item -Path ".\$Temp\$PackFolder\*" -Destination . -Recurse -Force
Remove-Item ".\$Temp" -Recurse -Force
Remove-Item ".\$ZipName" -Force
.\merge_scripts\run_v1_6_full_flow.ps1
