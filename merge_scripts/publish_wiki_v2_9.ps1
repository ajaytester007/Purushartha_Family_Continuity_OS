$ErrorActionPreference = "Stop"
$SourceRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo   = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $WikiRepo
git pull --rebase | Out-Host
Get-ChildItem $WikiRepo -Filter *.md | Remove-Item -Force

$IncludeDirs = @("122_Scenario_Simulator","123_Decision_Path_Model","124_Scenario_Reports","125_Release_Notes","126_Backlog_vNext")
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

## v2.9 Scenario Simulator

- [[Scenario Simulator|122-Scenario-Simulator-Scenario-Simulator]]
- [[Decision Path Model|123-Decision-Path-Model-Decision-Path-Model]]
- [[Scenario Reports|124-Scenario-Reports-Scenario-Reports]]
- [[Scenario Comparison Report|124-Scenario-Reports-scenario-comparison-report-v2-9]]
- [[v2.9 Release Notes|125-Release-Notes-v2.9-Scenario-Simulator]]
- [[v3.0 Backlog|126-Backlog-vNext-v3.0-Backlog]]
"@ | Set-Content -Encoding UTF8 "Home.md"

@"
# Purushartha OS Wiki

## v2.9
- [[Scenario Simulator|122-Scenario-Simulator-Scenario-Simulator]]
- [[Decision Path Model|123-Decision-Path-Model-Decision-Path-Model]]
- [[Scenario Reports|124-Scenario-Reports-Scenario-Reports]]
- [[Scenario Comparison Report|124-Scenario-Reports-scenario-comparison-report-v2-9]]
- [[v2.9 Release Notes|125-Release-Notes-v2.9-Scenario-Simulator]]
- [[v3.0 Backlog|126-Backlog-vNext-v3.0-Backlog]]
"@ | Set-Content -Encoding UTF8 "_Sidebar.md"

git add .
git commit -m "Publish Wiki from v2.9 pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Set-Location $SourceRepo
Write-Host "Wiki publish complete." -ForegroundColor Green
