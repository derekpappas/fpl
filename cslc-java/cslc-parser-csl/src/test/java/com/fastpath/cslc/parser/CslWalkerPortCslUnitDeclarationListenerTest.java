package com.fastpath.cslc.parser;

import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class CslWalkerPortCslUnitDeclarationListenerTest {

    @Test
    void minimalCslTriggersCslUnitDeclarationRule() throws IOException {
        String text;
        try (InputStream in = getClass().getResourceAsStream("/regression/minimal.csl")) {
            assertNotNull(in, "missing /regression/minimal.csl");
            text = new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
        var hook = new CslWalkerPortCslUnitDeclarationListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, hook);
        assertEquals(1, hook.getCslUnitDeclarationEnterCount());
        assertEquals("u", hook.getLastPrimaryUnitIdentifier());
    }
}
