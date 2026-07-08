$ErrorActionPreference = "Stop"

Write-Host "== Updating GitHub Pages for v2.2 ==" -ForegroundColor Cyan

$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }

$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Roadmap to v3.0") {
    $insert = @'
<section>
  <h2>Roadmap to v3.0</h2>
  <div class="grid">
    <div class="card"><h3>v2.2</h3><p>Interactive Reports Cockpit and Roadmap visible in Streamlit.</p></div>
    <div class="card"><h3>v2.5</h3><p>Graph Explorer UI with explainable relationship paths.</p></div>
    <div class="card"><h3>v2.7</h3><p>Private Local Mode for consented personal data use.</p></div>
    <div class="card"><h3>v3.0</h3><p>Integrated Family Continuity Intelligence Suite.</p></div>
  </div>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}

Write-Host "Pages updated for v2.2." -ForegroundColor Green
