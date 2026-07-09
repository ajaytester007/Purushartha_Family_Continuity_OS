$ErrorActionPreference = "Stop"
$SourceRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo   = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"

Set-Location $WikiRepo
git pull --rebase | Out-Host
Get-ChildItem $WikiRepo -Filter *.md | Remove-Item -Force

$IncludeDirs = @(
"150_Daily_Log_Persistence",
"151_Grievance_Report_Persistence",
"152_Relationship_Trend_Dashboard",
"153_App_Stabilization",
"154_Release_Notes",
"155_Backlog_vNext"
)

foreach ($dir in $IncludeDirs) {
    $full = Join-Path $SourceRepo $dir
    if (Test-Path $full) {
        Get-ChildItem $full -Recurse -Filter *.md | ForEach-Object {
            $relative = $_.FullName.Substring($SourceRepo.Length).TrimStart("\")
            $wikiName = $relative -replace "\\", "-" -replace "_", "-" -replace "\.md$", ".md"
            Copy-Item $_.FullName (Join-Path $WikiRepo $wikiName) -Force
        }
    }
}

@"
# Purushartha Family Continuity OS

## v3.3 Persistent Logs and App Stabilization

- [[Daily Log Persistence|150-Daily-Log-Persistence-Daily-Log-Persistence]]
- [[Grievance Report Persistence|151-Grievance-Report-Persistence-Grievance-Report-Persistence]]
- [[Relationship Trend Dashboard|152-Relationship-Trend-Dashboard-Relationship-Trend-Dashboard]]
- [[App Stabilization|153-App-Stabilization-App-Stabilization]]
- [[v3.3 Release Notes|154-Release-Notes-v3.3-Persistent-Logs-and-App-Stabilization]]
- [[v3.4 Backlog|155-Backlog-vNext-v3.4-Backlog]]
"@ | Set-Content -Encoding UTF8 "Home.md"

@"
# Purushartha OS Wiki

## v3.3
- [[Daily Log Persistence|150-Daily-Log-Persistence-Daily-Log-Persistence]]
- [[Grievance Report Persistence|151-Grievance-Report-Persistence-Grievance-Report-Persistence]]
- [[Relationship Trend Dashboard|152-Relationship-Trend-Dashboard-Relationship-Trend-Dashboard]]
- [[App Stabilization|153-App-Stabilization-App-Stabilization]]
- [[v3.3 Release Notes|154-Release-Notes-v3.3-Persistent-Logs-and-App-Stabilization]]
- [[v3.4 Backlog|155-Backlog-vNext-v3.4-Backlog]]
"@ | Set-Content -Encoding UTF8 "_Sidebar.md"

git add .
git commit -m "Publish Wiki from v3.3 pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host

Set-Location $SourceRepo
Write-Host "Wiki publish complete." -ForegroundColor Green
