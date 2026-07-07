# Decision Engine Pseudocode

```text
authorize(data)
events = normalize(data)
timeline = reconcile(events)
state = update_scd2(timeline)

if safety_signal(state):
    route_to_protection_review()
else:
    incidents = classify(state)
    scores = calculate_bounded_scores(incidents)
    patterns = detect_recurrence_and_repair(scores)
    tollgate = select_stage_tollgate(state)
    options = generate_least_irreversible_actions(tollgate)
    outcome = human_review(options)
    schedule_retest(outcome)
```

Scores never directly execute breakup, divorce, medical, legal, financial, or child-custody actions.
