from pathlib import Path
import sys
text=Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8-sig").replace("\ufeff","")
required=["v4.2 Interactive Journey Activation","Compatibility Health Check","Generate Compatibility Health Report","card_score_v42_0"]
missing=[x for x in required if x not in text]
if missing:
    print("FAIL missing", missing)
    sys.exit(1)
print("PASS v4.2 Streamlit features.")
