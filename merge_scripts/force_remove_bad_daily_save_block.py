from pathlib import Path

app = Path("51_Streamlit_MVP/app.py")
text = app.read_text(encoding="utf-8-sig").replace("\ufeff", "")
lines = text.splitlines()

target = 'if st.button("Save Daily Companion Log", key="save_daily_companion_log_v33"):'
starts = [i for i, line in enumerate(lines) if target in line]

print("Found bad blocks at lines:", [x + 1 for x in starts])

remove = set()
for start in starts:
    for j in range(start, min(start + 80, len(lines))):
        remove.add(j)
        if 'st.success("Daily companion log saved.")' in lines[j]:
            break

fixed = "\n".join(line for i, line in enumerate(lines) if i not in remove) + "\n"

backup = app.with_name("app_before_forced_remove_daily_save_block.py.bak")
backup.write_text(text, encoding="utf-8")
app.write_text(fixed, encoding="utf-8")

print("Forced removal complete.")
print("Backup:", backup)
