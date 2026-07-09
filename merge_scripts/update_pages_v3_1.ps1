$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v3.1 ==" -ForegroundColor Cyan
$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }
$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Relationship Consultancy Workbench") {
$insert = @'
<section>
  <h2>Relationship Consultancy Workbench</h2>
  <p>v3.1 adds guided intake, sanitized correspondence analysis, maturity scoring, course-of-action guidance, response coaching, and relationship accumulator foundations.</p>
</section>
'@
$html = $html -replace "</main>", "$insert`n</main>"
$html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v3.1." -ForegroundColor Green
