# Deployment Mode Detection

## Purpose

The app should distinguish between:

1. Public Streamlit deployment
2. Local private workstation

## Environment Variables

- PURUSHARTHA_DEPLOYMENT_MODE
  - public_demo
  - private_local

- PURUSHARTHA_ALLOW_PRIVATE_MODE
  - true
  - false

## Default

If variables are missing, default to public_demo.

## Reason

Safe defaults prevent accidental private-data use in the public app.
