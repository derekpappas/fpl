package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.csl.CslParserTrunkPort;
import org.antlr.v4.runtime.BailErrorStrategy;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Batch-9 hardening: ensure all committed CSL regression fixtures parse under a strict error strategy.
 *
 * <p>ANTLR's default error recovery can return a parse tree even for syntactically invalid inputs; this test uses
 * {@link BailErrorStrategy} to fail fast on the first syntax error.
 */
class CslTrunkPortStrictRegressionFixturesTest {

    @Test
    void allCslFixturesParseStrictly() throws IOException {
        Path dir = Path.of("src/test/resources/regression");
        assertTrue(Files.isDirectory(dir), "missing regression fixtures dir: " + dir.toAbsolutePath());
        List<Path> files;
        try (var s = Files.list(dir)) {
            files = s.filter(p -> p.getFileName().toString().endsWith(".csl")).sorted().toList();
        }
        assertFalse(files.isEmpty(), "no .csl fixtures found under " + dir.toAbsolutePath());

        for (Path p : files) {
            String text = Files.readString(p, StandardCharsets.UTF_8);
            assertDoesNotThrow(
                    () -> parseStrict(text),
                    () -> "strict parse failed for " + p);
        }
    }

    private static void parseStrict(String text) {
        CslParserTrunkPort parser = CslParserTrunkPortFacade.newParser(text);
        parser.removeErrorListeners();
        parser.setErrorHandler(new BailErrorStrategy());
        parser.source_text();
    }
}

