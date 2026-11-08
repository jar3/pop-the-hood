#!/usr/bin/env bash
# Runs the test.sh of every lab (or only the ones passed as arguments) against
# a fresh kind cluster, and deletes the cluster at the end.
# Corre el test.sh de cada laboratorio (o solo los que se pasen como argumento)
# contra un cluster de kind nuevo, y lo borra al final.
set -euo pipefail
cd "$(dirname "$0")/.."

CLUSTER="${CLUSTER:-pop-the-hood-test}"

labs=()
if [[ $# -gt 0 ]]; then
  labs=("$@")
else
  for dir in labs/*/; do
    [[ "$(basename "$dir")" == _* ]] && continue
    [[ -x "$dir/test.sh" ]] && labs+=("${dir%/}")
  done
fi

if [[ ${#labs[@]} -eq 0 ]]; then
  echo "No labs to test yet · Todavía no hay laboratorios para probar"
  exit 0
fi

kind create cluster --name "$CLUSTER" --wait 120s
trap 'kind delete cluster --name "$CLUSTER"' EXIT

failed=()
for lab in "${labs[@]}"; do
  echo "=== $lab"
  if "$lab/test.sh"; then
    echo "PASS $lab"
  else
    echo "FAIL $lab"
    failed+=("$lab")
  fi
done

if [[ ${#failed[@]} -gt 0 ]]; then
  echo "Failed · Fallaron: ${failed[*]}"
  exit 1
fi
echo "All labs passed · Pasaron todos"
