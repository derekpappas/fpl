#!/usr/bin/env bash
# Runs Maven test for cslc-java after the agent stops. Uses a workspace-local repo
# under cslc-java/.m2 so dependency resolution stays inside the project tree
# (friendlier to restricted / sandboxed environments than ~/.m2).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
JAVA_DIR="$ROOT/cslc-java"
M2_LOCAL="$JAVA_DIR/.m2/repository"
LOG="$ROOT/.cursor/cslc-java-last-mvn.log"

mkdir -p "$(dirname "$LOG")"
# Consume hook JSON from stdin
cat >/dev/null

if [[ ! -f "$JAVA_DIR/pom.xml" ]]; then
  printf '%s\n' '{}'
  exit 0
fi

mkdir -p "$M2_LOCAL"
{
  echo "=== $(date -Iseconds) mvn test (repo.local=$M2_LOCAL) ==="
  if (cd "$JAVA_DIR" && mvn -B -q -Dmaven.repo.local="$M2_LOCAL" test); then
    echo "RESULT: OK"
  else
    echo "RESULT: FAIL ($?)"
  fi
} >"$LOG" 2>&1

printf '%s\n' '{}'
exit 0
