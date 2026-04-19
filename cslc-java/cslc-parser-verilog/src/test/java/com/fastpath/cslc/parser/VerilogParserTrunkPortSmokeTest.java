package com.fastpath.cslc.parser;

import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class VerilogParserTrunkPortSmokeTest {

    @Test
    void trunkPortParsesEmptyModule() {
        ParseTree t = VerilogParserTrunkPortFacade.parseSourceTextStrict("module m();\nendmodule\n");
        assertNotNull(t);
        assertTrue(t.getText().contains("endmodule"));
    }
}
