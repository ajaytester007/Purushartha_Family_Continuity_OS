$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v2.3 ==" -ForegroundColor Cyan
$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }
$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Interactive Report Builder") {
    $insert = @'
<section>
  <h2>Interactive Report Builder</h2>
  <p>v2.3 adds a Streamlit Report Builder that can generate, preview, save, and download Markdown reports from selected workbench sections.</p>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v2.3." -ForegroundColor Green
