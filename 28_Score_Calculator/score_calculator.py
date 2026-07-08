from __future__ import annotations
from dataclasses import dataclass
from math import prod
from typing import Iterable

@dataclass
class ScoreResult:
    name: str
    score: float
    interpretation: str

def geometric_mean(values: Iterable[float]) -> float:
    vals = [max(float(v), 0.01) for v in values]
    return prod(vals) ** (1 / len(vals))

def relationship_health_score(
    safety: float,
    trust: float,
    reciprocity: float,
    affection: float,
    respect: float,
    teamwork: float,
    repair: float,
    growth: float
) -> ScoreResult:
    values = [safety, trust, reciprocity, affection, respect, teamwork, repair, growth]
    score = geometric_mean(values)

    if safety < 40:
        interpretation = 'Safety override: route to protection review.'
    elif score >= 85:
        interpretation = 'Flourishing'
    elif score >= 70:
        interpretation = 'Healthy with work'
    elif score >= 55:
        interpretation = 'Strained'
    elif score >= 40:
        interpretation = 'High-risk deterioration'
    else:
        interpretation = 'Critical review'

    return ScoreResult('Relationship Health Score', round(score, 2), interpretation)

def burden_skew_score(actual_share_a: float, expected_share_a: float, duration_multiplier: float = 1.0,
                      involuntary_multiplier: float = 1.0, recognition_recovery_factor: float = 1.0) -> ScoreResult:
    skew = abs(actual_share_a - expected_share_a)
    adjusted = skew * duration_multiplier * involuntary_multiplier / max(recognition_recovery_factor, 0.1)

    if adjusted >= 50:
        interpretation = 'Structural imbalance'
    elif adjusted >= 35:
        interpretation = 'Intervention needed'
    elif adjusted >= 20:
        interpretation = 'Review needed'
    else:
        interpretation = 'Within workable range'

    return ScoreResult('Burden Skew Score', round(adjusted, 2), interpretation)

if __name__ == '__main__':
    print(relationship_health_score(80, 75, 70, 72, 85, 78, 65, 74))
    print(burden_skew_score(80, 50, 1.2, 1.3, 0.8))
