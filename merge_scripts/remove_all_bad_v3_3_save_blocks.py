from pathlib import Path

app = Path("51_Streamlit_MVP/app.py")
text = app.read_text(encoding="utf-8-sig").replace("\ufeff", "")
lines = text.splitlines()

targets = [
    'if st.button("Save Daily Companion Log"',
    'if st.button("Save Grievance Report Index"'
]

remove = set()

for target in targets:
    starts = [i for i, line in enumerate(lines) if target in line]
    print(target, "found at:", [s + 1 for s in starts])

    for start in starts:
        for j in range(start, min(start + 100, len(lines))):
            remove.add(j)
            if (
                'st.success("Daily companion log saved.")' in lines[j]
                or 'st.success("Grievance report index saved.")' in lines[j]
            ):
                break

fixed = "\n".join(line for i, line in enumerate(lines) if i not in remove) + "\n"

backup = app.with_name("app_before_remove_v3_3_save_blocks.py.bak")
backup.write_text(text, encoding="utf-8")
app.write_text(fixed, encoding="utf-8")

print("Removed malformed v3.3 save blocks.")
print("Backup:", backup)
