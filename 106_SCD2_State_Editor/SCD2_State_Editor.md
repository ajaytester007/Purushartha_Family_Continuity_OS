# SCD2 State Editor

## Purpose

The SCD2 State Editor lets the user preserve history while creating a new current relationship state.

## Workflow

1. Identify current state.
2. Close current state by setting is_current=false and valid_to.
3. Create new state with is_current=true.
4. Record source event IDs, confidence, and reason.
5. Append transition audit entry.

## Rule

History is never overwritten.
