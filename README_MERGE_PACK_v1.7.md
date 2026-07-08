# Purushartha Family Continuity OS - v1.7 Merge Pack

Theme: GitHub Pages Public Experience Layer.

Same locations:
- Main repo: `C:\GitHub\Purushartha_Family_Continuity_OS_v1.0`
- Wiki repo: `C:\GitHub\Purushartha_Family_Continuity_OS.wiki`

## Adds

- GitHub Pages public website under `/docs`.
- Public landing page with links to Repo, Wiki, and live Streamlit app.
- Journey map section.
- Purushartha quadrant section.
- Case engine preview.
- Scoring preview.
- Roadmap section.
- GitHub Actions Pages deployment workflow.
- Wiki publishing update for v1.7.
- Release notes and v1.8 backlog.

## Run after placing ZIP in repo root

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v1.7_Merge_Pack.zip"
$Temp = ".\_merge_temp_v1.7"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v1.7_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v1_7_full_flow.ps1
```

## After push

In GitHub repo settings:
Settings -> Pages -> Build and deployment -> Source: GitHub Actions

Then open:
`https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/`
