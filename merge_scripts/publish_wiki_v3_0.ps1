$ErrorActionPreference = "Stop"
$SourceRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo   = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $WikiRepo
git pull --rebase | Out-Host
Get-ChildItem $WikiRepo -Filter *.md | Remove-Item -Force

$IncludeDirs = @(
"127_Family_Continuity_Intelligence_Suite","128_Suite_Architecture","129_Release_Dashboard",
"130_Capability_Matrix","131_Maturity_Model","132_Release_Notes","133_Backlog_vNext"
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

## v3.0 Family Continuity Intelligence Suite

- [[Family Continuity Intelligence Suite|127-Family-Continuity-Intelligence-Suite-Family-Continuity-Intelligence-Suite]]
- [[Suite Architecture v3.0|128-Suite-Architecture-Suite-Architecture-v3-0]]
- [[v3.0 Release Dashboard|129-Release-Dashboard-v3-0-Release-Dashboard]]
- [[v3.0 Release Summary|129-Release-Dashboard-v3-0-release-summary]]
- [[Capability Matrix v3.0|130-Capability-Matrix-Capability-Matrix-v3-0]]
- [[Maturity Model v3.0|131-Maturity-Model-Maturity-Model-v3-0]]
- [[v3.0 Release Notes|132-Release-Notes-v3.0-Family-Continuity-Intelligence-Suite]]
- [[v3.1 Backlog|133-Backlog-vNext-v3.1-Backlog]]

## Live Links

- Public site: https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/
- Live app: https://purusharthafamilycontinuityos-jakkkbzwpuv5pxapptc5up2.streamlit.app/
- Repo: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS
"@ | Set-Content -Encoding UTF8 "Home.md"

@"
# Purushartha OS Wiki

## v3.0
- [[Family Continuity Intelligence Suite|127-Family-Continuity-Intelligence-Suite-Family-Continuity-Intelligence-Suite]]
- [[Suite Architecture v3.0|128-Suite-Architecture-Suite-Architecture-v3-0]]
- [[v3.0 Release Dashboard|129-Release-Dashboard-v3-0-Release-Dashboard]]
- [[v3.0 Release Summary|129-Release-Dashboard-v3-0-release-summary]]
- [[Capability Matrix v3.0|130-Capability-Matrix-Capability-Matrix-v3-0]]
- [[Maturity Model v3.0|131-Maturity-Model-Maturity-Model-v3-0]]
- [[v3.0 Release Notes|132-Release-Notes-v3.0-Family-Continuity-Intelligence-Suite]]
- [[v3.1 Backlog|133-Backlog-vNext-v3.1-Backlog]]
"@ | Set-Content -Encoding UTF8 "_Sidebar.md"

git add .
git commit -m "Publish Wiki from v3.0 pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Set-Location $SourceRepo
Write-Host "Wiki publish complete." -ForegroundColor Green
