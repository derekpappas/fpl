#!/usr/bin/env python3
"""
Emit a row per file under trunk/cslc/trunk with conversion category and target Java module hint.
Run from anywhere:  python3 cslc-java/scripts/inventory_trunk.py
Writes: cslc-java/TRUNK_FILE_INVENTORY.tsv and cslc-java/TRUNK_FILE_INVENTORY_SUMMARY.json
Does not modify trunk/.
"""
from __future__ import annotations

import csv
import json
import os
from collections import Counter
from pathlib import Path


def repo_root() -> Path:
    return Path(__file__).resolve().parents[1].parent


def trunk_root() -> Path:
    return repo_root() / "trunk" / "cslc" / "trunk"


def module_hint(rel_posix: str) -> str:
    """Map legacy path (posix, relative to trunk) to cslc-java module artifact id."""
    if rel_posix.startswith("src/"):
        seg = rel_posix.split("/")[1] if "/" in rel_posix else rel_posix
        return {
            "support": "cslc-support",
            "cdom": "cslc-cdom",
            "csim": "cslc-csim",
            "csl_command_shell": "cslc-command-shell",
            "csl_xml_warn_error": "cslc-xml-warn-error",
            "cslc": "cslc-core",
            "cslom": "cslc-cslom",
            "cslom_design_checker": "cslc-design-checker",
            "cslom_generators": "cslc-generators",
            "cslom2cdom_adapter": "cslc-adapter",
            "autorouter": "cslc-autorouter",
            "FastPath": "cslc-fastpath",
            "gui_cslom": "cslc-gui-cslom",
            "ide": "cslc-ide",
            "license": "cslc-license",
            "parser": "cslc-grammars|cslc-parser-csl|cslc-parser-verilog",
            "preproc": "cslc-preproc",
            "aa": "cslc-aa",
            "wincslc": "cslc-wincslc",
        }.get(seg, "cslc-core")
    if rel_posix.startswith("antlr/"):
        return "(reference-only legacy ANTLR2)"
    if rel_posix.startswith("3rd_party_libs/"):
        return "cslc-stringtemplate"
    if rel_posix.startswith("templates/"):
        return "cslc-templates"
    if rel_posix.startswith("systemc/"):
        return "cslc-systemc-assets"
    if rel_posix.startswith("csl_gen/"):
        return "cslc-csl-gen"
    if rel_posix.startswith("driver/"):
        return "cslc-driver"
    if rel_posix.startswith("build_utils/"):
        return "cslc-build-utils"
    if rel_posix.startswith("scripts/"):
        return "cslc-java/regression/python"
    if rel_posix.startswith("include/"):
        return "cslc-support"
    if rel_posix.startswith("libc/"):
        return "cslc-libc-stub"
    if rel_posix.startswith("doc/"):
        return "(docs — keep RST/PDF or port to md later)"
    if rel_posix.startswith("build/"):
        return "(build output — do not port)"
    if rel_posix.startswith("old_src/"):
        return "(archived — do not port)"
    return "cslc-core"


def classify(rel: Path) -> str:
    name = rel.name.lower()
    suf = rel.suffix.lower()
    posix = rel.as_posix().lower()

    if posix.startswith("build/") or "/debug/" in posix or "/release/" in posix:
        return "BUILD_TREE_OR_OUTPUT"
    if suf in (".pdb", ".idb", ".obj", ".o", ".a", ".lib", ".exe", ".dll", ".so", ".dylib", ".class"):
        return "BINARY_BUILD_ARTIFACT"
    if suf in (".vcproj", ".sln", ".user", ".suo", ".ncb", ".dep"):
        return "IDE_PROJECT_FILE"
    if posix.startswith("antlr/"):
        return "VENDOR_ANTLR2"
    if posix.startswith("old_src/"):
        return "ARCHIVED_SOURCE"
    if suf in (".cpp", ".cc", ".cxx"):
        return "PORT_CPP_TO_JAVA"
    if suf in (".h", ".hpp"):
        return "PORT_HEADER_TO_JAVA"
    if suf == ".g":
        return "PORT_GRAMMAR_TO_G4"
    if suf == ".g4":
        return "ANTLR4_GRAMMAR"
    if suf == ".java" and "antlr" in posix:
        return "LEGACY_JAVA_TOOL_SOURCES"
    if suf == ".java":
        return "JAVA_SOURCE_REVIEW"
    if suf == ".tmpl":
        return "TEMPLATE_TO_RESOURCE_OR_ST"
    if suf == ".pl":
        return "SCRIPT_TO_PYTHON"
    if suf in (".sh", ".bat", ".bsh"):
        return "SCRIPT_TO_PYTHON_OR_SHELL"
    if suf in (".xml",):
        if "build" in posix or "history" in posix:
            return "BUILD_METADATA_XML"
        return "CONFIG_XML"
    if suf in (".xsl",):
        return "XSL_TRANSFORM"
    if suf in (".htm", ".html"):
        return "STATIC_HTML"
    if suf in (".png", ".gif", ".jpg", ".jpeg", ".ico"):
        return "BINARY_IMAGE"
    if suf in (".rst", ".rtf"):
        return "DOCUMENTATION"
    if suf == ".pdf":
        return "DOCUMENTATION_PDF"
    if suf == ".txt" and "windows_output" in name:
        return "LOG_OR_NOTES"
    if suf == ".txt":
        return "TEXT_RESOURCE"
    if suf == ".csl":
        return "CSL_FIXTURE"
    if suf == ".ui":
        return "QT_UI_TO_JAVAFX"
    if suf == ".pro":
        return "QMAKE_PROJECT"
    if suf in (".doxy",):
        return "DOXYGEN_CONFIG"
    if suf in (".gcno", ".gcda"):
        return "GCOV_ARTIFACT"
    if name == ".ds_store":
        return "OS_METADATA"
    return "OTHER"


def main() -> int:
    root = trunk_root()
    if not root.is_dir():
        print(f"Missing trunk tree: {root}")
        return 1

    out_tsv = Path(__file__).resolve().parents[1] / "TRUNK_FILE_INVENTORY.tsv"
    out_json = Path(__file__).resolve().parents[1] / "TRUNK_FILE_INVENTORY_SUMMARY.json"

    rows: list[dict[str, str]] = []
    cats: Counter[str] = Counter()

    for dirpath, dirnames, filenames in os.walk(root):
        # skip nothing — user asked for every file
        for fn in filenames:
            p = Path(dirpath) / fn
            try:
                rel = p.relative_to(root)
            except ValueError:
                continue
            rel_posix = rel.as_posix()
            try:
                size = str(p.stat().st_size)
            except OSError:
                size = ""
            cat = classify(rel)
            cats[cat] += 1
            rows.append(
                {
                    "path": rel_posix,
                    "ext": p.suffix.lower() or "(noext)",
                    "bytes": size,
                    "category": cat,
                    "target_module_hint": module_hint(rel_posix),
                }
            )

    rows.sort(key=lambda r: r["path"])

    with out_tsv.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["path", "ext", "bytes", "category", "target_module_hint"], delimiter="\t")
        w.writeheader()
        w.writerows(rows)

    summary = {
        "trunk_root": str(root),
        "file_count": len(rows),
        "by_category": dict(cats.most_common()),
    }
    out_json.write_text(json.dumps(summary, indent=2), encoding="utf-8")

    print(f"Wrote {out_tsv} ({len(rows)} files)")
    print(f"Wrote {out_json}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
