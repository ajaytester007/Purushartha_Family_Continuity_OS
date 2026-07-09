$src="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$wiki="C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $wiki
git pull --rebase|Out-Host
$dirs=@("209_Anonymous_Pilot_Data","210_Pilot_Rating_Matrix","211_Seer_Lens_Model","212_Emotional_Drama_Sanity_Check","213_Purushartha_Risk_Map","214_Wedding_Union_Staging","215_Relationship_Incubation_Dashboard","216_Decisioning_Reports","217_Release_Notes","218_Backlog_vNext")
foreach($d in $dirs){
  Get-ChildItem (Join-Path $src $d) -Recurse -Filter *.md|%{
    $rel=$_.FullName.Substring($src.Length).TrimStart("\")
    $name=$rel -replace "\\","-" -replace "_","-" -replace "\.md$",".md"
    Copy-Item $_.FullName (Join-Path $wiki $name) -Force
  }
}
"# v4.3 Anonymous Pilot Decisioning`n`n- [[Anonymous Pilot Data|209-Anonymous-Pilot-Data-Anonymous-Pilot-Data]]`n- [[Pilot Rating Matrix|210-Pilot-Rating-Matrix-Pilot-Rating-Matrix]]`n- [[Seer Lens Model|211-Seer-Lens-Model-Seer-Lens-Model]]`n- [[Emotional Drama Sanity Check|212-Emotional-Drama-Sanity-Check-Emotional-Drama-Sanity-Check]]`n- [[Purushartha Risk Map|213-Purushartha-Risk-Map-Purushartha-Risk-Map]]`n- [[Wedding Union Staging|214-Wedding-Union-Staging-Wedding-Union-Staging]]`n- [[Decisioning Reports|216-Decisioning-Reports-Decisioning-Reports]]"|Set-Content -Encoding UTF8 Home.md
git add .
git commit -m "Publish Wiki from v4.3 anonymous pilot decisioning pipeline"
if($LASTEXITCODE -ne 0){Write-Host "No Wiki changes to commit."}
git push|Out-Host
Set-Location $src
