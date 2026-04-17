package com.fastpath.cslc.cslgen.cgentb;

import java.nio.file.Path;
import java.util.Objects;
import java.util.Optional;

/**
 * Per-run TB state while {@link CGenTbRunStub} executes {@code buildTests}: resolved test-gen root, driver binary name,
 * {@link CGenTbTestGen} ordinal driver, selected {@link CGenTbChapter} filter, and shared {@link CGenTbTestCounter}. Mirrors
 * legacy globals {@code absoluteTestPath}, {@code argv[0]}, {@code ETestGen}, {@code testChapter}, {@code testCounter} for
 * code that runs inside {@code f()}.
 */
public final class CGenTbRunContext {

    private static final ThreadLocal<CGenTbRunContext> CURRENT = new ThreadLocal<>();

    private final Path absoluteTestGenRoot;
    private final String binaryName;
    private final CGenTbTestGen tgType;
    private final CGenTbChapter chapterFilter;
    private final CGenTbTestCounter testCounter;

    CGenTbRunContext(
            Path absoluteTestGenRoot,
            String binaryName,
            CGenTbTestGen tgType,
            CGenTbChapter chapterFilter,
            CGenTbTestCounter testCounter) {
        this.absoluteTestGenRoot = Objects.requireNonNull(absoluteTestGenRoot, "absoluteTestGenRoot");
        this.binaryName = Objects.requireNonNull(binaryName, "binaryName");
        this.tgType = Objects.requireNonNull(tgType, "tgType");
        this.chapterFilter = Objects.requireNonNull(chapterFilter, "chapterFilter");
        this.testCounter = Objects.requireNonNull(testCounter, "testCounter");
    }

    static void install(
            Path absoluteTestGenRoot,
            String binaryName,
            CGenTbTestGen tgType,
            CGenTbChapter chapterFilter,
            CGenTbTestCounter testCounter) {
        CURRENT.set(new CGenTbRunContext(absoluteTestGenRoot, binaryName, tgType, chapterFilter, testCounter));
    }

    static void clear() {
        CURRENT.remove();
    }

    public static Optional<CGenTbRunContext> current() {
        return Optional.ofNullable(CURRENT.get());
    }

    public Path absoluteTestGenRoot() {
        return absoluteTestGenRoot;
    }

    public String binaryName() {
        return binaryName;
    }

    public CGenTbTestGen tgType() {
        return tgType;
    }

    public CGenTbChapter chapterFilter() {
        return chapterFilter;
    }

    public CGenTbTestCounter testCounter() {
        return testCounter;
    }
}
