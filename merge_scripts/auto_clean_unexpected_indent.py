from pathlib import Path

app = Path("51_Streamlit_MVP/app.py")
text = app.read_text(encoding="utf-8-sig").replace("\ufeff", "")
backup = app.with_name("app_before_auto_indent_clean.py.bak")
backup.write_text(text, encoding="utf-8")

for attempt in range(20):
    try:
        compile(text, str(app), "exec")
        app.write_text(text, encoding="utf-8")
        print("PASS: app.py compiles successfully.")
        print("Backup:", backup)
        break
    except IndentationError as e:
        lines = text.splitlines()
        idx = e.lineno - 1
        print(f"Attempt {attempt+1}: removing unexpected indent block starting at line {e.lineno}:")
        print(lines[idx])

        start = idx
        end = idx

        # Remove the unexpected indented block and its continuation lines.
        for j in range(idx + 1, len(lines)):
            line = lines[j]
            if line.strip() == "":
                end = j
                break
            if line.startswith(" ") or line.startswith("\t"):
                end = j
                continue
            break

        print(f"Removing lines {start+1} through {end+1}")
        lines = lines[:start] + lines[end+1:]
        text = "\n".join(lines) + "\n"
else:
    raise SystemExit("FAIL: Could not repair indentation after 20 attempts.")
