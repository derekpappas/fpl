package com.fastpath.cslc.cslom.legacy;

/**
 * Repository-relative locations of legacy ANTLR2 <em>walker</em> grammars (still in trunk only).
 *
 * <p>These are listed so tooling, docs, and future ports share one canonical string. They are not
 * classpath resources and are not loaded by this module. To list tree-parser rule names for
 * scoping work, run {@code scripts/list_antlr2_rule_headers.py} on each {@code .g} file.
 *
 * @see LegacyAntlrParserSources
 */
public final class LegacyAntlrWalkerSources {

    private LegacyAntlrWalkerSources() {}

    public static final String TRUNK_CSL_WALKER_G = "trunk/cslc/trunk/src/parser/csl/csl.walker.g";

    public static final String TRUNK_VERILOG_WALKER_G = "trunk/cslc/trunk/src/parser/verilog/verilog.walker.g";
}
