# Operator Runbook

## Standard Release Flow

1. Download merge pack ZIP into the main repo root.
2. Extract into a temporary folder.
3. Copy extracted contents into repo root.
4. Delete ZIP and temp folder.
5. Run:

`powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\merge_scripts\run_v1_4_full_flow.ps1
`

## Expected Output

- Preflight passed
- Validation passed
- Mermaid maps generated
- Dashboard outputs generated
- Wiki published
- Main repo pushed
- Release tag v1.4 created/pushed
