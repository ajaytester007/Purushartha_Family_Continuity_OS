$p="docs\index.html";$h=Get-Content $p -Raw
if($h -notmatch "Feed Forward Journey Studio"){$s='<section><h2>Feed Forward Journey Studio</h2><p>v3.4 adds relationship makeovers, narrative storyboards, positive quests, journey maps, and the Genie Companion.</p></section>';$h=$h -replace "</main>","$s`n</main>";$h|Set-Content -Encoding UTF8 $p}
