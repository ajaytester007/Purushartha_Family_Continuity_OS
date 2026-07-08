$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v2.5 ==" -ForegroundColor Cyan
$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }
$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Graph Explorer UI") {
    $insert = @'
<section>
  <h2>Graph Explorer UI</h2>
  <p>v2.5 adds an interactive graph explorer with node, edge, stage, and domain filters plus risk-to-repair and tollgate path views.</p>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v2.5." -ForegroundColor Green
