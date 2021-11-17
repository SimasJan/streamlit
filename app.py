import streamlit as st
import pandas as pd

# Functions
@st.cache
def read_local(path):
    return pd.read_csv(path, encoding='latin-1')

df = read_local('dummy_recommendations.csv')

# UI
st.write("Use the side menu to select your favourite movies. We will use this to give you awesome recommendations.")
st.sidebar.title("Select your favourite movies")

movie1 = st.sidebar.selectbox('Select your first movie:', df['original_title'].unique())

df2 = df.drop(df.loc[df['original_title'] == movie1].index, axis=0)
movie2 = st.sidebar.selectbox('Select your second movie:', df2['original_title'].unique())

df3 = df2.drop(df2.loc[df2['original_title'] == movie2].index, axis=0)
movie3 = st.sidebar.selectbox('Select your third movie:', df3['original_title'].unique())

if st.sidebar.button(label = 'Submit'):
    st.write('Based on your preferences, we think you may like the following movies:')
    st.write(
        '> **Title**:', str(df['original_title'][0]),
        '\n \n',
        '> **Genres**:', ', '.join(str(df['genres'][0]).split('|')),
        '\n \n',
        '> **Description:**', str(df['description'][0])
    )

    st.markdown(f'<p style=“background-color:#0066cc;color:#33ff33;font-size:24px;border-radius:2%;“>Enjoy watching!</p>', unsafe_allow_html=True)
