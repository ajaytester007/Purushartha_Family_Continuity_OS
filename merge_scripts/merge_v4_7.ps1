$ErrorActionPreference = "Stop"
Write-Host "== Merging v4.7 DOCX Questionnaire Intake assets ==" -ForegroundColor Cyan

$dirs = @(
"247_DOCX_Questionnaire_Intake",
"248_Classy_Values_Analyzer",
"249_Questionnaire_Dimension_Map",
"250_Family_Mending_Inference",
"251_Questionnaire_Report_Model",
"252_Mobile_Evaluation_v4_7",
"253_Release_Notes",
"254_Backlog_vNext"
)
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# DOCX Questionnaire Intake

The app can accept a completed questionnaire document and extract:
- sections
- questions
- yes/no/other answers
- notes
- final comments
- unresolved concerns
- overall recommendation

The first implementation supports DOCX files through python-docx.
'@ | Set-Content -Encoding UTF8 "247_DOCX_Questionnaire_Intake\DOCX_Questionnaire_Intake.md"

@'
section_code,section_name,dimension,default_weight
A,Ahimsa Vegetarian Values,Dharma,5
B,Class Character,Dharma,5
C,Emotional Maturity,Repair,5
D,Family Culture,Family Ecology,5
E,Finances Logistics,Artha,5
F,Partnership Responsibility,Role Ownership,5
G,Individual Identity,Moksha,4
H,Conflict Crisis,Emotional Safety,5
I,Weddings Gifts Expectations,Family Ecology,4
J,Lifestyle Compatibility,Kama,4
K,Final Decision Notes,Milestone Readiness,5
'@ | Set-Content -Encoding UTF8 "249_Questionnaire_Dimension_Map\questionnaire_dimension_map_v4_7.csv"

@'
# Classy Values Analyzer

The analyzer looks for signals of:
- ahimsa and vegetarian alignment
- character
- dignity
- accountability
- emotional regulation
- family equality
- realistic finances
- partnership responsibility
- independent identity
- conflict repair
- wedding/gift expectation clarity
- lifestyle compatibility
- final recommendation

It should infer mending guidance, not merely score.
'@ | Set-Content -Encoding UTF8 "248_Classy_Values_Analyzer\Classy_Values_Analyzer.md"

@'
# Family Mending Inference

The app should advise both families:
- what to mend
- what to stop
- what to start
- what the couple must own
- what parents should release
- what should be retested
- when milestone escalation is premature
- when exit review is more dignified
'@ | Set-Content -Encoding UTF8 "250_Family_Mending_Inference\Family_Mending_Inference.md"

@'
# Questionnaire Report Model

Report sections:
- document intake summary
- detected sections
- answer distribution
- dimension scores
- strongest signals
- weakest signals
- notes/evidence
- mending playbook
- family advisory
- continue/incubate/pause/exit guidance
'@ | Set-Content -Encoding UTF8 "251_Questionnaire_Report_Model\Questionnaire_Report_Model.md"

@'
feature,check_from_iphone,pass_criteria
DOCX Upload,Streamlit v4.7 section,Can upload DOCX questionnaire
Extraction,Streamlit output,Shows extracted sections/questions
Scoring,Streamlit output,Shows dimension scores
Inference,Streamlit output,Shows mending and milestone guidance
Report,Download button,Downloads questionnaire intake report
Mobile Shell,Home Screen icon,Shows v4.7 update after Pages deploy
'@ | Set-Content -Encoding UTF8 "252_Mobile_Evaluation_v4_7\mobile_evaluation_v4_7.csv"

@'
# v4.7 Release Notes

Adds DOCX questionnaire upload, Classy Values Analyzer, section/dimension mapping, family mending inference, and downloadable questionnaire intake report.
'@ | Set-Content -Encoding UTF8 "253_Release_Notes\v4.7_DOCX_Questionnaire_Intake.md"

@'
# v4.8 Backlog

## Theme

Questionnaire Case Library + Evidence Heatmap

## Candidate Enhancements

- Save anonymous extracted case
- Compare multiple completed questionnaires
- Bride/groom/family delta heatmap
- Evidence excerpts by dimension
- Family meeting agenda generator
- Exit report generator from questionnaire
'@ | Set-Content -Encoding UTF8 "254_Backlog_vNext\v4.8_Backlog.md"

# ensure python-docx dependency
$req = "requirements.txt"
if (Test-Path $req) {
    $content = Get-Content $req -Raw
    if ($content -notmatch "python-docx") {
        Add-Content -Encoding UTF8 $req "`npython-docx"
    }
} else {
    "streamlit`npython-docx" | Set-Content -Encoding UTF8 $req
}

Write-Host "v4.7 assets merged." -ForegroundColor Green
