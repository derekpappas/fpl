#!/usr/bin/env bash
# Compile both CSL and Verilog trunk-port parser grammars (syntax check with org.antlr.v4.Tool).
# Usage (from cslc-java):
#   ./scripts/antlr_compile_trunk_ports.sh

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
"$ROOT/scripts/antlr_compile_csl_trunk_port.sh"
"$ROOT/scripts/antlr_compile_verilog_trunk_port.sh"
echo "OK: CSL and Verilog trunk-port grammars compile."
python3 "$ROOT/scripts/verify_antlr4_grammar_port_health.py"
echo "Tip: scripts/list_antlr2_rule_headers.py <legacy .g>  (parser + walker rule inventory for port planning)"
