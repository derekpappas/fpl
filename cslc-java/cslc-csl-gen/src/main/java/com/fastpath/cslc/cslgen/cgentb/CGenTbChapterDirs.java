package com.fastpath.cslc.cslgen.cgentb;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;
import java.util.Objects;
import java.util.stream.Stream;

/**
 * Legacy {@code buildDirName} / {@code buildValidInvalidDirs} / {@code buildMakeDirs} ({@code cGenBase_tb.cpp}): per-chapter
 * directory name stems under {@code absoluteTestPath} (test-gen root), with {@code ETestGen} ordinal suffix and
 * {@code _valid} / {@code _invalid} leaves (C++ uses {@code mkdir} on {@code path + dirName + suffix}).
 *
 * <p>Legacy {@code executeClean} removes matching immediate children before {@code buildMakeDirs}; use
 * {@link #purgeLeavesMatchingTestGen}.
 */
public final class CGenTbChapterDirs {

    private CGenTbChapterDirs() {}

    /**
     * Legacy {@code string(name).append(intToString(tgType))} without the leading slash — e.g. {@code csl_fifo_cg0} for
     * {@link CGenTbChapter#CPT_FIFO} and {@link CGenTbTestGen#TG_DECLARATION}.
     */
    public static String chapterWorkspaceBaseName(CGenTbChapter chapter, CGenTbTestGen tgType) {
        Objects.requireNonNull(chapter, "chapter");
        Objects.requireNonNull(tgType, "tgType");
        if (chapter == CGenTbChapter.CPT_ALL) {
            throw new IllegalArgumentException("CPT_ALL has no chapter workspace stem");
        }
        return chapterStem(chapter) + tgType.ordinal();
    }

    /** {@code chapterWorkspaceBaseName + "_valid"} (no trailing slash). */
    public static String validLeafName(CGenTbChapter chapter, CGenTbTestGen tgType) {
        return chapterWorkspaceBaseName(chapter, tgType) + "_valid";
    }

    /** {@code chapterWorkspaceBaseName + "_invalid"} (no trailing slash). */
    public static String invalidLeafName(CGenTbChapter chapter, CGenTbTestGen tgType) {
        return chapterWorkspaceBaseName(chapter, tgType) + "_invalid";
    }

    public static Path validDir(Path absoluteTestGenRoot, CGenTbChapter chapter, CGenTbTestGen tgType) {
        return absoluteTestGenRoot.resolve(validLeafName(chapter, tgType));
    }

    public static Path invalidDir(Path absoluteTestGenRoot, CGenTbChapter chapter, CGenTbTestGen tgType) {
        return absoluteTestGenRoot.resolve(invalidLeafName(chapter, tgType));
    }

    /**
     * Creates {@link #validDir} and {@link #invalidDir} for chapters selected by {@code filter}: {@link CGenTbChapter#CPT_ALL}
     * mirrors {@code testChapter == CPT_ALL} (all chapters); otherwise only that chapter — legacy {@code buildDirName}
     * {@code if (testChapter == CPT_ALL || testChapter == cpt)}. Writes {@link CGenTbRegressionCtrl} in each leaf (legacy
     * {@code createRegressionCtrl} after {@code mkdir}). Does not call {@link #purgeLeavesMatchingTestGen} itself;
     * {@link CGenTbRunStub} runs purge before this when mirroring full legacy startup.
     */
    public static void ensureChapterValidInvalidDirs(
            Path absoluteTestGenRoot, CGenTbTestGen tgType, CGenTbChapter filter) throws IOException {
        Objects.requireNonNull(absoluteTestGenRoot, "absoluteTestGenRoot");
        Objects.requireNonNull(tgType, "tgType");
        Objects.requireNonNull(filter, "filter");
        if (filter == CGenTbChapter.CPT_ALL) {
            for (CGenTbChapter ch : CGenTbChapter.values()) {
                if (ch == CGenTbChapter.CPT_ALL) {
                    continue;
                }
                Path v = validDir(absoluteTestGenRoot, ch, tgType);
                Path inv = invalidDir(absoluteTestGenRoot, ch, tgType);
                Files.createDirectories(v);
                CGenTbRegressionCtrl.write(v, true);
                Files.createDirectories(inv);
                CGenTbRegressionCtrl.write(inv, false);
            }
            return;
        }
        Path v = validDir(absoluteTestGenRoot, filter, tgType);
        Path inv = invalidDir(absoluteTestGenRoot, filter, tgType);
        Files.createDirectories(v);
        CGenTbRegressionCtrl.write(v, true);
        Files.createDirectories(inv);
        CGenTbRegressionCtrl.write(inv, false);
    }

    /**
     * Same as {@link #ensureChapterValidInvalidDirs(Path, CGenTbTestGen, CGenTbChapter)} with {@link CGenTbChapter#CPT_ALL}.
     */
    public static void ensureAllChapterValidInvalidDirs(Path absoluteTestGenRoot, CGenTbTestGen tgType) throws IOException {
        ensureChapterValidInvalidDirs(absoluteTestGenRoot, tgType, CGenTbChapter.CPT_ALL);
    }

    /**
     * Legacy {@code executeClean} glob fragment {@code "/*_cg" + tg + "_*"} — see {@link #purgeLeavesMatchingTestGen} for the
     * Java deletion policy on immediate children.
     */
    public static String cleanGlobFragment(CGenTbTestGen tgType) {
        Objects.requireNonNull(tgType, "tgType");
        return "/*_cg" + tgType.ordinal() + "_*";
    }

    /**
     * Legacy {@code executeClean}: under {@code absoluteTestGenRoot}, delete each immediate child whose file name contains
     * {@code "_cg" + tgType.ordinal() + "_"} (same selection as {@link #cleanGlobFragment} for typical generated names).
     * No-op if {@code absoluteTestGenRoot} is missing or not a directory.
     */
    public static void purgeLeavesMatchingTestGen(Path absoluteTestGenRoot, CGenTbTestGen tgType) throws IOException {
        Objects.requireNonNull(absoluteTestGenRoot, "absoluteTestGenRoot");
        Objects.requireNonNull(tgType, "tgType");
        if (!Files.isDirectory(absoluteTestGenRoot)) {
            return;
        }
        String needle = "_cg" + tgType.ordinal() + "_";
        try (Stream<Path> stream = Files.list(absoluteTestGenRoot)) {
            for (Path child : stream.toList()) {
                if (child.getFileName().toString().contains(needle)) {
                    deleteRecursively(child);
                }
            }
        }
    }

    private static void deleteRecursively(Path root) throws IOException {
        if (Files.notExists(root)) {
            return;
        }
        try (Stream<Path> walk = Files.walk(root)) {
            for (Path p : walk.sorted(Comparator.reverseOrder()).toList()) {
                Files.deleteIfExists(p);
            }
        }
    }

    private static String chapterStem(CGenTbChapter chapter) {
        return switch (chapter) {
            case CPT_ALL -> throw new IllegalArgumentException("CPT_ALL");
            case CPT_FIFO -> "csl_fifo_cg";
            case CPT_INTERCON -> "csl_interconnect_cg";
            case CPT_ISA -> "csl_isa_cg";
            case CPT_LANG -> "csl_language_cg";
            case CPT_MEM -> "csl_memory_cg";
            case CPT_MEM_MAP -> "csl_memory_map_cg";
            case CPT_REG -> "csl_register_cg";
            case CPT_REG_FILE -> "csl_register_file_cg";
            case CPT_TESTB -> "csl_testbench_cg";
            case CPT_VERIFC -> "csl_verification_components_cg";
        };
    }
}
