#!/usr/bin/env bash
set -euo pipefail

echo "== Git publish helper for v1.1 =="

git status
git add .
git commit -m "Add v1.1 publishing and intelligence foundation" || echo "Nothing to commit or commit failed."
git tag -f v1.1
echo "Created/updated tag v1.1."
echo "Run manually when ready:"
echo "  git push origin main --tags"
