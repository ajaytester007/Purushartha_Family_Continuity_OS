from pathlib import Path
p=Path("51_Streamlit_MVP/app.py")
t=p.read_text(encoding="utf-8")
marker="# === V3.4 FEED FORWARD JOURNEY STUDIO ==="
if marker in t:
    print("v3.4 patch already present")
    raise SystemExit(0)
block = r"""
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
"""
p.write_text(t+"\n\n"+block+"\n",encoding="utf-8")
print("v3.4 Streamlit patch complete")
