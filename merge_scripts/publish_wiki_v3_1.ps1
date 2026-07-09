$ErrorActionPreference = "Stop"
$SourceRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo   = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $WikiRepo
git pull --rebase | Out-Host
Get-ChildItem $WikiRepo -Filter *.md | Remove-Item -Force
$IncludeDirs = @("134_Relationship_Consultancy_Workbench","135_Correspondence_Analyzer","136_Maturity_Scoring_Rubric","137_Course_of_Action_Engine","138_Response_Coach","139_Relationship_Accumulator","140_Release_Notes","141_Backlog_vNext")
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

## v3.1 Relationship Consultancy Workbench

- [[Relationship Consultancy Workbench|134-Relationship-Consultancy-Workbench-Relationship-Consultancy-Workbench]]
- [[Correspondence Analyzer|135-Correspondence-Analyzer-Correspondence-Analyzer]]
- [[Maturity Scoring Rubric|136-Maturity-Scoring-Rubric-Maturity-Scoring-Rubric]]
- [[Course of Action Engine|137-Course-of-Action-Engine-Course-of-Action-Engine]]
- [[Response Coach|138-Response-Coach-Response-Coach]]
- [[Relationship Accumulator|139-Relationship-Accumulator-Relationship-Accumulator]]
- [[v3.1 Release Notes|140-Release-Notes-v3.1-Interactive-Relationship-Consultancy-Workbench]]
- [[v3.2 Backlog|141-Backlog-vNext-v3.2-Backlog]]
"@ | Set-Content -Encoding UTF8 "Home.md"
@"
# Purushartha OS Wiki

## v3.1
- [[Relationship Consultancy Workbench|134-Relationship-Consultancy-Workbench-Relationship-Consultancy-Workbench]]
- [[Correspondence Analyzer|135-Correspondence-Analyzer-Correspondence-Analyzer]]
- [[Maturity Scoring Rubric|136-Maturity-Scoring-Rubric-Maturity-Scoring-Rubric]]
- [[Course of Action Engine|137-Course-of-Action-Engine-Course-of-Action-Engine]]
- [[Response Coach|138-Response-Coach-Response-Coach]]
- [[Relationship Accumulator|139-Relationship-Accumulator-Relationship-Accumulator]]
- [[v3.1 Release Notes|140-Release-Notes-v3.1-Interactive-Relationship-Consultancy-Workbench]]
- [[v3.2 Backlog|141-Backlog-vNext-v3.2-Backlog]]
"@ | Set-Content -Encoding UTF8 "_Sidebar.md"
git add .
git commit -m "Publish Wiki from v3.1 pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Set-Location $SourceRepo
Write-Host "Wiki publish complete." -ForegroundColor Green
