$ErrorActionPreference="Stop"

$p="docs\index.html"
$html=Get-Content $p -Raw

if($html -notmatch "Checklist Intake"){
$section='<section><h2>v4.6 Checklist Intake + Family Life-Coach</h2><p>v4.6 adds anonymous checklist intake, bride/parent lens, mending playbooks, beyond-repair thresholds, and two-family advisory reports.</p></section>'
$html=$html -replace "</main>","$section`n</main>"
$html|Set-Content -Encoding UTF8 $p
}

$mobile="docs\mobile.html"
if(Test-Path $mobile){
$m=Get-Content $mobile -Raw
if($m -notmatch "v4.6 Checklist Intake"){
$add="<div class='card'><h2>v4.6 Checklist Intake</h2><p>Paste anonymous parent/bride checklist data and generate mending guidance for both families.</p></div>"
$m=$m -replace "</div></body></html>", "$add</div></body></html>"
$m|Set-Content -Encoding UTF8 $mobile
}
}

Write-Host "Pages updated for v4.6." -ForegroundColor Green
