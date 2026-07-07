Write-Host "== Purushartha Family Continuity OS: merging v1.1 assets =="

$dirs = @(
"13_Publishing","14_Dashboards","15_Event_Graph","16_Scoring_Formulas",
"17_Synthetic_Datasets","18_Local_App_Blueprint","docs",".github/workflows"
)

foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@"
# Changelog

## v1.1 — Publishing and Intelligence Foundation

Added publishing, validation, dashboard, event graph, scoring formula, synthetic dataset, local app blueprint, and GitHub Pages assets.
"@ | Set-Content -Encoding UTF8 "CHANGELOG.md"

@"
# Master Index

Start with the constitution, journey books, scoring engines, tollgates, ingestion models, templates, and playbooks.
"@ | Set-Content -Encoding UTF8 "13_Publishing/Master_Index.md"

@"
# Purushartha Family Continuity OS

A consent-first relationship, family continuity, wealth, and legacy intelligence framework.
"@ | Set-Content -Encoding UTF8 "docs/index.md"

Write-Host "v1.1 PowerShell merge complete. Bash merge has richer content if available."
