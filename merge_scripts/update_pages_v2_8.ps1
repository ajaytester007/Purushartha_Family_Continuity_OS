$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v2.8 ==" -ForegroundColor Cyan
$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }
$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Public Demo Mode Lock") {
    $insert = @'
<section>
  <h2>Public Demo Mode Lock</h2>
  <p>v2.8 hardens the public app so it defaults to synthetic/sanitized data only and directs private work to local/private mode.</p>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v2.8." -ForegroundColor Green
