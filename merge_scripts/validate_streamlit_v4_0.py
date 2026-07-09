from pathlib import Path
import sys
text = Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8-sig").replace("\ufeff", "")
required = ["v4.0 Mobile App Readiness Suite", "mobile_readiness_plan_v40", "app_store_readiness_score_v40", "Generate Mobile App Readiness Brief", "v40_generate_brief"]
missing = [x for x in required if x not in text]
if missing:
    print("FAIL: missing v4.0 items:", missing)
    sys.exit(1)
print("PASS: v4.0 Streamlit features present.")
