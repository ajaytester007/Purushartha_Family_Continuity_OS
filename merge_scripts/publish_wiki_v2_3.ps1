$ErrorActionPreference = "Stop"
$SourceRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo   = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Write-Host "== Publishing Purushartha OS to GitHub Wiki v2.3 ==" -ForegroundColor Cyan
Set-Location $WikiRepo
git pull --rebase | Out-Host
Get-ChildItem $WikiRepo -Filter *.md | Remove-Item -Force

$IncludeDirs = @(
"00_Constitution","01_Knowledgebase","02_Life_Journey_Books","03_Scoring_Engines",
"04_Tollgates_and_Decision_Models","05_Incident_and_Tort_Library","07_Ingestion_and_Evidence_Model",
"08_Playbooks","09_Templates","11_Architecture","13_Publishing","16_Scoring_Formulas",
"22_Wiki_Publishing","23_Case_Library","24_Release_Notes","25_Quality_Gates",
"26_Local_App","27_SQLite_Event_Graph","28_Score_Calculator","29_Dashboard_Outputs",
"30_Evidence_Consent_Registry","31_Case_Simulator","32_Reports","33_Release_Notes",
"35_Operator_Runbook","36_Health_Checks","37_Release_Automation","38_Local_App_Launcher",
"39_Wiki_QA","40_Backlog_vNext","41_Case_Engine","42_Tollgate_Rules","43_Decision_Explanations",
"44_Repair_Plans","45_Retest_Scheduler","46_Score_Confidence_Model","47_Case_Wiki_Publishing",
"48_Validation","49_Release_Notes","50_Backlog_vNext","51_Streamlit_MVP","52_SQLite_MVP",
"53_Report_Exporter","55_App_Documentation","56_Release_Notes","57_Backlog_vNext",
"58_GitHub_Pages","59_Public_Experience","60_Release_Notes","61_Backlog_vNext",
"62_SCD2_State","63_Event_Graph_Views","64_Pages_Branch_Deployment","65_App_UX_Upgrade",
"66_Release_Notes","67_Backlog_vNext","68_Event_Graph_Engine","69_SCD2_State_Engine",
"70_Consent_Aware_Ingestion","71_Graph_Reports","72_Streamlit_Graph_Upgrade","73_Release_Notes",
"74_Backlog_vNext","75_Workbench_Architecture","76_Governance_Cockpit","77_Report_Builder",
"78_Public_Private_Modes","79_Workbench_Operating_Model","80_Release_Notes","81_Backlog_vNext",
"82_Reports_Cockpit","83_Report_Manifest","84_Streamlit_Report_Workbench","85_Pages_Report_Cards",
"86_Release_Notes","87_Backlog_vNext","88_Roadmap_v3","89_Streamlit_Reports_Cockpit",
"90_Release_Notes","91_Backlog_vNext","92_Generated_Reports","93_Report_Builder_UI",
"94_Release_Notes","95_Backlog_vNext"
)

$PublishedPages = @()
foreach ($dir in $IncludeDirs) {
    $full = Join-Path $SourceRepo $dir
    if (Test-Path $full) {
        Get-ChildItem $full -Recurse -Filter *.md | ForEach-Object {
            $relative = $_.FullName.Substring($SourceRepo.Length).TrimStart("\")
            $wikiName = $relative -replace "\\", "-" -replace "_", "-" -replace "\.md$", ".md"
            $wikiName = $wikiName -replace "\s+", "-"
            Copy-Item $_.FullName (Join-Path $WikiRepo $wikiName) -Force
            $PublishedPages += [PSCustomObject]@{
                Title = (($wikiName -replace "\.md$","") -replace "-", " ")
                Page  = ($wikiName -replace "\.md$","")
            }
        }
    }
}

@"
# Purushartha Family Continuity OS

A consent-first relationship, marriage, parenting, family continuity, resilience, wealth, and legacy intelligence framework.

## v2.3 Interactive Report Builder UI

- [[Report Builder UI|93-Report-Builder-UI-Report-Builder-UI]]
- [[Generated Reports|92-Generated-Reports-README]]
- [[v2.3 Release Notes|94-Release-Notes-v2.3-Interactive-Report-Builder-UI]]
- [[v2.4 Backlog|95-Backlog-vNext-v2.4-Backlog]]

## Live Links

- Public site: https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/
- Live app: https://purusharthafamilycontinuityos-jakkkbzwpuv5pxapptc5up2.streamlit.app/
- Repo: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS

## Guardrail

Generated reports are decision support. They should not become accusations without human review and context.
"@ | Set-Content -Encoding UTF8 "Home.md"

@"
# Purushartha OS Wiki

## Start
- [[Home]]
- [[Master Index|13-Publishing-Master-Index]]

## v2.3
- [[Report Builder UI|93-Report-Builder-UI-Report-Builder-UI]]
- [[Generated Reports|92-Generated-Reports-README]]
- [[v2.3 Release Notes|94-Release-Notes-v2.3-Interactive-Report-Builder-UI]]
- [[v2.4 Backlog|95-Backlog-vNext-v2.4-Backlog]]

## All Published Pages
"@ | Set-Content -Encoding UTF8 "_Sidebar.md"

$PublishedPages | Sort-Object Page | ForEach-Object {
    Add-Content -Encoding UTF8 "_Sidebar.md" "- [[$($_.Title)|$($_.Page)]]"
}
@"
---
Purushartha Family Continuity OS - consent-first relationship, family, wealth, resilience, and legacy intelligence.
"@ | Set-Content -Encoding UTF8 "_Footer.md"
git add .
git commit -m "Publish Wiki from v2.3 pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Set-Location $SourceRepo
Write-Host "Wiki publish complete." -ForegroundColor Green
