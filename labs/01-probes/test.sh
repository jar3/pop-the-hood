#!/usr/bin/env bash
# Checks the three probes: startup, readiness (out of the Service, no restart)
# and liveness (restart). · Prueba las tres probes.
set -euo pipefail
cd "$(dirname "$0")"

NS="lab-$(basename "$PWD")"
kubectl create namespace "$NS"
trap 'kubectl delete namespace "$NS" --wait=false >/dev/null' EXIT
k() { kubectl -n "$NS" "$@"; }

endpoints() { k get endpointslices -l kubernetes.io/service-name=web -o jsonpath='{range .items[*].endpoints[?(@.conditions.ready==true)]}x{end}' | wc -c; }
restarts() { k get pod -l app=web -o jsonpath='{.items[0].status.containerStatuses[0].restartCount}'; }
wait_for() { for _ in $(seq 1 60); do eval "$1" && return 0; sleep 2; done; echo "timeout: $1" >&2; return 1; }

k apply -f manifests/

# 1. Startup: not Ready during the first 10 s, then Ready.
sleep 3
[[ "$(k get pod -l app=web -o jsonpath='{.items[0].status.containerStatuses[0].ready}')" == "false" ]]
k wait --for=condition=Available deployment/web --timeout=90s
POD=$(k get pod -l app=web -o name)
wait_for '[[ $(endpoints) -eq 1 ]]'

# 2. Readiness: remove the sign -> out of the Service, but no restart.
k exec "$POD" -- rm /usr/share/nginx/html/ready.html
k wait --for=condition=Ready=false "$POD" --timeout=30s
wait_for '[[ $(endpoints) -eq 0 ]]'
[[ "$(restarts)" == "0" ]]
k exec "$POD" -- sh -c 'echo ok > /usr/share/nginx/html/ready.html'
k wait --for=condition=Ready "$POD" --timeout=30s

# 3. Liveness: break the home page -> the container is restarted.
k exec "$POD" -- rm /usr/share/nginx/html/index.html
wait_for '[[ $(restarts) -ge 1 ]]'
k wait --for=condition=Ready "$POD" --timeout=90s
echo "probes OK"
