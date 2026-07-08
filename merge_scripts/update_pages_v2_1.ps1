$ErrorActionPreference = "Stop"

Write-Host "== Updating GitHub Pages for v2.1 report cards ==" -ForegroundColor Cyan

$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }

$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Workbench Reports") {
    $insert = @'
<section>
  <h2>Workbench Reports</h2>
  <div class="grid">
    <div class="card"><h3>Workbench Summary</h3><p>Integrated summary of repo, Wiki, Pages, Streamlit, graph, SCD2, governance, and reports.</p></div>
    <div class="card"><h3>Event Graph Report</h3><p>Node and edge summary for explainable relationship intelligence.</p></div>
    <div class="card"><h3>Family Continuity Summary</h3><p>Overview of live system links and continuity architecture.</p></div>
    <div class="card"><h3>Repair and Retest</h3><p>Generated repair plans and review schedules from synthetic cases.</p></div>
  </div>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}

Write-Host "Pages updated for v2.1." -ForegroundColor Green
