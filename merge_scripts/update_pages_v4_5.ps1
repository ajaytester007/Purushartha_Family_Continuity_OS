$p="docs\index.html"
$html=Get-Content $p -Raw
if($html -notmatch "Sacred Maze"){
$section='<section><h2>v4.5 Sacred Maze + Mind Map Game Engine</h2><p>v4.5 adds optional symbolic journey skins, maze paths, mind-map text view, chakra/tollgate metaphors, sadhana quests, and Sacred Maze reports.</p></section>'
$html=$html -replace "</main>","$section`n</main>"
$html|Set-Content -Encoding UTF8 $p
}
$mobile="docs\mobile.html"
if(Test-Path $mobile){
$m=Get-Content $mobile -Raw
if($m -notmatch "v4.5 Sacred Maze"){
$m=$m -replace "</div></body></html>", "<div class='card'><h2>🌀 v4.5 Sacred Maze</h2><p>Optional symbolic maze and mind-map journey mode now supports decision paths, tollgates, and sadhana quests.</p></div></div></body></html>"
$m|Set-Content -Encoding UTF8 $mobile
}
}
