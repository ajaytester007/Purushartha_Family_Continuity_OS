from pathlib import Path
import re, collections, py_compile, sys

app = Path("51_Streamlit_MVP/app.py")
if not app.exists():
    print("FAIL: app.py not found")
    sys.exit(1)

try:
    py_compile.compile(str(app), doraise=True)
except Exception as exc:
    print("FAIL: app.py does not compile")
    print(exc)
    sys.exit(1)

text = app.read_text(encoding="utf-8-sig").replace("\ufeff", "")
keys = re.findall(r'key="([^"]+)"', text)
dupes = [k for k, c in collections.Counter(keys).items() if c > 1]
if dupes:
    print("FAIL: duplicate Streamlit keys:", dupes)
    sys.exit(1)

print("PASS: app.py compiles.")
print("PASS: duplicate Streamlit keys: []")
