# Known bugs and technical debt

This document tracks defects found during the C++ → Java port and trunk audits.  
Update status as items are fixed.

## Fixed (reference)

| ID | Area | Issue | Resolution |
|----|------|--------|------------|
| TB-1 | `trunk/cslc/trunk/csl_gen/cslGen_TB.cpp` | Bitrange form 2 printed **upper** bound for both lower and upper parameters. | Use `m_bLower` / `m_bUpper` in `printBitrangeDeclLower` / `printBitrangeDeclUpper`. |
| TB-2 | `cslGen_TB.cpp` | Signal form 8 tested **`m_sBitrange == NULL`** after setting **`m_sCopyOf`** (copy branch never worked). | Test **`m_sCopyOf == NULL`**. |
| TB-3 | `cslGen_TB.cpp` / `.h` | **`addPort`** declared but not defined (link error if used). | Implemented `addPort`; **`newNameIsValid`** also checks **`m_dPorts`**. |
| TB-4 | `cslc-csl-gen` `tb` package | Java had mirrored TB-1/TB-2/TB-3 (stub / comments). | Aligned with fixed C++; tests added for `addPort`. |

## Fixed — trunk `csl_enum_field.cpp` (C++)

| ID | Issue | Resolution |
|----|--------|------------|
| EF-1 | **`CSLenum::buildDecl`** returned **`bool`** without **`return`**. | **`return true;`** at end of function. |
| EF-2 | **`CSLenumItem::buildDecl`** same. | **`return true;`** at end. |
| EF-3 | **`CSLfield::buildSet`**: no **`return`**; **`switch`** missing **`break`** (fall-through); LOWER_UPPER did not assign **`m_fieldLower`/`m_fieldUpper`** before print. | Per-case **`break;`**; assign fields; **`return true;`**. |
| EF-4 | **`CSLfield::buildDecl`**: **`rand() % 1`** always 0; empty **`if (c==0)`** so **`buildSet()`** never ran. | Call **`buildSet()`** each loop iteration; **`(void)design`** silences unused parameter. |
| EF-5 | **`CSL_FIELD_DECL_COPY`** used an uninitialized **`CSLfield*`**. | **`printFieldDeclE()`** fallback; **`CSL_FIELD_DECL_OBJECT`** now **`printFieldDeclE()`** instead of falling through. |

## Open — trunk TODO / deprecation (not runtime bugs)

| ID | Location | Note |
|----|----------|------|
| TD-1 | `csl_gen_base.h`, `cslInterconnectGen_TB.h`, `csl_gen.h` | TODO: replace raw pointers with refcounted types. |
| TD-2 | `csl_gen.h`, `csl_gen.cpp`, `csl_gen_design.cpp` | `FIXME DEP 2010-01-15` **`addIsaInstrFormat()`** stubbed / commented. |
| TD-3 | `cslGenEnumFieldEM.h` | `TODO: FIX ME-DEP` **`CSL_FIELD_MAX`**, **`CSL_FIELD_FUNCTION_MAX`**. |

## Java port — hygiene

| ID | Note |
|----|------|
| JV-1 | Prefer grep for **`TODO`/`FIXME`** in `cslc-java` when adding features; currently few markers — add near intentional gaps. |

## Porting map — `csl_enum_field.cpp` vs Java

| Topic | Detail |
|--------|--------|
| Alternate C++ path | `trunk/cslc/trunk/csl_gen/csl_enum_field.cpp` defines another **`CSLenum` / `CSLenumItem` / `CSLfield`** + **`CSLdesign::addEnum` / `addField`** (see EF-* fixes in this doc). |
| Canonical Java port | Interconnect + **`cslField` / `cslGenEnumFieldEM`**: **`CslGenEnum`**, **`CslGenEnumItem`**, **`CslGenField`**, **`CslGenDesign.addEnum` / `addField`**. |
| Tests | **`CslGenEnumFieldTraceTest`** (in `cslc-csl-gen`) asserts stable print invariants with fixed RNG seeds. |

---

**Inventory:** regenerate file lists with `python3 cslc-java/scripts/inventory_trunk.py`.

**cgentb codegen:** `python3 cslc-java/scripts/gen_cgen_tb_cmd_type.py` refreshes `CGenTbCmdType.java`;
`python3 cslc-java/scripts/gen_cgen_tb_esl_class.py` refreshes `CGenTbEslClass.java`. Building `cslc-csl-gen` runs both with
`--check` during the Maven `validate` phase (skip with `-Dcgentb.codegen.skip=true` if `trunk/` is absent).

**csl_gen C++ backlog (filtered):** after regenerating the inventory, `docs/TRUNK_CSL_GEN_PORT_CPP_BACKLOG.tsv` lists rows with
`category=PORT_CPP_TO_JAVA` and `target_module_hint=cslc-csl-gen` (26 paths as of last refresh).
