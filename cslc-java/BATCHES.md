# CSLC Java — batch roadmap (ANTLR / CSLOM / downstream)

This file is the **canonical batch index** for planning and chat context.  
For grammar-port detail and “next concrete work items,” also read [`ANTLR_PORT_BATCH_PLAN.txt`](ANTLR_PORT_BATCH_PLAN.txt).

## How to use this doc

- **Batch** = theme / epic (may span many PRs).
- **Slice** = shippable unit: one grammar shape or listener exit → typed IR field → `mini_*` fixture → tests (often bridge + strict corpus gate).
- **Size** (rough): **S** days–1 week, **M** weeks–1–2 months, **L** multi-month / program unless parallelized.

---

## Phase A — Grammar & parse (ANTLR4)

| Batch | Name | Size | Summary |
|------:|------|:----:|---------|
| **0** | Grammar toolchain | M | Trunk-port `.g4`, lexers, Maven ANTLR executions, port/audit scripts, token ref audits, `TRUNK_MODULE_MAP` / legacy source paths. |
| **1** | Parse / walk scaffolding | M | TrunkPort facades, `ParseTreeWalker` helpers, listener skeletons, metrics hooks, first rule hooks (e.g. `csl_unit_declaration`, `module`). |
| **7** | Lexer behavioral parity | L | Trunk lexer paths (numbers, identifiers, modes) vs `.g4`; discrepancy fixtures + fixes. |
| **29** | Grammar change policy | S | Versioning / changelog for `.g4` breaks; migration notes for fixtures and consumers. |
| **30** | Parser hardening | M | Timeouts, token/depth limits, friendly errors on pathological input; optional fuzzing hooks. |

---

## Phase B — CSLOM bridge & CSL IR (parser-csl → cslc-cslom)

| Batch | Name | Size | Summary |
|------:|------|:----:|---------|
| **2** | CSLOM bridge (typed stubs → real types) | M | One final class per trunk-port decl shape; `CslWalkerPortParserDeclStubBridgeListener` emits typed nodes; hierarchy under `CslomUnitDecl` / design. |
| **2b** | Bridge metadata hardening | S | **`CslomPlaceholder`:** optional `antlrRuleSimpleName` / `antlrText` + bridge attaches on nameless-unit paths and `emitStub` for placeholders. Tests: `CslomPlaceholderTest`. Named decls unchanged (already via `emitStub` → `CslomNamedDecl`). |
| **3** | CSL declaration refinement | L | Structured fields (widths, dirs, exprs) incrementally; raw text retained until consumers migrate; legacy walker rule map extensions + tests per mapping. |
| **3a** | Enum / list / include slice | S | **Done (CSLOM + bridge + tests):** enum item raw texts; list `eachListParamExprTextLists` + `additionalListDeclaratorNames` + synthetic `_csl_list` when no leading id; include `includeArgumentExpressionText`. Fixtures `mini_enum_*.csl`, `mini_list_*.csl`, `mini_include_with_expr.csl`. |
| **3b** | Remaining decl “body” parity | S | **`csl_testbench_declaration` done:** `CslomTestbenchDecl.unitDefinitionText` + bridge + `mini_testbench_with_body.csl`. Other decls: audit grammar vs bridge when new optional bodies appear. |
| **4** | `csl_unit_definition` body semantics | L | Inst vs ctor vs command in bodies; scope push/pop when symtree/API exists; richer fixtures. |
| **8** | Parser preamble / symtree | M | Java-side equivalents of legacy parser globals; orchestration in `cslc-core` / driver, not grammar-only. |

---

## Phase C — Commands & walker parity

| Batch | Name | Size | Summary |
|------:|------|:----:|---------|
| **5** | Walker command port | L | **Slices:** `param_list_set_width` (`mini_command_set_width.csl`), `param_list_set_depth` (`mini_command_set_depth.csl`), `param_list_create_rtl_module` (`mini_command_create_rtl_module.csl`, zero-arg), `param_list_reverse` (`mini_command_reverse.csl`, zero-arg), `param_list_auto_gen_memory_map` (`mini_command_auto_gen_memory_map.csl`, zero-arg), `param_list_add_to_memory_map` (`mini_command_add_to_memory_map.csl`, zero-arg), `param_list_set_alignment` (`mini_command_set_alignment.csl`, numeric expr), `param_list_set_endianess` (`mini_command_set_endianess.csl`, string expr), `param_list_set_mem_instance_name` (`mini_command_set_mem_instance_name.csl`, string expr), `param_list_set_name` (`mini_command_set_name.csl`, string expr), `param_list_set_type` (`mini_command_set_type.csl`, string expr), `param_list_set_unit_prefix` (`mini_command_set_unit_prefix.csl`, string expr), `param_list_set_signal_prefix` (`mini_command_set_signal_prefix.csl`, string expr), `param_list_set_signal_prefix_local` (`mini_command_set_signal_prefix_local.csl`, string expr), `param_list_directive` (`mini_command_directive.csl`, identifier), `param_list_set_direction` (`mini_command_set_direction.csl`, identifier expr), `param_list_set_number_of_dimensions` (`mini_command_set_number_of_dimensions.csl`, numeric expr), `param_list_set_offset` (`mini_command_set_offset.csl`, numeric expr), `param_list_set_prefix` (`mini_command_set_prefix.csl`, string expr), `param_list_set_reset_name` (`mini_command_set_reset_name.csl`, string expr), `param_list_set_suffix` (`mini_command_set_suffix.csl`, string expr), `param_list_set_radix` (`mini_command_set_radix.csl`, numeric expr), `param_list_set_range` (`mini_command_set_range.csl`, 2 args), `param_list_set_dim_range` (`mini_command_set_dim_range.csl`, 3 args), `param_list_set_dim_offset` (`mini_command_set_dim_offset.csl`, 2 args), `param_list_set_dim_width` (`mini_command_set_dim_width.csl`, 2 args), `param_list_set_dim_bitrange` (`mini_command_set_dim_bitrange.csl`, 2 args), `param_list_set_bitrange` (`mini_command_set_bitrange.csl`, 1 arg), `param_list_set_clock_name` (`mini_command_set_clock_name.csl`, string expr), `param_list_set_rd_clock_name` (`mini_command_set_rd_clock_name.csl`, string expr), `param_list_set_wr_clock_name` (`mini_command_set_wr_clock_name.csl`, string expr), `param_list_set_push_name` (`mini_command_set_push_name.csl`, string expr), `param_list_set_pop_name` (`mini_command_set_pop_name.csl`, string expr), `param_list_set_full_name` (`mini_command_set_full_name.csl`, string expr), `param_list_set_empty_name` (`mini_command_set_empty_name.csl`, string expr), `param_list_set_wr_data_name` (`mini_command_set_wr_data_name.csl`, string expr), `param_list_set_rd_data_name` (`mini_command_set_rd_data_name.csl`, string expr), `param_list_set_data_word_width` (`mini_command_set_data_word_width.csl`, numeric expr), `param_list_set_address_increment` (`mini_command_set_address_increment.csl`, numeric expr), `param_list_set_next_address` (`mini_command_set_next_address.csl`, numeric expr), `param_list_set_top_unit` (`mini_command_set_top_unit.csl`, identifier expr), `param_list_exclusion_list` (`mini_command_exclusion_list.csl`, 2 args), `param_list_include_only` (`mini_command_include_only.csl`, 2 args) — verb listener + decl bridge `CslomCommandDecl.inferredVerb` tests. **Remainder:** other `param_list_*` shapes, tie-break docs, optional CSLOM side effects. |

---

## Phase D — Verilog & CDOM

| Batch | Name | Size | Summary |
|------:|------|:----:|---------|
| **6** | Verilog trunk → design stubs | L | Sealed stubs, `VerilogWalkerPortDesignStubListener`, fixtures under `cslc-parser-verilog`; generate hierarchy, headers, instances, tasks/functions, etc. |
| **6b** | Verilog stub enrichment | M | Finer metadata (ports, attrs, gate kinds) where IR consumers need it. |
| **13** | Stubs → `cslc-cdom` | L | Map Verilog (and later CSL) stubs into CDOM when APIs exist; keep stubs stable as fallback. |

---

## Phase E — Parity, pipeline, product

| Batch | Name | Size | Summary |
|------:|------|:----:|---------|
| **9** | Golden & error parity vs legacy | L | Trunk corpus; compare parse pass/fail + diagnostics; CI-gated diff strategy. |
| **10** | Preprocessor end-to-end | L | Wire `cslc-preproc` into CSL path; ifdef/macro fixtures + golden tests. |
| **11** | Driver / compiler pipeline | L | `cslc-cli` / `cslc-driver`: end-to-end stages, stable error codes, file/line reporting. |
| **12** | CSLOM ↔ legacy parity layer | M | Document intentional gaps; adapters or explicit “not ported” surfaces. |
| **14** | `cslc-csl-gen` alignment | M | Generators track bridge/IR shapes; regression when decl metadata changes. |
| **15** | Design checker / static rules | L | Port trunk checks; start on strict-parse corpus, grow semantic rules. |
| **16** | Regression module expansion | M | `regression/` manifests, dynamic tests, nightly vs PR subsets. |
| **17** | Performance & scale | M | Large files, walker allocations, optional caching; profiling budget. |
| **18** | IDE / language service (optional) | L | Outline, diagnostics, symtree-backed navigation if `cslc-ide` is in scope. |
| **19** | Packaging & distribution | M | Reproducible builds, BOM, internal artifact publishing. |
| **20** | Docs & migration | S | “Add a declaration” playbook; trunk vs Java glossary; link to this file. |
| **21** | API stability / semver | S | Public surface for `cslc-parser-csl`, `cslc-cslom`, grammars jar; deprecation policy. |
| **22** | Property tests / fuzzing | M | Grammar invariants, random token streams, crash-only oracles. |
| **23** | Multi-file compilation | L | Include graph, root file, consistent source names in IR. |
| **24** | Script & tooling parity | M | Python/shell helpers vs trunk scripts; CI wiring. |
| **25** | Compliance & notices | S | Third-party / ANTLR / license rollup in distributions. |
| **26** | Observability (optional) | S | Structured logs, timing spans per phase (parse / walk / gen). |
| **27** | Security & supply chain | S | Dependency audit policy, pinned versions, SBOM if required by org. |
| **28** | Release engineering | M | Signing, tagged releases, changelog automation. |

---

## Quick reference — original plan batch IDs (0–9)

Aligned with [`ANTLR_PORT_BATCH_PLAN.txt`](ANTLR_PORT_BATCH_PLAN.txt):

| ID | Focus |
|----|--------|
| 0 | Grammar toolchain |
| 1 | Parse / walk scaffolding |
| 2 | CSLOM typed bridge |
| 3 | CSL declaration refinement |
| 4 | Unit body (inst / ctor / command) |
| 5 | Walker commands |
| 6 | Verilog → stubs |
| 7 | Lexer parity |
| 8 | Preamble / symtree |
| 9 | Golden & error parity |

Sub-batches **2b**, **3a**, **3b**, **6b** above are **suggested slices** so work stays reviewable.

---

## Suggested default “next three slices”

1. **3a** — enum / list / include structured capture + tests.  
2. **2b** — any remaining decls missing full metadata parity.  
3. **4** (small slice) — one body semantic (e.g. ctor vs inst) + fixture, before full scope stack.

---

*Last expanded: roadmap batches 0–30 and extension batches 10–28; merge or renumber as the project prefers.*
