$p="docs\index.html"
$html=Get-Content $p -Raw
if($html -notmatch "iPhone PWA Shell"){
$section='<section><h2>v4.1 iPhone PWA Shell and Compatibility Game Mode</h2><p>v4.1 adds a zero-cost iPhone Home Screen shell, compatibility checklists, trusted-circle ratings, game mode, diary mode, scoring model, and exit report model.</p><p><a href="mobile.html">Open Mobile Shell</a></p></section>'
$html=$html -replace "</main>","$section`n</main>"
$html|Set-Content -Encoding UTF8 $p
}
