$ErrorActionPreference = "Stop"
Write-Host "== Patching Streamlit app for v3.2 Daily Companion ==" -ForegroundColor Cyan

$app = "51_Streamlit_MVP\app.py"
if (-not (Test-Path $app)) { throw "Missing Streamlit app." }

$content = Get-Content $app -Raw

if ($content -notmatch '"Daily Companion"') {
    $content = $content.Replace('"Relationship Consultancy"', '"Daily Companion",' + "`n" + '    "Grievance Report",' + "`n" + '    "Relationship Consultancy"')
}

if ($content -notmatch "def score_daily_companion_v32") {
$helper = @'

def score_daily_companion_v32(mood, gratitude_text, concern_text, partner_effort, self_effort, unresolved, special_encounter):
    concern_weight = 12 if concern_text.strip() else 0
    unresolved_weight = 15 if unresolved else 0
    special_bonus = 5 if special_encounter else 0
    gratitude_bonus = 8 if gratitude_text.strip() else 0
    relationship_energy = max(0, min(100, mood * 10 + (partner_effort + self_effort) * 5 + gratitude_bonus + special_bonus - concern_weight - unresolved_weight))
    stars = "⭐" * max(1, min(5, int((relationship_energy + 10) / 20)))
    if relationship_energy >= 80:
        tone = "Bright and bonding-friendly 🌞"
        nudge = "Celebrate the small win and create one sweet memory today."
    elif relationship_energy >= 60:
        tone = "Workable with gentle attention 🌿"
        nudge = "Offer one appreciation and clarify one small expectation."
    elif relationship_energy >= 40:
        tone = "Tender zone 🕊️"
        nudge = "Keep tone soft, avoid escalation, and ask for one repairable change."
    else:
        tone = "Heavy day 💙"
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
'@
    $content = $content + "`n" + $helper
}

if ($content -notmatch "Your Relationship Companion") {
$append = @'

with tabs[0]:
    st.header("🌸 Your Relationship Companion")
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
    st.header("📝 Grievance Report Builder")
    st.caption("Turn a concern into a calm, structured, corrective-action report.")
    st.warning("Do not paste private identifying details in the public app. Sanitize names, dates, health data, and third-party information.")

    summary = st.text_area("Grievance Summary", height=100)
    facts = st.text_area("Observed Facts", height=100)
    impact = st.text_area("Emotional Impact", height=100)
    desired_change = st.text_area("Desired Change", height=100)
    severity = st.slider("Severity", 0, 5, 2)
    recurrence = st.slider("Repeated Pattern Count", 0, 10, 1)
    accountability = st.slider("Partner Accountability Shown", 0, 10, 5)
    repair_willingness = st.slider("Repair Willingness Shown", 0, 10, 5)
    trust_concern = st.slider("Trust / Fidelity Concern", 0, 5, 1)

    if st.button("Generate Grievance Report"):
        fidelity, prospect, action, report = build_grievance_report_v32(summary, facts, impact, desired_change, severity, recurrence, accountability, repair_willingness, trust_concern)
        c1, c2 = st.columns(2)
        c1.metric("Fidelity / Trust Signal Score", f"{fidelity}/100")
        c2.metric("Relationship Prospect Score", f"{prospect}/100")
        st.info(action)
        st.markdown(report)
        st.download_button("Download Grievance Report", report, "relationship_grievance_report.md", "text/markdown")
'@
    $content = $content + "`n" + $append
}

$content | Set-Content -Encoding UTF8 $app
Write-Host "Streamlit v3.2 daily companion patch complete." -ForegroundColor Green
