$src="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$wiki="C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $wiki
git pull --rebase|Out-Host
$dirs=@("247_DOCX_Questionnaire_Intake","248_Classy_Values_Analyzer","249_Questionnaire_Dimension_Map","250_Family_Mending_Inference","251_Questionnaire_Report_Model","252_Mobile_Evaluation_v4_7","253_Release_Notes","254_Backlog_vNext")
foreach($d in $dirs){
  Get-ChildItem (Join-Path $src $d) -Recurse -Filter *.md|%{
    $rel=$_.FullName.Substring($src.Length).TrimStart("\")
    $name=$rel -replace "\\","-" -replace "_","-" -replace "\.md$",".md"
    Copy-Item $_.FullName (Join-Path $wiki $name) -Force
  }
}
"# v4.7 DOCX Questionnaire Intake`n`n- [[DOCX Questionnaire Intake|247-DOCX-Questionnaire-Intake-DOCX-Questionnaire-Intake]]`n- [[Classy Values Analyzer|248-Classy-Values-Analyzer-Classy-Values-Analyzer]]`n- [[Questionnaire Dimension Map|249-Questionnaire-Dimension-Map-Questionnaire-Dimension-Map]]`n- [[Family Mending Inference|250-Family-Mending-Inference-Family-Mending-Inference]]`n- [[Questionnaire Report Model|251-Questionnaire-Report-Model-Questionnaire-Report-Model]]"|Set-Content -Encoding UTF8 Home.md
git add .
git commit -m "Publish Wiki from v4.7 DOCX questionnaire intake pipeline"
if($LASTEXITCODE -ne 0){Write-Host "No Wiki changes to commit."}
git push|Out-Host
Set-Location $src
