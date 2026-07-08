$ErrorActionPreference = "Stop"
Write-Host "== Disabling GitHub Actions Pages workflow for branch deployment ==" -ForegroundColor Cyan
$workflow = ".github\workflows\pages.yml"
if (Test-Path $workflow) {
    Remove-Item $workflow -Force
    Write-Host "Removed $workflow"
} else {
    Write-Host "No pages.yml workflow found; nothing to remove."
}
