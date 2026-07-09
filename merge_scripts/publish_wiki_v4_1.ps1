$src="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$wiki="C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $wiki
git pull --rebase|Out-Host
$dirs=@("191_iPhone_PWA_Shell","192_Compatibility_Checklists","193_Trusted_Circle_Ratings","194_Game_Mode_Requirements","195_Diary_Mode_Requirements","196_Compatibility_Scoring_Model","197_Exit_Report_Model","199_Release_Notes","200_Backlog_vNext")
foreach($d in $dirs){
  Get-ChildItem (Join-Path $src $d) -Recurse -Filter *.md|%{
    $rel=$_.FullName.Substring($src.Length).TrimStart("\")
    $name=$rel -replace "\\","-" -replace "_","-" -replace "\.md$",".md"
    Copy-Item $_.FullName (Join-Path $wiki $name) -Force
  }
}
"# v4.1 iPhone PWA + Compatibility Game Mode`n`n- [[iPhone PWA Shell|191-iPhone-PWA-Shell-iPhone-PWA-Shell]]`n- [[Compatibility Checklists|192-Compatibility-Checklists-Compatibility-Checklists]]`n- [[Trusted Circle Ratings|193-Trusted-Circle-Ratings-Trusted-Circle-Ratings]]`n- [[Game Mode Requirements|194-Game-Mode-Requirements-Game-Mode-Requirements]]"|Set-Content -Encoding UTF8 Home.md
git add .
git commit -m "Publish Wiki from v4.1 PWA compatibility pipeline"
if($LASTEXITCODE -ne 0){Write-Host "No Wiki changes to commit."}
git push|Out-Host
Set-Location $src
