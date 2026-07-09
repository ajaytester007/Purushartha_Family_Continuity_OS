$ErrorActionPreference = "Stop"
$p = "docs\index.html"
if (-not (Test-Path $p)) { throw "Missing docs\index.html" }
$html = Get-Content $p -Raw
if ($html -notmatch "Journey Identity") {
$section = '<section><h2>Journey Identity and Quest Board</h2><p>v3.5 adds relationship identity, score-lift quests, XP, celebrations, weekly story seeds, future postcards, and a stronger release safety gate.</p></section>'
$html = $html -replace "</main>", "$section`n</main>"
$html | Set-Content -Encoding UTF8 $p
}
Write-Host "Pages updated for v3.5." -ForegroundColor Green
