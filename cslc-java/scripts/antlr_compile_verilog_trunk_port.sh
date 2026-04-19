#!/usr/bin/env bash
# Compile VerilogLexer.g4 then VerilogParserTrunkPort.g4 with the same ANTLR jar Maven uses.
# Usage (from cslc-java):
#   ./scripts/antlr_compile_verilog_trunk_port.sh
# Optional: first arg = path to parser .g4 (default: .../VerilogParserTrunkPort.g4)

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
M2_LOCAL="${M2_LOCAL:-$ROOT/.m2/repository}"
JAR="$M2_LOCAL/org/antlr/antlr4/4.13.2/antlr4-4.13.2-complete.jar"
GRAM="$ROOT/cslc-grammars/src/main/antlr4/com/fastpath/cslc/parser/verilog"
PARSER="${1:-$GRAM/VerilogParserTrunkPort.g4}"
OUT="${OUT:-/tmp/antlr_verilog_check}"

if [[ ! -f "$JAR" ]]; then
  echo "Missing $JAR — run: mvn -q dependency:get -Dartifact=org.antlr:antlr4:4.13.2:jar:complete -Dmaven.repo.local=$M2_LOCAL" >&2
  exit 1
fi

rm -rf "$OUT"
mkdir -p "$OUT/lex"
java -cp "$JAR" org.antlr.v4.Tool -package com.fastpath.cslc.parser.verilog -o "$OUT/lex" "$GRAM/VerilogLexer.g4"
java -cp "$JAR" org.antlr.v4.Tool -long-messages -message-format gnu \
  -lib "$OUT/lex" -package com.fastpath.cslc.parser.verilog -o "$OUT/parser" "$PARSER"
echo "OK: generated under $OUT"
