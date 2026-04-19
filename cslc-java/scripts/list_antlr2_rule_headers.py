#!/usr/bin/env python3
"""
List ANTLR2 parser or tree-parser rule names from a legacy ``.g`` file.

Heuristic: a line that is only ``ruleName`` or ``ruleName [ ... ]`` (parameters), followed (after
blank lines) by ``{``, ``:``, or ``[`` opening the rule body / returns / predicate block.

Works for trunk ``csl.parser.g``, ``verilog.parser.g``, ``csl.walker.g``, ``verilog.walker.g``, etc.

Usage:
  python3 scripts/list_antlr2_rule_headers.py trunk/cslc/trunk/src/parser/csl/csl.parser.g | head
  python3 scripts/list_antlr2_rule_headers.py --count trunk/.../verilog/verilog.parser.g
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

RULE_HEADER = re.compile(r"^([a-z]\w*)(?:\s*\[.*\])?\s*$")

SKIP_HEADERS = frozenset(
    {
        "class",
        "options",
        "header",
        "tokens",
        "exception",
        "catch",
    }
)


def list_rules(lines: list[str]) -> list[str]:
    out: list[str] = []
    n = len(lines)
    i = 0
    while i < n:
        s = lines[i].strip()
        if not s or s.startswith("//"):
            i += 1
            continue
        m = RULE_HEADER.match(s)
        if not m or m.group(1) in SKIP_HEADERS:
            i += 1
            continue
        name = m.group(1)
        j = i + 1
        while j < n and not lines[j].strip():
            j += 1
        if j >= n:
            i += 1
            continue
        t = lines[j].strip()
        if t.startswith(":") or t == "{" or t.startswith("["):
            out.append(name)
        i += 1
    return out


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("input", type=Path, help="Path to legacy ANTLR2 .g parser or tree parser")
    ap.add_argument("--count", action="store_true", help="Print rule count only")
    args = ap.parse_args()
    if not args.input.is_file():
        print(f"Missing file: {args.input}", file=sys.stderr)
        return 1
    lines = args.input.read_text(encoding="utf-8", errors="replace").splitlines()
    rules = list_rules(lines)
    if args.count:
        print(len(rules))
        return 0
    for r in rules:
        print(r)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
