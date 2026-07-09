from pathlib import Path
import re, collections, py_compile, sys
app=Path("51_Streamlit_MVP/app.py")
if app.exists():
    try: py_compile.compile(str(app), doraise=True)
    except Exception as e: print("FAIL app.py compile", e); sys.exit(1)
    text=app.read_text(encoding="utf-8-sig").replace("\ufeff","")
    keys=re.findall(r'key="([^"]+)"', text)
    dupes=[k for k,c in collections.Counter(keys).items() if c>1]
    if dupes: print("FAIL duplicate keys", dupes); sys.exit(1)
for req in ["docs/mobile.html","docs/manifest.webmanifest"]:
    if not Path(req).exists(): print("FAIL missing", req); sys.exit(1)
print("PASS safety gate.")
