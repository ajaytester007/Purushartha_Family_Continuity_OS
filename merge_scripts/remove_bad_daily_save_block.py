from pathlib import Path
import ast

app = Path("51_Streamlit_MVP/app.py")
text = app.read_text(encoding="utf-8")
lines = text.splitlines()

target = 'if st.button("Save Daily Companion Log", key="save_daily_companion_log_v33"):'

starts = [i for i, line in enumerate(lines) if target in line]
print("Found starts:", [s + 1 for s in starts])

if not starts:
    raise SystemExit("Save Daily Companion Log block not found.")

# remove every malformed Save Daily Companion block
remove = set()
for start in starts:
    end = start
    for j in range(start, min(start + 60, len(lines))):
        remove.add(j)
        if 'st.success("Daily companion log saved.")' in lines[j]:
            end = j
            break
    print(f"Removing lines {start+1} through {end+1}")

fixed_lines = [line for i, line in enumerate(lines) if i not in remove]
fixed = "\n".join(fixed_lines) + "\n"

ast.parse(fixed)

backup = app.with_name("app_before_remove_bad_daily_save_block.py.bak")
backup.write_text(text, encoding="utf-8")
app.write_text(fixed, encoding="utf-8")

print("PASS: removed bad Save Daily Companion block.")
print("PASS: app.py syntax is valid.")
print("Backup:", backup)
