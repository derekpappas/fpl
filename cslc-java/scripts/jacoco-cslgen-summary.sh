#!/usr/bin/env bash
# Run JaCoCo (via mvn verify) for cslc-csl-gen and print instruction % for the cslgen package plus selected classes.
#
# Usage:
#   ./scripts/jacoco-cslgen-summary.sh
#   MAVEN_REPO_LOCAL=/path/to/.m2/repository ./scripts/jacoco-cslgen-summary.sh
#
# Optional first argument: "test" runs unit tests only (no JaCoCo site); "verify" (default) runs verify + summary.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
REPO_LOCAL="${MAVEN_REPO_LOCAL:-$ROOT/.m2/repository}"
JACOCO_XML="$ROOT/cslc-csl-gen/target/site/jacoco/jacoco.xml"

GOAL="${1:-verify}"
if [[ "$GOAL" != "test" && "$GOAL" != "verify" ]]; then
  echo "usage: $0 [test|verify]" >&2
  exit 2
fi

mvn -B -q -Dmaven.repo.local="$REPO_LOCAL" -pl cslc-csl-gen -am "$GOAL"

if [[ "$GOAL" == "test" ]]; then
  echo "mvn test finished (no JaCoCo site). Re-run with verify for $JACOCO_XML" >&2
  exit 0
fi

if [[ ! -f "$JACOCO_XML" ]]; then
  echo "no report at $JACOCO_XML" >&2
  exit 1
fi

python3 <<PY
import xml.etree.ElementTree as ET

root = ET.parse("$JACOCO_XML").getroot()
ns = root.tag.split("}")[0].strip("{") if root.tag.startswith("{") else ""


def q(t):
    return f"{{{ns}}}{t}" if ns else t


def inst_pct(cls_el):
    for c in cls_el.findall(q("counter")):
        if c.get("type") == "INSTRUCTION":
            im = int(c.get("missed", 0))
            ic = int(c.get("covered", 0))
            tot = im + ic
            pct = 100.0 * ic / tot if tot else 100.0
            return pct, im, ic
    return None


for pkg in root.findall(q("package")):
    if "cslgen" not in pkg.get("name", ""):
        continue
    r = inst_pct(pkg)
    if r:
        pct, im, ic = r
        print(f"package cslgen: {pct:.1f}% inst ({im} missed / {ic + im} total)")
    break

classes = [
    "CslCodeGenMain",
    "CslGenIfcInst",
    "CslGenRegisterFile",
]
want = set(classes)
for pkg in root.findall(q("package")):
    for cls in pkg.findall(q("class")):
        name = cls.get("name", "")
        short = name.rsplit("/", 1)[-1] if "/" in name else name
        if short not in want:
            continue
        r = inst_pct(cls)
        if r:
            pct, im, _ = r
            print(f"  {short}: {pct:.1f}% ({im} missed)")
PY
