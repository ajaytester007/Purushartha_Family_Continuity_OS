$ErrorActionPreference = "Stop"
$SourceRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$WikiRepo   = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Write-Host "== Publishing Purushartha OS to GitHub Wiki v2.7 ==" -ForegroundColor Cyan
Set-Location $WikiRepo
git pull --rebase | Out-Host
Get-ChildItem $WikiRepo -Filter *.md | Remove-Item -Force

$IncludeDirs = @(
"111_Private_Local_Mode","112_Public_Demo_Lock","113_Sanitization_Checklist",
"114_Private_Reports","115_Release_Notes","116_Backlog_vNext"
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

## v2.7 Private Local Mode

- [[Private Local Mode|111-Private-Local-Mode-Private-Local-Mode]]
- [[Public Demo Lock|112-Public-Demo-Lock-Public-Demo-Lock]]
- [[Sanitization Checklist|113-Sanitization-Checklist-Sanitization-Checklist]]
- [[Private Reports|114-Private-Reports-README]]
- [[v2.7 Release Notes|115-Release-Notes-v2.7-Private-Local-Mode-and-Public-Demo-Lock]]
- [[v2.8 Backlog|116-Backlog-vNext-v2.8-Backlog]]

## Live Links

- Public site: https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/
- Live app: https://purusharthafamilycontinuityos-jakkkbzwpuv5pxapptc5up2.streamlit.app/
- Repo: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS
"@ | Set-Content -Encoding UTF8 "Home.md"

@"
# Purushartha OS Wiki

## v2.7
- [[Private Local Mode|111-Private-Local-Mode-Private-Local-Mode]]
- [[Public Demo Lock|112-Public-Demo-Lock-Public-Demo-Lock]]
- [[Sanitization Checklist|113-Sanitization-Checklist-Sanitization-Checklist]]
- [[Private Reports|114-Private-Reports-README]]
- [[v2.7 Release Notes|115-Release-Notes-v2.7-Private-Local-Mode-and-Public-Demo-Lock]]
- [[v2.8 Backlog|116-Backlog-vNext-v2.8-Backlog]]
"@ | Set-Content -Encoding UTF8 "_Sidebar.md"

git add .
git commit -m "Publish Wiki from v2.7 pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Set-Location $SourceRepo
Write-Host "Wiki publish complete." -ForegroundColor Green
