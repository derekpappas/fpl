#!/usr/bin/env python3
"""Deprecated alias for ``list_antlr2_rule_headers.py`` (same behaviour)."""
from __future__ import annotations

import importlib.util
import sys
from pathlib import Path

_target = Path(__file__).resolve().parent / "list_antlr2_rule_headers.py"
_spec = importlib.util.spec_from_file_location("_rule_headers", _target)
assert _spec and _spec.loader
_mod = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_mod)
sys.exit(_mod.main())  # type: ignore[attr-defined]
