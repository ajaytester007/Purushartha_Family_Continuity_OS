$ErrorActionPreference = "Stop"
$p = "docs\index.html"
if (-not (Test-Path $p)) { throw "Missing docs\index.html" }
$html = Get-Content $p -Raw
if ($html -notmatch "Mobile App Readiness Suite") {
$section = '<section><h2>v4.0 Mobile App Readiness Suite</h2><p>v4.0 adds onboarding, privacy center, reminder preference model, mobile screen inventory, report/export centers, app-store metadata, native/PWA architecture, and safety guardrails.</p></section>'
$html = $html -replace "</main>", "$section`n</main>"
$html | Set-Content -Encoding UTF8 $p
}
Write-Host "Pages updated for v4.0." -ForegroundColor Green
