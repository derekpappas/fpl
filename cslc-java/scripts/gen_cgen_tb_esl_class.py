#!/usr/bin/env python3
"""
Regenerate CGenTbEslClass.java from trunk:
  - Enum member order + names: cGen_Declarations.h (ECSLClass)
  - Legacy stems: cGenBase_tb.cpp buildGenericNames() / cslGenericName (insert make_pair lines)

Usage (from repo root):
  python3 cslc-java/scripts/gen_cgen_tb_esl_class.py
  python3 cslc-java/scripts/gen_cgen_tb_esl_class.py --check   # exit 1 if file would change

Does not modify trunk/.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


def repo_root() -> Path:
    return Path(__file__).resolve().parents[2]


def trunk_root() -> Path:
    return repo_root() / "trunk" / "cslc" / "trunk"


def default_output_path() -> Path:
    return (
        repo_root()
        / "cslc-java"
        / "cslc-csl-gen"
        / "src"
        / "main"
        / "java"
        / "com"
        / "fastpath"
        / "cslc"
        / "cslgen"
        / "cgentb"
        / "CGenTbEslClass.java"
    )


def parse_ecsl_class(hdr_text: str) -> list[str]:
    m = re.search(r"typedef enum _ECSLClass \{([^}]+)\} ECSLClass", hdr_text, re.S)
    if not m:
        raise SystemExit("ECSLClass enum not found in header")
    return re.findall(r"\b(CSL_[A-Z0-9_]+)\s*,?", m.group(1))


def parse_csl_generic_name(cpp_text: str) -> dict[str, str]:
    m = re.search(
        r"void buildGenericNames\(\) \{(.*?)^\}",
        cpp_text,
        re.S | re.M,
    )
    if not m:
        raise SystemExit("buildGenericNames() not found in cGenBase_tb.cpp")
    body = m.group(1)
    pairs = re.findall(
        r"make_pair\(\s*(CSL_[A-Z0-9_]+)\s*,\s*\"([^\"]*)\"\s*\)",
        body,
    )
    return dict(pairs)


def java_escape(s: str) -> str:
    return s.replace("\\", "\\\\").replace('"', '\\"')


def generate_java(classes: list[str], stem_by_class: dict[str, str]) -> str:
    missing = [c for c in classes if c not in stem_by_class]
    if missing:
        raise SystemExit(f"buildGenericNames missing {len(missing)} enum keys, e.g. {missing[:5]}")
    extra = set(stem_by_class) - set(classes)
    if extra:
        raise SystemExit(f"buildGenericNames has keys not in ECSLClass: {sorted(extra)[:5]}")

    enum_lines = [f"    {c}(\"{java_escape(stem_by_class[c])}\")," for c in classes]
    enum_lines[-1] = enum_lines[-1].rstrip(",")

    parts = [
        "package com.fastpath.cslc.cslgen.cgentb;",
        "",
        "/**",
        " * Legacy {@code ECSLClass} ({@code trunk/cslc/trunk/csl_gen/cGen_Declarations.h}). Declaration order matches the",
        " * C++ enum (ordinal = legacy discriminant). {@link #legacyGenericStem()} mirrors {@code cslGenericName} in",
        " * {@code cGenBase_tb.cpp} ({@code buildGenericNames} / {@code cslTypeName} uses {@code \"csl_\" + stem}).",
        " *",
        " * <p><b>Generated</b> — regenerate with {@code python3 cslc-java/scripts/gen_cgen_tb_esl_class.py}.",
        " */",
        "public enum CGenTbEslClass {",
        *enum_lines,
        "    ;",
        "",
        "    private final String legacyGenericStem;",
        "",
        "    CGenTbEslClass(String legacyGenericStem) {",
        "        this.legacyGenericStem = legacyGenericStem;",
        "    }",
        "",
        "    /** Legacy map value in {@code cslGenericName} ({@code cGenBase_tb.cpp}). */",
        "    public String legacyGenericStem() {",
        "        return legacyGenericStem;",
        "    }",
        "",
        "    /** Legacy {@code cslTypeName} keyword: {@code \"csl_\" +} {@link #legacyGenericStem()}. */",
        "    public String legacyCslTypeKeyword() {",
        "        return \"csl_\" + legacyGenericStem;",
        "    }",
        "}",
        "",
    ]
    return "\n".join(parts)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "-o",
        "--output",
        type=Path,
        default=default_output_path(),
        help="Path to CGenTbEslClass.java",
    )
    ap.add_argument(
        "--check",
        action="store_true",
        help="Exit 1 if generated text differs from existing output file",
    )
    args = ap.parse_args()

    hdr = (trunk_root() / "csl_gen" / "cGen_Declarations.h").read_text()
    cpp = (trunk_root() / "csl_gen" / "cGenBase_tb.cpp").read_text()
    classes = parse_ecsl_class(hdr)
    stems = parse_csl_generic_name(cpp)
    text = generate_java(classes, stems)

    out: Path = args.output
    if args.check:
        if not out.is_file():
            print(f"check: missing {out}", file=sys.stderr)
            return 1
        existing = out.read_text()
        if existing != text:
            print(f"check: {out} is out of date (run without --check to refresh)", file=sys.stderr)
            return 1
        return 0

    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(text)
    print(f"Wrote {out} ({len(classes)} constants)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
