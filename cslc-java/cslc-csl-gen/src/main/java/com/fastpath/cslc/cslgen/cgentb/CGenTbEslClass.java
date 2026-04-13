package com.fastpath.cslc.cslgen.cgentb;

/**
 * Legacy {@code ECSLClass} ({@code trunk/cslc/trunk/csl_gen/cGen_Declarations.h}). Declaration order matches the
 * C++ enum (ordinal = legacy discriminant). {@link #legacyGenericStem()} mirrors {@code cslGenericName} in
 * {@code cGenBase_tb.cpp} ({@code buildGenericNames} / {@code cslTypeName} uses {@code "csl_" + stem}).
 *
 * <p><b>Generated</b> — regenerate with {@code python3 cslc-java/scripts/gen_cgen_tb_esl_class.py}.
 */
public enum CGenTbEslClass {
    CSL_BITRANGE("bitrange"),
    CSL_ENUM("enum"),
    CSL_ENUM_ITEM("enum_item"),
    CSL_EVENT("event"),
    CSL_FIELD("field"),
    CSL_FIFO("fifo"),
    CSL_INTERFACE("interface"),
    CSL_ISA_FIELD("isa_field"),
    CSL_MEMORY("memory"),
    CSL_MEMORY_MAP("memory_map"),
    CSL_MEMORY_MAP_PAGE("memory_map_page"),
    CSL_MULTI_DIM_BITRANGE("multi_dim_bitrange"),
    CSL_PORT("port"),
    CSL_REGISTER("register"),
    CSL_REGISTER_FILE("register_file"),
    CSL_SIGNAL("signal"),
    CSL_SIGNAL_GROUP("signal_group"),
    CSL_STATE_DATA("state_data"),
    CSL_TESTBENCH("testbench"),
    CSL_UNIT("unit"),
    CSL_VECTOR("vector")
    ;

    private final String legacyGenericStem;

    CGenTbEslClass(String legacyGenericStem) {
        this.legacyGenericStem = legacyGenericStem;
    }

    /** Legacy map value in {@code cslGenericName} ({@code cGenBase_tb.cpp}). */
    public String legacyGenericStem() {
        return legacyGenericStem;
    }

    /** Legacy {@code cslTypeName} keyword: {@code "csl_" +} {@link #legacyGenericStem()}. */
    public String legacyCslTypeKeyword() {
        return "csl_" + legacyGenericStem;
    }
}
