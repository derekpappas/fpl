package com.fastpath.cslc.parser;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

class VerilogWalkerPortMetricsListenerTest {

    @Test
    void emptyModuleRecordsSourceTextContext() {
        var metrics = new VerilogWalkerPortMetricsListener();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                "module m();\nendmodule\n", metrics);
        assertTrue(metrics.totalParserRuleEnters() > 0);
        assertTrue(
                metrics.enterCountsByContextClass().getOrDefault("Source_textContext", 0) >= 1,
                "expected ANTLR4 context for rule source_text");
    }
}
