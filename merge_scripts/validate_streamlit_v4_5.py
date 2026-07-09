from pathlib import Path
import sys
text=Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8-sig").replace("\ufeff","")
required=["v4.5 Sacred Maze","sacred_maze_direction_v45","Generate Sacred Maze Report","skin_v45"]
missing=[x for x in required if x not in text]
if missing:
    print("FAIL missing", missing)
    sys.exit(1)
print("PASS v4.5 Streamlit features.")
