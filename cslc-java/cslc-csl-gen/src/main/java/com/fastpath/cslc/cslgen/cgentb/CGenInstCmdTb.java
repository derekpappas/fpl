package com.fastpath.cslc.cslgen.cgentb;

/**
 * Instance-command TB driver stub: {@code trunk/cslc/trunk/csl_gen/cGenInstCmds_tb.cpp} / {@code cGenInstCmds_tb.h}.
 *
 * <p>Legacy {@code main} calls {@code runTestGen(TG_INSTANCE_COMMAND_CALL, argc, argv, &buildTests)}. The Java port models
 * {@code checkMainArgs} via {@link CGenTbMainArgs#validate}. {@code runTestGen} wiring uses {@link CGenTbBuildContainers},
 * {@link CGenTbRunContext}, and {@link CGenTbGeneratedFile} through {@link #runStubMainWithRepositoryAndDirs} /
 * {@link #runStubMainWithRepositoryAndReport}; {@link #buildTests()} mirrors {@link CGenCmdTb} for spec-driven cmd files.
 */
public final class CGenInstCmdTb {

    private CGenInstCmdTb() {}

    /**
     * Legacy {@code cGenInstCmds_tb.cpp} {@code buildTests()} — same spec-driven emission as {@link CGenCmdTb#buildTests()}
     * with {@link CGenTbTestGen#TG_INSTANCE_COMMAND_CALL} ordinals in output paths.
     */
    public static void buildTests() {
        CGenTbRunContext.current()
                .ifPresentOrElse(
                        ctx -> {
                            CGenTbCmdEmit.emitForRunContext(ctx);
                            CGenTbStubBuild.emitMarkerOnlyIfRunContext();
                        },
                        () -> {});
    }

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

    /** Like {@link #runStubMainWithRepository} plus {@code buildMakeDirs} layout. */
    public static int runStubMainWithRepositoryAndDirs(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecksWithDirs(
                argv, CGenInstCmdTb::buildTests, CGenTbTestGen.TG_INSTANCE_COMMAND_CALL);
    }

    /** Like {@link #runStubMainWithRepositoryAndDirs} plus {@code createReport} for {@link CGenTbTestGen#TG_INSTANCE_COMMAND_CALL}. */
    public static int runStubMainWithRepositoryAndReport(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                argv, CGenInstCmdTb::buildTests, CGenTbTestGen.TG_INSTANCE_COMMAND_CALL);
    }
}
