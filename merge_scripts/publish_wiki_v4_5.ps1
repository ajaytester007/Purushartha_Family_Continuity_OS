$src="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$wiki="C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $wiki
git pull --rebase|Out-Host
$dirs=@("228_Sacred_Maze_Engine","229_Mind_Map_Game","230_Symbolic_Journey_Skins","231_Chakra_Tollgate_Model","232_Sadhana_Quest_Library","233_Karma_Imprint_Reflection","234_Seer_Wisdom_Intake","235_Mobile_Evaluation_v4_5","236_Release_Notes","237_Backlog_vNext")
foreach($d in $dirs){
  Get-ChildItem (Join-Path $src $d) -Recurse -Filter *.md|%{
    $rel=$_.FullName.Substring($src.Length).TrimStart("\")
    $name=$rel -replace "\\","-" -replace "_","-" -replace "\.md$",".md"
    Copy-Item $_.FullName (Join-Path $wiki $name) -Force
  }
}
"# v4.5 Sacred Maze Engine`n`n- [[Sacred Maze Engine|228-Sacred-Maze-Engine-Sacred-Maze-Engine]]`n- [[Mind Map Game|229-Mind-Map-Game-Mind-Map-Game]]`n- [[Symbolic Journey Skins|230-Symbolic-Journey-Skins-Symbolic-Journey-Skins]]`n- [[Chakra Tollgate Model|231-Chakra-Tollgate-Model-Chakra-Tollgate-Model]]`n- [[Sadhana Quest Library|232-Sadhana-Quest-Library-Sadhana-Quest-Library]]`n- [[Karma Imprint Reflection|233-Karma-Imprint-Reflection-Karma-Imprint-Reflection]]`n- [[Seer Wisdom Intake|234-Seer-Wisdom-Intake-Seer-Wisdom-Intake]]"|Set-Content -Encoding UTF8 Home.md
git add .
git commit -m "Publish Wiki from v4.5 sacred maze pipeline"
if($LASTEXITCODE -ne 0){Write-Host "No Wiki changes to commit."}
git push|Out-Host
Set-Location $src
