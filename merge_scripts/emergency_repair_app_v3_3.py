from pathlib import Path
import ast

app = Path("51_Streamlit_MVP/app.py")
lines = app.read_text(encoding="utf-8").splitlines()

start = None
end = None

for i, line in enumerate(lines):
    if 'if st.button("Save Daily Companion Log"' in line:
        start = i
        break

if start is None:
    raise SystemExit("ERROR: Save Daily Companion Log block was not found.")

print(f"Found broken block starting at line {start + 1}:")
print(lines[start])

# Remove through the success message.
for i in range(start, min(start + 40, len(lines))):
    if 'st.success("Daily companion log saved.")' in lines[i]:
        end = i
        break

if end is None:
    raise SystemExit("ERROR: Could not find end of broken Save Daily Companion block.")

print(f"Removing malformed block: lines {start + 1} through {end + 1}")

fixed_lines = lines[:start] + lines[end + 1:]
fixed = "\n".join(fixed_lines) + "\n"

# Do not write anything unless the repaired file is syntactically valid.
ast.parse(fixed)

backup = app.with_name("app_before_v3_3_indentation_repair.py.bak")
backup.write_text("\n".join(lines) + "\n", encoding="utf-8")
app.write_text(fixed, encoding="utf-8")

print("PASS: malformed Save Daily Companion block removed.")
print("PASS: Python AST syntax validation succeeded.")
print(f"Backup created: {backup}")
