$ErrorActionPreference = "Stop"
Write-Host "== Patching Streamlit app for v3.1 Relationship Consultancy ==" -ForegroundColor Cyan

$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }
$content = Get-Content $app -Raw

if ($content -notmatch '"Relationship Consultancy"') {
    $content = $content.Replace('"Dashboard"', '"Relationship Consultancy",' + "`n" + '    "Dashboard"')
}

if ($content -notmatch "def analyze_correspondence_v31") {
$helper = @'

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
'@
$content = $content + "`n" + $helper
}

if ($content -notmatch "Interactive Relationship Consultancy") {
$append = @'

with tabs[0]:
    st.header("Interactive Relationship Consultancy")
    st.warning("Use only synthetic, anonymized, or sanitized correspondence in the public app. This is decision support, not diagnosis, legal advice, or therapy.")
    st.subheader("Guided Intake")
    relationship_stage = st.selectbox("Relationship Stage", ["New Relationship", "Committed", "Engaged", "Married", "Parenting", "Midlife", "Recovery"])
    challenge_type = st.multiselect("Challenge Type", ["Communication", "Trust", "Family Interference", "Burden Skew", "Respect", "Accountability", "Financial Stress", "Emotional Safety", "Future Planning"])
    severity = st.slider("Current Severity", 0, 5, 2)
    recurrence = st.slider("Repeated Pattern Count", 0, 10, 1)
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
'@
$content = $content + "`n" + $append
}

$content | Set-Content -Encoding UTF8 $app
Write-Host "Streamlit v3.1 consultancy patch complete." -ForegroundColor Green
