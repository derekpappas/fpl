#!/usr/bin/env python3
"""
Port legacy ANTLR2 C++ parser (.g) to ANTLR4 parser grammar (.g4) for Java.

This is a mechanical, syntax-oriented port: it preserves rule/alternative structure from trunk
but removes ANTLR2-only constructs and all { ... } action blocks (C++ / AST / error recovery).
Syntactic predicates of the form ``( ( ... ) => ... )`` are reduced by stripping the ``( inner ) =>`` prefix.

The result is intended to match the legacy grammar's *language* as closely as ANTLR4 allows without
embedding the old C++ semantic actions. Re-run after trunk edits:

  python3 scripts/port_trunk_parser_g_to_g4.py \\
    --input ../trunk/cslc/trunk/src/parser/verilog/verilog.parser.g \\
    --output cslc-grammars/src/main/antlr4/com/fastpath/cslc/parser/verilog/VerilogParser.trunk-port.g4 \\
    --grammar-name VerilogParser \\
    --token-vocab VerilogLexer \\
    --first-rule-line 170

  The Maven build uses ``VerilogParser.g4`` (small, compile-clean). Swap/rename when
  ``VerilogParser.trunk-port.g4`` is brought to a compiling state.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


def read_lines(p: Path) -> list[str]:
    return p.read_text(encoding="utf-8", errors="replace").splitlines(keepends=True)


def strip_exception_and_catch(lines: list[str]) -> list[str]:
    out: list[str] = []
    i = 0
    n = len(lines)
    while i < n:
        stripped = lines[i].strip()
        if stripped == "exception":
            i += 1
            while i < n:
                s2 = lines[i].lstrip()
                if s2.startswith("catch "):
                    i = _skip_braced_block(lines, i)
                    continue
                break
            continue
        if stripped.startswith("catch "):
            i = _skip_braced_block(lines, i)
            continue
        out.append(lines[i])
        i += 1
    return out


def _skip_braced_block(lines: list[str], start: int) -> int:
    """Skip from lines[start] through the closing } of the catch (or similar) block."""
    i = start
    n = len(lines)
    depth = 0
    seen_open = False
    while i < n:
        line = lines[i]
        for ch in line:
            if ch == "{":
                depth += 1
                seen_open = True
            elif ch == "}" and seen_open:
                depth -= 1
                if depth == 0:
                    return i + 1
        i += 1
    return i


def strip_braced_actions(text: str) -> str:
    """Remove { ... } blocks; skip braces inside // and /* */ and " strings."""
    out: list[str] = []
    i = 0
    n = len(text)
    in_line_comment = False
    in_block_comment = False
    in_string = False
    escape = False

    def starts_with(prefix: str, pos: int) -> bool:
        return text.startswith(prefix, pos)

    while i < n:
        if in_line_comment:
            out.append(text[i])
            if text[i] == "\n":
                in_line_comment = False
            i += 1
            continue
        if in_block_comment:
            if starts_with("*/", i):
                out.append(text[i])
                out.append(text[i + 1])
                i += 2
                in_block_comment = False
            else:
                out.append(text[i])
                i += 1
            continue
        if in_string:
            out.append(text[i])
            if escape:
                escape = False
            elif text[i] == "\\":
                escape = True
            elif text[i] == '"':
                in_string = False
            i += 1
            continue

        if starts_with("//", i):
            in_line_comment = True
            out.append(text[i])
            out.append(text[i + 1])
            i += 2
            continue
        if starts_with("/*", i):
            in_block_comment = True
            out.append(text[i])
            out.append(text[i + 1])
            i += 2
            continue
        if text[i] == '"':
            in_string = True
            out.append(text[i])
            i += 1
            continue

        if text[i] == "{":
            depth = 1
            j = i + 1
            while j < n and depth > 0:
                c = text[j]
                if c == '"' and text[j - 1] != "\\":
                    j += 1
                    while j < n:
                        if text[j] == "\\":
                            j += 2
                            continue
                        if text[j] == '"':
                            j += 1
                            break
                        j += 1
                    continue
                if starts_with("//", j):
                    while j < n and text[j] != "\n":
                        j += 1
                    continue
                if starts_with("/*", j):
                    j += 2
                    while j < n and not starts_with("*/", j):
                        j += 1
                    j += 2 if j + 1 < n else j
                    continue
                if c == "{":
                    depth += 1
                elif c == "}":
                    depth -= 1
                j += 1
            i = j
            continue

        out.append(text[i])
        i += 1
    return "".join(out)


def strip_line_comments(text: str) -> str:
    """Remove // line comments (legacy grammar uses // inside rules)."""
    out_lines: list[str] = []
    for line in text.splitlines(keepends=True):
        if "//" in line:
            i = line.find("//")
            # keep // only if inside a string — rare in this grammar
            in_dq = False
            escape = False
            cut = None
            for j, ch in enumerate(line):
                if escape:
                    escape = False
                    continue
                if ch == "\\" and in_dq:
                    escape = True
                    continue
                if ch == '"':
                    in_dq = not in_dq
                    continue
                if ch == "/" and j + 1 < len(line) and line[j + 1] == "/" and not in_dq:
                    cut = j
                    break
            if cut is not None:
                line = line[:cut].rstrip() + ("\n" if line.endswith("\n") else "")
        out_lines.append(line)
    return "".join(out_lines)


def strip_fat_arrow_predicates(text: str) -> str:
    """Remove ANTLR2 ``( ... ) =>`` syntactic predicates (single wrapping paren group)."""
    out = text
    while True:
        m = re.search(r"(?<!=)=>", out)
        if not m:
            break
        arrow = m.start()
        j = arrow - 1
        while j >= 0 and out[j] in " \t\r\n":
            j -= 1
        if j < 0 or out[j] != ")":
            break
        depth = 1
        k = j - 1
        while k >= 0 and depth > 0:
            if out[k] == ")":
                depth += 1
            elif out[k] == "(":
                depth -= 1
            k -= 1
        open_k = k + 1
        out = out[:open_k] + out[arrow + 2 :]
    return out


def strip_antlr2_syntactic_predicates(text: str) -> str:
    r"""
    Turn ``( ( X ) => rest`` into ``( rest`` by removing the inner ``( X ) =>`` when it follows ``(``.
    Handles common ANTLR2 disambiguation pattern from verilog.parser.g.
    """
    s = text
    out_parts: list[str] = []
    i = 0
    n = len(s)
    while i < n:
        if i + 1 < n and s[i] == "(" and s[i + 1] == "(":
            inner_open = i + 1
            depth = 1
            j = inner_open + 1
            while j < n and depth > 0:
                if s[j] == "(":
                    depth += 1
                elif s[j] == ")":
                    depth -= 1
                j += 1
            if depth != 0:
                out_parts.append(s[i])
                i += 1
                continue
            inner_close = j - 1
            k = inner_close + 1
            while k < n and s[k] in " \t\r\n":
                k += 1
            if s.startswith("=>", k):
                k += 2
                while k < n and s[k] in " \t\r\n":
                    k += 1
                out_parts.append(s[i])
                i = k
                continue
        out_parts.append(s[i])
        i += 1
    return "".join(out_parts)


def remove_bang_suffixes(text: str) -> str:
    """Remove ANTLR2 forced-backtrack suffix ! on identifiers / keyword tokens (not != or !==)."""
    prev = None
    t = text
    while prev != t:
        prev = t
        t = re.sub(r"\b([A-Za-z_]\w*)\s*!(?!=)", r"\1", t)
    return t


def remove_antlr2_negated_alternative_markers(text: str) -> str:
    """Turn ``|!`` (ANTLR2 negated/special alt marker) into ``|``."""
    return re.sub(r"\|\s*!", "| ", text)


def cpp_types_to_java(text: str) -> str:
    t = text
    t = re.sub(r"\bTInt\b", "int", t)
    t = re.sub(r"\bTUInt\b", "int", t)
    t = re.sub(r"\bTBool\b", "boolean", t)
    t = re.sub(r"\bTUdpType\b", "int", t)
    t = re.sub(r"\bTRUE\b", "true", t)
    t = re.sub(r"\bFALSE\b", "false", t)
    t = re.sub(r"\b(boolean|int)\s*&\b", r"\1", t)
    return t


def fix_antlr2_colon_element_labels(text: str) -> str:
    """
    ANTLR2 ``label : elem`` in alts -> ANTLR4 ``label=elem``.

    Covers ``label:K_*``, ``label:lowerCaseRule``, and ``label:UPPERCASE`` lexer tokens
    (e.g. ``tok:COLON``, ``pp:PATHPULSE``) while avoiding ``K_*`` handled by the first rule.
    """
    t = text
    t = re.sub(r"\b([a-zA-Z_]\w*):(K_[A-Z0-9_]+)\b", r"\1=\2", t)
    t = re.sub(r"\b([a-zA-Z_]\w*):([a-z][a-zA-Z0-9_]*)\b", r"\1=\2", t)
    t = re.sub(r"\b([a-zA-Z_]\w*):(?!K_)([A-Z][A-Z0-9_]*)\b", r"\1=\2", t)
    return t


def remove_antlr2_tree_root_suffixes(text: str) -> str:
    """Remove ANTLR2 ``^`` root markers on tokens/rules (``K_DEFPARAM^`` -> ``K_DEFPARAM``)."""
    prev = None
    t = text
    while prev != t:
        prev = t
        t = re.sub(r"\b([A-Za-z_]\w*)\s*\^", r"\1", t)
    return t


def collapse_legacy_rule_assignments(text: str) -> str:
    """
    Legacy ``a = b = ruleCall`` (return plumbing) -> ``b=ruleCall`` then ``ruleCall`` if needed.

    After ``fix_antlr2_colon_element_labels``, we still see ``canBeVar = pdecl=port_declaration``;
    peel ``name = `` prefixes until one ``label=rule`` remains.
    """
    prev = None
    t = text
    while prev != t:
        prev = t
        t = re.sub(
            r"\b[a-zA-Z_]\w*\s*=\s*([a-zA-Z_]\w*\s*=\s*[a-zA-Z_]\w*)",
            r"\1",
            t,
        )
    return t


def normalize_spaced_equals(text: str) -> str:
    """Turn legacy ``a = b`` into ``a=b`` so ANTLR4 label assignment is recognized."""
    prev = None
    t = text
    while prev != t:
        prev = t
        t = re.sub(
            r"\b([a-zA-Z_]\w*)\s+=\s+([a-zA-Z_]\w*)\b",
            r"\1=\2",
            t,
        )
    return t


def normalize_spaced_colon_labels(text: str) -> str:
    """
    ANTLR2 ``ex1 : expression`` -> ANTLR4 ``ex1=expression``.

    Uses horizontal whitespace only so we do not merge a rule name and its ``:`` body
    across lines (``description`` / newline / ``: attrs_opt``).
    """
    prev = None
    t = text
    while prev != t:
        prev = t
        t = re.sub(
            r"\b([a-zA-Z_]\w*)[ \t]*:[ \t]+([a-zA-Z_]\w*)\b",
            r"\1=\2",
            t,
        )
    return t


def collapse_antlr2_return_assign_prefixes(text: str) -> str:
    """
    Turn ``a=b=c`` (legacy ``a=b:c`` after colon fix) into ``b=c`` by peeling leading ``id=`` prefixes.

    Repeats until stable so ``canBeVar=pdecl1=port_declaration`` becomes ``pdecl1=port_declaration``.
    """
    prev = None
    t = text
    while prev != t:
        prev = t
        t = re.sub(r"\b[a-zA-Z_]\w*=\s*([a-zA-Z_]\w*=)", r"\1", t)
    return t


def strip_rule_header_parameters(text: str) -> str:
    """Remove ANTLR2 rule parameters ``name [ Type x ]`` before ``returns`` or ``:``."""
    out_lines: list[str] = []
    for line in text.splitlines(keepends=True):
        s = line.rstrip("\n")
        nl = "\n" if line.endswith("\n") else ""
        stripped = s.strip()
        if not stripped or stripped.startswith("//"):
            out_lines.append(line)
            continue
        m = re.match(r"^(\s*)(\w+)\s+(\[[^\]]+\])\s+(returns\s+\[[^\]]+\])\s*$", s)
        if m:
            out_lines.append(f"{m.group(1)}{m.group(2)} {m.group(4)}{nl}")
            continue
        m2 = re.match(r"^(\s*)(\w+)\s+(\[[^\]]+\])\s*$", s)
        if m2 and "returns" not in s:
            out_lines.append(f"{m2.group(1)}{m2.group(2)}{nl}")
            continue
        out_lines.append(line)
    return "".join(out_lines)


def strip_invocation_arguments(text: str) -> str:
    """Remove ``rule[args]`` -> ``rule`` (ANTLR2 parameters); keep ``returns [...]`` intact."""

    def repl(m: re.Match[str]) -> str:
        if m.group(1) == "returns":
            return m.group(0)
        return m.group(1)

    prev = None
    t = text
    while prev != t:
        prev = t
        t = re.sub(r"\b([a-zA-Z_]\w*)\s*\[\s*[^\]]*?\]", repl, t)
    return t


def strip_parser_return_clauses(text: str) -> str:
    """
    Remove ``returns [ Type name ]`` from parser rules.

    Legacy ANTLR2 return plumbing does not map 1:1 to ANTLR4 without Java actions; dropping
    ``returns`` keeps the structural rule/alternative port compiling. Re-add per-rule when
    wiring semantics.
    """
    return re.sub(r"\s+returns\s+\[[^\]]*\]", "", text)


def patch_empty_port_rule(text: str) -> str:
    """``port`` had ``| { empty = TRUE; }``; after stripping actions the alt is empty and breaks ANTLR4."""
    return re.sub(
        r"port returns \[boolean empty\]\s*:\s*\(\s*\(\s*port_expression\s*\|\s*named_port_expression\s*\)\s*\|\s*\)\s*;",
        "port returns [boolean empty]\n: ( port_expression | named_port_expression )?;",
        text,
        flags=re.DOTALL,
    )


def remove_orphan_optional_markers(text: str) -> str:
    """Remove lines that are only ``?`` left from ``{pred}?`` after action stripping."""
    t = re.sub(r"(?m)^\s*\?\s*$", "", text)
    t = re.sub(r"\n{3,}", "\n\n", t)
    return t


def strip_empty_optional_openers(text: str) -> str:
    """Remove ``( ?`` left when ``{pred} ?`` / ``{pred}?`` lost the predicate body."""
    prev = None
    t = text
    while prev != t:
        prev = t
        t = re.sub(r"\(\s*\?", "(", t)
    return t


def port_body(raw_lines: list[str]) -> str:
    lines = strip_exception_and_catch(raw_lines)
    text = "".join(lines)
    text = strip_braced_actions(text)
    text = strip_line_comments(text)
    text = strip_fat_arrow_predicates(text)
    text = strip_antlr2_syntactic_predicates(text)
    text = remove_bang_suffixes(text)
    text = remove_antlr2_negated_alternative_markers(text)
    text = cpp_types_to_java(text)
    text = fix_antlr2_colon_element_labels(text)
    text = normalize_spaced_equals(text)
    text = normalize_spaced_colon_labels(text)
    text = collapse_antlr2_return_assign_prefixes(text)
    text = collapse_legacy_rule_assignments(text)
    text = remove_antlr2_tree_root_suffixes(text)
    text = strip_rule_header_parameters(text)
    text = strip_invocation_arguments(text)
    text = remove_orphan_optional_markers(text)
    text = strip_empty_optional_openers(text)
    text = patch_empty_port_rule(text)
    text = strip_parser_return_clauses(text)
    return text


def build_header(*, grammar_name: str, token_vocab: str, source: Path, first_line: int) -> str:
    return (
        f"// ANTLR4 Java port of legacy ANTLR2/C++ parser grammar.\n"
        f"// Source: {source.as_posix()} (from first rule line {first_line}).\n"
        "// C++ actions, AST construction, and exception/catch handlers were removed (syntax-only port).\n"
        "// Regenerate with: scripts/port_trunk_parser_g_to_g4.py\n"
        "\n"
        f"parser grammar {grammar_name};\n"
        "\n"
        f"options {{ tokenVocab = {token_vocab}; }}\n"
        "\n"
    )


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--input", type=Path, required=True)
    ap.add_argument("--output", type=Path, required=True)
    ap.add_argument("--grammar-name", required=True)
    ap.add_argument("--token-vocab", required=True)
    ap.add_argument("--first-rule-line", type=int, required=True, help="1-based line number of first parser rule to keep")
    args = ap.parse_args()

    if not args.input.is_file():
        print(f"Missing input: {args.input}", file=sys.stderr)
        return 1

    all_lines = read_lines(args.input)
    start = max(1, args.first_rule_line) - 1
    if start >= len(all_lines):
        print("--first-rule-line past EOF", file=sys.stderr)
        return 1

    body = port_body(all_lines[start:])
    header = build_header(
        grammar_name=args.grammar_name,
        token_vocab=args.token_vocab,
        source=args.input.resolve(),
        first_line=args.first_rule_line,
    )
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(header + body, encoding="utf-8")
    print(f"Wrote {args.output} ({len(header + body)} bytes)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
