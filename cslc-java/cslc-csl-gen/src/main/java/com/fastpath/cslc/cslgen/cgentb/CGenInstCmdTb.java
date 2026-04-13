package com.fastpath.cslc.cslgen.cgentb;

/**
 * Instance-command TB driver stub: {@code trunk/cslc/trunk/csl_gen/cGenInstCmds_tb.cpp} / {@code cGenInstCmds_tb.h}.
 *
 * <p>Legacy {@code main} calls {@code runTestGen(TG_INSTANCE_COMMAND_CALL, argc, argv, &buildTests)}. The Java port models
 * {@code checkMainArgs} via {@link CGenTbMainArgs#validate} and the no-op {@code buildTests} body. {@code runTestGen} steps
 * that touch the repository path, containers, directories, headers, and reports are not ported yet.
 */
public final class CGenInstCmdTb {

    private CGenInstCmdTb() {}

    /** Legacy {@code cGenInstCmds_tb.cpp} {@code buildTests()} — empty. */
    public static void buildTests() {}

    /**
     * Stub for legacy {@code main}: validates CLI like {@code checkMainArgs}, then {@link #buildTests()}. Returns {@code 0}
     * on success, {@code 1} on argument errors (same exit convention as the C++ driver when {@code runTestGen} fails early).
     */
    public static int runStubMain(String[] argv) {
        return CGenTbRunStub.runAfterMainArgs(argv, CGenInstCmdTb::buildTests);
    }

    /** Like {@link #runStubMain} plus {@link CGenTbRepositoryPath#check}. */
    public static int runStubMainWithRepository(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecks(argv, CGenInstCmdTb::buildTests);
    }
}
