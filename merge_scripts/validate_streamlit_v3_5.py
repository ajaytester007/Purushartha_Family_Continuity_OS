from pathlib import Path
import sys
text = Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8-sig").replace("\ufeff", "")
required = ["Journey Identity + Quest Board", "quest_recommendation_v35", "Celebrate Progress", "Future Postcard", "ji_celebrate_v35"]
missing = [x for x in required if x not in text]
if missing:
    print("FAIL: missing v3.5 items:", missing)
    sys.exit(1)
print("PASS: v3.5 Streamlit features present.")
