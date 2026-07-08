$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v2.7 assets ==" -ForegroundColor Cyan

$Dirs = @(
"111_Private_Local_Mode",
"112_Public_Demo_Lock",
"113_Sanitization_Checklist",
"114_Private_Reports",
"115_Release_Notes",
"116_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v2.7 Private Local Mode and Public Demo Lock

## Purpose

v2.7 introduces the operating distinction between Public Demo Mode and Private Local Mode.

## Added

- Private Local Mode documentation.
- Public Demo Lock model.
- Private report folder excluded from Git.
- Sanitization checklist.
- Consent gate before private report generation.
- Streamlit app patch that adds mode controls and warnings.

## Rule

Public demo mode must remain synthetic. Private/local mode is for consented local use only.
'@ | Set-Content -Encoding UTF8 "115_Release_Notes\v2.7_Private_Local_Mode_and_Public_Demo_Lock.md"

@'
# Private Local Mode

## Purpose

Private Local Mode is for consented, local-only personal workbench use.

## Allowed

- Consented private notes
- Local evidence registry
- Local reports
- Local state transitions
- Local-only exports

## Not Allowed

- Publishing private reports to public GitHub
- Secret surveillance
- Third-party private data without consent
- Health or intimate data without explicit purpose and retention controls

## Rule

Private mode outputs must stay out of Git unless sanitized.
'@ | Set-Content -Encoding UTF8 "111_Private_Local_Mode\Private_Local_Mode.md"

@'
# Public Demo Lock

## Purpose

Public Demo Lock ensures the live public Streamlit deployment uses synthetic/demo content only.

## Public Demo Rules

- No real private messages
- No health records
- No intimate correspondence
- No third-party private records
- No private report publishing
- Synthetic and educational examples only

## Next Step

v2.8 will harden the public demo lock in the UI.
'@ | Set-Content -Encoding UTF8 "112_Public_Demo_Lock\Public_Demo_Lock.md"

@'
# Sanitization Checklist

Before any report is published:

- Remove real names.
- Remove phone numbers.
- Remove email addresses.
- Remove addresses.
- Remove health data.
- Remove private correspondence.
- Remove third-party identifiers.
- Replace real dates with generalized periods if needed.
- Confirm consent and purpose.
- Mark report as synthetic or sanitized.

If unsure, do not publish.
'@ | Set-Content -Encoding UTF8 "113_Sanitization_Checklist\Sanitization_Checklist.md"

@'
# Private Reports

This folder is intentionally reserved for local/private generated reports.

The folder is excluded from Git by `.gitignore`.

Do not commit private reports.
'@ | Set-Content -Encoding UTF8 "114_Private_Reports\README.md"

@'
*
!.gitignore
!README.md
'@ | Set-Content -Encoding UTF8 "114_Private_Reports\.gitignore"

@'
# v2.8 Backlog

## Theme

Public Demo Mode Lock Hardening

## Candidate Enhancements

- Detect Streamlit Cloud environment.
- Disable private mode in cloud deployment.
- Add synthetic-data-only banner.
- Block private report generation in cloud mode.
- Add public/private status badge to every tab.
- Add report publishing approval gate.
'@ | Set-Content -Encoding UTF8 "116_Backlog_vNext\v2.8_Backlog.md"

Write-Host "v2.7 assets merged successfully." -ForegroundColor Green
