from pathlib import Path
import sys
text=Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8-sig").replace("\ufeff","")
required=["v4.4 Real Anonymous Pilot Lab","First Decision Maze","Generate v4.4 Anonymous Pilot Report","role_score_v44_0"]
missing=[x for x in required if x not in text]
if missing:
    print("FAIL missing", missing)
    sys.exit(1)
print("PASS v4.4 Streamlit features.")
