package com.fastpath.cslc.parser;

import java.util.Optional;

/**
 * Maps ANTLR4 {@code CslParserTrunkPort} parser rule simple names to {@code csl.walker.g} tree-parser rule labels when
 * they differ (batch 3). Unmapped rules use the same name in both grammars.
 *
 * <p>Trunk walker's {@code csl_declaration} alternative lists {@code csl_interface_declaration} only; the ported
 * parser exposes {@code csl_read_interface_declaration} and {@code csl_write_interface_declaration} as separate rules.
 */
public final class CslTrunkPortAntlrToLegacyWalkerRuleNames {

    private CslTrunkPortAntlrToLegacyWalkerRuleNames() {}

    /**
     * Legacy walker rule simple name for correlation, or empty when the ANTLR4 parser rule name already matches
     * {@code csl.walker.g}.
     */
    public static Optional<String> legacyWalkerRuleSimpleNameForAntlrParserRule(String antlrParserRuleSimpleName) {
        if (antlrParserRuleSimpleName == null) {
            return Optional.empty();
        }
        return switch (antlrParserRuleSimpleName) {
            case "csl_read_interface_declaration", "csl_write_interface_declaration" ->
                    Optional.of("csl_interface_declaration");
            case "csl_const_int_declaration" -> Optional.of("csl_parameter_declaration");
            default -> Optional.empty();
        };
    }
}
