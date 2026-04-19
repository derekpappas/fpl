package com.fastpath.cslc.cslom.legacy;

/**
 * Repository-relative locations of legacy ANTLR2 <em>parser and lexer</em> grammars in trunk (still
 * the language source of truth for the old C++ stack).
 *
 * <p>Java uses ANTLR4 grammars under {@code cslc-grammars} ({@code *TrunkPort.g4} syntax ports and
 * {@code *.g4} lexers). Those ports omit C++ {@code { ... }} actions and anything above the
 * mechanical slice of {@code csl.parser.g}. Regenerate trunk-port parsers with
 * {@code cslc-java/scripts/port_trunk_parser_g_to_g4.py}. Lexer parity checks:
 * {@code cslc-java/scripts/audit_trunk_lexer_tokens_vs_g4.py} and
 * {@code cslc-java/scripts/audit_lexer_parser_token_refs.py}. Run all of them together with
 * {@code cslc-java/scripts/verify_antlr4_grammar_port_health.py} (also invoked from {@code antlr_compile_trunk_ports.sh}).
 *
 * <p>These strings are for tooling and documentation; this module does not load the files.
 *
 * @see LegacyAntlrWalkerSources
 */
public final class LegacyAntlrParserSources {

    private LegacyAntlrParserSources() {}

    public static final String TRUNK_CSL_PARSER_G = "trunk/cslc/trunk/src/parser/csl/csl.parser.g";

    public static final String TRUNK_CSL_LEXER_G = "trunk/cslc/trunk/src/parser/csl/csl.lexer.g";

    public static final String TRUNK_VERILOG_PARSER_G = "trunk/cslc/trunk/src/parser/verilog/verilog.parser.g";

    public static final String TRUNK_VERILOG_LEXER_G = "trunk/cslc/trunk/src/parser/verilog/verilog.lexer.g";
}
