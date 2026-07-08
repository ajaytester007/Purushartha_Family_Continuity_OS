$ErrorActionPreference = "Stop"
Write-Host "== Merging Purushartha OS v1.6 assets ==" -ForegroundColor Cyan

$Dirs = @("51_Streamlit_MVP","52_SQLite_MVP","53_Report_Exporter","54_UI_Test_Data","55_App_Documentation","56_Release_Notes","57_Backlog_vNext")
foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v1.6 Interactive Streamlit MVP

v1.6 introduces the first interactive local product layer.

## Added

- Streamlit MVP app.
- Event entry form.
- Synthetic case browser.
- Relationship health calculator.
- Burden skew calculator.
- Decision output viewer.
- Repair plan viewer.
- Markdown report export.
- SQLite database initializer.
- Local launcher script.

## Guardrail

The app uses synthetic or user-entered local data only. Do not ingest private real messages, media, health records, or third-party information without explicit consent and purpose controls.
'@ | Set-Content -Encoding UTF8 "56_Release_Notes\v1.6_Interactive_Streamlit_MVP.md"

@'
# v1.7 Backlog

## Theme

Persistent SCD2 State and Event Graph Visualizer

## Candidate Enhancements

- Relationship state history table.
- Person and household state history.
- Event graph viewer.
- Mermaid graph generated from SQLite.
- Confidence scoring UI.
- Consent ledger UI.
- Exportable family continuity report.
- Case comparison matrix.
'@ | Set-Content -Encoding UTF8 "57_Backlog_vNext\v1.7_Backlog.md"

@'

import sqlite3
from pathlib import Path
from datetime import datetime
from math import prod
import pandas as pd
import streamlit as st

ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "52_SQLite_MVP" / "purushartha_os_mvp.sqlite"
CASE_PATH = ROOT / "41_Case_Engine" / "synthetic_case_library_50.csv"
DECISION_PATH = ROOT / "43_Decision_Explanations" / "decision_explanations.md"
REPAIR_PATH = ROOT / "44_Repair_Plans" / "repair_plan_outputs.md"
REPORT_DIR = ROOT / "53_Report_Exporter"

st.set_page_config(page_title="Purushartha OS MVP", layout="wide")

def db():
    DB_PATH.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(DB_PATH)
    conn.execute("""
    CREATE TABLE IF NOT EXISTS local_event_log (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        created_at TEXT,
        stage TEXT,
        domain TEXT,
        harm_level INTEGER,
        impact_score REAL,
        repair_score REAL,
        learning_score REAL,
        summary TEXT,
        safety_override INTEGER DEFAULT 0
    )
    """)
    return conn

def geometric_mean(values):
    vals = [max(float(v), 0.01) for v in values]
    return prod(vals) ** (1 / len(vals))

def relationship_health(values):
    score = geometric_mean(values)
    if values[0] < 40:
        return score, "Safety override: route to protection review."
    if score >= 85:
        return score, "Flourishing"
    if score >= 70:
        return score, "Healthy with work"
    if score >= 55:
        return score, "Strained"
    if score >= 40:
        return score, "High-risk deterioration"
    return score, "Critical review"

def burden_skew(actual, expected, duration, involuntary, recognition):
    val = abs(actual - expected) * duration * involuntary / max(recognition, 0.1)
    if val >= 50:
        label = "Structural imbalance"
    elif val >= 35:
        label = "Intervention needed"
    elif val >= 20:
        label = "Review needed"
    else:
        label = "Within workable range"
    return val, label

st.title("Purushartha Family Continuity OS - Local MVP")
st.caption("Consent-first relationship, family, resilience, wealth, and legacy decision support.")

tabs = st.tabs(["Event Entry","Case Browser","Relationship Score","Burden Skew","Decision Outputs","Repair Plans","Report Export"])

with tabs[0]:
    st.header("Local Event Entry")
    with st.form("event_form"):
        stage = st.selectbox("Stage", ["New Relationship","Exclusivity","Family Integration","Marriage","Parenting","Midlife","Recovery","Aging","Legacy"])
        domain = st.text_input("Domain", "Communication")
        harm_level = st.slider("Harm Level", 0, 5, 1)
        impact = st.slider("Impact Score", 0, 100, 30)
        repair = st.slider("Repair Score", 0, 100, 50)
        learning = st.slider("Learning Score", 0, 100, 50)
        safety = st.checkbox("Safety override")
        summary = st.text_area("Summary", "Synthetic or consented local event only.")
        submitted = st.form_submit_button("Save Event")
    if submitted:
        conn = db()
        conn.execute("INSERT INTO local_event_log(created_at,stage,domain,harm_level,impact_score,repair_score,learning_score,summary,safety_override) VALUES (?,?,?,?,?,?,?,?,?)",
                     (datetime.utcnow().isoformat(), stage, domain, harm_level, impact, repair, learning, summary, int(safety)))
        conn.commit()
        st.success("Event saved locally.")
    conn = db()
    st.dataframe(pd.read_sql_query("SELECT * FROM local_event_log ORDER BY id DESC", conn), use_container_width=True)

with tabs[1]:
    st.header("Synthetic Case Browser")
    if CASE_PATH.exists():
        cases = pd.read_csv(CASE_PATH)
        selected = st.selectbox("Select Case", cases["case_id"] + " - " + cases["title"])
        case_id = selected.split(" - ")[0]
        st.dataframe(cases[cases["case_id"] == case_id], use_container_width=True)
    else:
        st.warning("Case library not found. Run v1.5+ flow.")

with tabs[2]:
    st.header("Relationship Health Calculator")
    c1 = st.columns(4)
    safety = c1[0].slider("Safety", 0, 100, 80)
    trust = c1[1].slider("Trust", 0, 100, 75)
    reciprocity = c1[2].slider("Reciprocity", 0, 100, 70)
    affection = c1[3].slider("Affection", 0, 100, 72)
    c2 = st.columns(4)
    respect = c2[0].slider("Respect", 0, 100, 80)
    teamwork = c2[1].slider("Teamwork", 0, 100, 75)
    repair_v = c2[2].slider("Repair", 0, 100, 65)
    growth = c2[3].slider("Growth", 0, 100, 70)
    score, label = relationship_health([safety, trust, reciprocity, affection, respect, teamwork, repair_v, growth])
    st.metric("Relationship Health Score", f"{score:.2f}", label)

with tabs[3]:
    st.header("Burden Skew Calculator")
    actual = st.slider("Actual Share for Partner A", 0, 100, 75)
    expected = st.slider("Expected Share for Partner A", 0, 100, 50)
    duration = st.slider("Duration Multiplier", 0.5, 3.0, 1.2)
    involuntary = st.slider("Involuntary Multiplier", 0.5, 3.0, 1.1)
    recognition = st.slider("Recognition/Recovery Factor", 0.1, 3.0, 1.0)
    score, label = burden_skew(actual, expected, duration, involuntary, recognition)
    st.metric("Adjusted Burden Skew", f"{score:.2f}", label)

with tabs[4]:
    st.header("Decision Outputs")
    if DECISION_PATH.exists():
        st.markdown(DECISION_PATH.read_text(encoding="utf-8"))
    else:
        st.warning("Decision explanations not generated yet.")

with tabs[5]:
    st.header("Repair Plans")
    if REPAIR_PATH.exists():
        st.markdown(REPAIR_PATH.read_text(encoding="utf-8"))
    else:
        st.warning("Repair plan outputs not generated yet.")

with tabs[6]:
    st.header("Report Export")
    REPORT_DIR.mkdir(parents=True, exist_ok=True)
    if st.button("Export Local MVP Report"):
        conn = db()
        events = pd.read_sql_query("SELECT * FROM local_event_log ORDER BY id", conn)
        report = REPORT_DIR / "local_mvp_report.md"
        lines = ["# Local MVP Report", "", f"Generated: {datetime.utcnow().isoformat()} UTC", ""]
        lines += ["## Local Events", ""]
        if events.empty:
            lines += ["No local events entered.", ""]
        else:
            lines += events.to_markdown(index=False).splitlines()
        report.write_text("\n".join(lines), encoding="utf-8")
        st.success(f"Report exported: {report}")

'@ | Set-Content -Encoding UTF8 "51_Streamlit_MVP\app.py"

@'
# Streamlit MVP

Run:

```powershell
.\merge_scripts\launch_streamlit_mvp.ps1
```

Features: event entry, case browser, relationship score calculator, burden skew calculator, decision outputs, repair plans, report export.
'@ | Set-Content -Encoding UTF8 "51_Streamlit_MVP\Streamlit_MVP.md"

@'
# SQLite MVP

Database: `52_SQLite_MVP/purushartha_os_mvp.sqlite`

Tables: local_event_log, synthetic_case_cache, mvp_run_log.
'@ | Set-Content -Encoding UTF8 "52_SQLite_MVP\SQLite_MVP.md"

@'
# Report Exporter

The Streamlit MVP can export `local_mvp_report.md`.
'@ | Set-Content -Encoding UTF8 "53_Report_Exporter\Report_Exporter.md"

@'
stage,domain,harm_level,impact_score,repair_score,learning_score,summary
Marriage,Household,2,55,70,75,Synthetic household burden event
Parenting,Gifted Child,2,65,72,78,Synthetic gifted child opportunity load event
Midlife,Lifestyle Drift,2,60,50,55,Synthetic shared joy decline event
'@ | Set-Content -Encoding UTF8 "54_UI_Test_Data\sample_event_entries.csv"

@'
# App Documentation

First launch:

```powershell
.\merge_scripts\launch_streamlit_mvp.ps1
```

If the app does not show repair plans, rerun `generate_repair_plans.ps1`.
'@ | Set-Content -Encoding UTF8 "55_App_Documentation\App_Documentation.md"

Write-Host "v1.6 assets merged successfully." -ForegroundColor Green
