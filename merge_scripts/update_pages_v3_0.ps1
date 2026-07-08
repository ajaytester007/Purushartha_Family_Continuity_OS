$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v3.0 ==" -ForegroundColor Cyan

$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }

$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Family Continuity Intelligence Suite") {
    $insert = @'
<section>
  <h2>v3.0 Family Continuity Intelligence Suite</h2>
  <p>v3.0 integrates knowledgebase, cases, reports, consent governance, graph explorer, SCD2 state editor, scenario simulator, public demo lock, private local mode, Wiki, Pages, and Streamlit into a unified continuity workbench.</p>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v3.0." -ForegroundColor Green
