from pathlib import Path
import sys
text=Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8-sig").replace("\ufeff","")
required=["v4.7 DOCX Questionnaire Intake","docx_upload_v47","Generate Questionnaire Intake Report","q_dimension_v47"]
missing=[x for x in required if x not in text]
if missing:
    print("FAIL missing", missing)
    sys.exit(1)
print("PASS v4.7 Streamlit features.")
