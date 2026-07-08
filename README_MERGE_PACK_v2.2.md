# Purushartha Family Continuity OS - v2.2 Merge Pack

Theme: Interactive Reports Cockpit + Roadmap to v3.0 inside Streamlit.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- Actual Streamlit app upgrade with visible Reports Cockpit tab.
- Actual Streamlit Roadmap tab through v3.0.
- Report manifest reader in the app.
- Markdown report preview and download inside app.
- Public/private and guardrail badges.
- Roadmap CSV and Markdown.
- Pages update for v3.0 roadmap.
- Wiki publishing update.
- v2.3 backlog.

## Run after placing ZIP in repo root

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v2.2_Merge_Pack.zip"
$Temp = ".\_merge_temp_v2.2"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v2.2_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v2_2_full_flow.ps1
```

After push, Streamlit Cloud should redeploy automatically from `main`.
