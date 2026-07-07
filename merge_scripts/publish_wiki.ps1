$ErrorActionPreference = "Stop"

$SourceRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo   = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"

Write-Host "== Publishing Purushartha OS to GitHub Wiki ==" -ForegroundColor Cyan

if (-not (Test-Path $SourceRepo)) { throw "Source repo not found: $SourceRepo" }
if (-not (Test-Path $WikiRepo)) { throw "Wiki repo not found: $WikiRepo" }
if (-not (Test-Path (Join-Path $WikiRepo ".git"))) { throw "Wiki folder is not a Git repo: $WikiRepo" }

cd $WikiRepo
git pull --rebase | Out-Host

Get-ChildItem $WikiRepo -Filter *.md | Remove-Item -Force

$IncludeDirs = @(
"00_Constitution","01_Knowledgebase","02_Life_Journey_Books","03_Scoring_Engines",
"04_Tollgates_and_Decision_Models","05_Incident_and_Tort_Library","07_Ingestion_and_Evidence_Model",
"08_Playbooks","09_Templates","11_Architecture","13_Publishing","16_Scoring_Formulas",
"22_Wiki_Publishing","23_Case_Library","24_Release_Notes","25_Quality_Gates"
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

A consent-first relationship, marriage, parenting, family continuity, resilience, wealth, and legacy intelligence framework guided by Dharma, Artha, Kama, and Moksha.

## Start Here

- [[Master Index|13-Publishing-Master-Index]]
- [[Life Vision Charter|00-Constitution-Life-Vision-Charter]]
- [[Relationship Etiquette Bible|01-Knowledgebase-Relationship-Etiquette-Bible]]
- [[Karma Bond Accumulator|03-Scoring-Engines-Karma-Bond-Accumulator]]
- [[Continue Correct Reconsider Exit|04-Tollgates-and-Decision-Models-Continue-Correct-Reconsider-Exit]]
- [[Quality Gates|25-Quality-Gates-Quality-Gates]]

## Guardrail

This system is decision support, not legal, medical, financial, or mental-health advice.
"@ | Set-Content -Encoding UTF8 "Home.md"

@"
# Purushartha OS Wiki

## Start
- [[Home]]
- [[Master Index|13-Publishing-Master-Index]]
- [[Quality Gates|25-Quality-Gates-Quality-Gates]]

## Constitution
- [[Life Vision Charter|00-Constitution-Life-Vision-Charter]]
- [[Privacy and Consent|00-Constitution-Relationship-Privacy-and-Consent-Policy]]
- [[Partner Handoff|00-Constitution-Partner-Handoff-Protocol]]

## Core Knowledgebase
- [[Relationship Etiquette Bible|01-Knowledgebase-Relationship-Etiquette-Bible]]
- [[Marriage Operating System|01-Knowledgebase-Marriage-Operating-System]]
- [[Family Wealth Management|01-Knowledgebase-Family-Wealth-Management]]

## Scoring
- [[Relationship Health Score|03-Scoring-Engines-Relationship-Health-Score]]
- [[Karma Bond Accumulator|03-Scoring-Engines-Karma-Bond-Accumulator]]
- [[Burden Skew Index|03-Scoring-Engines-Burden-Skew-Index]]

## All Published Pages
"@ | Set-Content -Encoding UTF8 "_Sidebar.md"

$PublishedPages | Sort-Object Page | ForEach-Object {
    Add-Content -Encoding UTF8 "_Sidebar.md" "- [[$($_.Title)|$($_.Page)]]"
}

@"
---
Purushartha Family Continuity OS — consent-first relationship, family, wealth, resilience, and legacy intelligence.
"@ | Set-Content -Encoding UTF8 "_Footer.md"

git add .
git commit -m "Publish Wiki from v1.2 pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host

Write-Host "Wiki publish complete." -ForegroundColor Green
Write-Host "Open: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS/wiki"
