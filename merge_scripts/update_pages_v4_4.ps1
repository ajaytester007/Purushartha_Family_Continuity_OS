$p="docs\index.html"
$html=Get-Content $p -Raw
if($html -notmatch "Real Anonymous Pilot Lab"){
$section='<section><h2>v4.4 Real Anonymous Pilot Lab</h2><p>v4.4 adds anonymous pilot setup, multi-rater scoring, first decision maze, perspective pivots, coaching quests, and mobile feature evaluation.</p></section>'
$html=$html -replace "</main>","$section`n</main>"
$html|Set-Content -Encoding UTF8 $p
}
$mobile="docs\mobile.html"
if(Test-Path $mobile){
$m=Get-Content $mobile -Raw
if($m -notmatch "v4.4 Pilot Lab"){
$m=$m -replace "</div></body></html>", "<div class='card'><h2>🧪 v4.4 Pilot Lab</h2><p>Now includes anonymous pilot cases, multi-rater ratings, first decision maze, perspective pivots, and downloadable pilot reports.</p></div></div></body></html>"
$m|Set-Content -Encoding UTF8 $mobile
}
}
