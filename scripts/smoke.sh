#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname -- "${BASH_SOURCE[0]}")/.."

echo "[smoke] bash -n (scripts)"
while IFS= read -r -d '' f; do
  bash -n "$f"
done < <(find scripts -type f -name '*.sh' -print0)

echo "[smoke] bash -n (template scripts)"
while IFS= read -r -d '' f; do
  bash -n "$f"
done < <(find skills/init/templates -type f -name '*.sh.template' -print0)

echo "[smoke] python compile"
python3 -m py_compile scripts/awesome/catalog.py

echo "[smoke] seeds.tsv format"
awk -F'\t' '
  BEGIN { ok=1 }
  /^#/ || NF==0 { next }
  NF < 2 { ok=0; print "bad line (need >=2 columns): " NR > "/dev/stderr" }
  END { exit ok ? 0 : 2 }
' references/awesome/seeds.tsv

echo "[smoke] ok"

