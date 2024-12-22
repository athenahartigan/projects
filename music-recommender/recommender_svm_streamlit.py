import pandas as pd
from sklearn.preprocessing import StandardScaler, MinMaxScaler
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.svm import SVR
from sklearn.metrics.pairwise import cosine_similarity
import streamlit as st
import numpy as np

# Load dataset
@st.cache_data
def load_data():
    data = pd.read_csv('all_audio_features_modified.csv')
    return data

data = load_data()

# Preprocess data
@st.cache_resource
def preprocess_data(data):
    numeric_data = data.drop(columns=['song_name', 'genre'])
    target_column = numeric_data.columns[0]
    y = numeric_data[target_column].values
    X = numeric_data.drop(columns=[target_column])

    scaler = StandardScaler()
    scaled_data = scaler.fit_transform(X)
    return numeric_data, X, y, scaled_data, scaler

numeric_data, X, y, scaled_data, scaler = preprocess_data(data)

# Train SVM model
@st.cache_resource
def train_svm(X, y):
    X_train, X_temp, y_train, y_temp = train_test_split(X, y, test_size=0.4, random_state=42)
    X_val, X_test, y_val, y_test = train_test_split(X_temp, y_temp, test_size=0.5, random_state=42)

    svm = SVR()
    param_grid = {
        'C': [0.1, 1, 10, 100],
        'gamma': ['scale', 'auto'],
        'kernel': ['linear', 'poly', 'rbf', 'sigmoid']
    }

    grid_search = GridSearchCV(estimator=svm, param_grid=param_grid, cv=3, scoring='neg_mean_squared_error', verbose=2)
    grid_search.fit(X_train, y_train)

    return grid_search.best_estimator_, scaler, X_train, X_val, X_test

best_svm, scaler, X_train, X_val, X_test = train_svm(scaled_data, y)

# Streamlit app
st.title("Music Recommendation System with SVM")
st.write("Choose a song, and we'll recommend similar ones based on SVM!")

selected_song = st.selectbox("Select a Song", options=data['song_name'])

if selected_song:
    st.write(f"You selected: {selected_song}")

    song_index = data[data['song_name'] == selected_song].index[0]
    song_features = X.iloc[song_index].values.reshape(1, -1)
    scaled_song_features = scaler.transform(song_features)

    # Calculate cosine similarity
    similarities = cosine_similarity(scaled_data, scaled_song_features).flatten()
    recommended_indices = similarities.argsort()[-6:-1][::-1]

    recommended_songs = data.iloc[recommended_indices]['song_name'].values
    similarity_scores = similarities[recommended_indices]

    st.subheader("Recommended Songs")
    for i, (song, score) in enumerate(zip(recommended_songs, similarity_scores)):
        st.write(f"{i+1}. {song} (Similarity Score: {score:.4f})")
