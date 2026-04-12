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
 * single-design stdout path).
 */
public final class CslCodeGenMain {

    public static void main(String[] args) {
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
                    System.err.println("CslCodeGenMain: --seed requires a long argument");
                    System.exit(1);
                }
                try {
                    seed = Long.parseLong(args[++i]);
                } catch (NumberFormatException e) {
                    System.err.println("CslCodeGenMain: invalid --seed: " + args[i]);
                    System.exit(1);
                }
            } else if ("--ao-batch".equals(a)) {
                if (i + 1 >= args.length) {
                    System.err.println("CslCodeGenMain: --ao-batch requires a directory path");
                    System.exit(1);
                }
                aoBatchDir = Paths.get(args[++i]);
                if (i + 1 < args.length && !args[i + 1].startsWith("-")) {
                    String countStr = args[++i];
                    try {
                        aoBatchCount = Integer.parseInt(countStr);
                        if (aoBatchCount < 0) {
                            System.err.println("CslCodeGenMain: --ao-batch count must be >= 0");
                            System.exit(1);
                        }
                    } catch (NumberFormatException e) {
                        System.err.println("CslCodeGenMain: invalid --ao-batch count: " + countStr);
                        System.exit(1);
                    }
                }
            } else if ("--help".equals(a) || "-h".equals(a)) {
                System.err.println("Usage: CslCodeGenMain [--print|-p] [--seed <long>] [--ao-batch <dir> [n]]]");
                System.err.println("  --print, -p       Write generated CSL to stdout after buildDecl (single design).");
                System.err.println("  --seed <long>     Fixed RNG seed (java.util.Random).");
                System.err.println("  --ao-batch <dir> [n]  Write n CSL files (default "
                        + CslGenAoBatch.LEGACY_DEFAULT_FILE_COUNT + ") under dir/"
                        + CslGenAoBatch.GEN_TESTS_DIR_NAME + "/ (cGen_ao.cpp batch mode); then exit.");
                return;
            }
        }
        RandomGenerator rng = createRng(seed);
        if (aoBatchDir != null) {
            int n = aoBatchCount != null ? aoBatchCount : CslGenAoBatch.LEGACY_DEFAULT_FILE_COUNT;
            try {
                CslGenAoBatch.writeCslFiles(aoBatchDir, n, rng);
            } catch (IOException e) {
                System.err.println("CslCodeGenMain: batch write failed: " + e.getMessage());
                System.exit(1);
            }
            return;
        }
        CslGenDesign design = new CslGenDesign("design");
        design.buildDecl(rng);
        if (print) {
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
