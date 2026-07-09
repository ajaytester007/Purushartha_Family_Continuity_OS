$src="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$wiki="C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $wiki
git pull --rebase|Out-Host
$dirs=@("219_Real_Anonymous_Pilot_Lab","220_Multi_Rater_Engine","221_Decision_Maze","222_Perspective_Pivots","223_Moment_of_Truth_Log","224_Coaching_Quest_Retest","225_Mobile_Feature_Evaluation","226_Release_Notes","227_Backlog_vNext")
foreach($d in $dirs){
  Get-ChildItem (Join-Path $src $d) -Recurse -Filter *.md|%{
    $rel=$_.FullName.Substring($src.Length).TrimStart("\")
    $name=$rel -replace "\\","-" -replace "_","-" -replace "\.md$",".md"
    Copy-Item $_.FullName (Join-Path $wiki $name) -Force
  }
}
"# v4.4 Real Anonymous Pilot Lab`n`n- [[Real Anonymous Pilot Lab|219-Real-Anonymous-Pilot-Lab-Real-Anonymous-Pilot-Lab]]`n- [[Multi Rater Engine|220-Multi-Rater-Engine-Multi-Rater-Engine]]`n- [[Decision Maze|221-Decision-Maze-Decision-Maze]]`n- [[Perspective Pivots|222-Perspective-Pivots-Perspective-Pivots]]`n- [[Moment of Truth Log|223-Moment-of-Truth-Log-Moment-of-Truth-Log]]`n- [[Coaching Quest Retest|224-Coaching-Quest-Retest-Coaching-Quest-Retest]]`n- [[Mobile Feature Evaluation|225-Mobile-Feature-Evaluation-Mobile-Feature-Evaluation]]"|Set-Content -Encoding UTF8 Home.md
git add .
git commit -m "Publish Wiki from v4.4 real anonymous pilot lab pipeline"
if($LASTEXITCODE -ne 0){Write-Host "No Wiki changes to commit."}
git push|Out-Host
Set-Location $src
