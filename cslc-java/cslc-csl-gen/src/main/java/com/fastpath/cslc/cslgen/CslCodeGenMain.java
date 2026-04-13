package com.fastpath.cslc.cslgen;

import java.io.IOException;
import java.io.PrintStream;
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
 * {@code -1}), which are rejected with an error message). A non-integer token after the directory that does not start
 * with {@code '-'} is rejected (invalid count); tokens starting with {@code '-'} that are not valid integers are left
 * unconsumed so they can be parsed as flags.
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
                if (i + 1 < args.length) {
                    String next = args[i + 1];
                    try {
                        int c = Integer.parseInt(next);
                        if (c < 0) {
                            return CliParseResult.error("CslCodeGenMain: --ao-batch count must be >= 0");
                        }
                        aoBatchCount = c;
                        i++;
                    } catch (NumberFormatException e) {
                        if (next.startsWith("-")) {
                            /* e.g. --print; leave for the outer loop */
                        } else {
                            return CliParseResult.error("CslCodeGenMain: invalid --ao-batch count: " + next);
                        }
                    }
                }
            } else if ("--help".equals(a) || "-h".equals(a)) {
                return CliParseResult.helpRequest();
            }
        }
        return CliParseResult.ok(print, seed, aoBatchDir, aoBatchCount);
    }

    public static void main(String[] args) {
        int exit = runMainBody(args, System.err, System.out);
        if (exit != 0) {
            System.exit(exit);
        }
    }

    /**
     * Full CLI run without {@link System#exit(int)} — returns {@code 0} on success, {@code 1} on parse error or batch
     * {@link IOException}. Package-private for tests.
     */
    static int runMainBody(String[] args, PrintStream err, PrintStream out) {
        CliParseResult r = parseCli(args);
        if (r.help()) {
            printUsage(err);
            return 0;
        }
        if (r.hasError()) {
            err.println(r.errorMessage());
            return 1;
        }
        try {
            runFromParsed(r, out);
        } catch (IOException e) {
            err.println("CslCodeGenMain: batch write failed: " + e.getMessage());
            return 1;
        }
        return 0;
    }

    private static void printUsage(PrintStream err) {
        err.println("Usage: CslCodeGenMain [--print|-p] [--seed <long>] [--ao-batch <dir> [n]]]");
        err.println("  --print, -p       Write generated CSL to stdout after buildDecl (single design).");
        err.println("  --seed <long>     Fixed RNG seed (java.util.Random).");
        err.println("  --ao-batch <dir> [n]  Write n CSL files (default "
                + CslGenAoBatch.LEGACY_DEFAULT_FILE_COUNT + ") under dir/"
                + CslGenAoBatch.GEN_TESTS_DIR_NAME + "/ (cGen_ao.cpp batch mode); then exit.");
    }

    /**
     * Runs generation from a successful {@link CliParseResult}. Package-private for tests (e.g. batch {@link IOException}).
     */
    static void runFromParsed(CliParseResult r) throws IOException {
        runFromParsed(r, System.out);
    }

    static void runFromParsed(CliParseResult r, PrintStream out) throws IOException {
        RandomGenerator rng = createRng(r.seed());
        if (r.aoBatchDir() != null) {
            int n = r.aoBatchCount() != null ? r.aoBatchCount() : CslGenAoBatch.LEGACY_DEFAULT_FILE_COUNT;
            CslGenAoBatch.writeCslFiles(r.aoBatchDir(), n, rng);
            return;
        }
        CslGenDesign design = new CslGenDesign("design");
        design.buildDecl(rng);
        if (r.print()) {
            StringBuilder sb = new StringBuilder();
            design.appendPrintedCsl(sb);
            out.print(sb.toString());
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
