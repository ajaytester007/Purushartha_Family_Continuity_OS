$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v2.3 assets ==" -ForegroundColor Cyan

$Dirs = @(
"92_Generated_Reports",
"93_Report_Builder_UI",
"94_Release_Notes",
"95_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v2.3 Interactive Report Builder UI

## Purpose

v2.3 adds an actual interactive Report Builder tab inside the Streamlit workbench.

## Added

- Report Builder tab.
- Report type selector.
- Section selector.
- Context note input.
- Markdown generation.
- Local generated report storage.
- Report preview.
- Download buttons.
- Generated reports list.

## Correction

v2.2 made reports visible. v2.3 lets the user generate new report outputs directly from the app.
'@ | Set-Content -Encoding UTF8 "94_Release_Notes\v2.3_Interactive_Report_Builder_UI.md"

@'
# Report Builder UI

## Features

- Choose report type.
- Choose sections.
- Add context note.
- Generate Markdown.
- Preview generated report.
- Download generated report.
- Save generated report locally.

## Output Folder

`92_Generated_Reports`
'@ | Set-Content -Encoding UTF8 "93_Report_Builder_UI\Report_Builder_UI.md"

@'
# v2.4 Backlog

## Theme

Consent Ledger UI

## Candidate Enhancements

- Consent ledger editor.
- Evidence registry editor.
- Public/private mode badge.
- Data retention controls.
- Consent validation before report generation.
- Safety override gate.
- Report publication approval gate.
'@ | Set-Content -Encoding UTF8 "95_Backlog_vNext\v2.4_Backlog.md"

@'
# Generated Reports

This folder stores local Markdown reports generated from the Streamlit Report Builder.

Public demo reports should remain synthetic.
Private reports should stay local unless explicitly sanitized and approved.
'@ | Set-Content -Encoding UTF8 "92_Generated_Reports\README.md"

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
GENERATED_REPORT_DIR = ROOT / "92_Generated_Reports"

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

def build_report(report_type, selected_sections, context_note):
    now = datetime.utcnow().isoformat()
    lines = [f"# {report_type}", "", f"Generated: {now} UTC", ""]
    lines += ["## Context Note", "", context_note or "Synthetic/demo workbench report.", ""]
    for section in selected_sections:
        lines += [f"## {section}", ""]
        if section == "Local Events":
            events = pd.read_sql_query("SELECT * FROM local_event_log ORDER BY id DESC", db())
            if events.empty:
                lines += ["No local events entered.", ""]
            else:
                lines += events.to_markdown(index=False).splitlines() + [""]
        elif section == "Case Summary":
            cases = load_csv(CASE_PATH)
            if cases.empty:
                lines += ["No case data found.", ""]
            else:
                summary = cases.groupby("domain").size().reset_index(name="case_count")
                lines += summary.to_markdown(index=False).splitlines() + [""]
        elif section == "SCD2 State":
            scd = load_csv(SCD2_PATH)
            if scd.empty:
                lines += ["No SCD2 data found.", ""]
            else:
                lines += scd.to_markdown(index=False).splitlines() + [""]
        elif section == "Event Graph":
            nodes = load_csv(GRAPH_NODES)
            edges = load_csv(GRAPH_EDGES)
            lines += [f"- Nodes: {len(nodes)}", f"- Edges: {len(edges)}", ""]
        elif section == "Decision Explanations":
            lines += [read_md(DECISION_PATH), ""]
        elif section == "Repair Plans":
            lines += [read_md(REPAIR_PATH), ""]
        elif section == "Governance Guardrails":
            lines += [
                "- Use synthetic data publicly.",
                "- Use real data only in private/local mode with explicit consent.",
                "- Label confidence and contradictions.",
                "- Do not use the tool to punish, shame, secretly monitor, or diagnose.",
                "- Safety override must supersede relationship optimization.",
                ""
            ]
        elif section == "Roadmap":
            lines += [read_md(ROADMAP_MD), ""]
        else:
            lines += ["Section not implemented yet.", ""]
    return "\n".join(lines)

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
    "Report Builder",
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
    generated = list(GENERATED_REPORT_DIR.glob("*.md")) if GENERATED_REPORT_DIR.exists() else []

    c1, c2, c3, c4, c5 = st.columns(5)
    c1.metric("Local Events", len(local_events))
    c2.metric("Synthetic Cases", len(cases))
    c3.metric("Catalog Reports", len(reports))
    c4.metric("Generated Reports", len(generated))
    c5.metric("Roadmap Items", len(roadmap))

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
        st.warning("Report manifest not found. Run v2.1+ full flow and redeploy.")
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
    st.header("Interactive Report Builder")
    GENERATED_REPORT_DIR.mkdir(parents=True, exist_ok=True)
    report_type = st.selectbox("Report Type", [
        "Relationship Health Report",
        "Burden Skew Audit",
        "Family Continuity Report",
        "Event Graph Report",
        "Governance Report",
        "Roadmap Report"
    ])
    sections = st.multiselect(
        "Sections",
        ["Local Events", "Case Summary", "SCD2 State", "Event Graph", "Decision Explanations", "Repair Plans", "Governance Guardrails", "Roadmap"],
        default=["Case Summary", "SCD2 State", "Governance Guardrails"]
    )
    context_note = st.text_area("Context Note", "Synthetic/demo report generated from the Purushartha OS workbench.")
    if st.button("Generate Report"):
        content = build_report(report_type, sections, context_note)
        safe_name = report_type.lower().replace(" ", "_").replace("/", "_")
        out_path = GENERATED_REPORT_DIR / f"{safe_name}_{datetime.utcnow().strftime('%Y%m%d_%H%M%S')}.md"
        out_path.write_text(content, encoding="utf-8")
        st.session_state["last_generated_report"] = str(out_path)
        st.success(f"Generated: {out_path}")

    last = st.session_state.get("last_generated_report")
    if last:
        p = Path(last)
        st.subheader("Generated Report Preview")
        content = read_md(p)
        st.markdown(content)
        st.download_button("Download Generated Report", content, p.name, "text/markdown")

    existing = sorted(GENERATED_REPORT_DIR.glob("*.md"), reverse=True)
    if existing:
        st.subheader("Existing Generated Reports")
        chosen = st.selectbox("Open generated report", [p.name for p in existing])
        p = GENERATED_REPORT_DIR / chosen
        content = read_md(p)
        st.markdown(content)
        st.download_button("Download Selected Generated Report", content, p.name, "text/markdown")

with tabs[6]:
    st.header("Roadmap to v3.0")
    roadmap = load_csv(ROADMAP_PATH)
    if not roadmap.empty:
        st.dataframe(roadmap, use_container_width=True)
        st.subheader("Roadmap Status")
        st.bar_chart(roadmap.groupby("status").size())
    if ROADMAP_MD.exists():
        st.markdown(ROADMAP_MD.read_text(encoding="utf-8"))

with tabs[7]:
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

with tabs[8]:
    st.header("SCD2 State Timeline")
    scd = load_csv(SCD2_PATH)
    if scd.empty:
        st.warning("SCD2 seed not found.")
    else:
        st.dataframe(scd, use_container_width=True)
        chart_df = scd[["valid_from","relationship_health_score","burden_skew_score","purushartha_balance_score"]].copy()
        chart_df["valid_from"] = pd.to_datetime(chart_df["valid_from"])
        st.line_chart(chart_df.set_index("valid_from"))

with tabs[9]:
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

Write-Host "v2.3 assets merged successfully." -ForegroundColor Green
