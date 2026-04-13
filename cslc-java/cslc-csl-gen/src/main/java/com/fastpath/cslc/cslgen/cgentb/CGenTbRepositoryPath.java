package com.fastpath.cslc.cslgen.cgentb;

import com.fastpath.cslc.cslgen.CGenConsts;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * Legacy {@code getAbsoluteTestPath} / {@code checkRepositoryPath} / {@code checkPath} ({@code cGenBase_tb.cpp}): {@code WORK}
 * + {@link CGenConsts#RELATIVE_TEST_PATH}, then verify the path is usable (Java uses {@link Files#isDirectory} instead of
 * {@code cd}).
 */
public final class CGenTbRepositoryPath {

    private CGenTbRepositoryPath() {}

    /** Outcome of {@link #check()} / {@link #checkWorkRoot(String)}. */
    public record Outcome(boolean ok, Path absoluteTestGenPath, String errorLog) {
        /** Success: resolved test-gen directory (legacy {@code absoluteTestPath}). */
        public static Outcome success(Path absoluteTestGenPath) {
            return new Outcome(true, absoluteTestGenPath, "");
        }

        /** Failure: same user-facing text as legacy {@code testErrorLog} for repository checks. */
        public static Outcome failure(String errorLog) {
            return new Outcome(false, null, errorLog);
        }
    }

    private static final String REPO_CHECK_FAILED =
            "Repository path check failed!\nPlease check the env variable " + CGenConsts.ENV_VAR_NAME + "\n";

    /**
     * Legacy {@code checkRepositoryPath()} using {@link System#getenv(String)} ({@link CGenConsts#ENV_VAR_NAME}).
     */
    public static Outcome check() {
        return checkWorkRoot(System.getenv(CGenConsts.ENV_VAR_NAME));
    }

    /**
     * Legacy {@code getenv(WORK)} + {@code append(RELATIVE_TEST_PATH)} and {@code checkPath}. {@code workRoot} is the same
     * string the C++ driver reads from the environment (may be {@code null}).
     */
    public static Outcome checkWorkRoot(String workRoot) {
        if (workRoot == null || workRoot.isBlank()) {
            return Outcome.failure(REPO_CHECK_FAILED);
        }
        Path absolute = Path.of(workRoot + CGenConsts.RELATIVE_TEST_PATH).normalize();
        if (!Files.isDirectory(absolute)) {
            return Outcome.failure(REPO_CHECK_FAILED);
        }
        return Outcome.success(absolute);
    }
}
