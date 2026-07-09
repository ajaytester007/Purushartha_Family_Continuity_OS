# Purushartha Family Continuity OS v4.7

Theme: DOCX Questionnaire Intake + Classy Values Analyzer.

## What this adds

- DOCX questionnaire upload in Streamlit
- Text extraction using python-docx
- Section detection for A-K style questionnaires
- Yes/No/Other answer parsing
- Notes/evidence capture
- Dimension scoring
- Bride / parent lens mapping
- Two-family mending advice
- Continue / incubate / pause / exit guidance
- Downloadable questionnaire intake report
- Mobile shell update

## Install dependency

The full flow will update requirements.txt to include python-docx. If needed:

```powershell
python -m pip install python-docx
```

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v4.7_Merge_Pack.zip"
$Temp = ".\_merge_temp_v4.7"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v4.7_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v4_7_full_flow.ps1
```
