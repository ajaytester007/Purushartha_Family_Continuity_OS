$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v2.6 ==" -ForegroundColor Cyan
$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }
$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "SCD2 State Editor") {
    $insert = @'
<section>
  <h2>SCD2 State Editor</h2>
  <p>v2.6 adds a controlled state transition workflow: close the current state, create a new current state, record source events, and preserve history.</p>
</section>
'@
    $html = $html -replace "</main>", "$insert`n</main>"
    $html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v2.6." -ForegroundColor Green
