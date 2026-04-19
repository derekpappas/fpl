package com.fastpath.cslc.parser;

import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

class CslWalkerPortCommandVerbListenerTest {

    @Test
    void fileLevelNoPrefixRecordsVerbAndReceiver() throws IOException {
        String text = read("/regression/mini_file_command.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("no_prefix", listener.verbsInExitOrder().get(0));
        assertEquals("u", listener.getLastReceiverIdentifier());
    }

    @Test
    void ctorBodyNoPrefixRecordsVerbWithoutReceiver() throws IOException {
        String text = read("/regression/mini_unit_ctor_command.csl");
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(1, listener.getCslCommandExitCount());
        assertEquals("no_prefix", listener.verbsInExitOrder().get(0));
        assertNull(listener.getLastReceiverIdentifier());
    }

    @Test
    void twoFileLevelCommandsPreserveExitOrder() {
        String text =
                """
                a.no_prefix();
                b.no_prefix();
                """;
        var listener = new CslWalkerPortCommandVerbListener();
        CslParserTrunkPortFacade.parseSourceTextStrictAndWalk(text, listener);
        assertEquals(2, listener.getCslCommandExitCount());
        assertEquals("no_prefix", listener.verbsInExitOrder().get(0));
        assertEquals("no_prefix", listener.verbsInExitOrder().get(1));
        assertEquals("b", listener.getLastReceiverIdentifier());
    }

    private static String read(String path) throws IOException {
        try (InputStream in = CslWalkerPortCommandVerbListenerTest.class.getResourceAsStream(path)) {
            assertNotNull(in, "missing resource " + path);
            return new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
    }
}
