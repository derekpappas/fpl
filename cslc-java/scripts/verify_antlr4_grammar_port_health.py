#!/usr/bin/env python3
"""
Run ANTLR4 port health checks (lexer/parser vocabulary) for CSL and Verilog.

  1. ``audit_trunk_lexer_tokens_vs_g4.py`` — trunk ``*.lexer.g`` ``tokens{}`` names vs ``*.g4`` lexer rules
  2. ``audit_lexer_parser_token_refs.py`` — ALL_CAPS refs in ``*TrunkPort.g4`` vs lexer rules (heuristic)

Requires a checkout where ``<repo>/trunk/cslc/trunk/...`` exists next to ``cslc-java`` (same layout as other scripts).
If trunk lexers are missing, trunk-token checks are skipped (with a message); parser/lexer ``.g4`` checks always run.

Usage (from ``cslc-java``):

  python3 scripts/verify_antlr4_grammar_port_health.py

Exit code: first failing sub-audit's code (1 = missing file, 2 = audit found gaps).
"""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPTS = ROOT / "scripts"
GRAM = ROOT / "cslc-grammars" / "src" / "main" / "antlr4" / "com" / "fastpath" / "cslc" / "parser"

TRUNK_CSL_LEX = ROOT.parent / "trunk" / "cslc" / "trunk" / "src" / "parser" / "csl" / "csl.lexer.g"
TRUNK_V_LEX = ROOT.parent / "trunk" / "cslc" / "trunk" / "src" / "parser" / "verilog" / "verilog.lexer.g"

CSL_LEX = GRAM / "csl" / "CslLexer.g4"
CSL_PT = GRAM / "csl" / "CslParserTrunkPort.g4"
V_LEX = GRAM / "verilog" / "VerilogLexer.g4"
V_PT = GRAM / "verilog" / "VerilogParserTrunkPort.g4"


def run(label: str, argv: list[str]) -> int:
    print(f"== {label} ==", file=sys.stderr)
    r = subprocess.run([sys.executable, *argv], cwd=str(ROOT))
    if r.returncode != 0:
        print(f"FAIL ({r.returncode}): {' '.join(argv)}", file=sys.stderr)
    return r.returncode


def main() -> int:
    worst = 0

    if TRUNK_CSL_LEX.is_file():
        worst = max(worst, run("CSL trunk tokens vs CslLexer.g4", [str(SCRIPTS / "audit_trunk_lexer_tokens_vs_g4.py"), f"--trunk-lexer={TRUNK_CSL_LEX}", f"--g4-lexer={CSL_LEX}"]))
    else:
        print(f"SKIP: missing {TRUNK_CSL_LEX}", file=sys.stderr)

    if TRUNK_V_LEX.is_file():
        worst = max(worst, run("Verilog trunk tokens vs VerilogLexer.g4", [str(SCRIPTS / "audit_trunk_lexer_tokens_vs_g4.py"), f"--trunk-lexer={TRUNK_V_LEX}", f"--g4-lexer={V_LEX}"]))
    else:
        print(f"SKIP: missing {TRUNK_V_LEX}", file=sys.stderr)

    worst = max(worst, run("CSL TrunkPort parser vs CslLexer", [str(SCRIPTS / "audit_lexer_parser_token_refs.py"), f"--parser={CSL_PT}", f"--lexer={CSL_LEX}"]))

    worst = max(worst, run("Verilog TrunkPort parser vs VerilogLexer", [str(SCRIPTS / "audit_lexer_parser_token_refs.py"), f"--parser={V_PT}", f"--lexer={V_LEX}"]))

    if worst == 0:
        print("OK: all ANTLR4 grammar port audits passed.", file=sys.stderr)
    return worst


if __name__ == "__main__":
    raise SystemExit(main())
