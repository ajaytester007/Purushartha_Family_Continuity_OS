from pathlib import Path
import re,collections,sys
t=Path("51_Streamlit_MVP/app.py").read_text(encoding="utf-8")
missing=[x for x in ["Feed Forward Journey Studio","Genie Companion","feed_forward_plan_v34","genie_reply_v34"] if x not in t]
keys=re.findall(r'key="([^"]+)"',t); dupes=[k for k,c in collections.Counter(keys).items() if c>1]
print("Missing:",missing); print("Duplicate keys:",dupes)
sys.exit(1 if missing or dupes else 0)
