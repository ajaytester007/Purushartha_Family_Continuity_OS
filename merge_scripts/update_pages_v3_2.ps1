$ErrorActionPreference = "Stop"
Write-Host "== Updating GitHub Pages for v3.2 ==" -ForegroundColor Cyan
$DocsIndex = "docs\index.html"
if (-not (Test-Path $DocsIndex)) { throw "Missing docs\index.html" }
$html = Get-Content $DocsIndex -Raw
if ($html -notmatch "Daily Companion") {
$insert = @'
<section>
  <h2>Daily Companion and Grievance Reports</h2>
  <p>v3.2 adds daily logs, companion-style stars and emojis, grievance report generation, fidelity/prospect scoring, corrective action plans, mobile readiness, and bonding ritual prompts.</p>
</section>
'@
$html = $html -replace "</main>", "$insert`n</main>"
$html | Set-Content -Encoding UTF8 $DocsIndex
}
Write-Host "Pages updated for v3.2." -ForegroundColor Green
