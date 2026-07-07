#!/usr/bin/env bash
set -euo pipefail

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT="_published/Purushartha_Family_Continuity_OS_${STAMP}"
mkdir -p "$OUT"

echo "== Publishing snapshot to $OUT =="

cp -R 00_Constitution "$OUT/" 2>/dev/null || true
cp -R 01_Knowledgebase "$OUT/" 2>/dev/null || true
cp -R 02_Life_Journey_Books "$OUT/" 2>/dev/null || true
cp -R 03_Scoring_Engines "$OUT/" 2>/dev/null || true
cp -R 04_Tollgates_and_Decision_Models "$OUT/" 2>/dev/null || true
cp -R 05_Incident_and_Tort_Library "$OUT/" 2>/dev/null || true
cp -R 06_Mind_Maps_and_Visual_Models "$OUT/" 2>/dev/null || true
cp -R 07_Ingestion_and_Evidence_Model "$OUT/" 2>/dev/null || true
cp -R 08_Playbooks "$OUT/" 2>/dev/null || true
cp -R 09_Templates "$OUT/" 2>/dev/null || true
cp -R 10_Data_Contracts "$OUT/" 2>/dev/null || true
cp -R 11_Architecture "$OUT/" 2>/dev/null || true
cp -R 12_Sample_Cases "$OUT/" 2>/dev/null || true
cp -R 13_Publishing "$OUT/" 2>/dev/null || true
cp -R 14_Dashboards "$OUT/" 2>/dev/null || true
cp -R 15_Event_Graph "$OUT/" 2>/dev/null || true
cp -R 16_Scoring_Formulas "$OUT/" 2>/dev/null || true
cp -R 17_Synthetic_Datasets "$OUT/" 2>/dev/null || true
cp -R 18_Local_App_Blueprint "$OUT/" 2>/dev/null || true
cp README.md "$OUT/" 2>/dev/null || true
cp CHANGELOG.md "$OUT/" 2>/dev/null || true

find "$OUT" -type f | sort > "$OUT/PUBLISHED_MANIFEST.txt"

echo "Snapshot ready: $OUT"
