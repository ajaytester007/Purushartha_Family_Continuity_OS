$p="docs\index.html"
$html=Get-Content $p -Raw
if($html -notmatch "Anonymous Pilot Decisioning"){
$section='<section><h2>v4.3 Anonymous Pilot Decisioning</h2><p>v4.3 enables anonymous pilot ratings, seer lenses, Purushartha quadrant risk mapping, emotional drama sanity checks, wedding union staging, and decision reports.</p></section>'
$html=$html -replace "</main>","$section`n</main>"
$html|Set-Content -Encoding UTF8 $p
}
