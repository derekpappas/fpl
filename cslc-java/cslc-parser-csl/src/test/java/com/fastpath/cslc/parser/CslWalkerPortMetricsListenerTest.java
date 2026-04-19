package com.fastpath.cslc.parser;

import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class CslWalkerPortMetricsListenerTest {

    @Test
    void minimalCslRecordsSourceTextContext() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/minimal.csl")) {
            assertNotNull(in, "missing /regression/minimal.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        var metrics = new CslWalkerPortMetricsListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, metrics);
        assertTrue(metrics.totalParserRuleEnters() > 0);
        assertTrue(
                metrics.enterCountsByContextClass().getOrDefault("Source_textContext", 0) >= 1,
                "expected ANTLR4 context for rule source_text");
    }
}
