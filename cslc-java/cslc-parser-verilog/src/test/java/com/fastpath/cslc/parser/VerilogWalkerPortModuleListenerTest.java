package com.fastpath.cslc.parser;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class VerilogWalkerPortModuleListenerTest {

    @Test
    void emptyModuleTriggersModuleRule() {
        var hook = new VerilogWalkerPortModuleListener();
        VerilogParserTrunkPortFacade.parseSourceTextStrictAndWalk(
                "module m();\nendmodule\n", hook);
        assertEquals(1, hook.getModuleEnterCount());
        assertEquals("m", hook.getLastModuleIdentifier());
    }
}
