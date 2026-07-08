# Score Confidence Model

## Confidence Inputs

- number of evidence sources
- source quality
- directness of observation
- contradiction level
- time recency
- recurrence
- human review status

## Confidence Bands

Low:
- single source
- high inference
- no review
- contradictory evidence

Medium:
- multiple sources or repeated pattern
- moderate context
- some human review

High:
- clear repeated behavior
- direct evidence
- context reviewed
- contradictions addressed

## Rule

A high severity finding with low confidence should trigger careful review, not automatic conclusion.
