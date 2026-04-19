package com.fastpath.cslc.parser;

import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class CslParserTrunkPortResourceTest {

    @Test
    void parsesBundledMinimalCsl() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/minimal.csl")) {
            assertNotNull(in, "missing /regression/minimal.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        ParseTree t = CslParserTrunkPortFacade.parseSourceTextStrict(text);
        assertNotNull(t);
        assertTrue(t.getText().contains("csl_unit"));
    }
}
