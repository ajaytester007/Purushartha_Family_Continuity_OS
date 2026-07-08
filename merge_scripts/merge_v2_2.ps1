$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v2.2 assets ==" -ForegroundColor Cyan

$Dirs = @(
"88_Roadmap_v3",
"89_Streamlit_Reports_Cockpit",
"90_Release_Notes",
"91_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v2.2 Interactive Reports Cockpit and Roadmap to v3.0

## Purpose

v2.2 makes the Reports Cockpit visible inside the Streamlit app and publishes the roadmap through v3.0 inside the app.

## Added

- Reports Cockpit tab in Streamlit.
- Roadmap to v3.0 tab in Streamlit.
- Manifest-driven report cards.
- Markdown and CSV preview/download.
- Public/private and guardrail badges.
- Roadmap CSV and Markdown.
- Pages roadmap section.
- Wiki publishing update.

## Key Correction

v2.1 created report architecture, but the reports were not visible in the app. v2.2 corrects that gap by modifying the actual Streamlit app.
'@ | Set-Content -Encoding UTF8 "90_Release_Notes\v2.2_Interactive_Reports_Cockpit_and_Roadmap.md"

@'
version,title,theme,status,deliverable
v2.2,Interactive Reports Cockpit,Reports visible in Streamlit,complete,Reports tab and roadmap tab
v2.3,Report Builder UI,Generate selected reports from app,planned,Report form and export buttons
v2.4,Consent Ledger UI,Consent and evidence governance in app,planned,Consent entry and validation
v2.5,Graph Explorer UI,Interactive event graph in app,planned,Graph filters and path view
v2.6,SCD2 State Editor,Relationship state timeline editing,planned,State change workflow
v2.7,Private Local Mode,Local-only private data mode,planned,Private mode switch and warnings
v2.8,Public Demo Mode Lock,Safe public demo constraints,planned,Synthetic-data-only deployment guard
v2.9,Scenario Simulator,Compare future paths,planned,Case comparison and what-if engine
v3.0,Family Continuity Intelligence Suite,Integrated local workbench,planned,Reports plus governance plus graph plus state
'@ | Set-Content -Encoding UTF8 "88_Roadmap_v3\roadmap_to_v3.csv"

@'
# Roadmap to v3.0

## v2.2 - Interactive Reports Cockpit
Reports become visible inside Streamlit through a manifest-driven cockpit.

## v2.3 - Report Builder UI
The app can generate selected reports from user-selected sections.

## v2.4 - Consent Ledger UI
Consent and evidence governance becomes editable and visible inside the app.

## v2.5 - Graph Explorer UI
The event graph becomes navigable, filterable, and explainable.

## v2.6 - SCD2 State Editor
Relationship state history can be updated through controlled state transitions.

## v2.7 - Private Local Mode
The workbench supports a private local mode for consented personal use.

## v2.8 - Public Demo Mode Lock
The public demo prevents private data ingestion and uses synthetic data only.

## v2.9 - Scenario Simulator
The system compares future paths and what-if scenarios.

## v3.0 - Family Continuity Intelligence Suite
A complete integrated local workbench for reports, governance, graph, state, cases, and continuity.
'@ | Set-Content -Encoding UTF8 "88_Roadmap_v3\Roadmap_to_v3.md"

@'
# Streamlit Reports Cockpit

## What v2.2 Adds

- Visible Reports Cockpit tab.
- Manifest-driven report list.
- Report preview.
- Markdown/CSV download.
- Public/private mode badge.
- Guardrail badge.

## Report Source

`83_Report_Manifest/report_manifest.csv`
'@ | Set-Content -Encoding UTF8 "89_Streamlit_Reports_Cockpit\Streamlit_Reports_Cockpit.md"

@'
# v2.3 Backlog

## Theme

Interactive Report Builder UI

## Candidate Enhancements

- Select report type.
- Select sections.
- Generate new report from app.
- Save report to local folder.
- Download report.
- Publish selected synthetic report to Wiki.
- Add report freshness indicator.
'@ | Set-Content -Encoding UTF8 "91_Backlog_vNext\v2.3_Backlog.md"

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
MANIFEST_PATH = ROOT / "83_Report_Manifest" / "report_manifest.csv"
ROADMAP_PATH = ROOT / "88_Roadmap_v3" / "roadmap_to_v3.csv"
ROADMAP_MD = ROOT / "88_Roadmap_v3" / "Roadmap_to_v3.md"
CONSENT_PATH = ROOT / "30_Evidence_Consent_Registry" / "consent_ledger.csv"
SCD2_PATH = ROOT / "62_SCD2_State" / "relationship_state_seed.csv"
GRAPH_NODES = ROOT / "68_Event_Graph_Engine" / "event_graph_nodes.csv"
GRAPH_EDGES = ROOT / "68_Event_Graph_Engine" / "event_graph_edges.csv"
REPORT_DIR = ROOT / "53_Report_Exporter"

st.set_page_config(page_title="Purushartha OS Workbench", layout="wide")

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

def load_csv(path: Path) -> pd.DataFrame:
    if path.exists():
        try:
            return pd.read_csv(path)
        except Exception as exc:
            st.warning(f"Could not read {path}: {exc}")
    return pd.DataFrame()

def read_md(path: Path) -> str:
    if path.exists():
        try:
            return path.read_text(encoding="utf-8")
        except Exception as exc:
            return f"Could not read {path}: {exc}"
    return "Report not found yet. Run the latest full-flow scripts and redeploy."

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

st.title("Purushartha Family Continuity OS")
st.caption("Consent-first relationship, family, resilience, wealth, and legacy intelligence workbench.")

with st.sidebar:
    st.header("Live System")
    st.markdown("[GitHub Repo](https://github.com/ajaytester007/Purushartha_Family_Continuity_OS)")
    st.markdown("[GitHub Wiki](https://github.com/ajaytester007/Purushartha_Family_Continuity_OS/wiki)")
    st.markdown("[Public Pages](https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/)")
    st.markdown("---")
    st.warning("Decision support only. Do not use for surveillance, diagnosis, punishment, or publishing private evidence without consent.")

tabs = st.tabs([
    "Dashboard",
    "Event Entry",
    "Cases",
    "Scores",
    "Reports Cockpit",
    "Roadmap to v3.0",
    "Graph",
    "State Timeline",
    "Governance"
])

with tabs[0]:
    st.header("Workbench Dashboard")
    conn = db()
    local_events = pd.read_sql_query("SELECT * FROM local_event_log ORDER BY id DESC", conn)
    cases = load_csv(CASE_PATH)
    reports = load_csv(MANIFEST_PATH)
    roadmap = load_csv(ROADMAP_PATH)

    c1, c2, c3, c4 = st.columns(4)
    c1.metric("Local Events", len(local_events))
    c2.metric("Synthetic Cases", len(cases))
    c3.metric("Reports", len(reports))
    c4.metric("Roadmap Items", len(roadmap))

    if not cases.empty:
        st.subheader("Case Domain Distribution")
        st.bar_chart(cases.groupby("domain").size().sort_values(ascending=False).head(12))

with tabs[1]:
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
        conn.execute(
            "INSERT INTO local_event_log(created_at,stage,domain,harm_level,impact_score,repair_score,learning_score,summary,safety_override) VALUES (?,?,?,?,?,?,?,?,?)",
            (datetime.utcnow().isoformat(), stage, domain, harm_level, impact, repair, learning, summary, int(safety))
        )
        conn.commit()
        st.success("Event saved locally.")
    st.dataframe(pd.read_sql_query("SELECT * FROM local_event_log ORDER BY id DESC", db()), use_container_width=True)

with tabs[2]:
    st.header("Case Engine")
    cases = load_csv(CASE_PATH)
    if cases.empty:
        st.warning("Case library not found.")
    else:
        domains = sorted(cases["domain"].dropna().unique())
        selected_domains = st.multiselect("Filter by domain", domains)
        filtered = cases.copy()
        if selected_domains:
            filtered = filtered[filtered["domain"].isin(selected_domains)]
        st.dataframe(filtered, use_container_width=True)
        st.download_button("Download filtered cases", filtered.to_csv(index=False), "filtered_cases.csv", "text/csv")

with tabs[3]:
    st.header("Score Calculators")
    st.subheader("Relationship Health")
    a = st.columns(4)
    safety = a[0].slider("Safety", 0, 100, 80)
    trust = a[1].slider("Trust", 0, 100, 75)
    reciprocity = a[2].slider("Reciprocity", 0, 100, 70)
    affection = a[3].slider("Affection", 0, 100, 72)
    b = st.columns(4)
    respect = b[0].slider("Respect", 0, 100, 80)
    teamwork = b[1].slider("Teamwork", 0, 100, 75)
    repair_v = b[2].slider("Repair", 0, 100, 65)
    growth = b[3].slider("Growth", 0, 100, 70)
    score, label = relationship_health([safety, trust, reciprocity, affection, respect, teamwork, repair_v, growth])
    st.metric("Relationship Health Score", f"{score:.2f}", label)

    st.subheader("Burden Skew")
    actual = st.slider("Actual Share for Partner A", 0, 100, 75)
    expected = st.slider("Expected Share for Partner A", 0, 100, 50)
    duration = st.slider("Duration Multiplier", 0.5, 3.0, 1.2)
    involuntary = st.slider("Involuntary Multiplier", 0.5, 3.0, 1.1)
    recognition = st.slider("Recognition/Recovery Factor", 0.1, 3.0, 1.0)
    bscore, blabel = burden_skew(actual, expected, duration, involuntary, recognition)
    st.metric("Adjusted Burden Skew", f"{bscore:.2f}", blabel)

with tabs[4]:
    st.header("Reports Cockpit")
    manifest = load_csv(MANIFEST_PATH)
    if manifest.empty:
        st.warning("Report manifest not found. Run v2.2 full flow and redeploy.")
    else:
        st.dataframe(manifest, use_container_width=True)
        selected = st.selectbox("Open report", manifest["report_id"] + " - " + manifest["report_name"])
        report_id = selected.split(" - ")[0]
        row = manifest[manifest["report_id"] == report_id].iloc[0]
        st.subheader(row["report_name"])
        col1, col2, col3 = st.columns(3)
        col1.info(f"Type: {row['report_type']}")
        col2.info(f"Mode: {row['public_private_mode']}")
        col3.success(f"Guardrail: {row['guardrail_status']}")
        local_path = ROOT / row["local_path"]
        if local_path.suffix.lower() == ".md":
            content = read_md(local_path)
            st.markdown(content)
            st.download_button("Download Markdown", content, local_path.name, "text/markdown")
        elif local_path.suffix.lower() == ".csv" and local_path.exists():
            df = pd.read_csv(local_path)
            st.dataframe(df, use_container_width=True)
            st.download_button("Download CSV", df.to_csv(index=False), local_path.name, "text/csv")
        else:
            st.warning(f"Report file not found locally: {local_path}")

with tabs[5]:
    st.header("Roadmap to v3.0")
    roadmap = load_csv(ROADMAP_PATH)
    if not roadmap.empty:
        st.dataframe(roadmap, use_container_width=True)
        status_counts = roadmap.groupby("status").size()
        st.subheader("Roadmap Status")
        st.bar_chart(status_counts)
    if ROADMAP_MD.exists():
        st.markdown(ROADMAP_MD.read_text(encoding="utf-8"))

with tabs[6]:
    st.header("Event Graph")
    nodes = load_csv(GRAPH_NODES)
    edges = load_csv(GRAPH_EDGES)
    c1, c2 = st.columns(2)
    c1.metric("Nodes", len(nodes))
    c2.metric("Edges", len(edges))
    st.subheader("Nodes")
    st.dataframe(nodes, use_container_width=True)
    st.subheader("Edges")
    st.dataframe(edges, use_container_width=True)

with tabs[7]:
    st.header("SCD2 State Timeline")
    scd = load_csv(SCD2_PATH)
    if scd.empty:
        st.warning("SCD2 seed not found.")
    else:
        st.dataframe(scd, use_container_width=True)
        chart_df = scd[["valid_from","relationship_health_score","burden_skew_score","purushartha_balance_score"]].copy()
        chart_df["valid_from"] = pd.to_datetime(chart_df["valid_from"])
        st.line_chart(chart_df.set_index("valid_from"))

with tabs[8]:
    st.header("Governance")
    consent = load_csv(CONSENT_PATH)
    if consent.empty:
        st.warning("Consent ledger not found.")
    else:
        st.dataframe(consent, use_container_width=True)
    st.markdown("""
### Governance Guardrails
- Use synthetic data publicly.
- Use real data only in private/local mode with explicit consent.
- Label confidence and contradictions.
- Do not use the tool to punish, shame, secretly monitor, or diagnose.
- Safety override must supersede relationship optimization.
""")

'@ | Set-Content -Encoding UTF8 "51_Streamlit_MVP\app.py"

Write-Host "v2.2 assets merged successfully." -ForegroundColor Green
