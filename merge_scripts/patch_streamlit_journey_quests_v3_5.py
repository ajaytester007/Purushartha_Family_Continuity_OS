from pathlib import Path

app = Path("51_Streamlit_MVP/app.py")
text = app.read_text(encoding="utf-8-sig").replace("\ufeff", "")
marker = "# === V3.5 JOURNEY IDENTITY QUEST SYSTEM ==="
if marker in text:
    print("v3.5 Streamlit patch already present.")
    raise SystemExit(0)

lines = [
"# === V3.5 JOURNEY IDENTITY QUEST SYSTEM ===",
"",
"def quest_recommendation_v35(focus):",
"    catalog = {",
"        'Trust': ('Promise Keeper', 'Make one small promise today and keep it.', 15),",
"        'Friendship': ('Curiosity Date', 'Ask three new questions with warmth.', 15),",
"        'Communication': ('Calm Repair', 'Name one fact, one impact, and one request kindly.', 20),",
"        'Teamwork': ('Team Us', 'Complete one practical task together.', 15),",
"        'Joy': ('Joy Spark', 'Recreate a tiny happy memory.', 10),",
"        'Shared Vision': ('Future Postcard', 'Write a note from your future selves.', 15),",
"    }",
"    return catalog.get(focus, catalog['Friendship'])",
"",
"st.markdown('---')",
"st.header('🌟 Journey Identity + Quest Board')",
"st.caption('Create a positive relationship identity, choose a quest, and celebrate progress.')",
"ji_name_v35 = st.text_input('Relationship / Chapter Name', value='Our Next Chapter', key='ji_name_v35')",
"ji_stage_v35 = st.selectbox('Current Chapter', ['Just Starting','Dating','Committed','Engaged','Married','Parenting','Renewal','Makeover'], key='ji_stage_v35')",
"ji_values_v35 = st.multiselect('Guiding Values', ['Kindness','Trust','Ahimsa','Growth','Joy','Teamwork','Family Harmony','Freedom','Spiritual Alignment'], default=['Kindness','Trust'], key='ji_values_v35')",
"ji_strength_v35 = st.text_area('One strength to preserve', placeholder='Example: We communicate honestly when calm.', key='ji_strength_v35')",
"ji_dream_v35 = st.text_area('One shared dream to move toward', placeholder='Example: Build a peaceful, joyful, well-managed life together.', key='ji_dream_v35')",
"st.subheader('🎯 Choose Today\'s Score-Lift Quest')",
"ji_focus_v35 = st.selectbox('Growth Focus', ['Trust','Friendship','Communication','Teamwork','Joy','Shared Vision'], key='ji_focus_v35')",
"quest_name_v35, quest_desc_v35, quest_xp_v35 = quest_recommendation_v35(ji_focus_v35)",
"st.success(f'Today\'s Quest: {quest_name_v35}')",
"st.info(quest_desc_v35)",
"st.metric('Quest XP', quest_xp_v35)",
"completed_v35 = st.checkbox('We completed this quest', key='ji_completed_v35')",
"bonus_v35 = st.slider('Bonus effort', 0, 10, 5, key='ji_bonus_effort_v35')",
"if st.button('Celebrate Progress', key='ji_celebrate_v35'):",
"    xp_v35 = quest_xp_v35 + bonus_v35",
"    stars_v35 = '⭐' * max(1, min(5, int(xp_v35 / 5)))",
"    st.balloons()",
"    st.subheader(f'Celebration: {stars_v35}')",
"    st.success(f'You earned {xp_v35} XP toward {ji_name_v35}.')",
"    recap_v35 = (",
"        f'# Weekly Story Seed\\n\\nThis week, **{ji_name_v35}** practiced **{ji_focus_v35}** through **{quest_name_v35}**.\\n\\n'",
"        f'Strength preserved: {ji_strength_v35 or "a strength still being named"}\\n\\n'",
"        f'Shared dream: {ji_dream_v35 or "a dream still being shaped"}\\n\\n'",
"        'Next gentle step: repeat one small behavior that made the relationship feel safer, kinder, or more joyful.'",
"    )",
"    st.markdown(recap_v35)",
"    st.download_button('Download Weekly Story Seed', recap_v35, 'weekly_story_seed.md', 'text/markdown', key='ji_download_story_v35')",
"st.subheader('💌 Future Postcard')",
"future_note_v35 = st.text_area('Write a note from your future selves', placeholder='Dear us, thank you for choosing...', key='ji_future_postcard_v35')",
"if st.button('Create Future Postcard', key='ji_create_postcard_v35'):",
"    postcard_v35 = '# Future Postcard\\n\\nDear us,\\n\\n' + future_note_v35 + '\\n\\nWith gratitude,\\nOur future selves'",
"    st.markdown(postcard_v35)",
"    st.download_button('Download Future Postcard', postcard_v35, 'future_postcard.md', 'text/markdown', key='ji_download_postcard_v35')",
"st.subheader('🧞 Genie Home Prompt')",
"st.info('Try asking: What quest should we do if we want more trust, more joy, or a calmer repair conversation?')",
"# === END V3.5 JOURNEY IDENTITY QUEST SYSTEM ===",
]
block = "\n".join(lines)
app.write_text(text + "\n\n" + block + "\n", encoding="utf-8")
print("v3.5 Streamlit Journey Identity + Quest patch complete.")
