"""
Provides simple Streamlit Frontend for demonstrating a CI/CD pipeline template.
"""

import os
import streamlit as st
import requests


st.title("Test API Trigger Dashboard")

API_BASE_URL = os.getenv("API_BASE_URL", "http://localhost:8000")
OLD_CT_API_URL = f"{API_BASE_URL}/old_ct_names"
NEW_CT_API_URL = f"{API_BASE_URL}/new_ct_names"

if st.button("Get Old CT Names"):
    try:
        response = requests.get(OLD_CT_API_URL, timeout=5.0)
        if response.ok:
            st.success("Old CT Names successfuly retrieved")
            st.json(response.json())
        else:
            st.error(f"Old CT Names unsuccessfully retrieved: {response.status_code}")
    except Exception as e:
        st.error(f"Error calling API: {e}")

if st.button("Get New CT Names"):
    try:
        response = requests.get(NEW_CT_API_URL, timeout=5.0)
        if response.ok:
            st.success("New CT Names successfuly retrieved")
            st.json(response.json())
        else:
            st.error(f"New CT Names unsuccessfully retrieved: {response.status_code}")
    except Exception as e:
        st.error(f"Error calling API: {e}")
