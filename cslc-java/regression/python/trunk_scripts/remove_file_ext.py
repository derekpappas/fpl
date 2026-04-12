#!/usr/bin/env python3
"""
Python port of logic from trunk/cslc/trunk/scripts/remove_file_ext.pl (strip last extension, batch copy).

Legacy Perl copied */*/build.xml to *.1.xml. This version uses pathlib and is safe-by-default (dry-run
unless --apply).
"""
from __future__ import annotations

import argparse
import shutil
from pathlib import Path


def find_build_xml_files(root: Path) -> list[Path]:
    return sorted(root.glob("*/*/build.xml"))


def main() -> int:
    p = argparse.ArgumentParser(description="Copy */*/build.xml to sibling build1.xml (legacy remove_file_ext.pl)")
    p.add_argument("root", type=Path, nargs="?", default=Path("."), help="Search root (default .)")
    p.add_argument("--apply", action="store_true", help="Actually copy files; default is dry-run")
    args = p.parse_args()
    root: Path = args.root
    hits = find_build_xml_files(root)
    if not hits:
        print(f"No */*/build.xml under {root.resolve()}")
        return 0
    for src in hits:
        dest = src.with_name(src.stem + "1.xml")
        print(f"{src} -> {dest}")
        if args.apply:
            shutil.copy2(src, dest)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
