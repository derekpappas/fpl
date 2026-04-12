#!/usr/bin/env python3
"""
Generate ANTLR4 CslLexer.g4 keyword rules from legacy trunk ANTLR2 csl.lexer.g.
Reads trunk only; writes under cslc-java. Does not modify trunk.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

TOKEN_LINE = re.compile(
    r"^\s*([A-Z][A-Z0-9_]*)\s*=\s*\"((?:[^\"\\]|\\.)*)\"\s*;"
)


def extract_tokens(lexer_g: str) -> list[tuple[str, str]]:
    in_tokens = False
    out: list[tuple[str, str]] = []
    for line in lexer_g.splitlines():
        if not in_tokens:
            if re.match(r"^\s*tokens\s*\{", line):
                in_tokens = True
            continue
        if re.match(r"^\s*}\s*$", line) and "tokens" not in line:
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
    trunk_lexer = root.parent / "trunk" / "cslc" / "trunk" / "src" / "parser" / "csl" / "csl.lexer.g"
    if not trunk_lexer.is_file():
        print(f"Missing legacy lexer (read-only reference): {trunk_lexer}", file=sys.stderr)
        return 1
    text = trunk_lexer.read_text(encoding="utf-8", errors="replace")
    pairs = extract_tokens(text)
    # Longest literal first so ANTLR prefers specific keywords over IDENTIFIER
    pairs.sort(key=lambda p: len(p[1]), reverse=True)

    out_path = root / "cslc-grammars" / "src" / "main" / "antlr4" / "com" / "fastpath" / "cslc" / "parser" / "csl" / "CslLexer.g4"
    out_path.parent.mkdir(parents=True, exist_ok=True)

    lines = [
        "lexer grammar CslLexer;",
        "",
        "// Generated in part by scripts/gen_csl_lexer_g4.py from legacy csl.lexer.g tokens{}",
        "// Operators, whitespace, numbers, strings: hand-aligned with legacy lexer rules.",
        "",
    ]
    for name, lit in pairs:
        if not lit.strip():
            continue
        esc = escape_g4_string(lit)
        lines.append(f"{name} : '{esc}' ;")
    lines.append("")
    body = r"""
// --- Punctuation and operators (legacy csl.lexer.g order matters for ^ vs ~^) ---
BACKTICK   : '`' ;
AT         : '@' ;
COLON      : ':' ;
COMMA      : ',' ;
DOT        : '.' ;
ASSIGN     : '=' ;
MINUS      : '-' ;
LBRACK     : '[' ;
RBRACK     : ']' ;
LCURLY     : '{' ;
RCURLY     : '}' ;
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
STARP      : '*)' ;
PO_POS     : '+:' ;
PO_NEG     : '-:' ;
SUPERSTAR  : '(*)' ;

SYSTEM_TASK_NAME : '$' [a-zA-Z0-9_$]+ ;

STRING
    : '"' ( '\\' ~[\r\n] | ~["\\\r\n] )* '"'
    ;

fragment DIGIT : [0-9] ;
fragment NZ_DIGIT : [1-9] ;
fragment HEX_DIGIT : [0-9a-fA-F] ;
fragment BIN_DIGIT : [01] ;
fragment OCT_DIGIT : [0-7] ;
fragment XZ_DIGIT : [xXzZ?] ;

fragment UNSIGNED_NUMBER : DIGIT ( DIGIT | '_' )* ;

REAL_NUMBER
    : UNSIGNED_NUMBER '.' UNSIGNED_NUMBER
    ;

REAL_NUMBER_EXP
    : UNSIGNED_NUMBER ('.' UNSIGNED_NUMBER)? [eE] [+-]? UNSIGNED_NUMBER
    ;

NUMBER
    : REAL_NUMBER_EXP
    | REAL_NUMBER
    | UNSIGNED_NUMBER
    ;

ESCAPED_IDENTIFIER
    : '\\' ~[.\r\n\t \u000B\f]+ (' ' | '\t' | [\u000B\f] | '\r' | '\n')?
    ;

IDENTIFIER : [a-zA-Z_] [a-zA-Z0-9_$]* ;

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
