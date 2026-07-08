$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v2.7 ==" -ForegroundColor Cyan
$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }
$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Private Local Mode") {
    $insert = @'
<section>
  <h2>Private Local Mode</h2>
  <p>v2.7 separates public demo use from private local workbench use. Public content must stay synthetic; private reports must stay local unless sanitized and approved.</p>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v2.7." -ForegroundColor Green
