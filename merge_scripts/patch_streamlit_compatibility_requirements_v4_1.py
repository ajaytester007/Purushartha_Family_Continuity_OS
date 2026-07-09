from pathlib import Path
app=Path("51_Streamlit_MVP/app.py")
text=app.read_text(encoding="utf-8-sig").replace("\ufeff","")
marker="# === V4.1 COMPATIBILITY CHECKLIST REQUIREMENTS ==="
if marker in text:
    print("v4.1 patch already present"); raise SystemExit(0)
lines=[
"# === V4.1 COMPATIBILITY CHECKLIST REQUIREMENTS ===",
"def compatibility_band_v41(score):",
"    if score >= 85: return 'Strong readiness'",
"    if score >= 70: return 'Promising with growth tasks'",
"    if score >= 55: return 'Needs correction and retest'",
"    if score >= 40: return 'Pause and review'",
"    return 'High risk; consider exit or major intervention'",
"",
"st.markdown('---')",
"st.header('✅ v4.1 Compatibility Checklist Preview')",
"st.caption('Requirements preview for the upcoming game-mode and diary-mode compatibility engine.')",
"v41_partner=st.slider('Primary Partner Compatibility',0,100,75,key='v41_partner')",
"v41_family=st.slider('Immediate Family Support',0,100,70,key='v41_family')",
"v41_circle=st.slider('Trusted Circle Stability',0,100,70,key='v41_circle')",
"v41_budget=st.slider('Budget and Logistics Feasibility',0,100,65,key='v41_budget')",
"v41_happiness=st.slider('Happiness Quotient',0,100,75,key='v41_happiness')",
"v41_repair=st.slider('Repair and Role-Play Maturity',0,100,70,key='v41_repair')",
"v41_score=round((v41_partner*.25+v41_family*.15+v41_circle*.10+v41_budget*.15+v41_happiness*.15+v41_repair*.20),1)",
"st.metric('Long-Term Compatibility Readiness',f'{v41_score}/100')",
"st.info(compatibility_band_v41(v41_score))",
"st.subheader('Game Mode Requirement')",
"st.markdown('- Convert checklist categories into levels.\\n- Let partners and trusted circle members submit constructive ratings.\\n- Award stars/XP for role-play episodes and repair attempts.\\n- Show milestone signposts for wedding launch and married-life readiness.\\n- Generate health-check and exit reports.')",
"st.subheader('iPhone Home Screen')",
"st.markdown('Open the GitHub Pages mobile shell, then use Safari Share → Add to Home Screen.')",
"# === END V4.1 COMPATIBILITY CHECKLIST REQUIREMENTS ==="]
app.write_text(text+"\n\n"+"\n".join(lines)+"\n", encoding="utf-8")
print("v4.1 Streamlit patch complete.")
