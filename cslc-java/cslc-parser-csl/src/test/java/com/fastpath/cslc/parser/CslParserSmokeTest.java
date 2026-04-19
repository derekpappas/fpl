package com.fastpath.cslc.parser;

import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertNotNull;

class CslParserSmokeTest {

    @Test
    void stubParsesMinimalUnit() {
        ParseTree t = CslParserFacade.parseSourceFileStrict("csl_unit u { } ;\n");
        assertNotNull(t);
    }

    @Test
    void trunkPortParsesEmptySource() {
        ParseTree t = CslParserTrunkPortFacade.parseSourceTextStrict("");
        assertNotNull(t);
    }
}
