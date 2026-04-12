package com.fastpath.cslc.cslgen;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;
import java.util.random.RandomGenerator;

/**
 * Entry point mirroring {@code trunk/cslc/trunk/csl_gen/csl_code_gen.cpp} ({@code main} + {@code CSLdesign}).
 *
 * <p>Pass {@code --print} or {@code -p} to emit generated CSL to standard output after {@link CslGenDesign#buildDecl},
 * like {@code cGen_ao.cpp} after {@code CSLdesign::buildDecl()} + {@code CSLdesign::print()}.
 *
 * <p>Optional {@code --seed &lt;n&gt;} selects a fixed {@link Random} (reproducible output); with no seed, behavior
 * matches unseeded {@link ThreadLocalRandom} use.
 *
 * <p>{@code --ao-batch &lt;dir&gt; [n]} mirrors {@code cGen_ao.cpp} {@code main}: writes {@code n} files (default {@value
 * CslGenAoBatch#LEGACY_DEFAULT_FILE_COUNT}) under {@code dir}/{@link CslGenAoBatch#GEN_TESTS_DIR_NAME} and exits (no
 * single-design stdout path). Optional {@code n} is any string accepted by {@link Integer#parseInt(String)} (including
 * negative values, which are rejected with an error message).
 */
public final class CslCodeGenMain {

    /**
     * Successful or failed CLI parse (no I/O). Package-private for unit tests; {@link #main} maps errors to
     * {@code System.exit(1)}.
     */
    record CliParseResult(
            String errorMessage,
            boolean help,
            boolean print,
            Long seed,
            Path aoBatchDir,
            Integer aoBatchCount) {

        static CliParseResult error(String msg) {
            return new CliParseResult(msg, false, false, null, null, null);
        }

        static CliParseResult helpRequest() {
            return new CliParseResult(null, true, false, null, null, null);
        }

        static CliParseResult ok(boolean print, Long seed, Path aoBatchDir, Integer aoBatchCount) {
            return new CliParseResult(null, false, print, seed, aoBatchDir, aoBatchCount);
        }

        boolean hasError() {
            return errorMessage != null;
        }
    }

    static CliParseResult parseCli(String[] args) {
        boolean print = false;
        Long seed = null;
        Path aoBatchDir = null;
        Integer aoBatchCount = null;
        for (int i = 0; i < args.length; i++) {
            String a = args[i];
            if ("--print".equals(a) || "-p".equals(a)) {
                print = true;
            } else if ("--seed".equals(a)) {
                if (i + 1 >= args.length) {
                    return CliParseResult.error("CslCodeGenMain: --seed requires a long argument");
                }
                i++;
                try {
                    seed = Long.parseLong(args[i]);
                } catch (NumberFormatException e) {
                    return CliParseResult.error("CslCodeGenMain: invalid --seed: " + args[i]);
                }
            } else if ("--ao-batch".equals(a)) {
                if (i + 1 >= args.length) {
                    return CliParseResult.error("CslCodeGenMain: --ao-batch requires a directory path");
                }
                i++;
                aoBatchDir = Paths.get(args[i]);
                if (i + 1 < args.length && isOptionalBatchCountToken(args[i + 1])) {
                    i++;
                    String countStr = args[i];
                    try {
                        int c = Integer.parseInt(countStr);
                        if (c < 0) {
                            return CliParseResult.error("CslCodeGenMain: --ao-batch count must be >= 0");
                        }
                        aoBatchCount = c;
                    } catch (NumberFormatException e) {
                        return CliParseResult.error("CslCodeGenMain: invalid --ao-batch count: " + countStr);
                    }
                }
            } else if ("--help".equals(a) || "-h".equals(a)) {
                return CliParseResult.helpRequest();
            }
        }
        return CliParseResult.ok(print, seed, aoBatchDir, aoBatchCount);
    }

    /** True when {@code token} is a valid {@link Integer#parseInt} argument (e.g. {@code 3}, {@code -1}). */
    private static boolean isOptionalBatchCountToken(String token) {
        try {
            Integer.parseInt(token);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static void main(String[] args) {
        CliParseResult r = parseCli(args);
        if (r.help()) {
            printUsage();
            return;
        }
        if (r.hasError()) {
            System.err.println(r.errorMessage());
            System.exit(1);
        }
        try {
            runFromParsed(r);
        } catch (IOException e) {
            System.err.println("CslCodeGenMain: batch write failed: " + e.getMessage());
            System.exit(1);
        }
    }

    private static void printUsage() {
        System.err.println("Usage: CslCodeGenMain [--print|-p] [--seed <long>] [--ao-batch <dir> [n]]]");
        System.err.println("  --print, -p       Write generated CSL to stdout after buildDecl (single design).");
        System.err.println("  --seed <long>     Fixed RNG seed (java.util.Random).");
        System.err.println("  --ao-batch <dir> [n]  Write n CSL files (default "
                + CslGenAoBatch.LEGACY_DEFAULT_FILE_COUNT + ") under dir/"
                + CslGenAoBatch.GEN_TESTS_DIR_NAME + "/ (cGen_ao.cpp batch mode); then exit.");
    }

    /**
     * Runs generation from a successful {@link CliParseResult}. Package-private for tests (e.g. batch {@link IOException}).
     */
    static void runFromParsed(CliParseResult r) throws IOException {
        RandomGenerator rng = createRng(r.seed());
        if (r.aoBatchDir() != null) {
            int n = r.aoBatchCount() != null ? r.aoBatchCount() : CslGenAoBatch.LEGACY_DEFAULT_FILE_COUNT;
            CslGenAoBatch.writeCslFiles(r.aoBatchDir(), n, rng);
            return;
        }
        CslGenDesign design = new CslGenDesign("design");
        design.buildDecl(rng);
        if (r.print()) {
            StringBuilder out = new StringBuilder();
            design.appendPrintedCsl(out);
            System.out.print(out);
        }
    }

    static RandomGenerator createRng(Long seed) {
        if (seed != null) {
            return new Random(seed);
        }
        ThreadLocalRandom tlr = ThreadLocalRandom.current();
        tlr.nextInt();
        return tlr;
    }

    private CslCodeGenMain() {}
}
