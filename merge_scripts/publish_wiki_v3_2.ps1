$ErrorActionPreference = "Stop"
$SourceRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo   = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $WikiRepo
git pull --rebase | Out-Host
Get-ChildItem $WikiRepo -Filter *.md | Remove-Item -Force
$IncludeDirs = @("142_Daily_Companion","143_Grievance_Report_Workbench","144_Fidelity_Prospect_Scoring","145_Corrective_Action_Plans","146_Mobile_Readiness","147_Reminders_Rewards_Rituals","148_Release_Notes","149_Backlog_vNext")
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

## v3.2 Daily Companion and Grievance Report Workbench

- [[Daily Companion|142-Daily-Companion-Daily-Companion]]
- [[Grievance Report Workbench|143-Grievance-Report-Workbench-Grievance-Report-Workbench]]
- [[Fidelity and Prospect Scoring|144-Fidelity-Prospect-Scoring-Fidelity-Prospect-Scoring]]
- [[Corrective Action Plans|145-Corrective-Action-Plans-Corrective-Action-Plans]]
- [[Mobile Readiness|146-Mobile-Readiness-Mobile-Readiness]]
- [[Reminders Rewards Rituals|147-Reminders-Rewards-Rituals-Reminders-Rewards-Rituals]]
- [[v3.2 Release Notes|148-Release-Notes-v3.2-Daily-Companion-and-Grievance-Report-Workbench]]
- [[v3.3 Backlog|149-Backlog-vNext-v3.3-Backlog]]
"@ | Set-Content -Encoding UTF8 "Home.md"
@"
# Purushartha OS Wiki

## v3.2
- [[Daily Companion|142-Daily-Companion-Daily-Companion]]
- [[Grievance Report Workbench|143-Grievance-Report-Workbench-Grievance-Report-Workbench]]
- [[Fidelity and Prospect Scoring|144-Fidelity-Prospect-Scoring-Fidelity-Prospect-Scoring]]
- [[Corrective Action Plans|145-Corrective-Action-Plans-Corrective-Action-Plans]]
- [[Mobile Readiness|146-Mobile-Readiness-Mobile-Readiness]]
- [[Reminders Rewards Rituals|147-Reminders-Rewards-Rituals-Reminders-Rewards-Rituals]]
- [[v3.2 Release Notes|148-Release-Notes-v3.2-Daily-Companion-and-Grievance-Report-Workbench]]
- [[v3.3 Backlog|149-Backlog-vNext-v3.3-Backlog]]
"@ | Set-Content -Encoding UTF8 "_Sidebar.md"
git add .
git commit -m "Publish Wiki from v3.2 pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Set-Location $SourceRepo
Write-Host "Wiki publish complete." -ForegroundColor Green
