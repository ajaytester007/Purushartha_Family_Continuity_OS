# System Architecture

## Layers
1. Consent Gateway
2. Source Connectors
3. Normalization
4. Evidence Store
5. Event Graph
6. SCD2 State Store
7. Rule and Scoring Engines
8. Pattern Detection
9. Tollgate Engine
10. Experience Layer
11. Audit and Governance

## Storage
- immutable source references;
- normalized events;
- versioned person/relationship/household states;
- derived scores with explanations;
- decision history;
- consent ledger.

## Intelligence Rule
Every derived conclusion must point to:
source events → transformation → rule/model → confidence → human review status.

## Mind Map Generation
Create nodes for people, events, obligations, influences, injuries, repairs, and milestones. Edge types include supports, conflicts, depends-on, influences, repairs, repeats, and replaces-role-without-replacing-person.
