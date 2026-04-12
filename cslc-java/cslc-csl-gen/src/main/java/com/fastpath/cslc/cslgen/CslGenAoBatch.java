package com.fastpath.cslc.cslgen;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.random.RandomGenerator;

/**
 * Batch file generation from legacy {@code trunk/cslc/trunk/csl_gen/cGen_ao.cpp} ({@code main}: {@code mkdir gen_tests},
 * loop 50× {@code CSLdesign} {@code buildDecl} + {@code print} to {@code out<i>.csl}).
 */
public final class CslGenAoBatch {

    /** Legacy {@code cGen_ao.cpp} {@code for (i=0;i<50;i++)} file count. */
    public static final int LEGACY_DEFAULT_FILE_COUNT = 50;

    /** Subdirectory created under the user-supplied output path ({@code cGen_ao.cpp} {@code makeDir(..., "gen_tests/", ...)}). */
    public static final String GEN_TESTS_DIR_NAME = "gen_tests";

    private CslGenAoBatch() {}

    /**
     * Creates {@code baseOutputDir}/{@value #GEN_TESTS_DIR_NAME} (if needed) and writes {@code out0}{@link CGenConsts#TEST_EXTENSION}
     * … {@code out(n-1)} with one full design each ({@link CslGenDesign#buildDecl} + {@link CslGenDesign#appendPrintedCsl}).
     *
     * @param baseOutputDir directory under which {@value #GEN_TESTS_DIR_NAME} is created (need not end with {@code '/'} —
     *     unlike the legacy CLI, which required a trailing slash on the argument path)
     * @param fileCount number of files (legacy uses {@code 50})
     */
    public static void writeCslFiles(Path baseOutputDir, int fileCount, RandomGenerator rng) throws IOException {
        if (fileCount < 0) {
            throw new IllegalArgumentException("fileCount must be >= 0");
        }
        Path genTests = baseOutputDir.resolve(GEN_TESTS_DIR_NAME);
        Files.createDirectories(genTests);
        for (int i = 0; i < fileCount; i++) {
            CslGenDesign design = new CslGenDesign("design");
            design.buildDecl(rng);
            StringBuilder out = new StringBuilder();
            design.appendPrintedCsl(out);
            Path file = genTests.resolve("out" + i + CGenConsts.TEST_EXTENSION);
            Files.writeString(file, out.toString(), StandardCharsets.UTF_8);
        }
    }
}
