package com.fastpath.cslc.parser;

import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class VerilogParserTrunkPortResourceTest {

    @Test
    void parsesBundledMinimalVerilog() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/minimal.v")) {
            assertNotNull(in, "missing /regression/minimal.v");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        ParseTree t = VerilogParserTrunkPortFacade.parseSourceTextStrict(text);
        assertNotNull(t);
        assertTrue(t.getText().contains("endmodule"));
    }
}
