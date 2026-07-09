
import sqlite3
from pathlib import Path
from datetime import datetime
from math import prod

import pandas as pd
import streamlit as st
import os

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
SCD2_AUDIT_PATH = ROOT / "106_SCD2_State_Editor" / "state_transition_audit.csv"
GRAPH_NODES = ROOT / "68_Event_Graph_Engine" / "event_graph_nodes.csv"
GRAPH_EDGES = ROOT / "68_Event_Graph_Engine" / "event_graph_edges.csv"
SCENARIO_PATH = ROOT / "122_Scenario_Simulator" / "scenario_seed.csv"
SCENARIO_REPORT_PATH = ROOT / "124_Scenario_Reports" / "scenario_comparison_report_v2_9.md"
V3_CAPABILITY_MATRIX = ROOT / "130_Capability_Matrix" / "v3_0_capability_matrix.csv"
V3_RELEASE_SUMMARY = ROOT / "129_Release_Dashboard" / "v3_0_release_summary.md"
GENERATED_REPORT_DIR = ROOT / "92_Generated_Reports"
DAILY_LOG_PATH = ROOT / "150_Daily_Log_Persistence" / "daily_logs.csv"
GRIEVANCE_REPORTS_PATH = ROOT / "151_Grievance_Report_Persistence" / "grievance_reports.csv"
WORKBENCH_MODE = os.environ.get("PURUSHARTHA_WORKBENCH_MODE", "Public Demo")
PRIVATE_REPORT_DIR = ROOT / "114_Private_Reports"

st.set_page_config(page_title="Purushartha OS Workbench", layout="wide")

DEPLOYMENT_MODE = os.environ.get("PURUSHARTHA_DEPLOYMENT_MODE", "public_demo").lower()
ALLOW_PRIVATE_MODE = os.environ.get("PURUSHARTHA_ALLOW_PRIVATE_MODE", "false").lower() == "true"
PUBLIC_DEMO_LOCKED = DEPLOYMENT_MODE != "private_local" or not ALLOW_PRIVATE_MODE

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
        if section == "Case Summary":
            cases = load_csv(CASE_PATH)
            if cases.empty:
                lines += ["No case data found.", ""]
            else:
                lines += cases.groupby("domain").size().reset_index(name="case_count").to_markdown(index=False).splitlines() + [""]
        elif section == "SCD2 State":
            scd = load_csv(SCD2_PATH)
            lines += (["No SCD2 data found.", ""] if scd.empty else scd.to_markdown(index=False).splitlines() + [""])
        elif section == "Event Graph":
            nodes = load_csv(GRAPH_NODES)
            edges = load_csv(GRAPH_EDGES)
            lines += [f"- Nodes: {len(nodes)}", f"- Edges: {len(edges)}", ""]
        elif section == "Governance Guardrails":
            lines += ["- Use synthetic data publicly.", "- Use private data only in local/private mode with explicit consent.", "- Safety override supersedes relationship optimization.", ""]
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

def append_audit(row):
    SCD2_AUDIT_PATH.parent.mkdir(parents=True, exist_ok=True)
    existing = load_csv(SCD2_AUDIT_PATH)
    new_df = pd.DataFrame([row])
    combined = pd.concat([existing, new_df], ignore_index=True) if not existing.empty else new_df
    save_csv(combined, SCD2_AUDIT_PATH)

st.title("Purushartha Family Continuity OS")
st.caption("Consent-first relationship, family, resilience, wealth, and legacy intelligence workbench.")

if PUBLIC_DEMO_LOCKED:
    st.error("PUBLIC DEMO LOCK ACTIVE: Use synthetic or sanitized data only. Do not enter private relationship, health, or third-party information.")
else:
    st.success("PRIVATE LOCAL MODE ENABLED: Keep outputs local unless sanitized and explicitly approved.")

with st.sidebar:
    st.header("Live System")
    st.markdown("[GitHub Repo](https://github.com/ajaytester007/Purushartha_Family_Continuity_OS)")
    st.markdown("[GitHub Wiki](https://github.com/ajaytester007/Purushartha_Family_Continuity_OS/wiki)")
    st.markdown("[Public Pages](https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/)")
    st.markdown("---")
    st.warning("Decision support only. Do not use for surveillance, diagnosis, punishment, or publishing private evidence without consent.")
st.markdown("---")
available_modes = ["Public Demo"] if PUBLIC_DEMO_LOCKED else ["Public Demo", "Private Local"]
mode = st.radio("Workbench Mode", available_modes, index=0)
if PUBLIC_DEMO_LOCKED:
    st.warning("Private Local mode is disabled in public deployment.")
st.session_state["workbench_mode"] = mode
if mode == "Public Demo":
    st.success("Public Demo Mode: synthetic/sanitized data only.")
else:
    st.error("Private Local Mode: keep outputs local; do not publish private reports.")

tabs = st.tabs([
    "v3.0 Suite",
    "Daily Companion",
    "Grievance Report",
    "Relationship Trends",
    "Relationship Consultancy",
    "Dashboard",
    "Event Entry",
    "Cases",
    "Scores",
    "Reports Cockpit",
    "Report Builder",
    "Roadmap to v3.0",
    "Graph Explorer",
    "SCD2 State Editor",
    "Governance",
    "Scenario Simulator",
    "Consent Ledger"
])

with tabs[0]:
    st.header("Workbench Dashboard")
    local_events = pd.read_sql_query("SELECT * FROM local_event_log ORDER BY id DESC", db())
    cases = load_csv(CASE_PATH)
    reports = load_csv(MANIFEST_PATH)
    roadmap = load_csv(ROADMAP_PATH)
    nodes = load_csv(GRAPH_NODES)
    edges = load_csv(GRAPH_EDGES)
    scd = load_csv(SCD2_PATH)
    c1, c2, c3, c4, c5, c6 = st.columns(6)
    c1.metric("Local Events", len(local_events))
    c2.metric("Synthetic Cases", len(cases))
    c3.metric("Reports", len(reports))
    c4.metric("Roadmap Items", len(roadmap))
    c5.metric("Graph Nodes", len(nodes))
    c6.metric("State Rows", len(scd))
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
        selected_domains = st.multiselect("Filter by domain", sorted(cases["domain"].dropna().unique()))
        filtered = cases[cases["domain"].isin(selected_domains)] if selected_domains else cases
        st.dataframe(filtered, use_container_width=True)

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
        st.info(f"Type: {row['report_type']} | Mode: {row['public_private_mode']} | Guardrail: {row['guardrail_status']}")
        local_path = ROOT / row["local_path"]
        if local_path.suffix.lower() == ".md":
            content = read_md(local_path)
            st.markdown(content)
            st.download_button("Download Markdown", content, local_path.name, "text/markdown")
        elif local_path.suffix.lower() == ".csv" and local_path.exists():
            df = pd.read_csv(local_path)
            st.dataframe(df, use_container_width=True)

with tabs[5]:
    st.header("Interactive Report Builder")
current_mode = st.session_state.get("workbench_mode", "Public Demo")
if current_mode == "Private Local":
    st.error("Private mode outputs must not be committed or published unless sanitized.")
else:
    st.success("Public Demo Mode: generated reports must remain synthetic/sanitized.")
    GENERATED_REPORT_DIR.mkdir(parents=True, exist_ok=True)
    report_type = st.selectbox("Report Type", ["Relationship Health Report","Burden Skew Audit","Family Continuity Report","Event Graph Report","Governance Report"])
    sections = st.multiselect("Sections", ["Case Summary","SCD2 State","Event Graph","Governance Guardrails"], default=["Case Summary","SCD2 State","Governance Guardrails"])
    context_note = st.text_area("Context Note", "Synthetic/demo report generated from the Purushartha OS workbench.")
    if PUBLIC_DEMO_LOCKED:
        st.warning("Report generation is public-demo locked. Output must remain synthetic/sanitized.")
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
        selected_node_types = st.multiselect("Node Type", sorted(nodes["node_type"].dropna().unique()))
        filtered_nodes = nodes[nodes["node_type"].isin(selected_node_types)] if selected_node_types else nodes
        selected_ids = set(filtered_nodes["node_id"].astype(str))
        filtered_edges = edges[edges["from_node"].astype(str).isin(selected_ids) & edges["to_node"].astype(str).isin(selected_ids)]
        st.dataframe(filtered_nodes, use_container_width=True)
        st.dataframe(filtered_edges, use_container_width=True)
        mermaid = mermaid_from_graph(filtered_nodes, filtered_edges)
        st.code(mermaid, language="mermaid")
        st.download_button("Download Mermaid Graph", mermaid, "filtered_event_graph.mmd", "text/plain")

with tabs[8]:
    st.header("SCD2 State Editor")
    scd = load_csv(SCD2_PATH)
    if scd.empty:
        st.warning("SCD2 seed not found.")
    else:
        st.subheader("Current State Timeline")
        st.dataframe(scd, use_container_width=True)
        chart_df = scd[["valid_from","relationship_health_score","burden_skew_score","purushartha_balance_score"]].copy()
        chart_df["valid_from"] = pd.to_datetime(chart_df["valid_from"])
        st.line_chart(chart_df.set_index("valid_from"))

        st.subheader("Create Controlled State Transition")
        current_rows = scd[scd["is_current"].astype(str).str.lower() == "true"]
        current_state_id = current_rows.iloc[0]["state_id"] if not current_rows.empty else scd.iloc[-1]["state_id"]
        st.info(f"Current state to close: {current_state_id}")

        with st.form("scd2_transition_form"):
            new_state_id = st.text_input("New State ID", f"S{len(scd)+1:03d}")
            relationship_id = st.text_input("Relationship ID", "R001")
            valid_from = st.date_input("New Valid From")
            relationship_health_score = st.slider("Relationship Health Score", 0, 100, 80)
            burden_skew_score = st.slider("Burden Skew Score", 0, 100, 25)
            karma_bond_score = st.slider("Karma Bond Score", 0, 100, 78)
            purushartha_balance_score = st.slider("Purushartha Balance Score", 0, 100, 82)
            confidence = st.selectbox("Confidence", ["low", "medium", "high"])
            source_event_ids = st.text_input("Source Event IDs", "synthetic")
            reason = st.text_area("State Change Reason", "Synthetic controlled transition.")
            submit_state = st.form_submit_button("Close Current and Create New State")

        if submit_state:
            updated = scd.copy()
            updated.loc[updated["is_current"].astype(str).str.lower() == "true", "is_current"] = "false"
            updated.loc[updated["state_id"] == current_state_id, "valid_to"] = str(valid_from)
            new_row = {
                "state_id": new_state_id,
                "relationship_id": relationship_id,
                "valid_from": str(valid_from),
                "valid_to": "",
                "is_current": "true",
                "relationship_health_score": relationship_health_score,
                "burden_skew_score": burden_skew_score,
                "karma_bond_score": karma_bond_score,
                "purushartha_balance_score": purushartha_balance_score,
                "confidence": confidence,
                "notes": reason
            }
            updated = pd.concat([updated, pd.DataFrame([new_row])], ignore_index=True)
            save_csv(updated, SCD2_PATH)
            append_audit({
                "transition_id": f"TR{datetime.utcnow().strftime('%Y%m%d%H%M%S')}",
                "transition_at": datetime.utcnow().isoformat(),
                "closed_state_id": current_state_id,
                "new_state_id": new_state_id,
                "relationship_id": relationship_id,
                "source_event_ids": source_event_ids,
                "confidence": confidence,
                "reason": reason
            })
            st.success("SCD2 transition saved locally. Refresh app to view updated timeline.")

        audit = load_csv(SCD2_AUDIT_PATH)
        if not audit.empty:
            st.subheader("State Transition Audit")
            st.dataframe(audit, use_container_width=True)

with tabs[9]:
    st.header("Governance")
    evidence = load_csv(EVIDENCE_PATH)
    if evidence.empty:
        st.warning("Evidence registry not found.")
    else:
        st.dataframe(evidence, use_container_width=True)
    st.markdown("- Use synthetic data publicly.\n- Use real data only in private/local mode with explicit consent.\n- Safety override supersedes relationship optimization.")

with tabs[10]:
    st.header("Scenario Simulator",
    "Consent Ledger")
    consent = load_csv(CONSENT_PATH)
    if consent.empty:
        consent = pd.DataFrame(columns=["consent_id","participant","record_id","status","allowed_viewers","allowed_analysis","retention_until","revoked_at"])
    edited = st.data_editor(consent, use_container_width=True, num_rows="dynamic")
    if st.button("Save Consent Ledger Locally"):
        save_csv(edited, CONSENT_PATH)
        st.success(f"Saved consent ledger to {CONSENT_PATH}")
    if not edited.empty and "status" in edited.columns:
        st.bar_chart(edited.groupby("status").size())
    st.info("On Streamlit Cloud, edits may not persist permanently. Use local mode for durable private governance data.")





with tabs[-2]:
    st.header("Scenario Simulator")
    scenarios = load_csv(SCENARIO_PATH)
    if scenarios.empty:
        st.warning("Scenario seed not found. Run v2.9 full flow.")
    else:
        st.subheader("Scenario Comparison")
        st.dataframe(scenarios, use_container_width=True)
        path = st.selectbox("Select path", scenarios["path"])
        row = scenarios[scenarios["path"] == path].iloc[0]
        c1, c2, c3, c4 = st.columns(4)
        c1.metric("Health Delta", row["relationship_health_delta"])
        c2.metric("Burden Delta", row["burden_skew_delta"])
        c3.metric("Continuity", row["continuity_score"])
        c4.metric("Risk", row["risk_score"])
        st.info(row["recommendation"])
        st.subheader("Tradeoff Chart")
        chart = scenarios[["path","continuity_score","risk_score","repair_effort"]].set_index("path")
        st.bar_chart(chart)
        if SCENARIO_REPORT_PATH.exists():
            report = SCENARIO_REPORT_PATH.read_text(encoding="utf-8")
            st.subheader("Scenario Report")
            st.markdown(report)
            st.download_button("Download Scenario Report", report, "scenario_comparison_report_v2_9.md", "text/markdown")
        st.warning("Scenario simulation is decision support only. Safety and professional review override optimization.")


with tabs[0]:
    st.header("v3.0 Family Continuity Intelligence Suite Milestone")
    st.success("v3.0 integrates knowledgebase, cases, reports, consent governance, graph, SCD2 state, scenario simulation, public demo lock, and private local mode.")
    matrix = load_csv(V3_CAPABILITY_MATRIX)
    if not matrix.empty:
        st.subheader("Capability Matrix")
        st.dataframe(matrix, use_container_width=True)
        st.bar_chart(matrix.groupby("status").size())
    if V3_RELEASE_SUMMARY.exists():
        st.subheader("Release Summary")
        st.markdown(V3_RELEASE_SUMMARY.read_text(encoding="utf-8"))


def analyze_correspondence_v31(text, severity, recurrence, family_influence):
    lower = text.lower()
    positive_terms = ["sorry", "understand", "respect", "clarify", "work together", "repair", "accountable", "appreciate", "listen"]
    negative_terms = ["always", "never", "fault", "cheap", "threat", "done", "leave", "hate", "slander", "blame", "shame"]
    boundary_terms = ["boundary", "space", "pause", "respect", "comfortable", "not okay"]
    positive = sum(1 for w in positive_terms if w in lower)
    negative = sum(1 for w in negative_terms if w in lower)
    boundary = sum(1 for w in boundary_terms if w in lower)
    maturity = max(0, min(100, 70 + positive * 5 + boundary * 2 - negative * 6 - severity * 5 - recurrence * 3 - family_influence * 4))
    repair = max(0, min(100, 50 + positive * 8 - negative * 5 - severity * 4))
    escalation = max(0, min(100, 25 + negative * 10 + severity * 8 + recurrence * 5 + family_influence * 5 - positive * 4))
    if escalation >= 70 or maturity < 40:
        action = "Pause / protect dignity / consider mediation or exit-threshold review"
    elif maturity >= 75 and repair >= 65:
        action = "Continue with calm clarification and repair agreement"
    elif maturity >= 55:
        action = "Correct with clear boundaries, retest date, and specific behavior change"
    else:
        action = "Reconsider; require accountability before proceeding"
    suggested_reply = ("Thank you for sharing this. I want us to handle this calmly and respectfully. "
                       "I am open to repair, but I need clarity, accountability, and a specific change going forward. "
                       "Let us discuss this without blame, pressure, or family escalation, and agree on what each of us will do differently.")
    return {"maturity": maturity, "repair": repair, "escalation": escalation, "positive": positive, "negative": negative, "boundary": boundary, "action": action, "suggested_reply": suggested_reply}

with tabs[0]:
    st.header("Interactive Relationship Consultancy")
    st.warning("Use only synthetic, anonymized, or sanitized correspondence in the public app. This is decision support, not diagnosis, legal advice, or therapy.")
    st.subheader("Guided Intake")
    relationship_stage = st.selectbox("Relationship Stage", ["New Relationship", "Committed", "Engaged", "Married", "Parenting", "Midlife", "Recovery"])
    challenge_type = st.multiselect("Challenge Type", ["Communication", "Trust", "Family Interference", "Burden Skew", "Respect", "Accountability", "Financial Stress", "Emotional Safety", "Future Planning"])
    severity = st.slider("Current Severity", 0, 5, 2, key="consult_current_severity")
    recurrence = st.slider("Repeated Pattern Count", 0, 10, 1, key="consult_repeated_pattern_count")
    family_influence = st.slider("Family / Influencer Pressure", 0, 5, 1)
    st.subheader("Correspondence Analyzer")
    text = st.text_area("Paste sanitized correspondence or describe the interaction", height=220, placeholder="Remove names, phone numbers, addresses, health details, and third-party private information.")
    if st.button("Analyze Interaction"):
        if not text.strip():
            st.error("Please enter sanitized text to analyze.")
        else:
            result = analyze_correspondence_v31(text, severity, recurrence, family_influence)
            c1, c2, c3 = st.columns(3)
            c1.metric("Communication Maturity", result["maturity"])
            c2.metric("Repair Potential", result["repair"])
            c3.metric("Escalation Risk", result["escalation"])
            st.write({"positive_repair_signals": result["positive"], "negative_risk_signals": result["negative"], "boundary_signals": result["boundary"]})
            st.subheader("Course of Action")
            st.info(result["action"])
            st.subheader("Suggested Reply")
            st.text_area("Draft response", result["suggested_reply"], height=160)
            st.subheader("Retest Plan")
            st.markdown("- Agree on one specific behavior change.\n- Avoid family escalation while the couple clarifies facts.\n- Retest in 7-14 days if severity is high; 30 days if moderate.\n- Escalate to a trusted mediator/professional if safety, coercion, or repeated non-repair appears.")


def score_daily_companion_v32(mood, gratitude_text, concern_text, partner_effort, self_effort, unresolved, special_encounter):
    concern_weight = 12 if concern_text.strip() else 0
    unresolved_weight = 15 if unresolved else 0
    special_bonus = 5 if special_encounter else 0
    gratitude_bonus = 8 if gratitude_text.strip() else 0
    relationship_energy = max(0, min(100, mood * 10 + (partner_effort + self_effort) * 5 + gratitude_bonus + special_bonus - concern_weight - unresolved_weight))
    stars = "â­" * max(1, min(5, int((relationship_energy + 10) / 20)))
    if relationship_energy >= 80:
        tone = "Bright and bonding-friendly ðŸŒž"
        nudge = "Celebrate the small win and create one sweet memory today."
    elif relationship_energy >= 60:
        tone = "Workable with gentle attention ðŸŒ¿"
        nudge = "Offer one appreciation and clarify one small expectation."
    elif relationship_energy >= 40:
        tone = "Tender zone ðŸ•Šï¸"
        nudge = "Keep tone soft, avoid escalation, and ask for one repairable change."
    else:
        tone = "Heavy day ðŸ’™"
        nudge = "Pause, protect dignity, and choose calm reflection before action."
    return relationship_energy, stars, tone, nudge

def build_grievance_report_v32(summary, facts, impact, desired_change, severity, recurrence, accountability, repair_willingness, trust_concern):
    fidelity = max(0, min(100, 80 - severity*7 - recurrence*4 - trust_concern*8 + accountability*5 + repair_willingness*6))
    prospect = max(0, min(100, 65 - severity*5 - recurrence*3 + accountability*6 + repair_willingness*7))
    if severity >= 4 or fidelity < 40:
        action = "Pause and protect dignity; consider mediator/professional support before deeper commitment."
    elif prospect >= 75:
        action = "Correct and strengthen; request a clear repair agreement and retest in 14-30 days."
    elif prospect >= 55:
        action = "Clarify and correct; use boundaries, accountability, and a short retest window."
    else:
        action = "Reconsider trajectory; do not normalize repeated non-repair."

    report = f"""# Relationship Grievance Report

## Grievance Summary
{summary}

## Observed Facts
{facts}

## Emotional Impact
{impact}

## Desired Change
{desired_change}

## Fidelity / Trust Signal Score
{fidelity}/100

## Relationship Prospect Score
{prospect}/100

## Recommended Course of Action
{action}

## Corrective Action Plan
1. State the concern calmly using facts.
2. Ask for one specific behavior change.
3. Offer one self-correction you are willing to make.
4. Avoid family escalation unless safety or repeated non-repair requires support.
5. Set a retest date.

## Suggested Conversation Starter
I want to discuss this calmly because the relationship matters to me. Here is what I observed, how it affected me, and what I need to change going forward. I am also willing to hear your side and agree on what I should improve.

## Guardrail
This is decision support only. Safety, dignity, and professional guidance override optimization.
"""
    return fidelity, prospect, action, report

with tabs[0]:
    st.header("ðŸŒ¸ Your Relationship Companion")
    st.caption("A gentle daily check-in for reflection, repair, bonding, and maturity.")
    st.warning("Public app reminder: enter only synthetic, anonymized, or sanitized details.")

    mood = st.slider("How does your relationship energy feel today?", 0, 10, 7)
    gratitude_text = st.text_area("One thing you appreciated today", placeholder="Example: They checked in kindly / I felt heard / We laughed together.")
    concern_text = st.text_area("One concern or tenderness point", placeholder="Keep it factual and gentle.")
    partner_effort = st.slider("Partner effort noticed today", 0, 10, 5)
    self_effort = st.slider("Your effort offered today", 0, 10, 5)
    unresolved = st.checkbox("There is an unresolved concern today")
    special_encounter = st.checkbox("This log follows a special meeting, call, outing, or emotional encounter")

    if st.button("Create My Daily Companion Card"):
        energy, stars, tone, nudge = score_daily_companion_v32(mood, gratitude_text, concern_text, partner_effort, self_effort, unresolved, special_encounter)
        st.metric("Relationship Energy", f"{energy}/100")
        st.subheader(f"Today's Stars: {stars}")
        st.success(tone)
        st.info(nudge)
        st.subheader("Daily Plan of Action")
        st.markdown("""
- Send or say one sincere appreciation.
- Take one small repair step if there is tension.
- Avoid harsh words when tired or triggered.
- Choose one bonding ritual: tea walk, shared song, gratitude message, prayer/meditation, reading, cooking, or quiet time.
- Optional symbolic prompt: wear a lucky color, carry a meaningful crystal/object, or choose a shared memory cue.
""")
        st.subheader("Memory / Vlog Prompt")
        st.markdown("Capture one happy photo, voice note, or short reflection privately if it helps preserve good moments.")

with tabs[1]:
    st.header("ðŸ“ Grievance Report Builder")
    st.caption("Turn a concern into a calm, structured, corrective-action report.")
    st.warning("Do not paste private identifying details in the public app. Sanitize names, dates, health data, and third-party information.")

    summary = st.text_area("Grievance Summary", height=100)
    facts = st.text_area("Observed Facts", height=100)
    impact = st.text_area("Emotional Impact", height=100)
    desired_change = st.text_area("Desired Change", height=100)
    severity = st.slider("Severity", 0, 5, 2, key="grievance_severity")
    recurrence = st.slider("Repeated Pattern Count", 0, 10, 1, key="consult_repeated_pattern_count_2")
    accountability = st.slider("Partner Accountability Shown", 0, 10, 5, key="grievance_partner_accountability")
    repair_willingness = st.slider("Repair Willingness Shown", 0, 10, 5, key="grievance_repair_willingness")
    trust_concern = st.slider("Trust / Fidelity Concern", 0, 5, 1, key="grievance_trust_concern")

    if st.button("Generate Grievance Report"):
        fidelity, prospect, action, report = build_grievance_report_v32(summary, facts, impact, desired_change, severity, recurrence, accountability, repair_willingness, trust_concern)
        c1, c2 = st.columns(2)
        c1.metric("Fidelity / Trust Signal Score", f"{fidelity}/100")
        c2.metric("Relationship Prospect Score", f"{prospect}/100")
        st.info(action)
        st.markdown(report)


def append_csv_row_v33(path, row):
    path.parent.mkdir(parents=True, exist_ok=True)
    existing = load_csv(path)
    new_df = pd.DataFrame([row])
    combined = pd.concat([existing, new_df], ignore_index=True) if not existing.empty else new_df
    combined.to_csv(path, index=False)
    return combined

with tabs[2]:
    st.header("ðŸ“ˆ Relationship Trend Dashboard")
    st.caption("Review saved daily logs and grievance report trends.")

    daily_logs = load_csv(DAILY_LOG_PATH)
    grievance_logs = load_csv(GRIEVANCE_REPORTS_PATH)

    st.subheader("Daily Logs")
    if daily_logs.empty:
        st.info("No daily logs saved yet.")
    else:
        st.dataframe(daily_logs, width="stretch")
        if "created_at" in daily_logs.columns and "relationship_energy" in daily_logs.columns:
            chart_df = daily_logs.copy()
            chart_df["created_at"] = pd.to_datetime(chart_df["created_at"], errors="coerce")
            chart_df["relationship_energy"] = pd.to_numeric(chart_df["relationship_energy"], errors="coerce")
            chart_df = chart_df.dropna(subset=["created_at", "relationship_energy"])
            if not chart_df.empty:
                st.line_chart(chart_df.set_index("created_at")[["relationship_energy"]])
        st.download_button("Download Daily Logs CSV", daily_logs.to_csv(index=False), "daily_logs.csv", "text/csv")

    st.subheader("Grievance Reports")
    if grievance_logs.empty:
        st.info("No grievance report indexes saved yet.")
    else:
        st.dataframe(grievance_logs, width="stretch")
        if "fidelity_score" in grievance_logs.columns and "prospect_score" in grievance_logs.columns:
            score_df = grievance_logs[["report_id","fidelity_score","prospect_score"]].copy()
            score_df["fidelity_score"] = pd.to_numeric(score_df["fidelity_score"], errors="coerce")
            score_df["prospect_score"] = pd.to_numeric(score_df["prospect_score"], errors="coerce")
            st.bar_chart(score_df.set_index("report_id"))
        st.download_button("Download Grievance Reports CSV", grievance_logs.to_csv(index=False), "grievance_reports.csv", "text/csv")

    st.warning("Public deployment should use synthetic/sanitized logs only. Use private local mode for real personal records.")



# === V3.4 FEED FORWARD JOURNEY STUDIO ===
def feed_forward_plan_v34(stage,theme,trust,friendship,communication,teamwork,joy):
    scores={"Trust":trust,"Friendship":friendship,"Communication":communication,"Teamwork":teamwork,"Joy":joy}
    growth=min(scores,key=scores.get); strength=max(scores,key=scores.get)
    avg=round(sum(scores.values())/len(scores),1)
    quests={"Trust":"Promise Keeper: make one small promise today and keep it.","Friendship":"Curiosity Date: ask three questions you have never asked before.","Communication":"Ten-Minute Listening Ritual: five minutes each, no fixing.","Teamwork":"Team Us: complete one practical task together.","Joy":"Joy Spark: recreate a tiny version of a favorite happy memory."}
    lines=["## Your Next Chapter: "+theme,"","You are entering this chapter in the **"+stage+"** stage.","","Protect your strongest foundation: **"+strength+"**.","","Your next growth opportunity is **"+growth+"**. This is not a failure label; it is the next place where a small investment may create the greatest lift.","","### Today's Quest",quests[growth],"","### Seven-Day Feed Forward Plan","1. Name one thing already working.","2. Practice one action in "+growth.lower()+".","3. Create one phone-free moment.","4. Ask one future-facing question.","5. Complete one act of practical teamwork.","6. Capture one private happy memory.","7. Celebrate what improved and choose the next chapter.","","Do not chase a perfect score. Raise the relationship through repeatable behaviors both people freely choose."]
    return avg,strength,growth,"\n".join(lines)

def genie_reply_v34(message,stage):
    m=message.lower()
    if any(x in m for x in ["fight","argument","hurt"]): return "🕊️ Choose a calm repair: name the fact, name the impact, ask for one change, and offer one change of your own. If there is fear, coercion, or danger, prioritize safety and qualified support."
    if any(x in m for x in ["fun","date","joy"]): return "🌟 Try a Curiosity Date: one question, one tiny surprise, and one memory to revisit."
    if any(x in m for x in ["score","improve","higher"]): return "📈 Healthy score lift comes from consistency: one kept promise, one appreciation, one listening moment, and one shared task."
    if any(x in m for x in ["makeover","reset","restart"]): return "🪄 Preserve three strengths, retire one unhelpful habit, begin one ritual, and plan one memory."
    return "💫 For your "+stage+" chapter, I can help create a next step, makeover, bonding quest, repair prompt, or memory-making idea."

st.markdown("---")
st.header("🪄 Feed Forward Journey Studio")
st.caption("Build the next chapter of your relationship — at the beginning, in the middle, or during a voluntary makeover.")
ff_stage_v34=st.selectbox("Where are you in the journey?",["Just Starting","Dating","Committed","Engaged","Married","Parenting","Midlife Renewal","Recovery / Makeover"],key="ff_stage_v34")
ff_theme_v34=st.selectbox("Choose your next chapter theme",["A Fresh Beginning","More Friendship","Trust in Action","Team Us","Joy and Adventure","Calm Communication","A 30-Day Makeover"],key="ff_theme_v34")
a,b,c,d,e=st.columns(5)
with a: ff_trust_v34=st.slider("Trust",0,10,7,key="ff_trust_v34")
with b: ff_friendship_v34=st.slider("Friendship",0,10,7,key="ff_friendship_v34")
with c: ff_communication_v34=st.slider("Communication",0,10,7,key="ff_communication_v34")
with d: ff_teamwork_v34=st.slider("Teamwork",0,10,7,key="ff_teamwork_v34")
with e: ff_joy_v34=st.slider("Joy",0,10,7,key="ff_joy_v34")
if st.button("✨ Storyboard Our Next Chapter",key="ff_storyboard_button_v34"):
    avg,strength,growth,chapter=feed_forward_plan_v34(ff_stage_v34,ff_theme_v34,ff_trust_v34,ff_friendship_v34,ff_communication_v34,ff_teamwork_v34,ff_joy_v34)
    st.metric("Journey Momentum",f"{avg}/10"); st.success(f"🌟 Protect this strength: {strength}"); st.info(f"🌱 Next growth opportunity: {growth}"); st.markdown(chapter)
    st.download_button("Download Our Next Chapter",chapter,"our_next_relationship_chapter.md","text/markdown",key="ff_download_chapter_v34")
st.subheader("🧞 Genie Companion")
ff_genie_message_v34=st.text_input("What would you like help creating next?",placeholder="Example: We want more fun together...",key="ff_genie_message_v34")
if st.button("Ask the Genie",key="ff_ask_genie_v34"): st.chat_message("assistant").write(genie_reply_v34(ff_genie_message_v34,ff_stage_v34))
st.subheader("🎬 Storyboard Cards")
cols=st.columns(4); cards=[("🌱 Chapter 1","Preserve one strength"),("🗺️ Chapter 2","Choose one shared direction"),("✨ Chapter 3","Complete one positive quest"),("📸 Chapter 4","Create one memory worth keeping")]
for col,(title,body) in zip(cols,cards):
    with col: st.markdown("### "+title); st.write(body)
st.subheader("💌 Today's Feed Forward Prompt")
st.info("What is one small thing we could do this week that our future selves would thank us for?")
# === END V3.4 FEED FORWARD JOURNEY STUDIO ===



# === V4.0 MOBILE APP READINESS SUITE ===

def mobile_readiness_plan_v40(stage, privacy_level, reminder_style, companion_style):
    stage_routes = {
        'Just Starting': 'Begin with values, boundaries, curiosity, and low-pressure positive quests.',
        'Dating': 'Build friendship, trust patterns, and transparent communication rituals.',
        'Engaged': 'Plan responsibilities, families, finances, ceremonies, and repair rituals.',
        'Married': 'Strengthen household teamwork, shared vision, intimacy, and conflict repair.',
        'Parenting': 'Protect sleep, teamwork, child routines, affection, and family support.',
        'Renewal': 'Rebuild joy, health, adventure, and shared purpose.',
        'Recovery': 'Use safety-first repair, accountability, and short retest windows.',
        'Makeover': 'Preserve strengths, release one habit, begin one ritual, and create one new memory.'
    }
    return stage_routes.get(stage, stage_routes['Just Starting'])

def app_store_readiness_score_v40(onboarding, privacy, reminders, reports, mobile_arch):
    score = onboarding*20 + privacy*25 + reminders*15 + reports*20 + mobile_arch*20
    if score >= 85:
        label = 'Strong prototype readiness; next step is native/PWA implementation.'
    elif score >= 65:
        label = 'Good product direction; strengthen privacy, persistence, and mobile shell.'
    else:
        label = 'Concept stage; complete core app-store readiness foundations first.'
    return score, label

st.markdown('---')
st.header('📱 v4.0 Mobile App Readiness Suite')
st.caption('Prepare the relationship companion for a real iPhone / Android product experience.')
st.warning('App Store / Google Play distribution will need privacy policy, terms, safety disclaimers, account/data handling decisions, and usually a native or PWA shell beyond Streamlit.')

v40_stage = st.selectbox('Primary user journey stage', ['Just Starting','Dating','Engaged','Married','Parenting','Renewal','Recovery','Makeover'], key='v40_stage')
v40_privacy = st.selectbox('Privacy posture', ['Public demo only','Private local only','Account-based private app','Hybrid with explicit consent'], key='v40_privacy')
v40_reminders = st.selectbox('Reminder style', ['Gentle daily check-in','After special encounters','Weekly recap only','User-controlled quiet mode'], key='v40_reminders')
v40_companion = st.selectbox('Companion style', ['Genie guide','Coach style','Journal friend','Minimalist planner'], key='v40_companion')
route_v40 = mobile_readiness_plan_v40(v40_stage, v40_privacy, v40_reminders, v40_companion)
st.subheader('Recommended Journey Route')
st.info(route_v40)

st.subheader('App Store Readiness Checklist')
c1,c2,c3,c4,c5 = st.columns(5)
with c1: onboarding_v40 = st.slider('Onboarding',0,1,1,key='v40_onboarding')
with c2: privacy_v40 = st.slider('Privacy Center',0,1,0,key='v40_privacy_center')
with c3: reminders_v40 = st.slider('Reminders',0,1,0,key='v40_reminders_score')
with c4: reports_v40 = st.slider('Reports',0,1,1,key='v40_reports')
with c5: mobile_arch_v40 = st.slider('Native/PWA Shell',0,1,0,key='v40_mobile_arch')
score_v40, label_v40 = app_store_readiness_score_v40(onboarding_v40, privacy_v40, reminders_v40, reports_v40, mobile_arch_v40)
st.metric('App Store Readiness Score', f'{score_v40}/100')
st.success(label_v40)

st.subheader('Mobile Screen Blueprint')
screen_rows_v40 = [
    ('Splash + Safety Intro','Start with warmth and clear safety boundaries.'),
    ('Onboarding Wizard','Capture stage, goals, privacy, reminder preferences.'),
    ('Companion Home','Mood, quest, Genie, memory prompt, daily log.'),
    ('Daily Log','One-minute private reflection.'),
    ('Quest Center','Positive score-lift actions and celebrations.'),
    ('Report Center','Grievance reports, weekly recaps, makeover reports.'),
    ('Privacy Center','Consent, export, retention, delete controls.'),
    ('Export Center','Markdown, CSV, PDF-ready reports.')
]
for name_v40, desc_v40 in screen_rows_v40:
    st.markdown(f'**{name_v40}** — {desc_v40}')

st.subheader('Native App Architecture Recommendation')
st.markdown('- Keep Streamlit as public demo / admin workbench.\n- Build production mobile UX in React Native + Expo or Flutter.\n- Use a small backend API for accounts, encrypted logs, reminders, and reports.\n- Use local-first storage for private drafts where possible.\n- Add privacy policy, terms, support URL, data deletion flow, and safety disclaimer before store submission.')

if st.button('Generate Mobile App Readiness Brief', key='v40_generate_brief'):
    brief_v40 = '# Mobile App Readiness Brief\n\n'
    brief_v40 += '## Stage\n' + v40_stage + '\n\n'
    brief_v40 += '## Privacy Posture\n' + v40_privacy + '\n\n'
    brief_v40 += '## Reminder Style\n' + v40_reminders + '\n\n'
    brief_v40 += '## Companion Style\n' + v40_companion + '\n\n'
    brief_v40 += '## Recommended Route\n' + route_v40 + '\n\n'
    brief_v40 += '## App Store Readiness Score\n' + str(score_v40) + '/100\n\n'
    brief_v40 += '## Next Build Steps\n1. Finalize privacy policy, terms, and safety disclaimer.\n2. Create PWA or native shell.\n3. Build onboarding, companion home, daily log, quest center, report center, and privacy center.\n4. Add secure persistence and export/delete controls.\n5. Prepare screenshots and App Store metadata.'
    st.markdown(brief_v40)
    st.download_button('Download Mobile App Readiness Brief', brief_v40, 'mobile_app_readiness_brief.md', 'text/markdown', key='v40_download_brief')
# === END V4.0 MOBILE APP READINESS SUITE ===


# === V4.1 COMPATIBILITY CHECKLIST REQUIREMENTS ===
def compatibility_band_v41(score):
    if score >= 85: return 'Strong readiness'
    if score >= 70: return 'Promising with growth tasks'
    if score >= 55: return 'Needs correction and retest'
    if score >= 40: return 'Pause and review'
    return 'High risk; consider exit or major intervention'

st.markdown('---')
st.header('✅ v4.1 Compatibility Checklist Preview')
st.caption('Requirements preview for the upcoming game-mode and diary-mode compatibility engine.')
v41_partner=st.slider('Primary Partner Compatibility',0,100,75,key='v41_partner')
v41_family=st.slider('Immediate Family Support',0,100,70,key='v41_family')
v41_circle=st.slider('Trusted Circle Stability',0,100,70,key='v41_circle')
v41_budget=st.slider('Budget and Logistics Feasibility',0,100,65,key='v41_budget')
v41_happiness=st.slider('Happiness Quotient',0,100,75,key='v41_happiness')
v41_repair=st.slider('Repair and Role-Play Maturity',0,100,70,key='v41_repair')
v41_score=round((v41_partner*.25+v41_family*.15+v41_circle*.10+v41_budget*.15+v41_happiness*.15+v41_repair*.20),1)
st.metric('Long-Term Compatibility Readiness',f'{v41_score}/100')
st.info(compatibility_band_v41(v41_score))
st.subheader('Game Mode Requirement')
st.markdown('- Convert checklist categories into levels.\n- Let partners and trusted circle members submit constructive ratings.\n- Award stars/XP for role-play episodes and repair attempts.\n- Show milestone signposts for wedding launch and married-life readiness.\n- Generate health-check and exit reports.')
st.subheader('iPhone Home Screen')
st.markdown('Open the GitHub Pages mobile shell, then use Safari Share → Add to Home Screen.')
# === END V4.1 COMPATIBILITY CHECKLIST REQUIREMENTS ===


# === V4.2 INTERACTIVE JOURNEY ACTIVATION ===
def band_v42(score):
    if score >= 85: return '🌟 Strong readiness — keep building with joy and consistency.'
    if score >= 70: return '🌿 Promising — choose growth quests and retest.'
    if score >= 55: return '🛠️ Needs correction — focus on the lowest area for 7-14 days.'
    if score >= 40: return '🕊️ Pause and review — reduce pressure and clarify gaps.'
    return '🛑 High risk — safety, dignity, and repeated non-repair must be reviewed.'

def prompt_v42(low_area, stage):
    prompts={
        'Primary Partners':'What is one habit that would help both partners feel chosen and respected?',
        'Parents':'What family boundary would help the couple grow without pressure?',
        'Siblings and Friends':'Who in the trusted circle lifts the relationship, and who adds noise?',
        'Modern Life':'What lower-cost or lower-stress substitution could preserve excitement?',
        'Role Play':'What real-life episode can we practice before pressure arrives?',
        'Milestone':'What must be true before moving to the wedding launch gate?'
    }
    return prompts.get(low_area, 'What small action would raise tomorrow’s relationship score?')

st.markdown('---')
st.header('🎮 v4.2 Interactive Journey Activation')
st.caption('Turn compatibility checklists into chapters, XP, health reports, and a game-style roadmap.')

if 'journey_xp_v42' not in st.session_state:
    st.session_state['journey_xp_v42']=0
if 'completed_chapters_v42' not in st.session_state:
    st.session_state['completed_chapters_v42']=[]

couple_name_v42=st.text_input('Couple / Journey Name', value='Our Compatibility Quest', key='couple_name_v42')
stage_v42=st.selectbox('Journey Stage', ['Just Starting','Dating','Engaged','Married','Parenting','Recovery','Makeover'], key='stage_v42')
avatar_v42=st.selectbox('Choose Avatar Style', ['🌸 Lotus Guides','🧞 Genie Quest','🦚 Peacock Path','🛕 Temple Bells','🚀 Modern Makers'], key='avatar_v42')
theme_v42=st.selectbox('Color Theme Feeling', ['Royal Purple','Rose Gold','Temple Sunrise','Calm Ocean','Forest Renewal'], key='theme_v42')

cards_v42=[
('Preserve Strength','Primary Partners','Name one relationship strength worth protecting',5),
('Shared Direction','Primary Partners','Rate shared life direction',5),
('Communication Grove','Primary Partners','Rate calm communication under pressure',5),
('Family Bridge','Parents','Rate respectful family boundary support',5),
('Trusted Circle','Siblings and Friends','Rate trusted-circle encouragement',4),
('Budget Mountain','Modern Life','Rate cost and logistics feasibility',5),
('Distance Crossing','Modern Life','Rate distance travel or relocation feasibility',4),
('Recovery Rest Stop','Modern Life','Rate sickness and recovery support',4),
('Happiness Garden','Primary Partners','Rate joy humor affection and companionship',4),
('Role-Play Arena','Role Play','Rate teamwork during a practical episode',5),
('Repair Forge','Role Play','Rate apology correction and retest behavior',5),
('Wedding Launch Gate','Milestone','Rate readiness for wedding union launch',5),
]

st.subheader('✅ Checklist Cards')
scores_v42=[]
weights_v42=[]
areas_v42=[]
for idx,(chapter,area,prompt,weight) in enumerate(cards_v42):
    with st.expander(f'{idx+1}. {chapter} — {area}', expanded=(idx<3)):
        st.write(prompt)
        score=st.slider('Score',0,100,70,key=f'card_score_v42_{idx}')
        reflection=st.text_area('Reflection / episode note', key=f'card_reflection_v42_{idx}', placeholder='Optional sanitized note...')
        complete=st.checkbox('Chapter task completed', key=f'card_complete_v42_{idx}')
        if complete and chapter not in st.session_state['completed_chapters_v42']:
            st.session_state['completed_chapters_v42'].append(chapter)
            st.session_state['journey_xp_v42'] += weight*5
        scores_v42.append(score)
        weights_v42.append(weight)
        areas_v42.append(area)

weighted_v42=round(sum(s*w for s,w in zip(scores_v42,weights_v42))/sum(weights_v42),1)
low_idx_v42=min(range(len(scores_v42)), key=lambda i:scores_v42[i])
high_idx_v42=max(range(len(scores_v42)), key=lambda i:scores_v42[i])
low_area_v42=areas_v42[low_idx_v42]
high_chapter_v42=cards_v42[high_idx_v42][0]
stars_v42='⭐'*max(1,min(5,int(weighted_v42/20)))

st.subheader('📊 Compatibility Health Check')
c1,c2,c3=st.columns(3)
c1.metric('Compatibility Readiness', f'{weighted_v42}/100')
c2.metric('Journey XP', st.session_state['journey_xp_v42'])
c3.metric('Stars', stars_v42)
st.info(band_v42(weighted_v42))
st.success(f'Strongest chapter right now: {high_chapter_v42}')
st.warning(f'Next coaching focus: {low_area_v42}')

st.subheader('💌 Dynamic Feed Forward Prompt')
st.write(prompt_v42(low_area_v42, stage_v42))

st.subheader('🗺️ Roadmap with Signposts')
road_v42=['First Chemistry','Communication Grove','Family Bridge','Budget Mountain','Distance Crossing','Recovery Rest Stop','Role-Play Arena','Wedding Launch Gate','Household Village','Renewal Garden']
road_text_v42=' → '.join(['✅ '+x if x in st.session_state['completed_chapters_v42'] else '📍 '+x for x in road_v42])
st.markdown(road_text_v42)

if st.button('Generate Compatibility Health Report', key='generate_report_v42'):
    report=f'''# Compatibility Health Report

## Journey
{couple_name_v42}

## Stage
{stage_v42}

## Avatar / Theme
{avatar_v42} / {theme_v42}

## Compatibility Readiness
{weighted_v42}/100

## Readiness Band
{band_v42(weighted_v42)}

## Strongest Chapter
{high_chapter_v42}

## Coaching Focus
{low_area_v42}

## Dynamic Prompt
{prompt_v42(low_area_v42, stage_v42)}

## XP and Stars
XP: {st.session_state['journey_xp_v42']}  
Stars: {stars_v42}

## Completed Chapters
{', '.join(st.session_state['completed_chapters_v42']) if st.session_state['completed_chapters_v42'] else 'None yet'}

## Next Action
Complete one small quest in the lowest scoring area, then retest in 7-14 days.

## Safety Rule
Safety and dignity override relationship optimization.
'''
    st.markdown(report)
    st.download_button('Download Compatibility Health Report', report, 'compatibility_health_report.md', 'text/markdown', key='download_report_v42')
# === END V4.2 INTERACTIVE JOURNEY ACTIVATION ===


# === V4.3 ANONYMOUS PILOT DECISIONING ===
def decision_band_v43(score):
    if score >= 85: return 'Continue toward launch — strong dharmic viability.'
    if score >= 70: return 'Continue with incubation — promising but needs hand-holding.'
    if score >= 55: return 'Pause and retest — gaps must be coached before next milestone.'
    if score >= 40: return 'High caution — significant drama/logistics/family risks.'
    return 'Exit review — preserve maturity gained and consider a new game later.'

def drama_band_v43(score):
    if score <= 25: return 'Low drama load — emotions are manageable.'
    if score <= 50: return 'Moderate drama load — use boundaries and reality checks.'
    if score <= 75: return 'High drama load — pause, de-escalate, and retest.'
    return 'Critical drama load — safety, dignity, and trauma-loop review needed.'

st.markdown('---')
st.header('🧭 v4.3 Anonymous Pilot Decisioning Lab')
st.caption('Use aliases only. Evaluate real-life readiness through Purushartha quadrants, seer lenses, drama sanity checks, and wedding union staging.')
st.warning('Do not enter real names, phone numbers, addresses, health identifiers, or private third-party details in the public app.')

pilot_id_v43=st.text_input('Anonymous Pilot ID', value='LOTUS-001', key='pilot_id_v43')
stage_v43=st.selectbox('Wedding Union Stage', ['Seed Chemistry','Early Alignment','Family Awareness','Role Play Incubation','Repair Retest','Budget Logistics Gate','Wedding Launch Gate','Household Takeoff'], key='stage_v43')
seer_lens_v43=st.multiselect('Seer / Trusted Lens Applied', ['Dharma Lens','Artha Lens','Kama Lens','Moksha Lens','Family Ecosystem Lens','Modern Life Lens','Recovery Lens','Wedding Launch Lens'], default=['Dharma Lens','Family Ecosystem Lens'], key='seer_lens_v43')

st.subheader('🕉️ Purushartha Quadrant Risk Map')
c1,c2,c3,c4=st.columns(4)
with c1: dharma_v43=st.slider('Dharma',0,100,75,key='dharma_v43')
with c2: artha_v43=st.slider('Artha',0,100,70,key='artha_v43')
with c3: kama_v43=st.slider('Kama',0,100,75,key='kama_v43')
with c4: moksha_v43=st.slider('Moksha',0,100,70,key='moksha_v43')

st.subheader('🌪️ Emotional Drama Sanity Check')
drama_spike_v43=st.slider('Escalation / emotional drama spike',0,100,35,key='drama_spike_v43')
trauma_loop_v43=st.slider('Trauma-bond caution / repeated hurt-repair loop',0,100,30,key='trauma_loop_v43')
reality_check_v43=st.slider('Reality check quality: facts separated from assumptions',0,100,70,key='reality_check_v43')
repair_visible_v43=st.slider('Visible repair attempt',0,100,65,key='repair_visible_v43')

st.subheader('👨‍👩‍👧 Family Ecosystem + Trusted Circle')
family_support_v43=st.slider('Family support without control',0,100,70,key='family_support_v43')
circle_stability_v43=st.slider('Trusted circle stability',0,100,65,key='circle_stability_v43')
budget_logistics_v43=st.slider('Budget, distance, cost, and logistics feasibility',0,100,65,key='budget_logistics_v43')
roleplay_maturity_v43=st.slider('Role-play / moment-of-truth maturity',0,100,70,key='roleplay_maturity_v43')

purushartha_score_v43=round((dharma_v43*.30+artha_v43*.25+kama_v43*.20+moksha_v43*.25),1)
drama_load_v43=round((drama_spike_v43*.35+trauma_loop_v43*.35+(100-reality_check_v43)*.15+(100-repair_visible_v43)*.15),1)
ecosystem_score_v43=round((family_support_v43*.30+circle_stability_v43*.20+budget_logistics_v43*.25+roleplay_maturity_v43*.25),1)
decision_score_v43=round((purushartha_score_v43*.45+ecosystem_score_v43*.35+(100-drama_load_v43)*.20),1)

st.subheader('📊 Decisioning Dashboard')
d1,d2,d3,d4=st.columns(4)
d1.metric('Purushartha Fit', f'{purushartha_score_v43}/100')
d2.metric('Drama Load', f'{drama_load_v43}/100')
d3.metric('Ecosystem Support', f'{ecosystem_score_v43}/100')
d4.metric('Decision Readiness', f'{decision_score_v43}/100')
st.info(decision_band_v43(decision_score_v43))
st.warning(drama_band_v43(drama_load_v43))

st.subheader('Moment of Truth Log')
episode_v43=st.text_area('Anonymous episode / role-play notes', placeholder='Describe the moment of truth with aliases only...', key='episode_v43')
coach_gap_v43=st.text_area('Coaching gap noticed', placeholder='What needs to mature before the next stage?', key='coach_gap_v43')

if st.button('Generate Anonymous Decision Report', key='generate_decision_report_v43'):
    report=f'''# Anonymous Pilot Decision Report

## Pilot ID
{pilot_id_v43}

## Stage
{stage_v43}

## Seer Lenses
{', '.join(seer_lens_v43)}

## Scores
- Purushartha Fit: {purushartha_score_v43}/100
- Emotional Drama Load: {drama_load_v43}/100
- Ecosystem Support: {ecosystem_score_v43}/100
- Decision Readiness: {decision_score_v43}/100

## Recommendation
{decision_band_v43(decision_score_v43)}

## Drama Sanity Check
{drama_band_v43(drama_load_v43)}

## Moment of Truth
{episode_v43 or 'Not supplied'}

## Coaching Gap
{coach_gap_v43 or 'Not supplied'}

## Retest Plan
Retest the lowest scoring dimension after 7-14 days of visible behavior change.

## Exit Rule
If safety, dignity, repeated non-repair, coercion, or no-hope signals dominate, prepare a dignified exit report that preserves maturity gained.
'''
    st.markdown(report)
    st.download_button('Download Anonymous Decision Report', report, 'anonymous_decision_report.md', 'text/markdown', key='download_decision_report_v43')
# === END V4.3 ANONYMOUS PILOT DECISIONING ===


# === V4.4 REAL ANONYMOUS PILOT LAB ===
def decision_v44(score, gap, drama):
    if drama >= 75: return 'Pause: drama load is too high; de-escalate before milestone movement.'
    if gap >= 35: return 'Incubate: perspectives are far apart; run a clarity and repair quest.'
    if score >= 85: return 'Continue: strong readiness with normal monitoring.'
    if score >= 70: return 'Continue with coaching: promising but needs targeted quests.'
    if score >= 55: return 'Pause and retest: gaps must visibly improve.'
    if score >= 40: return 'High caution: consider mediated support and delayed milestone.'
    return 'Exit review: preserve learning and avoid forcing the bond.'

st.markdown('---')
st.header('🧪 v4.4 Real Anonymous Pilot Lab')
st.caption('Test anonymous relationship cases with multi-rater scoring, perspective pivots, decision maze, and coaching retest plans.')
st.warning('Use aliases only. Do not enter real identifying details in the public app.')

pilot_v44=st.text_input('Anonymous Pilot Code', value='LOTUS-001', key='pilot_v44')
stage_v44=st.selectbox('Pilot Stage', ['Dating','Engaged','Makeover','Recovery','Wedding Launch Gate','Household Takeoff'], key='stage_v44')
episode_v44=st.text_area('Moment-of-Truth Episode', placeholder='Describe the episode with aliases only...', key='episode_v44')

st.subheader('👥 Multi-Rater Scores')
roles_v44=['Partner-A','Partner-B','Parent-A','Parent-B','Sibling/Friend','Seer/Mentor','Support System']
role_scores_v44=[]
for i,role in enumerate(roles_v44):
    role_scores_v44.append(st.slider(role+' rating',0,100,70,key=f'role_score_v44_{i}'))
avg_role_v44=round(sum(role_scores_v44)/len(role_scores_v44),1)
gap_v44=max(role_scores_v44)-min(role_scores_v44)

st.subheader('🧭 Perspective Pivots')
pivot_v44=st.multiselect('Which views should be considered?', ['My intention','Partner experience','Parent/family influence','Child/future-child lens','Pets/care ecosystem','Friends/colleagues/support system','Seer lens','Dharma/Artha/Kama/Moksha'], default=['My intention','Partner experience','Parent/family influence','Seer lens'], key='pivot_v44')
facts_v44=st.text_area('Facts', key='facts_v44', placeholder='What is objectively known?')
feelings_v44=st.text_area('Feelings', key='feelings_v44', placeholder='What emotions surfaced?')
assumptions_v44=st.text_area('Assumptions', key='assumptions_v44', placeholder='What might be assumed but not proven?')

st.subheader('🌪️ Emotional Drama Sanity')
escalation_v44=st.slider('Escalation load',0,100,40,key='escalation_v44')
triangulation_v44=st.slider('Triangulation / third-party noise',0,100,35,key='triangulation_v44')
repair_v44=st.slider('Visible repair behavior',0,100,65,key='repair_v44')
drama_v44=round(escalation_v44*.45+triangulation_v44*.35+(100-repair_v44)*.20,1)

st.subheader('🕉️ Purushartha Decision Map')
p1,p2,p3,p4=st.columns(4)
with p1: dharma_v44=st.slider('Dharma',0,100,75,key='dharma_v44')
with p2: artha_v44=st.slider('Artha',0,100,70,key='artha_v44')
with p3: kama_v44=st.slider('Kama',0,100,75,key='kama_v44')
with p4: moksha_v44=st.slider('Moksha',0,100,70,key='moksha_v44')
purushartha_v44=round((dharma_v44*.30+artha_v44*.25+kama_v44*.20+moksha_v44*.25),1)
decision_score_v44=round(avg_role_v44*.35+purushartha_v44*.40+(100-drama_v44)*.25,1)

st.subheader('📊 Pilot Decision Dashboard')
a,b,c,d=st.columns(4)
a.metric('Multi-Rater Avg', f'{avg_role_v44}/100')
b.metric('Perspective Gap', gap_v44)
c.metric('Drama Load', f'{drama_v44}/100')
d.metric('Decision Score', f'{decision_score_v44}/100')
recommendation_v44=decision_v44(decision_score_v44, gap_v44, drama_v44)
st.info(recommendation_v44)

st.subheader('🌀 First Decision Maze')
maze_v44=[
('My Intention','What was I trying to do?'),
('Partner Experience','How might my partner have experienced it?'),
('Family Influence','What family expectation entered?'),
('Practical Constraints','What budget, distance, time, health, or logistics mattered?'),
('Emotional Activation','What old wound or fear may have been activated?'),
('Facts vs Assumptions','What is known and what is assumed?'),
('Purushartha View','What do Dharma, Artha, Kama, and Moksha reveal?'),
('Repair Choices','What repair choices are available?'),
('Consequence Preview','What happens if we continue, pause, incubate, or exit?'),
('Next Tollgate','What must be retested before the next milestone?')
]
for idx,(node,q) in enumerate(maze_v44):
    with st.expander(f'{idx+1}. {node}', expanded=(idx<2)):
        st.write(q)
        st.text_area('Maze note', key=f'maze_note_v44_{idx}', placeholder='Optional anonymous reflection...')

st.subheader('🎯 Coaching Quest + Retest')
if gap_v44>=35:
    quest_v44='Clarity Bridge Quest: each side writes intention, impact, and one needed repair before discussing again.'
elif drama_v44>=60:
    quest_v44='Drama Cooling Quest: pause, separate facts from assumptions, and retest after 48 hours.'
elif artha_v44<60:
    quest_v44='Artha Reality Quest: create one practical budget/logistics substitution plan.'
elif kama_v44<60:
    quest_v44='Kama Renewal Quest: create one low-cost joy or affection ritual.'
else:
    quest_v44='Momentum Quest: preserve one strength and complete one small promise.'
st.success(quest_v44)

if st.button('Generate v4.4 Anonymous Pilot Report', key='generate_report_v44'):
    report=f'''# v4.4 Anonymous Pilot Report

## Pilot Code
{pilot_v44}

## Stage
{stage_v44}

## Recommendation
{recommendation_v44}

## Scores
- Multi-Rater Average: {avg_role_v44}/100
- Perspective Gap: {gap_v44}
- Drama Load: {drama_v44}/100
- Purushartha Score: {purushartha_v44}/100
- Decision Score: {decision_score_v44}/100

## Perspective Pivots
{', '.join(pivot_v44)}

## Facts
{facts_v44 or 'Not supplied'}

## Feelings
{feelings_v44 or 'Not supplied'}

## Assumptions
{assumptions_v44 or 'Not supplied'}

## Coaching Quest
{quest_v44}

## Retest Plan
Retest the lowest-scoring or highest-gap area after 7-14 days of visible behavior change.

## Safety Rule
Safety and dignity override relationship optimization.
'''
    st.markdown(report)
    st.download_button('Download v4.4 Pilot Report', report, 'v4_4_anonymous_pilot_report.md', 'text/markdown', key='download_report_v44')
# === END V4.4 REAL ANONYMOUS PILOT LAB ===


# === V4.5 SACRED MAZE ENGINE ===
def sacred_maze_direction_v45(dharma, artha, kama, moksha, drama):
    score=round(dharma*.30+artha*.25+kama*.20+moksha*.25-drama*.15,1)
    if drama>=75: return score,'Pause at the Dharma Mirror: de-escalation is required before continuing.'
    if score>=80: return score,'Proceed to the next tollgate with a small sadhana quest.'
    if score>=65: return score,'Incubate: continue, but retest the weakest quadrant.'
    if score>=50: return score,'Pause and repair: the maze reveals unresolved loops.'
    return score,'Exit Review: preserve the lesson and avoid forcing the path.'

def sadhana_v45(focus):
    quests={'Dharma':'Truth Sadhana: state one fact, one feeling, and one dignified request.','Artha':'Artha Sadhana: create one realistic cost, distance, time, or responsibility plan.','Kama':'Kama Sadhana: create one low-cost joyful bonding moment.','Moksha':'Moksha Sadhana: name how each person can grow without control.','Family':'Boundary Sadhana: define one respectful family boundary.','Repair':'Repair Sadhana: offer one apology, correction, or retest behavior.'}
    return quests.get(focus, quests['Dharma'])

st.markdown('---')
st.header('🌀 v4.5 Sacred Maze + Mind Map Game Engine')
st.caption('Optional symbolic layer for navigating relationship decision points through perspectives, Purushartha quadrants, tollgates, and sadhana quests.')
st.warning('Symbolic mode is metaphorical and optional. It is not diagnosis, certainty, or spiritual judgment.')
skin_v45=st.selectbox('Journey Skin', ['Shiva Karana Path','Ganesha Obstacle Path','Devi Shakti Path','Nature River Path','Secular Compass Path'], key='skin_v45')
episode_v45=st.text_area('Maze Episode', placeholder='Describe the anonymous episode or decision point...', key='episode_v45')
focus_v45=st.selectbox('Primary Focus', ['Dharma','Artha','Kama','Moksha','Family','Repair'], key='focus_v45')

st.subheader('🧭 Maze Path')
maze_nodes_v45=[('Entry Sankalpa','What intention are we entering with?'),('Self Chamber','What did I intend and fear?'),('Partner Chamber','What might my partner have experienced?'),('Family Gate','What family expectation appeared?'),('Artha Corridor','What practical constraint mattered?'),('Kama Garden','What joy is being preserved or lost?'),('Dharma Mirror','What is fair, truthful, and dignified?'),('Moksha Window','What helps both souls mature?'),('Repair Bridge','What visible repair or boundary is needed?'),('Tollgate','Continue, incubate, pause, or exit?')]
for i,(node,q) in enumerate(maze_nodes_v45):
    with st.expander(f'{i+1}. {node}', expanded=(i<2)):
        st.write(q)
        st.text_area('Maze reflection', key=f'maze_reflection_v45_{i}', placeholder='Optional anonymous note...')

st.subheader('🕉️ Quadrant + Drama Inputs')
c1,c2,c3,c4,c5=st.columns(5)
with c1: dharma_v45=st.slider('Dharma',0,100,75,key='dharma_v45')
with c2: artha_v45=st.slider('Artha',0,100,70,key='artha_v45')
with c3: kama_v45=st.slider('Kama',0,100,75,key='kama_v45')
with c4: moksha_v45=st.slider('Moksha',0,100,70,key='moksha_v45')
with c5: drama_v45=st.slider('Drama Load',0,100,35,key='drama_v45')
maze_score_v45,maze_direction_v45=sacred_maze_direction_v45(dharma_v45,artha_v45,kama_v45,moksha_v45,drama_v45)
st.metric('Maze Readiness', f'{maze_score_v45}/100')
st.info(maze_direction_v45)
st.success(sadhana_v45(focus_v45))
st.subheader('🗺️ Mind Map Text View')
mind_map_v45='Entry Sankalpa → Self Chamber / Partner Chamber → Family Gate → Artha Corridor / Kama Garden → Dharma Mirror → Moksha Window → Repair Bridge → Tollgate'
st.markdown(mind_map_v45)
st.subheader('🔔 Chakra / Tollgate Metaphor')
tollgate_v45=st.selectbox('Current Tollgate', ['Root: Safety','Sacral: Joy','Solar Plexus: Responsible Will','Heart: Compassion','Throat: Truth','Third Eye: Insight','Crown: Meaning'], key='tollgate_v45')
st.write('Current symbolic tollgate:', tollgate_v45)
if st.button('Generate Sacred Maze Report', key='generate_maze_report_v45'):
    report=f'''# Sacred Maze Report\n\n## Journey Skin\n{skin_v45}\n\n## Episode\n{episode_v45 or 'Not supplied'}\n\n## Focus\n{focus_v45}\n\n## Tollgate\n{tollgate_v45}\n\n## Maze Readiness\n{maze_score_v45}/100\n\n## Direction\n{maze_direction_v45}\n\n## Sadhana Quest\n{sadhana_v45(focus_v45)}\n\n## Mind Map\n{mind_map_v45}\n\n## Guardrail\nSymbolic mode is metaphorical and optional. Safety and dignity override relationship optimization.'''
    st.markdown(report)
    st.download_button('Download Sacred Maze Report', report, 'sacred_maze_report.md', 'text/markdown', key='download_maze_report_v45')
# === END V4.5 SACRED MAZE ENGINE ===


# === V4.6 CHECKLIST INTAKE LIFE COACH ===
import io

def parse_intake_v46(raw):
    rows=[]
    for line in raw.strip().splitlines():
        if not line.strip() or line.lower().startswith('role,'):
            continue
        parts=[p.strip() for p in line.split(',')]
        if len(parts)<3:
            continue
        role=parts[0]
        dimension=parts[1]
        try: score=float(parts[2])
        except: score=0
        note=','.join(parts[3:]).strip() if len(parts)>3 else ''
        rows.append({'role':role,'dimension':dimension,'score':score,'note':note})
    return rows

def advisory_band_v46(score):
    if score>=85: return 'Continue with confidence: strong readiness, maintain rituals and sanity checks.'
    if score>=70: return 'Continue with mending: promising, but specific repair actions are needed.'
    if score>=55: return 'Incubate before milestone: pause public escalation and retest behavior.'
    if score>=40: return 'High caution: structured coaching, family reset, and delayed decision advised.'
    return 'Exit review: protect dignity, document learning, and avoid forcing the pair-up.'

def playbook_v46(low_dim):
    d=low_dim.lower()
    if 'repair' in d or 'communication' in d: return 'Accountability Repair: one apology, one correction, one retest behavior, no public humiliation.'
    if 'family' in d or 'ecology' in d: return 'Family Boundary Reset: both families agree to support without control, gossip, or scorekeeping.'
    if 'artha' in d or 'budget' in d or 'logistics' in d: return 'Budget and Logistics Clarity: write the real cost, distance, travel, role, and timeline plan.'
    if 'kama' in d or 'happiness' in d: return 'Happiness Substitution Quest: create low-cost joy rituals that preserve excitement without pressure.'
    if 'moksha' in d: return 'Dignity and Freedom Reset: each partner names what helps them grow without control.'
    if 'wedding' in d: return 'Milestone Incubation: delay launch until repair and logistics are visibly stronger.'
    return 'Tone Reset: reduce emotional drama, separate facts from assumptions, and retest in 7-14 days.'

st.markdown('---')
st.header('📥 v4.6 Checklist Intake + Family Life-Coach')
st.caption('Paste anonymous completed checklist data from bride-side parent, prospective bride, groom-side family, or trusted circle. The app infers mending guidance and milestone readiness.')
st.warning('Use anonymous roles only. Do not enter real names, phone numbers, emails, addresses, or identifying private details.')

sample_v46='''role,dimension,score,note\nBride Parent,Dharma,72,Concerned about accountability and respectful family communication\nBride Parent,Artha,64,Cost distance and logistics need clearer planning\nBride Parent,Kama,70,There is warmth but emotional drama reduces joy\nBride Parent,Moksha,66,Needs more space dignity and maturity\nBride Parent,Family Ecology,58,Family boundaries and tone need reset\nBride Parent,Repair,52,Repair needs visible behavior not just words\nBride Parent,Wedding Launch,55,Needs incubation before public milestone\nBride,Trust,68,Wants reassurance and consistent actions\nBride,Communication,60,Needs calmer hard conversations\nBride,Happiness,74,Feels connection but wants less emotional volatility\nBride,Role Play,62,Stress episodes need better teamwork\nBride,Exit Risk,45,Not hopeless but risk is present if repair does not improve'''
raw_v46=st.text_area('Paste anonymous checklist CSV rows', value=sample_v46, height=260, key='raw_checklist_v46')
rows_v46=parse_intake_v46(raw_v46)

if rows_v46:
    scores_v46=[r['score'] for r in rows_v46]
    avg_v46=round(sum(scores_v46)/len(scores_v46),1)
    low_v46=min(rows_v46, key=lambda r:r['score'])
    high_v46=max(rows_v46, key=lambda r:r['score'])
    role_groups_v46={}
    for r in rows_v46:
        role_groups_v46.setdefault(r['role'],[]).append(r['score'])
    role_summary_v46={k:round(sum(v)/len(v),1) for k,v in role_groups_v46.items()}
    gap_v46=round(max(role_summary_v46.values())-min(role_summary_v46.values()),1) if role_summary_v46 else 0
    st.subheader('📊 Intake Analysis')
    a,b,c=st.columns(3)
    a.metric('Average Intake Score', f'{avg_v46}/100')
    b.metric('Lowest Dimension', f"{low_v46['dimension']} {low_v46['score']}/100")
    c.metric('Role Disagreement Gap', gap_v46)
    st.info(advisory_band_v46(avg_v46))
    st.success(f"Strongest area: {high_v46['dimension']} from {high_v46['role']} ({high_v46['score']}/100)")
    st.warning(f"Mending focus: {low_v46['dimension']} from {low_v46['role']} ({low_v46['score']}/100)")
    st.subheader('🧭 Life-Coach Guidance for Both Families')
    st.markdown('- Couple: own the repair; do not outsource the relationship to parents.')
    st.markdown('- Bride-side family: protect dignity while allowing the couple room to demonstrate maturity.')
    st.markdown('- Groom-side family: reduce defensiveness; show visible accountability and tone reset.')
    st.markdown('- Trusted circle: reduce noise, gossip, and scorekeeping; support retest behavior.')
    st.subheader('🛠️ Recommended Mending Playbook')
    st.success(playbook_v46(low_v46['dimension']))
    if avg_v46<45 or low_v46['score']<35:
        st.error('Beyond-repair caution: prepare an exit-review report unless visible safety, dignity, and repair improve quickly.')
    elif avg_v46<60:
        st.warning('Incubation advised: do not escalate wedding or public milestone until retest improves.')
    else:
        st.info('Mending path exists: use the playbook and retest in 7-14 days.')
    if st.button('Generate Two-Family Advisory Report', key='generate_advisory_report_v46'):
        role_lines='\n'.join([f'- {k}: {v}/100' for k,v in role_summary_v46.items()])
        report=f'''# Two-Family Advisory Report

## Anonymous Intake Summary
Average Score: {avg_v46}/100

## Recommendation
{advisory_band_v46(avg_v46)}

## Role Summary
{role_lines}

## Strongest Area
{high_v46['dimension']} from {high_v46['role']} ({high_v46['score']}/100)

## Mending Focus
{low_v46['dimension']} from {low_v46['role']} ({low_v46['score']}/100)

## Recommended Playbook
{playbook_v46(low_v46['dimension'])}

## Guidance to Couple
Own the repair directly. Demonstrate visible behavior change before asking families to bless the next milestone.

## Guidance to Bride-Side Family
Protect dignity and clarity while avoiding over-control, public shaming, or escalation.

## Guidance to Groom-Side Family
Show accountability, reduce defensiveness, and help create a safe tone for retest.

## Retest Plan
Retest the mending focus after 7-14 days of visible behavior change.

## Exit Rule
If scores dip beyond repair because of safety, dignity, repeated non-repair, coercion, or no-hope patterns, prepare a dignified exit report.
'''
        st.markdown(report)
        st.download_button('Download Two-Family Advisory Report', report, 'two_family_advisory_report.md', 'text/markdown', key='download_advisory_report_v46')
# === END V4.6 CHECKLIST INTAKE LIFE COACH ===
