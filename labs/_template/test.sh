#!/usr/bin/env bash
# Exits 0 if the lab works as described in README.md. It runs against the
# current cluster and cleans up after itself.
# Sale con 0 si el laboratorio funciona como dice el README.md. Corre contra el
# cluster actual y limpia lo que crea.
set -euo pipefail
cd "$(dirname "$0")"

NS="lab-$(basename "$PWD")"
kubectl create namespace "$NS"
trap 'kubectl delete namespace "$NS" --wait=false >/dev/null' EXIT

kubectl apply -n "$NS" -f manifests/

# Replace with the lab's real checks · Reemplazar por las pruebas reales:
# kubectl wait -n "$NS" --for=condition=Available deployment/web --timeout=120s
