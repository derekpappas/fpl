package com.fastpath.cslc.cslgen.cgentb;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Objects;
import java.util.concurrent.TimeUnit;
import java.util.function.Supplier;

/**
 * Shared entry for legacy TB {@code main} programs that call {@code runTestGen(..., &buildTests)}: validates CLI like
 * {@code checkMainArgs} ({@link CGenTbMainArgs#validate}), optionally {@link CGenTbRepositoryPath} like {@code runChecks},
 * then runs {@code buildTests}. {@link #runAfterLegacyRunChecksWithDirs} and {@link #runAfterLegacyRunChecksWithReport} run
 * {@link CGenTbBuildContainers#run()} (loads {@link CGenTbContainers}), then {@link CGenTbChapterDirs#purgeLeavesMatchingTestGen} and
 * {@link CGenTbChapterDirs#ensureChapterValidInvalidDirs} after the repo check (legacy {@code executeClean} /
 * {@code buildMakeDirs} before {@code f()}). {@link #runAfterLegacyRunChecksWithReport} also writes {@link CGenTbReport}.
 * Legacy {@code buildHeader} is {@link CGenTbFileHeader#line}; {@link CGenTbGeneratedFile} appends it like {@code closeFile}.
 * While {@code buildTests} runs, {@link CGenTbRunContext} exposes the test-gen root and {@link CGenTbTestCounter}.
 */
public final class CGenTbRunStub {

    private CGenTbRunStub() {}

    /**
     * Returns {@code 0} if {@link CGenTbMainArgs#validate} succeeds and {@code buildTests} completes; {@code 1} if argument
     * validation fails (legacy early exit before {@link CGenTbBuildContainers}).
     */
    public static int runAfterMainArgs(String[] argv, Runnable buildTests) {
        Objects.requireNonNull(buildTests, "buildTests");
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(argv);
        if (!r.ok()) {
            return 1;
        }
        buildTests.run();
        return 0;
    }

    /**
     * Like legacy {@code runChecks} + {@code runTestGen} body through {@code f()}: main-args validation, then
     * {@link CGenTbRepositoryPath#check()}, then {@code buildTests}.
     */
    public static int runAfterLegacyRunChecks(String[] argv, Runnable buildTests) {
        return runAfterLegacyRunChecks(argv, buildTests, CGenTbRepositoryPath::check);
    }

    /**
     * Same as {@link #runAfterLegacyRunChecks(String[], Runnable)} but uses the supplied repository check (for tests or custom
     * {@code WORK} resolution).
     */
    public static int runAfterLegacyRunChecks(
            String[] argv, Runnable buildTests, Supplier<CGenTbRepositoryPath.Outcome> repositoryCheck) {
        Objects.requireNonNull(buildTests, "buildTests");
        Objects.requireNonNull(repositoryCheck, "repositoryCheck");
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(argv);
        if (!r.ok()) {
            return 1;
        }
        CGenTbRepositoryPath.Outcome repo = repositoryCheck.get();
        if (!repo.ok()) {
            return 1;
        }
        buildTests.run();
        return 0;
    }

    /**
     * Like {@link #runAfterLegacyRunChecks(String[], Runnable, Supplier)} plus legacy {@code buildMakeDirs} layout:
     * {@link CGenTbChapterDirs#purgeLeavesMatchingTestGen} and {@link CGenTbChapterDirs#ensureChapterValidInvalidDirs} under the
     * resolved test-gen root using the chapter from {@link CGenTbMainArgs#validate}.
     */
    public static int runAfterLegacyRunChecksWithDirs(String[] argv, Runnable buildTests, CGenTbTestGen tgType) {
        return runAfterLegacyRunChecksWithDirs(argv, buildTests, tgType, CGenTbRepositoryPath::check);
    }

    /**
     * Same as {@link #runAfterLegacyRunChecksWithDirs(String[], Runnable, CGenTbTestGen)} with a custom repository check.
     */
    public static int runAfterLegacyRunChecksWithDirs(
            String[] argv,
            Runnable buildTests,
            CGenTbTestGen tgType,
            Supplier<CGenTbRepositoryPath.Outcome> repositoryCheck) {
        Objects.requireNonNull(buildTests, "buildTests");
        Objects.requireNonNull(tgType, "tgType");
        Objects.requireNonNull(repositoryCheck, "repositoryCheck");
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(argv);
        if (!r.ok()) {
            return 1;
        }
        CGenTbRepositoryPath.Outcome repo = repositoryCheck.get();
        if (!repo.ok()) {
            return 1;
        }
        CGenTbBuildContainers.run();
        Path gen;
        try {
            gen = repo.absoluteTestGenPath();
            CGenTbChapterDirs.purgeLeavesMatchingTestGen(gen, tgType);
            CGenTbChapterDirs.ensureChapterValidInvalidDirs(gen, tgType, r.chapter());
        } catch (IOException e) {
            return 1;
        }
        String binaryName = argv.length > 0 ? argv[0] : "unknown";
        CGenTbTestCounter runCounter = new CGenTbTestCounter();
        CGenTbRunContext.install(gen, binaryName, tgType, r.chapter(), runCounter);
        try {
            buildTests.run();
        } finally {
            CGenTbRunContext.clear();
        }
        return 0;
    }

    /**
     * Like {@link #runAfterLegacyRunChecksWithDirs(String[], Runnable, CGenTbTestGen, Supplier)} and then legacy
     * {@code createReport}: writes {@link CGenTbReport#reportFilePath} under the resolved test-gen root. {@code testCount} comes
     * from a fresh {@link CGenTbTestCounter} (starts at {@code 0}, like C++ before any {@code closeFile}); use
     * {@link #runAfterLegacyRunChecksWithReport(String[], Runnable, CGenTbTestGen, CGenTbTestCounter)} so {@code buildTests} can
     * call {@link CGenTbTestCounter#increment()} per generated file. Elapsed time is wall time around {@code buildTests}.
     * Returns {@code 1} if layout or report I/O fails.
     */
    public static int runAfterLegacyRunChecksWithReport(String[] argv, Runnable buildTests, CGenTbTestGen tgType) {
        return runAfterLegacyRunChecksWithReport(argv, buildTests, tgType, new CGenTbTestCounter(), CGenTbRepositoryPath::check);
    }

    /**
     * Same as {@link #runAfterLegacyRunChecksWithReport(String[], Runnable, CGenTbTestGen)} with a shared
     * {@link CGenTbTestCounter} (pass the same instance into closures used by {@code buildTests} to mirror {@code closeFile}).
     */
    public static int runAfterLegacyRunChecksWithReport(
            String[] argv, Runnable buildTests, CGenTbTestGen tgType, CGenTbTestCounter testCounter) {
        Objects.requireNonNull(testCounter, "testCounter");
        return runAfterLegacyRunChecksWithReport(argv, buildTests, tgType, testCounter, CGenTbRepositoryPath::check);
    }

    /**
     * Same as {@link #runAfterLegacyRunChecksWithReport(String[], Runnable, CGenTbTestGen)} with a custom repository check.
     */
    public static int runAfterLegacyRunChecksWithReport(
            String[] argv,
            Runnable buildTests,
            CGenTbTestGen tgType,
            Supplier<CGenTbRepositoryPath.Outcome> repositoryCheck) {
        return runAfterLegacyRunChecksWithReport(argv, buildTests, tgType, new CGenTbTestCounter(), repositoryCheck);
    }

    /**
     * Same as {@link #runAfterLegacyRunChecksWithReport(String[], Runnable, CGenTbTestGen, CGenTbTestCounter)} with a custom
     * repository check.
     */
    public static int runAfterLegacyRunChecksWithReport(
            String[] argv,
            Runnable buildTests,
            CGenTbTestGen tgType,
            CGenTbTestCounter testCounter,
            Supplier<CGenTbRepositoryPath.Outcome> repositoryCheck) {
        Objects.requireNonNull(buildTests, "buildTests");
        Objects.requireNonNull(tgType, "tgType");
        Objects.requireNonNull(testCounter, "testCounter");
        Objects.requireNonNull(repositoryCheck, "repositoryCheck");
        CGenTbMainArgs.Result r = CGenTbMainArgs.validate(argv);
        if (!r.ok()) {
            return 1;
        }
        CGenTbRepositoryPath.Outcome repo = repositoryCheck.get();
        if (!repo.ok()) {
            return 1;
        }
        CGenTbBuildContainers.run();
        Path gen;
        try {
            gen = repo.absoluteTestGenPath();
            CGenTbChapterDirs.purgeLeavesMatchingTestGen(gen, tgType);
            CGenTbChapterDirs.ensureChapterValidInvalidDirs(gen, tgType, r.chapter());
        } catch (IOException e) {
            return 1;
        }
        String binaryName = argv.length > 0 ? argv[0] : "unknown";
        CGenTbRunContext.install(gen, binaryName, tgType, r.chapter(), testCounter);
        long t0 = System.nanoTime();
        try {
            buildTests.run();
        } finally {
            CGenTbRunContext.clear();
        }
        long elapsedSec = Math.max(0, TimeUnit.NANOSECONDS.toSeconds(System.nanoTime() - t0));
        StringBuilder rep = new StringBuilder();
        CGenTbReport.appendReportText(binaryName, testCounter.get(), elapsedSec, rep);
        Path reportPath = CGenTbReport.reportFilePath(repo.absoluteTestGenPath(), tgType);
        try {
            Path parent = reportPath.getParent();
            if (parent != null) {
                Files.createDirectories(parent);
            }
            Files.writeString(reportPath, rep.toString(), StandardCharsets.UTF_8);
        } catch (IOException e) {
            return 1;
        }
        return 0;
    }
}
