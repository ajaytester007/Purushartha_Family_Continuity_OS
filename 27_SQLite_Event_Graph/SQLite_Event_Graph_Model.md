# SQLite Event Graph

## Purpose

The SQLite schema supports a local, auditable event graph.

## Tables

- person
- relationship_event
- event_participant
- graph_edge
- scd2_relationship_state

## SCD2 Rule

Never overwrite a major state change. Close the old state row and create a new current row.
