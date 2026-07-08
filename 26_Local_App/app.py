import streamlit as st
import pandas as pd
from pathlib import Path

st.set_page_config(page_title='Purushartha OS Local App', layout='wide')

st.title('Purushartha Family Continuity OS')
st.caption('Consent-first relationship, family, wealth, resilience and legacy intelligence.')

root = Path(__file__).resolve().parents[1]
events_path = root / '20_Dashboard_Data' / 'synthetic_lifetime_events.csv'
metrics_path = root / '20_Dashboard_Data' / 'dashboard_metrics_seed.csv'

tab1, tab2, tab3 = st.tabs(['Journey Events', 'Metrics', 'Guidance'])

with tab1:
    st.header('Synthetic Lifetime Events')
    if events_path.exists():
        df = pd.read_csv(events_path)
        st.dataframe(df, use_container_width=True)
    else:
        st.warning('No synthetic_lifetime_events.csv found. Run merge scripts first.')

with tab2:
    st.header('Dashboard Metrics')
    if metrics_path.exists():
        df = pd.read_csv(metrics_path)
        st.dataframe(df, use_container_width=True)
        st.bar_chart(df.set_index('metric')['value'])
    else:
        st.warning('No dashboard_metrics_seed.csv found.')

with tab3:
    st.header('Operating Guardrail')
    st.write('This is decision support only. Do not use it for secret surveillance, diagnosis, or punishment.')
    st.write('Every score needs evidence, confidence, contradiction review, and a retest date.')
