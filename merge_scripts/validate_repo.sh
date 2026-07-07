#!/usr/bin/env bash
set -euo pipefail

echo "== Validating Purushartha Family Continuity OS repository =="

required_dirs=(
  "00_Constitution"
  "01_Knowledgebase"
  "02_Life_Journey_Books"
  "03_Scoring_Engines"
  "04_Tollgates_and_Decision_Models"
  "05_Incident_and_Tort_Library"
  "06_Mind_Maps_and_Visual_Models"
  "07_Ingestion_and_Evidence_Model"
  "08_Playbooks"
  "09_Templates"
)

missing=0
for d in "${required_dirs[@]}"; do
  if [ ! -d "$d" ]; then
    echo "Missing directory: $d"
    missing=1
  fi
done

if [ ! -f "README.md" ]; then
  echo "Missing README.md"
  missing=1
fi

if [ "$missing" -eq 1 ]; then
  echo "Validation failed."
  exit 1
fi

echo "Markdown file count:"
find . -type f -name "*.md" | wc -l

echo "Mermaid file count:"
find . -type f -name "*.mmd" | wc -l

echo "JSON schema count:"
find . -type f -name "*.json" | wc -l

echo "Validation passed."
