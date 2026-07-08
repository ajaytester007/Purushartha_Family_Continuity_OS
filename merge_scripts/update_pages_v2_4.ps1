$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v2.4 ==" -ForegroundColor Cyan
$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }
$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Consent Ledger UI") {
    $insert = @'
<section>
  <h2>Consent Ledger UI</h2>
  <p>v2.4 adds visible consent and evidence governance foundations, including a consent ledger, evidence registry, and publication approval gate.</p>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v2.4." -ForegroundColor Green
