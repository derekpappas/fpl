package com.fastpath.cslc.regression;

import com.fastpath.cslc.parser.CslParserTrunkPortFacade;
import com.fastpath.cslc.parser.csl.CslParserTrunkPort;
import org.antlr.v4.runtime.BailErrorStrategy;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.junit.jupiter.api.DynamicTest;
import org.junit.jupiter.api.TestFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.DynamicTest.dynamicTest;

/**
 * Batch 9 starter: committed mini-corpus + manifest gating strict ANTLR4 {@code CslParserTrunkPort} parses.
 *
 * <p>Uses {@link BailErrorStrategy} so the first syntax error fails fast (default error recovery would still
 * return a parse tree). Expand {@code parity_csl/} and {@code manifest.tsv} as trunk sample coverage grows.
 */
class CslAntlr4ParityCorpusTest {

    private static final String MANIFEST = "/parity_csl/manifest.tsv";

    @TestFactory
    Stream<DynamicTest> manifestRowsDriveStrictParseExpectations() throws IOException {
        List<ManifestRow> rows = loadManifest();
        List<DynamicTest> tests = new ArrayList<>();
        for (ManifestRow row : rows) {
            String label = row.file + " -> " + row.expect;
            tests.add(
                    dynamicTest(
                            label,
                            () -> {
                                String text = readResource("/parity_csl/" + row.file);
                                if (row.expect == Expect.PASS) {
                                    assertDoesNotThrow(() -> parseStrict(text));
                                } else {
                                    assertThrows(ParseCancellationException.class, () -> parseStrict(text));
                                }
                            }));
        }
        assertTrue(tests.size() >= 2, "manifest should list at least two cases");
        return tests.stream();
    }

    private static List<ManifestRow> loadManifest() throws IOException {
        try (InputStream in = CslAntlr4ParityCorpusTest.class.getResourceAsStream(MANIFEST)) {
            assertTrue(in != null, "missing " + MANIFEST);
            List<ManifestRow> out = new ArrayList<>();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(in, StandardCharsets.UTF_8))) {
                String line;
                while ((line = br.readLine()) != null) {
                    line = line.strip();
                    if (line.isEmpty() || line.startsWith("#")) {
                        continue;
                    }
                    String[] parts = line.split("\t");
                    assertTrue(parts.length == 2, "bad manifest line (need path<TAB>PASS|FAIL): " + line);
                    String file = parts[0].strip();
                    Expect expect = Expect.valueOf(parts[1].strip());
                    out.add(new ManifestRow(file, expect));
                }
            }
            return out;
        }
    }

    private static String readResource(String path) throws IOException {
        try (InputStream in = CslAntlr4ParityCorpusTest.class.getResourceAsStream(path)) {
            assertTrue(in != null, "missing resource " + path);
            return new String(in.readAllBytes(), StandardCharsets.UTF_8);
        }
    }

    private static void parseStrict(String text) {
        CslParserTrunkPort parser = CslParserTrunkPortFacade.newParser(text);
        parser.removeErrorListeners();
        parser.setErrorHandler(new BailErrorStrategy());
        parser.source_text();
    }

    private enum Expect {
        PASS,
        FAIL
    }

    private record ManifestRow(String file, Expect expect) {}
}
