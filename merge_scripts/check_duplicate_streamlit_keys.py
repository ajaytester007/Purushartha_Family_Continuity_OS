from pathlib import Path
import re
import collections

text = Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8")
keys = re.findall(r'key="([^"]+)"', text)
dupes = [k for k, c in collections.Counter(keys).items() if c > 1]

print("Duplicate keys:", dupes)
