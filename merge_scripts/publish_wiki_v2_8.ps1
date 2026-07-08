$ErrorActionPreference = "Stop"
$SourceRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo   = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Write-Host "== Publishing Purushartha OS to GitHub Wiki v2.8 ==" -ForegroundColor Cyan
Set-Location $WikiRepo
git pull --rebase | Out-Host
Get-ChildItem $WikiRepo -Filter *.md | Remove-Item -Force

$IncludeDirs = @(
"117_Public_Demo_Mode_Hardening","118_Deployment_Mode_Detection",
"119_Publication_Approval_Workflow","120_Release_Notes","121_Backlog_vNext"
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

## v2.8 Public Demo Mode Lock

- [[Public Demo Mode Hardening|117-Public-Demo-Mode-Hardening-Public-Demo-Mode-Hardening]]
- [[Deployment Mode Detection|118-Deployment-Mode-Detection-Deployment-Mode-Detection]]
- [[Publication Approval Workflow|119-Publication-Approval-Workflow-Publication-Approval-Workflow]]
- [[v2.8 Release Notes|120-Release-Notes-v2.8-Public-Demo-Mode-Lock-Hardening]]
- [[v2.9 Backlog|121-Backlog-vNext-v2.9-Backlog]]

## Live Links

- Public site: https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/
- Live app: https://purusharthafamilycontinuityos-jakkkbzwpuv5pxapptc5up2.streamlit.app/
- Repo: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS
"@ | Set-Content -Encoding UTF8 "Home.md"

@"
# Purushartha OS Wiki

## v2.8
- [[Public Demo Mode Hardening|117-Public-Demo-Mode-Hardening-Public-Demo-Mode-Hardening]]
- [[Deployment Mode Detection|118-Deployment-Mode-Detection-Deployment-Mode-Detection]]
- [[Publication Approval Workflow|119-Publication-Approval-Workflow-Publication-Approval-Workflow]]
- [[v2.8 Release Notes|120-Release-Notes-v2.8-Public-Demo-Mode-Lock-Hardening]]
- [[v2.9 Backlog|121-Backlog-vNext-v2.9-Backlog]]
"@ | Set-Content -Encoding UTF8 "_Sidebar.md"

git add .
git commit -m "Publish Wiki from v2.8 pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Set-Location $SourceRepo
Write-Host "Wiki publish complete." -ForegroundColor Green
