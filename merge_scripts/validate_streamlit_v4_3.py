from pathlib import Path
import sys
text=Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8-sig").replace("\ufeff","")
required=["v4.3 Anonymous Pilot Decisioning Lab","decision_band_v43","Purushartha Fit","Generate Anonymous Decision Report"]
missing=[x for x in required if x not in text]
if missing:
    print("FAIL missing", missing)
    sys.exit(1)
print("PASS v4.3 Streamlit features.")
