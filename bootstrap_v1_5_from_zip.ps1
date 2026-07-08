$ErrorActionPreference = "Stop"

$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$ZipName = "Purushartha_Family_Continuity_OS_v1.5_Merge_Pack.zip"
$PackFolder = "Purushartha_Family_Continuity_OS_v1.5_Merge_Pack"
$Temp = "_merge_temp_v1.5"

Set-Location $MainRepo

Write-Host "== Bootstrap v1.5 from ZIP ==" -ForegroundColor Cyan

if (-not (Test-Path ".\$ZipName")) {
    throw "ZIP not found in repo root: $ZipName"
}

if (Test-Path ".\$Temp") {
    Remove-Item ".\$Temp" -Recurse -Force
}

Expand-Archive -Path ".\$ZipName" -DestinationPath ".\$Temp" -Force

$ExtractedPack = ".\$Temp\$PackFolder"
if (-not (Test-Path $ExtractedPack)) {
    throw "Expected extracted pack folder not found: $ExtractedPack"
}

Copy-Item -Path "$ExtractedPack\*" -Destination . -Recurse -Force

if (-not (Test-Path ".\merge_scripts\run_v1_5_full_flow.ps1")) {
    throw "v1.5 full flow script was not copied successfully."
}

Remove-Item ".\$Temp" -Recurse -Force
Remove-Item ".\$ZipName" -Force

Write-Host "Bootstrap completed. Launching v1.5 full flow..." -ForegroundColor Green
.\merge_scripts\run_v1_5_full_flow.ps1
