#!/usr/bin/env python3
"""
Compare legacy trunk ANTLR2 lexer ``tokens{}`` symbol names to ANTLR4 ``.g4`` lexer rule names.

Collects names from:
  - ``NAME = "literal";`` lines
  - bare ``NAME;`` or ``NAME /* … */ ;`` (Verilog ``K_TABLE`` / ``K_ENDTABLE``, ``PSTAR``, UDP_*, etc.)

``fragment`` rules in the ``.g4`` file count as defined (same idea as ``audit_lexer_parser_token_refs.py``).

Usage:
  python3 scripts/audit_trunk_lexer_tokens_vs_g4.py \\
    --trunk-lexer ../trunk/cslc/trunk/src/parser/csl/csl.lexer.g \\
    --g4-lexer cslc-grammars/src/main/antlr4/com/fastpath/cslc/parser/csl/CslLexer.g4

Exit code 2 if any trunk ``tokens{}`` names are missing as lexer rules in the ``.g4`` file.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

TOKEN_LINE = re.compile(
    r"^\s*([A-Z][A-Z0-9_]*)\s*=\s*\"((?:[^\"\\]|\\.)*)\"\s*;"
)
# Bare token decl: PSTAR;  or  K_ENDTABLE /* = "endtable" */ ;
BARE_TOKEN = re.compile(r"^\s*([A-Z][A-Z0-9_]*)\s*(?:/\*.*?\*/\s*)?\s*;\s*(?://.*)?$")
LEXER_RULE = re.compile(r"^\s*(?:fragment\s+)?([A-Za-z_]\w*)\s*:", re.MULTILINE)


def lexer_rule_names(g4_text: str) -> set[str]:
    return {m.group(1) for m in LEXER_RULE.finditer(g4_text)}


def trunk_token_names_csl(lexer_g: str) -> set[str]:
    """CSL style: ``tokens {`` on one line; only ``NAME = \"…\";`` entries."""
    in_tokens = False
    names: set[str] = set()
    for line in lexer_g.splitlines():
        if not in_tokens:
            if re.match(r"^\s*tokens\s*\{", line):
                in_tokens = True
            continue
        if re.match(r"^\s*}\s*$", line):
            break
        if line.strip().startswith("//"):
            continue
        m = TOKEN_LINE.match(line)
        if m:
            names.add(m.group(1))
    return names


def trunk_token_names_verilog(lexer_g: str) -> set[str]:
    """Verilog style: ``tokens`` then ``{`` (possibly next line); literals + bare ``NAME;``."""
    in_tokens = False
    pending_open = False
    names: set[str] = set()
    for line in lexer_g.splitlines():
        if pending_open:
            if re.match(r"^\s*\{", line):
                in_tokens = True
            pending_open = False
            continue
        if not in_tokens:
            if re.match(r"^\s*tokens\s*\{", line):
                in_tokens = True
            elif re.match(r"^\s*tokens\s*$", line):
                pending_open = True
            continue
        if re.match(r"^\s*}\s*$", line):
            break
        if line.strip().startswith("//"):
            continue
        m = TOKEN_LINE.match(line)
        if m:
            names.add(m.group(1))
            continue
        if not line.strip():
            continue
        mb = BARE_TOKEN.match(line)
        if mb:
            names.add(mb.group(1))
    return names


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--trunk-lexer", type=Path, required=True)
    ap.add_argument("--g4-lexer", type=Path, required=True)
    ap.add_argument(
        "--flavor",
        choices=("auto", "csl", "verilog"),
        default="auto",
        help="How to scan the trunk tokens block (default: from --trunk-lexer basename)",
    )
    args = ap.parse_args()
    if not args.trunk_lexer.is_file() or not args.g4_lexer.is_file():
        print("Missing --trunk-lexer or --g4-lexer file", file=sys.stderr)
        return 1
    text = args.trunk_lexer.read_text(encoding="utf-8", errors="replace")
    flavor = args.flavor
    if flavor == "auto":
        flavor = "verilog" if "verilog" in args.trunk_lexer.name.lower() else "csl"
    if flavor == "verilog":
        trunk_names = trunk_token_names_verilog(text)
    else:
        trunk_names = trunk_token_names_csl(text)

    g4_names = lexer_rule_names(args.g4_lexer.read_text(encoding="utf-8", errors="replace"))
    missing = sorted(trunk_names - g4_names)
    for n in missing:
        print(n)
    if missing:
        print(
            f"# {len(missing)} trunk token name(s) not defined as lexer rules in {args.g4_lexer}",
            file=sys.stderr,
        )
        return 2
    print("# trunk tokens block ⊆ g4 lexer rules (name-level)", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
