from pathlib import Path
import sys
text=Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8-sig").replace("\ufeff","")
required=["v4.6 Checklist Intake","parse_intake_v46","Generate Two-Family Advisory Report","raw_checklist_v46"]
missing=[x for x in required if x not in text]
if missing:
    print("FAIL missing", missing)
    sys.exit(1)
print("PASS v4.6 Streamlit features.")
