$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v2.9 ==" -ForegroundColor Cyan
$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }
$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Scenario Simulator") {
    $insert = @'
<section>
  <h2>Scenario Simulator</h2>
  <p>v2.9 compares continue, correct, reconsider, pause, and exit paths using synthetic tradeoff scoring.</p>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v2.9." -ForegroundColor Green
