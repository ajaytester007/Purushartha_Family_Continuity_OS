$src="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$wiki="C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $wiki
git pull --rebase|Out-Host
$dirs=@("201_Interactive_Journey_Activation","202_Checklist_Card_Engine","203_Journey_Roadmap_Game","204_Dynamic_Feed_Forward_Prompts","205_Local_Progress_Model","206_Compatibility_Health_Report","207_Release_Notes","208_Backlog_vNext")
foreach($d in $dirs){
  Get-ChildItem (Join-Path $src $d) -Recurse -Filter *.md|%{
    $rel=$_.FullName.Substring($src.Length).TrimStart("\")
    $name=$rel -replace "\\","-" -replace "_","-" -replace "\.md$",".md"
    Copy-Item $_.FullName (Join-Path $wiki $name) -Force
  }
}
"# v4.2 Interactive Journey Activation`n`n- [[Interactive Journey Activation|201-Interactive-Journey-Activation-Interactive-Journey-Activation]]`n- [[Checklist Card Engine|202-Checklist-Card-Engine-Checklist-Card-Engine]]`n- [[Journey Roadmap Game|203-Journey-Roadmap-Game-Journey-Roadmap-Game]]`n- [[Compatibility Health Report|206-Compatibility-Health-Report-Compatibility-Health-Report]]"|Set-Content -Encoding UTF8 Home.md
git add .
git commit -m "Publish Wiki from v4.2 interactive journey pipeline"
if($LASTEXITCODE -ne 0){Write-Host "No Wiki changes to commit."}
git push|Out-Host
Set-Location $src
