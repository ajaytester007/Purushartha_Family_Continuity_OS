from pathlib import Path
import ast

app = Path("51_Streamlit_MVP/app.py")

# Read with utf-8-sig and remove hidden BOMs anywhere
text = app.read_text(encoding="utf-8-sig").replace("\ufeff", "")
lines = text.splitlines()

target = 'if st.button("Save Daily Companion Log", key="save_daily_companion_log_v33"):'
starts = [i for i, line in enumerate(lines) if target in line]
print("Found starts:", [s + 1 for s in starts])

if not starts:
    print("No bad Save Daily Companion block found.")
else:
    remove = set()
    for start in starts:
        end = start
        for j in range(start, min(start + 80, len(lines))):
            remove.add(j)
            if 'st.success("Daily companion log saved.")' in lines[j]:
                end = j
                break
        print(f"Removing lines {start+1} through {end+1}")

    lines = [line for i, line in enumerate(lines) if i not in remove]

fixed = "\n".join(lines) + "\n"

# Validate before saving
ast.parse(fixed)

backup = app.with_name("app_before_bom_and_indent_repair.py.bak")
backup.write_text(text, encoding="utf-8")
app.write_text(fixed, encoding="utf-8")

print("PASS: BOM removed.")
print("PASS: bad Save Daily Companion block removed.")
print("PASS: app.py syntax is valid.")
print("Backup:", backup)
