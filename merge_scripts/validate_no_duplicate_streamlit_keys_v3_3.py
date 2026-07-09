from pathlib import Path
import re
from collections import Counter
import sys

app = Path("51_Streamlit_MVP/app.py")
text = app.read_text(encoding="utf-8")
keys = re.findall(r'key="([^"]+)"', text)
dupes = [k for k, c in Counter(keys).items() if c > 1]

if dupes:
    print("Duplicate keys found:", dupes)
    sys.exit(1)

print("Duplicate keys: []")
