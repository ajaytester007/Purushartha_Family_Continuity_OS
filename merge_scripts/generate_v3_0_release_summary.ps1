$ErrorActionPreference = "Stop"
Write-Host "== Generating v3.0 release summary ==" -ForegroundColor Cyan

$outDir = "129_Release_Dashboard"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$out = Join-Path $outDir "v3_0_release_summary.md"

$lines = @()
$lines += "# v3.0 Release Summary"
$lines += ""
$lines += "Purushartha Family Continuity OS has reached the Family Continuity Intelligence Suite milestone."
$lines += ""
$lines += "## Live Links"
$lines += ""
$lines += "- Repo: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS"
$lines += "- Wiki: https://github.com/ajaytester007/Purushartha_Family_Continuity_OS/wiki"
$lines += "- Pages: https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/"
$lines += "- Streamlit: https://purusharthafamilycontinuityos-jakkkbzwpuv5pxapptc5up2.streamlit.app/"
$lines += ""
$lines += "## Completed Milestone Capabilities"
$lines += ""
$lines += "- Knowledgebase"
$lines += "- Case engine"
$lines += "- Reports cockpit"
$lines += "- Report builder"
$lines += "- Consent ledger foundation"
$lines += "- Evidence governance foundation"
$lines += "- Graph explorer"
$lines += "- SCD2 state editor"
$lines += "- Public demo lock"
$lines += "- Private local mode"
$lines += "- Scenario simulator"
$lines += ""
$lines += "## Guardrail"
$lines += ""
$lines += "The suite is decision support only and must remain consent-first."

$lines | Set-Content -Encoding UTF8 $out
Write-Host "Generated $out" -ForegroundColor Green
