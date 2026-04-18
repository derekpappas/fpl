package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.verilog.VerilogParser;
import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class VerilogParserSmokeTest {

    @Test
    void parsesEmptyModuleWithPorts() {
        ParseTree t = VerilogParserFacade.parseSourceTextStrict("module m();\nendmodule\n");
        assertNotNull(t);
        assertTrue(t.getText().contains("endmodule"));
    }

    @Test
    void parsesModuleWithoutPortList() {
        VerilogParser p = VerilogParserFacade.newParser("module m;\nendmodule\n");
        p.removeErrorListeners();
        ParseTree t = p.source_text();
        assertNotNull(t);
    }
}
