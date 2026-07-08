$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v2.5 assets ==" -ForegroundColor Cyan

$Dirs = @(
"101_Graph_Explorer_UI",
"102_Graph_Path_Views",
"103_Mermaid_Graph_Export",
"104_Release_Notes",
"105_Backlog_vNext"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v2.5 Graph Explorer UI

## Purpose

v2.5 makes the event graph explorable inside the Streamlit app.

## Added

- Graph Explorer tab.
- Filters by node type, stage, domain, and edge type.
- Risk-to-repair path view.
- Tollgate path view.
- Mermaid graph preview.
- Mermaid graph download.
- Graph Explorer documentation.
- v2.6 backlog for SCD2 State Editor.

## Guardrail

Graph views explain traceable relationships. They are not moral verdicts.
'@ | Set-Content -Encoding UTF8 "104_Release_Notes\v2.5_Graph_Explorer_UI.md"

@'
# Graph Explorer UI

## Features

- Node type filter
- Stage filter
- Domain filter
- Edge type filter
- Filtered node table
- Filtered edge table
- Risk-to-repair path view
- Tollgate path view
- Mermaid graph preview
- Mermaid download

## Guardrail

Graph paths are explainable structures, not blame assignments.
'@ | Set-Content -Encoding UTF8 "101_Graph_Explorer_UI\Graph_Explorer_UI.md"

@'
# Graph Path Views

## Path Families

- Risk to Repair
- Event to Tollgate
- Support to Relationship
- Obligation to Burden
- Asset to Floor Protection
- State to Relationship

## v2.5 Scope

The first app view displays risk/repair and tollgate path tables.
'@ | Set-Content -Encoding UTF8 "102_Graph_Path_Views\Graph_Path_Views.md"

@'
# Mermaid Graph Export

The Streamlit Graph Explorer can export a filtered graph as Mermaid `.mmd`.

## Use

Copy the Mermaid output into GitHub Markdown, Mermaid Live, or another renderer.

## Future

v2.6+ may render graph diagrams directly inside the app.
'@ | Set-Content -Encoding UTF8 "103_Mermaid_Graph_Export\Mermaid_Graph_Export.md"

@'
# v2.6 Backlog

## Theme

SCD2 State Editor

## Candidate Enhancements

- Editable state timeline.
- Close current state row.
- Create new current state.
- State-change reason.
- Confidence label.
- Source event references.
- State-to-report generator.
'@ | Set-Content -Encoding UTF8 "105_Backlog_vNext\v2.6_Backlog.md"

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
EVIDENCE_PATH = ROOT / "30_Evidence_Consent_Registry" / "evidence_registry.csv"
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

def save_csv(df: pd.DataFrame, path: Path):
    path.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(path, index=False)

def read_md(path: Path) -> str:
    if path.exists():
        try:
            return path.read_text(encoding="utf-8")
        except Exception as exc:
            return f"Could not read {path}: {exc}"
    return "Report not found yet."

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
            lines += (["No local events entered.", ""] if events.empty else events.to_markdown(index=False).splitlines() + [""])
        elif section == "Case Summary":
            cases = load_csv(CASE_PATH)
            if cases.empty:
                lines += ["No case data found.", ""]
            else:
                summary = cases.groupby("domain").size().reset_index(name="case_count")
                lines += summary.to_markdown(index=False).splitlines() + [""]
        elif section == "SCD2 State":
            scd = load_csv(SCD2_PATH)
            lines += (["No SCD2 data found.", ""] if scd.empty else scd.to_markdown(index=False).splitlines() + [""])
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
    return "\n".join(lines)

def mermaid_from_graph(nodes_df, edges_df):
    lines = ["flowchart TD"]
    if nodes_df.empty:
        return "flowchart TD\n  EMPTY[No graph nodes selected]"
    for _, n in nodes_df.iterrows():
        node_id = str(n.get("node_id", "")).strip()
        label = f"{n.get('node_type','Node')}: {n.get('label', node_id)}".replace('"', "'")
        if node_id:
            lines.append(f'  {node_id}["{label}"]')
    selected_ids = set(nodes_df["node_id"].astype(str)) if "node_id" in nodes_df.columns else set()
    for _, e in edges_df.iterrows():
        f = str(e.get("from_node", "")).strip()
        t = str(e.get("to_node", "")).strip()
        if f in selected_ids and t in selected_ids:
            label = str(e.get("edge_type", "links_to")).replace("_", " ")
            lines.append(f"  {f} -- {label} --> {t}")
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
    "Graph Explorer",
    "State Timeline",
    "Governance",
    "Consent Ledger"
])

with tabs[0]:
    st.header("Workbench Dashboard")
    local_events = pd.read_sql_query("SELECT * FROM local_event_log ORDER BY id DESC", db())
    cases = load_csv(CASE_PATH)
    reports = load_csv(MANIFEST_PATH)
    roadmap = load_csv(ROADMAP_PATH)
    consent = load_csv(CONSENT_PATH)
    nodes = load_csv(GRAPH_NODES)
    edges = load_csv(GRAPH_EDGES)
    c1, c2, c3, c4, c5, c6 = st.columns(6)
    c1.metric("Local Events", len(local_events))
    c2.metric("Synthetic Cases", len(cases))
    c3.metric("Reports", len(reports))
    c4.metric("Roadmap Items", len(roadmap))
    c5.metric("Graph Nodes", len(nodes))
    c6.metric("Graph Edges", len(edges))
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
        st.warning("Report manifest not found.")
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
        "Relationship Health Report","Burden Skew Audit","Family Continuity Report","Event Graph Report","Governance Report","Roadmap Report"
    ])
    sections = st.multiselect(
        "Sections",
        ["Local Events","Case Summary","SCD2 State","Event Graph","Decision Explanations","Repair Plans","Governance Guardrails","Roadmap"],
        default=["Case Summary","SCD2 State","Governance Guardrails"]
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
        content = read_md(p)
        st.markdown(content)
        st.download_button("Download Generated Report", content, p.name, "text/markdown")

with tabs[6]:
    st.header("Roadmap to v3.0")
    roadmap = load_csv(ROADMAP_PATH)
    if not roadmap.empty:
        st.dataframe(roadmap, use_container_width=True)
        st.bar_chart(roadmap.groupby("status").size())
    if ROADMAP_MD.exists():
        st.markdown(ROADMAP_MD.read_text(encoding="utf-8"))

with tabs[7]:
    st.header("Graph Explorer")
    nodes = load_csv(GRAPH_NODES)
    edges = load_csv(GRAPH_EDGES)
    if nodes.empty or edges.empty:
        st.warning("Graph node/edge seed files not found.")
    else:
        c1, c2 = st.columns(2)
        c1.metric("Nodes", len(nodes))
        c2.metric("Edges", len(edges))

        node_types = sorted(nodes["node_type"].dropna().unique())
        stages = sorted(nodes["stage"].dropna().unique())
        domains = sorted(nodes["domain"].dropna().unique())
        edge_types = sorted(edges["edge_type"].dropna().unique())

        f1, f2, f3, f4 = st.columns(4)
        selected_node_types = f1.multiselect("Node Type", node_types)
        selected_stages = f2.multiselect("Stage", stages)
        selected_domains = f3.multiselect("Domain", domains)
        selected_edge_types = f4.multiselect("Edge Type", edge_types)

        filtered_nodes = nodes.copy()
        if selected_node_types:
            filtered_nodes = filtered_nodes[filtered_nodes["node_type"].isin(selected_node_types)]
        if selected_stages:
            filtered_nodes = filtered_nodes[filtered_nodes["stage"].isin(selected_stages)]
        if selected_domains:
            filtered_nodes = filtered_nodes[filtered_nodes["domain"].isin(selected_domains)]

        selected_ids = set(filtered_nodes["node_id"].astype(str))
        filtered_edges = edges[
            edges["from_node"].astype(str).isin(selected_ids) &
            edges["to_node"].astype(str).isin(selected_ids)
        ].copy()
        if selected_edge_types:
            filtered_edges = filtered_edges[filtered_edges["edge_type"].isin(selected_edge_types)]

        st.subheader("Filtered Nodes")
        st.dataframe(filtered_nodes, use_container_width=True)
        st.subheader("Filtered Edges")
        st.dataframe(filtered_edges, use_container_width=True)

        st.subheader("Risk-to-Repair Paths")
        risk_ids = set(nodes[nodes["node_type"].astype(str).str.lower() == "risk"]["node_id"].astype(str))
        repair_ids = set(nodes[nodes["node_type"].astype(str).str.lower() == "repair"]["node_id"].astype(str))
        repair_edges = edges[
            edges["from_node"].astype(str).isin(repair_ids) |
            edges["to_node"].astype(str).isin(repair_ids) |
            edges["from_node"].astype(str).isin(risk_ids) |
            edges["to_node"].astype(str).isin(risk_ids)
        ]
        st.dataframe(repair_edges, use_container_width=True)

        st.subheader("Tollgate Paths")
        tollgate_ids = set(nodes[nodes["node_type"].astype(str).str.lower() == "tollgate"]["node_id"].astype(str))
        tollgate_edges = edges[
            edges["from_node"].astype(str).isin(tollgate_ids) |
            edges["to_node"].astype(str).isin(tollgate_ids)
        ]
        st.dataframe(tollgate_edges, use_container_width=True)

        st.subheader("Mermaid Graph Preview")
        mermaid = mermaid_from_graph(filtered_nodes, filtered_edges)
        st.code(mermaid, language="mermaid")
        st.download_button("Download Mermaid Graph", mermaid, "filtered_event_graph.mmd", "text/plain")

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
    evidence = load_csv(EVIDENCE_PATH)
    if evidence.empty:
        st.warning("Evidence registry not found.")
    else:
        st.subheader("Evidence Registry")
        st.dataframe(evidence, use_container_width=True)
    st.markdown("""
### Governance Guardrails
- Use synthetic data publicly.
- Use real data only in private/local mode with explicit consent.
- Label confidence and contradictions.
- Do not use the tool to punish, shame, secretly monitor, or diagnose.
- Safety override must supersede relationship optimization.
""")

with tabs[10]:
    st.header("Consent Ledger")
    consent = load_csv(CONSENT_PATH)
    if consent.empty:
        consent = pd.DataFrame(columns=["consent_id","participant","record_id","status","allowed_viewers","allowed_analysis","retention_until","revoked_at"])
    edited = st.data_editor(consent, use_container_width=True, num_rows="dynamic")
    if st.button("Save Consent Ledger Locally"):
        save_csv(edited, CONSENT_PATH)
        st.success(f"Saved consent ledger to {CONSENT_PATH}")
    st.subheader("Consent Status Summary")
    if not edited.empty and "status" in edited.columns:
        st.bar_chart(edited.groupby("status").size())
    st.info("On Streamlit Cloud, edits may not persist permanently. Use local mode for durable private governance data.")

'@ | Set-Content -Encoding UTF8 "51_Streamlit_MVP\app.py"

Write-Host "v2.5 assets merged successfully." -ForegroundColor Green
