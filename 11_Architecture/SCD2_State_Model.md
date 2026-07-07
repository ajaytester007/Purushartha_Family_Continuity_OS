# SCD2 State Model

Use Slowly Changing Dimension Type 2 for evolving state.

## Grain
Separate state tables for:
- person;
- relationship;
- household;
- child/dependent;
- financial resilience;
- Purushartha balance.

## Update
When material evidence changes a tracked attribute:
1. close current row with `valid_to`;
2. create new row;
3. retain source event IDs;
4. record confidence and reviewer.

Never overwrite history merely because the latest interpretation changed.
