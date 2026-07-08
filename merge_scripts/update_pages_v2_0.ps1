$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v2.0 ==" -ForegroundColor Cyan

$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }

$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "v2.0 Workbench") {
    $insert = @'
<section>
  <h2>v2.0 Workbench</h2>
  <p>v2.0 consolidates the knowledgebase, case engine, event graph, SCD2 timeline, governance cockpit, report builder, Wiki, Pages, and Streamlit app into a local relationship intelligence workbench.</p>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v2.0." -ForegroundColor Green
