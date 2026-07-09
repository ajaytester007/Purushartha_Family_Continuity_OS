$ErrorActionPreference = "Stop"
$src = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$wiki = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $wiki
git pull --rebase | Out-Host
$dirs = @("165_Journey_Identity","166_Quest_System","167_Celebrations_Streaks","168_Weekly_Story_Recap","169_Future_Postcards","170_Release_Safety_Gate","171_Release_Notes","172_Backlog_vNext")
foreach ($d in $dirs) {
    Get-ChildItem (Join-Path $src $d) -Recurse -Filter *.md | ForEach-Object {
        $rel = $_.FullName.Substring($src.Length).TrimStart("\")
        $name = $rel -replace "\\","-" -replace "_","-" -replace "\.md$",".md"
        Copy-Item $_.FullName (Join-Path $wiki $name) -Force
    }
}
@'
# Purushartha Family Continuity OS

## v3.5 Journey Identity + Quest System

- [[Journey Identity|165-Journey-Identity-Journey-Identity]]
- [[Quest System|166-Quest-System-Quest-System]]
- [[Celebrations and Streaks|167-Celebrations-Streaks-Celebrations-Streaks]]
- [[Weekly Story Recap|168-Weekly-Story-Recap-Weekly-Story-Recap]]
- [[Future Postcards|169-Future-Postcards-Future-Postcards]]
- [[Release Safety Gate|170-Release-Safety-Gate-Release-Safety-Gate]]
- [[v3.5 Release Notes|171-Release-Notes-v3.5-Journey-Identity-and-Quest-System]]
- [[v3.6 Backlog|172-Backlog-vNext-v3.6-Backlog]]
'@ | Set-Content -Encoding UTF8 "Home.md"
git add .
git commit -m "Publish Wiki from v3.5 journey quest pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Set-Location $src
Write-Host "Wiki publish complete." -ForegroundColor Green
