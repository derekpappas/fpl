#!/usr/bin/env python3
"""
One row per file under trunk/cslc/misc with conversion category (not all become Java).
Writes: cslc-java/MISC_FILE_INVENTORY.tsv and MISC_FILE_INVENTORY_SUMMARY.json
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


def misc_root() -> Path:
    return repo_root() / "trunk" / "cslc" / "misc"


def top_segment(rel_posix: str) -> str:
    return rel_posix.split("/")[0] if "/" in rel_posix else rel_posix


def action_hint(rel: Path, cat: str) -> str:
    posix = rel.as_posix()
    if cat.startswith("LEGAL"):
        return "keep_reference_only"
    if cat == "GENERATED_TEST_ARTIFACT":
        return "cslc-java/regression/python fixtures or delete from port scope"
    if cat == "EDITOR_DOTFILES":
        return "developer_environment_not_product_code"
    if "projects/" in posix and cat == "SOURCE_CPP":
        return "optional_separate_repo_or_examples_not_core_compiler"
    if cat == "DOCUMENTATION":
        return "docs_site_or_asciidoc_later"
    if cat == "SCRIPT_PERL_OR_SHELL":
        return "cslc-java/regression/python"
    if cat in ("PORT_CPP_TO_JAVA", "PORT_HEADER_TO_JAVA"):
        return "nearest_cslc_java_module_per_domain"
    return "see_MISC_PORT_MAP_txt"


def classify(rel: Path) -> str:
    posix = rel.as_posix().lower()
    suf = rel.suffix.lower()
    name = rel.name.lower()
    seg = top_segment(rel.as_posix())

    if seg == "patents":
        return "LEGAL_ARCHIVE_PAGES_KEY"
    if seg == "generated-test":
        return "GENERATED_TEST_ARTIFACT"
    if seg == "support" and ("emacs" in posix or posix.endswith(".el")):
        return "EDITOR_DOTFILES"
    if seg == "support":
        return "BUILD_SUPPORT_RTF_OR_TEXT"
    if seg in ("docs", "test_docs", "build_instructions"):
        return "DOCUMENTATION"
    if seg == "prj_management":
        return "PROJECT_METADATA_XML"
    if seg == "specs":
        return "SPEC_TEXT"
    if suf in (".cpp", ".cc", ".cxx") and "projects" in posix:
        return "SOURCE_CPP"
    if suf in (".h", ".hpp") and "projects" in posix:
        return "SOURCE_HEADER"
    if suf in (".v", ".sv", ".vh", ".vf") or suf == ".vhd":
        return "HDL_REFERENCE_OR_GENERATED"
    if suf == ".csl":
        return "CSL_FIXTURE"
    if suf in (".pl", ".sh", ".bat"):
        return "SCRIPT_PERL_OR_SHELL"
    if suf in (".xml",) and "planner" in posix:
        return "PROJECT_METADATA_XML"
    if suf in (".xml",):
        return "XML_DATA"
    if suf in (".png", ".jpg", ".jpeg", ".gif", ".ico", ".pdf"):
        return "BINARY_ASSET"
    if suf in (".pages",) or name.endswith(".key"):
        return "IWORK_BUNDLE"
    if suf in (".rtf", ".txt", ".csv", ".log"):
        return "TEXT_OR_LOG"
    if suf in (".tmpl",):
        return "TEMPLATE_FILE"
    if suf in (".asm",):
        return "ASSEMBLY_TEST"
    if suf in (".java",):
        return "JAVA_FILE_MISC"
    if suf in (".makefile",) or name == "makefile" or name.endswith("makefile"):
        return "MAKEFILE"
    if suf in (".o", ".a", ".so", ".dylib", ".exe", ".dll"):
        return "BINARY_BUILD_ARTIFACT"
    if suf in (".class",):
        return "JAVA_CLASS_ARTIFACT"
    if name == ".ds_store":
        return "OS_METADATA"
    return "OTHER"


def main() -> int:
    root = misc_root()
    if not root.is_dir():
        print(f"Missing: {root}")
        return 1

    out_tsv = Path(__file__).resolve().parents[1] / "MISC_FILE_INVENTORY.tsv"
    out_json = Path(__file__).resolve().parents[1] / "MISC_FILE_INVENTORY_SUMMARY.json"

    rows: list[dict[str, str]] = []
    cats: Counter[str] = Counter()
    tops: Counter[str] = Counter()

    for dirpath, _, filenames in os.walk(root):
        for fn in filenames:
            p = Path(dirpath) / fn
            try:
                rel = p.relative_to(root)
            except ValueError:
                continue
            rel_posix = rel.as_posix()
            tops[top_segment(rel_posix)] += 1
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
                    "top_dir": top_segment(rel_posix),
                    "action_hint": action_hint(rel, cat),
                }
            )

    rows.sort(key=lambda r: r["path"])
    with out_tsv.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(
            f,
            fieldnames=["path", "ext", "bytes", "category", "top_dir", "action_hint"],
            delimiter="\t",
        )
        w.writeheader()
        w.writerows(rows)

    summary = {
        "misc_root": str(root),
        "file_count": len(rows),
        "by_category": dict(cats.most_common()),
        "by_top_level_dir": dict(tops.most_common(40)),
    }
    out_json.write_text(json.dumps(summary, indent=2), encoding="utf-8")
    print(f"Wrote {out_tsv} ({len(rows)} files)")
    print(f"Wrote {out_json}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
