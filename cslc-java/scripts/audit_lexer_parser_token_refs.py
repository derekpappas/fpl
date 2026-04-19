#!/usr/bin/env python3
"""
Heuristic diff: ALL_CAPS-like symbols in a parser .g4 minus lexer rule names in a lexer .g4.

ANTLR4 ``implicit token`` warnings usually mean the parser references a name the lexer does not define.
This script lists likely gaps (false positives: parser fragments, string literals, or comments).

Usage:
  python3 scripts/audit_lexer_parser_token_refs.py \\
    --parser cslc-grammars/src/main/antlr4/com/fastpath/cslc/parser/csl/CslParserTrunkPort.g4 \\
    --lexer cslc-grammars/src/main/antlr4/com/fastpath/cslc/parser/csl/CslLexer.g4
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

LEXER_RULE = re.compile(r"^\s*(?:fragment\s+)?([A-Za-z_]\w*)\s*:", re.MULTILINE)
PARSER_CAPS = re.compile(r"\b([A-Z][A-Z0-9_]*)\b")

SKIP = frozenset(
    {
        "EOF",
        "PARSER",
        "LEXER",
        "GRAMMAR",
        "OPTIONS",
        "TOKENS",
        "IMPORT",
        "MODE",
        "CHANNELS",
        "FRAGMENT",
    }
)


def lexer_rule_names(lexer_text: str) -> set[str]:
    return {m.group(1) for m in LEXER_RULE.finditer(lexer_text)}


def parser_caps_refs(parser_text: str) -> set[str]:
    # Strip block and line comments roughly
    t = re.sub(r"/\*.*?\*/", " ", parser_text, flags=re.DOTALL)
    t = re.sub(r"//[^\n]*", " ", t)
    out: set[str] = set()
    for m in PARSER_CAPS.finditer(t):
        name = m.group(1)
        if name in SKIP:
            continue
        out.add(name)
    return out


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--parser", type=Path, required=True)
    ap.add_argument("--lexer", type=Path, required=True)
    args = ap.parse_args()
    if not args.parser.is_file() or not args.lexer.is_file():
        print("Missing --parser or --lexer file", file=sys.stderr)
        return 1
    lex_names = lexer_rule_names(args.lexer.read_text(encoding="utf-8", errors="replace"))
    refs = parser_caps_refs(args.parser.read_text(encoding="utf-8", errors="replace"))
    missing = sorted(refs - lex_names)
    for name in missing:
        print(name)
    if missing:
        print(f"# {len(missing)} symbol(s) referenced in parser not defined as lexer rules in lexer", file=sys.stderr)
        return 2
    print("# no gaps (heuristic)", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
