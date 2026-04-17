package com.fastpath.cslc.cslgen.cgentb;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * Legacy {@code buildGenericNames} / {@code buildCmdNames} ({@code cGenBase_tb.cpp}): maps from string keys to
 * {@link CGenTbEslClass} / {@link CGenTbCmdType}. Java stores names on the enums; this type exposes the same reverse lookups
 * C++ kept in {@code cslGenericName} / {@code cslCmdName}.
 */
public final class CGenTbContainers {

    private static final class Holder {
        static final CGenTbContainers INSTANCE = build();
    }

    private final Map<String, CGenTbEslClass> eslByGenericStem;
    private final Map<String, CGenTbEslClass> eslByCslTypeKeyword;
    private final Map<String, CGenTbCmdType> cmdByLegacyName;
    private final Map<CGenTbEslClass, CGenTbChapter> chapterByEslClass;

    private CGenTbContainers(
            Map<String, CGenTbEslClass> eslByGenericStem,
            Map<String, CGenTbEslClass> eslByCslTypeKeyword,
            Map<String, CGenTbCmdType> cmdByLegacyName,
            Map<CGenTbEslClass, CGenTbChapter> chapterByEslClass) {
        this.eslByGenericStem = eslByGenericStem;
        this.eslByCslTypeKeyword = eslByCslTypeKeyword;
        this.cmdByLegacyName = cmdByLegacyName;
        this.chapterByEslClass = chapterByEslClass;
    }

    private static CGenTbContainers build() {
        Map<String, CGenTbEslClass> byStem = new HashMap<>();
        Map<String, CGenTbEslClass> byKw = new HashMap<>();
        for (CGenTbEslClass e : CGenTbEslClass.values()) {
            putUnique(byStem, e.legacyGenericStem(), e, "duplicate legacyGenericStem");
            putUnique(byKw, e.legacyCslTypeKeyword(), e, "duplicate legacyCslTypeKeyword");
        }
        Map<String, CGenTbCmdType> byCmd = new HashMap<>();
        for (CGenTbCmdType t : CGenTbCmdType.values()) {
            putUnique(byCmd, t.legacyCslCmdName(), t, "duplicate legacyCslCmdName");
        }
        Map<CGenTbEslClass, CGenTbChapter> chapterBy = new HashMap<>();
        // Legacy CSLClass constructors in cGenBase_tb.cpp: these are the chapter associations for each ESL class.
        chapterBy.put(CGenTbEslClass.CSL_BITRANGE, CGenTbChapter.CPT_LANG);
        chapterBy.put(CGenTbEslClass.CSL_ENUM, CGenTbChapter.CPT_LANG);
        chapterBy.put(CGenTbEslClass.CSL_ENUM_ITEM, CGenTbChapter.CPT_LANG);
        chapterBy.put(CGenTbEslClass.CSL_EVENT, CGenTbChapter.CPT_LANG);
        chapterBy.put(CGenTbEslClass.CSL_FIELD, CGenTbChapter.CPT_LANG);
        chapterBy.put(CGenTbEslClass.CSL_MULTI_DIM_BITRANGE, CGenTbChapter.CPT_LANG);
        chapterBy.put(CGenTbEslClass.CSL_FIFO, CGenTbChapter.CPT_FIFO);
        chapterBy.put(CGenTbEslClass.CSL_INTERFACE, CGenTbChapter.CPT_INTERCON);
        chapterBy.put(CGenTbEslClass.CSL_PORT, CGenTbChapter.CPT_INTERCON);
        chapterBy.put(CGenTbEslClass.CSL_SIGNAL, CGenTbChapter.CPT_INTERCON);
        chapterBy.put(CGenTbEslClass.CSL_SIGNAL_GROUP, CGenTbChapter.CPT_INTERCON);
        chapterBy.put(CGenTbEslClass.CSL_TESTBENCH, CGenTbChapter.CPT_TESTB);
        chapterBy.put(CGenTbEslClass.CSL_UNIT, CGenTbChapter.CPT_INTERCON);
        chapterBy.put(CGenTbEslClass.CSL_ISA_FIELD, CGenTbChapter.CPT_ISA);
        chapterBy.put(CGenTbEslClass.CSL_MEMORY, CGenTbChapter.CPT_MEM);
        chapterBy.put(CGenTbEslClass.CSL_MEMORY_MAP, CGenTbChapter.CPT_MEM_MAP);
        chapterBy.put(CGenTbEslClass.CSL_MEMORY_MAP_PAGE, CGenTbChapter.CPT_MEM_MAP);
        chapterBy.put(CGenTbEslClass.CSL_REGISTER, CGenTbChapter.CPT_REG);
        chapterBy.put(CGenTbEslClass.CSL_REGISTER_FILE, CGenTbChapter.CPT_REG_FILE);
        chapterBy.put(CGenTbEslClass.CSL_STATE_DATA, CGenTbChapter.CPT_VERIFC);
        chapterBy.put(CGenTbEslClass.CSL_VECTOR, CGenTbChapter.CPT_VERIFC);
        return new CGenTbContainers(
                Collections.unmodifiableMap(byStem),
                Collections.unmodifiableMap(byKw),
                Collections.unmodifiableMap(byCmd),
                Collections.unmodifiableMap(chapterBy));
    }

    private static <T> void putUnique(Map<String, T> map, String key, T val, String what) {
        Objects.requireNonNull(key, "key");
        T old = map.put(key, val);
        if (old != null) {
            throw new IllegalStateException(what + ": " + key);
        }
    }

    /** Loads lookup tables (idempotent). */
    public static CGenTbContainers get() {
        return Holder.INSTANCE;
    }

    /** Legacy {@code cslGenericName} value → class (stem only, e.g. {@code "fifo"}). */
    public CGenTbEslClass eslClassForLegacyGenericStem(String stem) {
        return eslByGenericStem.get(stem);
    }

    /** Legacy {@code cslTypeName} keyword → class (e.g. {@code "csl_fifo"}). */
    public CGenTbEslClass eslClassForLegacyCslTypeKeyword(String keyword) {
        return eslByCslTypeKeyword.get(keyword);
    }

    /** Legacy {@code cslCmdName} string → command. */
    public CGenTbCmdType cmdTypeForLegacyName(String legacyCmdName) {
        return cmdByLegacyName.get(legacyCmdName);
    }

    /** Legacy {@code CSLClass.getChapter()} association for this kind. */
    public CGenTbChapter chapterForEslClass(CGenTbEslClass kind) {
        return chapterByEslClass.get(Objects.requireNonNull(kind, "kind"));
    }

    /** Legacy {@code buildObjNames}: {@code stem + "_obj"}. */
    public String legacyObjName(CGenTbEslClass kind) {
        return Objects.requireNonNull(kind, "kind").legacyGenericStem() + "_obj";
    }

    /** Legacy {@code buildObjNames}: {@code stem + "1"}. */
    public String legacyObj1Name(CGenTbEslClass kind) {
        return Objects.requireNonNull(kind, "kind").legacyGenericStem() + "1";
    }

    /** Legacy {@code buildObjNames}: {@code stem + "2"}. */
    public String legacyObj2Name(CGenTbEslClass kind) {
        return Objects.requireNonNull(kind, "kind").legacyGenericStem() + "2";
    }

    /** Legacy {@code buildObjNames}: {@code stem + "_param"}. */
    public String legacyParamName(CGenTbEslClass kind) {
        return Objects.requireNonNull(kind, "kind").legacyGenericStem() + "_param";
    }

    /** Legacy {@code buildObjNames}: {@code stem + "_inst"}. */
    public String legacyInst1Name(CGenTbEslClass kind) {
        return Objects.requireNonNull(kind, "kind").legacyGenericStem() + "_inst";
    }
}
