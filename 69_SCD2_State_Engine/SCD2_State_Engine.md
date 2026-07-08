# SCD2 State Engine

## Purpose

SCD2 state preserves a history of changing relationship and household conditions.

## Operation

When a material event changes a tracked state:

1. Close the current state row with valid_to.
2. Create a new current row.
3. Preserve source events and confidence.
4. Never overwrite history.

## v1.9 Scope

This version generates a simulated updated state output.
