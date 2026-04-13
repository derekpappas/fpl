package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;
import java.util.function.Supplier;

/**
 * Shared entry for legacy TB {@code main} programs that call {@code runTestGen(..., &buildTests)}: validates CLI like
 * {@code checkMainArgs} ({@link CGenTbMainArgs#validate}), optionally {@link CGenTbRepositoryPath} like {@code runChecks},
 * then runs {@code buildTests}. Remaining {@code runTestGen} steps (containers, directories, reports) are not ported.
 */
public final class CGenTbRunStub {

    private CGenTbRunStub() {}

    /**
     * Returns {@code 0} if {@link CGenTbMainArgs#validate} succeeds and {@code buildTests} completes; {@code 1} if argument
     * validation fails (legacy early exit before {@code buildContainers}).
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
}
