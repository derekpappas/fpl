package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;
import java.util.Optional;

/**
 * Legacy {@code checkMainArgs} / chapter CLI parsing ({@code cGenBase_tb.cpp}, {@code cGen_Consts.h} {@code ARG_HELP}).
 */
public final class CGenTbMainArgs {

    /** Legacy {@code ARG_HELP} in {@code trunk/cslc/trunk/csl_gen/cGen_Consts.h}. */
    public static final String ARG_HELP = "--help";

    /**
     * Legacy usage suffix appended after {@code argv[0]} in {@code checkMainArgs} error messages (trailing newline).
     */
    public static final String USAGE_SUFFIX =
            " [fifo | interconnect | isa | language | memory | memory_map | register | register_file | testbench |"
                    + " verification_components]\n";

    private CGenTbMainArgs() {}

    /**
     * Legacy {@code isValidChapter} ({@code cGenBase_tb.cpp}) — maps the second CLI token to {@link CGenTbChapter}
     * (excluding {@link CGenTbChapter#CPT_ALL}).
     */
    public static Optional<CGenTbChapter> parseChapterName(String chapter) {
        Objects.requireNonNull(chapter, "chapter");
        return switch (chapter) {
            case "fifo" -> Optional.of(CGenTbChapter.CPT_FIFO);
            case "interconnect" -> Optional.of(CGenTbChapter.CPT_INTERCON);
            case "isa" -> Optional.of(CGenTbChapter.CPT_ISA);
            case "language" -> Optional.of(CGenTbChapter.CPT_LANG);
            case "memory" -> Optional.of(CGenTbChapter.CPT_MEM);
            case "memory_map" -> Optional.of(CGenTbChapter.CPT_MEM_MAP);
            case "register" -> Optional.of(CGenTbChapter.CPT_REG);
            case "register_file" -> Optional.of(CGenTbChapter.CPT_REG_FILE);
            case "testbench" -> Optional.of(CGenTbChapter.CPT_TESTB);
            case "verification_components" -> Optional.of(CGenTbChapter.CPT_VERIFC);
            default -> Optional.empty();
        };
    }

    /**
     * Legacy {@code checkMainArgs(argc, argv)}: {@code argv[0]} is the program name; {@code argv.length} must be {@code 1}
     * or {@code 2}. On success, {@code chapter} is {@link CGenTbChapter#CPT_ALL} when only the program name is present.
     */
    public static Result validate(String[] argv) {
        Objects.requireNonNull(argv, "argv");
        int argc = argv.length;
        if (argc < 1 || argc > 2) {
            String prog = argc > 0 ? argv[0] : "(program)";
            return Result.error(
                    "Invalid number of arguments\n" + prog + USAGE_SUFFIX);
        }
        String program = argv[0];
        if (argc == 2) {
            String second = argv[1];
            if (ARG_HELP.equals(second)) {
                return Result.error(program + USAGE_SUFFIX);
            }
            Optional<CGenTbChapter> ch = parseChapterName(second);
            if (ch.isEmpty()) {
                return Result.error("Invalid chapter name\n" + program + USAGE_SUFFIX);
            }
            return Result.ok(ch.get());
        }
        return Result.ok(CGenTbChapter.CPT_ALL);
    }

    /** Outcome of {@link #validate(String[])}. */
    public record Result(boolean ok, CGenTbChapter chapter, String errorLog) {
        private static Result ok(CGenTbChapter chapter) {
            return new Result(true, chapter, "");
        }

        private static Result error(String errorLog) {
            return new Result(false, CGenTbChapter.CPT_ALL, errorLog);
        }
    }
}
