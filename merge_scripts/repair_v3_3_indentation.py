from pathlib import Path
import ast

app = Path("51_Streamlit_MVP/app.py")
text = app.read_text(encoding="utf-8")

bad = '''        if st.button("Save Daily Companion Log", key="save_daily_companion_log_v33"):
            append_csv_row_v33(DAILY_LOG_PATH, {
                "log_id": f"DL{datetime.utcnow().strftime('%Y%m%d%H%M%S')}",
                "created_at": datetime.utcnow().isoformat(),
                "mood": mood,
                "relationship_energy": energy,
                "partner_effort": partner_effort,
                "self_effort": self_effort,
                "unresolved": unresolved,
                "special_encounter": special_encounter,
                "gratitude_note": gratitude_text,
                "concern_note": concern_text,
                "daily_nudge": nudge
            })
            st.success("Daily companion log saved.")
'''

good = '''    if st.button("Save Daily Companion Log", key="save_daily_companion_log_v33"):
        append_csv_row_v33(DAILY_LOG_PATH, {
            "log_id": f"DL{datetime.utcnow().strftime('%Y%m%d%H%M%S')}",
            "created_at": datetime.utcnow().isoformat(),
            "mood": mood,
            "relationship_energy": energy,
            "partner_effort": partner_effort,
            "self_effort": self_effort,
            "unresolved": unresolved,
            "special_encounter": special_encounter,
            "gratitude_note": gratitude_text,
            "concern_note": concern_text,
            "daily_nudge": nudge
        })
        st.success("Daily companion log saved.")
'''

if bad in text:
    text = text.replace(bad, good)
    print("Fixed v3.3 Daily Companion indentation.")
else:
    print("Exact bad block not found. Checking nearby lines before changing anything.")

app.write_text(text, encoding="utf-8")

try:
    ast.parse(text)
    print("PASS: app.py Python syntax is valid.")
except SyntaxError as e:
    print(f"FAIL: line {e.lineno}: {e.msg}")
    raise
