from pathlib import Path
import sys
text=Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8-sig").replace("\ufeff","")
missing=[x for x in ["v4.1 Compatibility Checklist Preview","compatibility_band_v41","Long-Term Compatibility Readiness"] if x not in text]
if missing:
    print("FAIL missing", missing); sys.exit(1)
print("PASS v4.1 Streamlit features.")
