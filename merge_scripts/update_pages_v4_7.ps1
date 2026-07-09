$ErrorActionPreference="Stop"
$p="docs\index.html"
$html=Get-Content $p -Raw
if($html -notmatch "DOCX Questionnaire Intake"){
$section='<section><h2>v4.7 DOCX Questionnaire Intake</h2><p>v4.7 adds DOCX questionnaire upload, Classy Values Analyzer, dimension scoring, family mending guidance, and questionnaire intake reports.</p></section>'
$html=$html -replace "</main>","$section`n</main>"
$html|Set-Content -Encoding UTF8 $p
}
$mobile="docs\mobile.html"
if(Test-Path $mobile){
$m=Get-Content $mobile -Raw
if($m -notmatch "v4.7 DOCX Questionnaire"){
$add="<div class='card'><h2>v4.7 DOCX Questionnaire</h2><p>Upload or paste anonymous completed checklists and generate family life-coach guidance.</p></div>"
$m=$m -replace "</div></body></html>", "$add</div></body></html>"
$m|Set-Content -Encoding UTF8 $mobile
}
}
Write-Host "Pages updated for v4.7." -ForegroundColor Green
