package com.fastpath.cslc.parser;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class CslTrunkPortAntlrToLegacyWalkerRuleNamesTest {

    @Test
    void readWriteInterfaceMapToWalkerInterfaceRule() {
        assertEquals(
                "csl_interface_declaration",
                CslTrunkPortAntlrToLegacyWalkerRuleNames.legacyWalkerRuleSimpleNameForAntlrParserRule(
                                "csl_read_interface_declaration")
                        .orElseThrow());
        assertEquals(
                "csl_interface_declaration",
                CslTrunkPortAntlrToLegacyWalkerRuleNames.legacyWalkerRuleSimpleNameForAntlrParserRule(
                                "csl_write_interface_declaration")
                        .orElseThrow());
    }

    @Test
    void constIntMapsToWalkerParameterDeclarationRule() {
        assertEquals(
                "csl_parameter_declaration",
                CslTrunkPortAntlrToLegacyWalkerRuleNames.legacyWalkerRuleSimpleNameForAntlrParserRule(
                                "csl_const_int_declaration")
                        .orElseThrow());
    }

    @Test
    void unmappedRuleReturnsEmpty() {
        assertTrue(
                CslTrunkPortAntlrToLegacyWalkerRuleNames.legacyWalkerRuleSimpleNameForAntlrParserRule(
                                "csl_signal_declaration")
                        .isEmpty());
    }
}
