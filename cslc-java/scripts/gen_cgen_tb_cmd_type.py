#!/usr/bin/env python3
"""
Regenerate CGenTbCmdType.java from trunk:
  - Enum member order + names: cGen_Declarations.h (ECSLCmdType)
  - Legacy strings: cGenBase_tb.cpp buildCmdNames() / cslCmdName (make_pair lines)

Usage (from repo root):
  python3 cslc-java/scripts/gen_cgen_tb_cmd_type.py
  python3 cslc-java/scripts/gen_cgen_tb_cmd_type.py --check   # exit 1 if file would change

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
        / "CGenTbCmdType.java"
    )


def parse_ecsl_cmd_type(hdr_text: str) -> list[str]:
    m = re.search(r"typedef enum _ECSLCmdType \{([^}]+)\} ECSLCmdType", hdr_text, re.S)
    if not m:
        raise SystemExit("ECSLCmdType enum not found in header")
    return re.findall(r"\b(CMD_[A-Z0-9_]+)\s*,?", m.group(1))


def parse_build_cmd_names(cpp_text: str) -> dict[str, str]:
    pairs = re.findall(
        r"make_pair\(\s*(CMD_[A-Z0-9_]+)\s*,\s*\"([^\"]*)\"\s*\)",
        cpp_text,
    )
    return dict(pairs)


def java_escape(s: str) -> str:
    return s.replace("\\", "\\\\").replace('"', '\\"')


def generate_java(cmds: list[str], name_by_cmd: dict[str, str]) -> str:
    missing = [c for c in cmds if c not in name_by_cmd]
    if missing:
        raise SystemExit(f"buildCmdNames missing {len(missing)} enum keys, e.g. {missing[:5]}")
    extra = set(name_by_cmd) - set(cmds)
    if extra:
        raise SystemExit(f"buildCmdNames has keys not in ECSLCmdType: {sorted(extra)[:5]}")

    enum_lines = [f"    {c}(\"{java_escape(name_by_cmd[c])}\")," for c in cmds]
    enum_lines[-1] = enum_lines[-1].rstrip(",")

    parts = [
        "package com.fastpath.cslc.cslgen.cgentb;",
        "",
        "import java.util.Collections;",
        "import java.util.EnumMap;",
        "import java.util.Map;",
        "",
        "/**",
        " * Legacy {@code ECSLCmdType} ({@code trunk/cslc/trunk/csl_gen/cGen_Declarations.h}). Declaration order matches the",
        " * C++ enum (ordinal = legacy discriminant). {@link #legacyCslCmdName()} mirrors {@code buildCmdNames()} in",
        " * {@code cGenBase_tb.cpp} ({@code ECSLCmdStringMap} / {@code cslCmdName}).",
        " *",
        " * <p><b>Generated</b> — regenerate with {@code python3 cslc-java/scripts/gen_cgen_tb_cmd_type.py}.",
        " */",
        "public enum CGenTbCmdType {",
        *enum_lines,
        "    ;",
        "",
        "    private static final Map<CGenTbCmdType, String> LEGACY_NAMES;",
        "",
        "    static {",
        "        EnumMap<CGenTbCmdType, String> m = new EnumMap<>(CGenTbCmdType.class);",
        "        for (CGenTbCmdType t : values()) {",
        "            m.put(t, t.legacyCslCmdName);",
        "        }",
        "        LEGACY_NAMES = Collections.unmodifiableMap(m);",
        "    }",
        "",
        "    private final String legacyCslCmdName;",
        "",
        "    CGenTbCmdType(String legacyCslCmdName) {",
        "        this.legacyCslCmdName = legacyCslCmdName;",
        "    }",
        "",
        "    /** String used in legacy {@code cslCmdName} / {@code GET_CMD} tables ({@code cGenBase_tb.cpp}). */",
        "    public String legacyCslCmdName() {",
        "        return legacyCslCmdName;",
        "    }",
        "",
        "    /** Unmodifiable view of all legacy command strings (same as per-constant {@link #legacyCslCmdName()}). */",
        "    public static Map<CGenTbCmdType, String> legacyNameTable() {",
        "        return LEGACY_NAMES;",
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
        help="Path to CGenTbCmdType.java",
    )
    ap.add_argument(
        "--check",
        action="store_true",
        help="Exit 1 if generated text differs from existing output file",
    )
    args = ap.parse_args()

    hdr = (trunk_root() / "csl_gen" / "cGen_Declarations.h").read_text()
    cpp = (trunk_root() / "csl_gen" / "cGenBase_tb.cpp").read_text()
    cmds = parse_ecsl_cmd_type(hdr)
    names = parse_build_cmd_names(cpp)
    text = generate_java(cmds, names)

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
    print(f"Wrote {out} ({len(cmds)} constants)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
