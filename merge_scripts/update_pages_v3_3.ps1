$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v3.3 ==" -ForegroundColor Cyan

$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }

$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Persistent Daily Logs") {
$insert = @'
<section>
  <h2>Persistent Daily Logs and Relationship Trends</h2>
  <p>v3.3 adds saved daily companion logs, saved grievance report indexes, relationship trend charts, and duplicate Streamlit key stabilization.</p>
</section>
'@
$html = $html -replace "</main>", "$insert`n</main>"
$html | Set-Content -Encoding UTF8 $DocsIndex
}

Write-Host "Pages updated for v3.3." -ForegroundColor Green
