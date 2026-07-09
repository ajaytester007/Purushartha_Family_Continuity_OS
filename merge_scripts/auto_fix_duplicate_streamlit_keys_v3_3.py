from pathlib import Path
import re
from collections import defaultdict

app = Path("51_Streamlit_MVP/app.py")
text = app.read_text(encoding="utf-8")

seen = defaultdict(int)

def repl(match):
    key = match.group(1)
    seen[key] += 1
    if seen[key] == 1:
        return f'key="{key}"'
    return f'key="{key}_{seen[key]}"'

text = re.sub(r'key="([^"]+)"', repl, text)
app.write_text(text, encoding="utf-8")

dupes_fixed = {k: v for k, v in seen.items() if v > 1}
print("Duplicate Streamlit keys auto-fixed.")
print(dupes_fixed)
