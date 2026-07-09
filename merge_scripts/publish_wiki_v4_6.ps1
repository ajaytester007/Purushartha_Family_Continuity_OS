$src="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$wiki="C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $wiki
git pull --rebase|Out-Host
$dirs=@("238_Checklist_Intake_Engine","239_Bride_Parent_Lens","240_Family_Life_Coach_Inference","241_Relationship_Mending_Playbooks","242_Beyond_Repair_Thresholds","243_Two_Family_Advisory_Report","244_Mobile_Evaluation_v4_6","245_Release_Notes","246_Backlog_vNext")
foreach($d in $dirs){
  Get-ChildItem (Join-Path $src $d) -Recurse -Filter *.md|%{
    $rel=$_.FullName.Substring($src.Length).TrimStart("\")
    $name=$rel -replace "\\","-" -replace "_","-" -replace "\.md$",".md"
    Copy-Item $_.FullName (Join-Path $wiki $name) -Force
  }
}
"# v4.6 Checklist Intake Life Coach`n`n- [[Checklist Intake Engine|238-Checklist-Intake-Engine-Checklist-Intake-Engine]]`n- [[Bride Parent Lens|239-Bride-Parent-Lens-Bride-Parent-Lens]]`n- [[Family Life Coach Inference|240-Family-Life-Coach-Inference-Family-Life-Coach-Inference]]`n- [[Relationship Mending Playbooks|241-Relationship-Mending-Playbooks-Relationship-Mending-Playbooks]]`n- [[Beyond Repair Thresholds|242-Beyond-Repair-Thresholds-Beyond-Repair-Thresholds]]`n- [[Two Family Advisory Report|243-Two-Family-Advisory-Report-Two-Family-Advisory-Report]]"|Set-Content -Encoding UTF8 Home.md
git add .
git commit -m "Publish Wiki from v4.6 checklist intake life coach pipeline"
if($LASTEXITCODE -ne 0){Write-Host "No Wiki changes to commit."}
git push|Out-Host
Set-Location $src
