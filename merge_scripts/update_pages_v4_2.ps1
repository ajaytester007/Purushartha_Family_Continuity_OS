$p="docs\index.html"
$html=Get-Content $p -Raw
if($html -notmatch "Interactive Journey Activation"){
$section='<section><h2>v4.2 Interactive Journey Activation</h2><p>v4.2 turns checklist placeholders into working journey cards, XP/stars, roadmap signposts, dynamic prompts, and compatibility health reports.</p></section>'
$html=$html -replace "</main>","$section`n</main>"
$html|Set-Content -Encoding UTF8 $p
}
