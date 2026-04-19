#!/usr/bin/env python3
"""
Generate ANTLR4 VerilogLexer.g4 keyword rules from legacy trunk ANTLR2 verilog.lexer.g.
Reads trunk only; writes under cslc-java. Does not modify trunk.

K_TABLE / K_ENDTABLE are not in verilog.lexer.g ``tokens{}`` (legacy maps spellings ``table`` /
``endtable`` from IDENTIFIER with UDP state). The checked-in ``VerilogLexer.g4`` adds them plus
mode ``UDP_TABLE`` by hand; this generator only emits ``NAME = "lit"`` lines from ``tokens{}``.
UDP edge tokens ``UDP_Q0`` … ``UDP_XQ`` are also hand-maintained in ``UDP_TABLE`` (see trunk lexer comments);
``scripts/audit_trunk_lexer_tokens_vs_g4.py`` checks every ``tokens{}`` name exists as a lexer rule.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

TOKEN_LINE = re.compile(
    r"^\s*([A-Z][A-Z0-9_]*)\s*=\s*\"((?:[^\"\\]|\\.)*)\"\s*;"
)


def extract_tokens(lexer_g: str) -> list[tuple[str, str]]:
    """Support both `tokens {` (CSL style) and `tokens` / `{` on separate lines (Verilog style)."""
    in_tokens = False
    pending_open = False
    out: list[tuple[str, str]] = []
    for line in lexer_g.splitlines():
        if pending_open:
            if re.match(r"^\s*\{", line):
                in_tokens = True
                pending_open = False
            elif line.strip():
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
        m = TOKEN_LINE.match(line)
        if m:
            name, lit = m.group(1), bytes(m.group(2), "utf-8").decode("unicode_escape")
            out.append((name, lit))
    return out


def escape_g4_string(s: str) -> str:
    return s.replace("\\", "\\\\").replace("'", "\\'")


def main() -> int:
    root = Path(__file__).resolve().parents[1]
    trunk_lexer = root.parent / "trunk" / "cslc" / "trunk" / "src" / "parser" / "verilog" / "verilog.lexer.g"
    if not trunk_lexer.is_file():
        print(f"Missing legacy lexer (read-only reference): {trunk_lexer}", file=sys.stderr)
        return 1
    text = trunk_lexer.read_text(encoding="utf-8", errors="replace")
    pairs = extract_tokens(text)
    pairs.sort(key=lambda p: len(p[1]), reverse=True)

    out_path = (
        root
        / "cslc-grammars"
        / "src"
        / "main"
        / "antlr4"
        / "com"
        / "fastpath"
        / "cslc"
        / "parser"
        / "verilog"
        / "VerilogLexer.g4"
    )
    out_path.parent.mkdir(parents=True, exist_ok=True)

    lines = [
        "lexer grammar VerilogLexer;",
        "",
        "// Generated in part by scripts/gen_verilog_lexer_g4.py from legacy verilog.lexer.g tokens{}",
        "// Operators, numbers, identifiers: hand-aligned with legacy lexer (UDP/table modes not modeled).",
        "",
    ]
    for name, lit in pairs:
        if not lit.strip():
            continue
        esc = escape_g4_string(lit)
        lines.append(f"{name} : '{esc}' ;")
    lines.append("")
    body = r"""
// --- Punctuation and operators (legacy verilog.lexer.g; XNOR before XOR like CslLexer) ---
BACKTICK   : '`' ;
AT         : '@' ;
COLON      : ':' ;
COMMA      : ',' ;
DOT        : '.' ;
ASSIGN     : '=' ;
MINUS      : '-' ;
LBRACK     : '[' ;
RBRACK     : ']' ;
// Legacy verilog.lexer.g names (parser importVocab=Verilog matches these, not LCURLY/RCURLY)
LCRULY     : '{' ;
RCRULY     : '}' ;
LPAREN     : '(' ;
RPAREN     : ')' ;
POUND      : '#' ;
QUESTION   : '?' ;
SEMI       : ';' ;
PLUS       : '+' ;
LNOT       : '!' ;
NOT        : '~' ;
AND        : '&' ;
NAND       : '~&' ;
OR         : '|' ;
NOR        : '~|' ;
XNOR       : '~^' | '^~' ;
XOR        : '^' ;
STAR       : '*' ;
POW        : '**' ;
DIV        : '/' ;
MOD        : '%' ;
EQUAL      : '==' ;
NOT_EQ     : '!=' ;
NOT_EQ_CASE: '!==' ;
EQ_CASE    : '===' ;
LAND       : '&&' ;
TAND       : '&&&' ;
LOR        : '||' ;
LT_        : '<' ;
LE         : '<=' ;
GT         : '>' ;
GE         : '>=' ;
SL         : '<<' ;
SSL        : '<<<' ;
SR         : '>>' ;
SSR        : '>>>' ;
TRIGGER    : '->' ;
PPATH      : '=>' ;
FPATH      : '*>' ;
SUPERSTAR  : '(*)' ;
PSTAR      : '(*' ;
STARP      : '*)' ;
PO_POS     : '+:' ;
PO_NEG     : '-:' ;

EDGE_DESC : ( '0' | '1' ) ( 'x' | 'X' | 'z' | 'Z' ) ;

// Legacy treats PATHPULSE$... as a dedicated token
PATHPULSE : 'PATHPULSE' '$' [a-zA-Z0-9_$]* ;

STRING
    : '"' ( '\\' ~[\r\n] | ~["\\\r\n] )* '"'
    ;

fragment DIGIT : [0-9] ;
fragment NZ_DIGIT : [1-9] ;
fragment HEX_DIGIT : [0-9a-fA-F] ;
fragment BIN_DIGIT : [01] ;
fragment OCT_DIGIT : [0-7] ;
fragment XZ_DIGIT : [xXzZ?] ;

// Exposed as in legacy lexer/parser (NUMBER rule in .g delegates to these token types)
UNSIGNED_NUMBER : DIGIT ( DIGIT | '_' )* ;

NZ_UNSIGNED_NUMBER : [1-9] ( DIGIT | '_' )* ;

REAL_NUMBER
    : UNSIGNED_NUMBER '.' UNSIGNED_NUMBER
    ;

REAL_NUMBER_EXP
    : UNSIGNED_NUMBER ('.' UNSIGNED_NUMBER)? [eE] [+-]? UNSIGNED_NUMBER
    ;

// Commented as //TICK in legacy .g; parser unexpected{} still references TICK
TICK : ['] ;

// Sized/unsized based literals (simplified vs legacy VerilogNumber pipeline; good enough for lexer coverage)
BASED_NUMBER
    : [0-9]* '\'' [sS]? [bB] ( WHITE_SPACE_IN_BASED* ( BIN_DIGIT | XZ_DIGIT | '_' ) )+
    | [0-9]* '\'' [sS]? [oO] ( WHITE_SPACE_IN_BASED* ( OCT_DIGIT | XZ_DIGIT | '_' ) )+
    | [0-9]* '\'' [sS]? [dD] ( WHITE_SPACE_IN_BASED* ( DIGIT | XZ_DIGIT | '_' ) )+
    | [0-9]* '\'' [sS]? [hH] ( WHITE_SPACE_IN_BASED* ( HEX_DIGIT | XZ_DIGIT | '_' ) )+
    ;

fragment WHITE_SPACE_IN_BASED : [ \t] ;

ESCAPED_IDENTIFIER
    : '\\' ~[.\r\n\t \u000B\f]+ (' ' | '\t' | [\u000B\f] | '\r' | '\n')?
    ;

IDENTIFIER : [a-zA-Z_] [a-zA-Z0-9_$]* ;

SYSTEM_TASK_NAME : '$' [a-zA-Z0-9_$]+ ;

// Legacy skips these; hide so parsers can ignore them uniformly
HASH_LINE
    : '#line' [ \t]+ '"' ~["\r\n]* '"' [ \t]+ [0-9]+ ~[\r\n]* ( '\r'? '\n' | '\r' )? -> channel(HIDDEN)
    ;

DIRECTIVE
    : '`' ~[\r\n]* ( '\r'? '\n' | '\r' )? -> channel(HIDDEN)
    ;

SL_COMMENT : '//' ~[\r\n]* -> channel(HIDDEN) ;
ML_COMMENT : '/*' .*? '*/' -> channel(HIDDEN) ;

WS : [ \t\u000B\f\r\n]+ -> channel(HIDDEN) ;
"""
    lines.append(body.strip() + "\n")
    out_path.write_text("\n".join(lines), encoding="utf-8")
    print(f"Wrote {out_path} ({len(pairs)} keyword tokens)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
