package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;

/**
 * Cmd TB harness: {@code cGenCmds_tb.cpp}. Trace methods mirror {@code testGlobalPlainDeclGlobalCall*} (no file I/O). Legacy
 * {@code main} uses {@code runTestGen(TG_COMMAND_CALL, argc, argv, &buildTests)} — see {@link #runStubMain} / {@link #buildTests}.
 */
public final class CGenCmdTb {

    private CGenCmdTb() {}

    /** Legacy {@code cGenCmds_tb.cpp} {@code buildTests()} — not ported (requires cmd/class containers). */
    public static void buildTests() {}

    /**
     * Stub for legacy {@code main}: {@link CGenTbMainArgs#validate} then {@link #buildTests()}. Full {@code runTestGen} is not
     * ported.
     */
    public static int runStubMain(String[] argv) {
        return CGenTbRunStub.runAfterMainArgs(argv, CGenCmdTb::buildTests);
    }

    /** Like {@link #runStubMain} plus {@link CGenTbRepositoryPath#check}. */
    public static int runStubMainWithRepository(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecks(argv, CGenCmdTb::buildTests);
    }

    /** Legacy {@code testGlobalPlainDeclGlobalCallAux(...)} — trace line only. */
    public static void testGlobalPlainDeclGlobalCallAux(
            CGenTbCmdRef cmd, CGenTbClassRef cls, boolean legal, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        out.append("// testGlobalPlainDeclGlobalCallAux cmd=")
                .append(cmd.type().legacyCslCmdName())
                .append(" clsKind=")
                .append(cls.kind().name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /**
     * Legacy {@code testGlobalPlainDeclGlobalCall(cmd, cls)} — {@code paramVectRowCount} is {@code cls.getParams()}
     * row count; {@code preDeclOrderRows} is {@code getPreDeclVectOrder(cmd->getParamVect())} size (0 means one aux
     * without inner predecl loop per param row).
     */
    public static void testGlobalPlainDeclGlobalCall(
            CGenTbCmdRef cmd,
            CGenTbClassRef cls,
            int paramVectRowCount,
            int preDeclOrderRows,
            StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        boolean legal = cmd.isLegalFor(cls);
        if (paramVectRowCount > 0) {
            for (int p = 0; p < paramVectRowCount; p++) {
                if (preDeclOrderRows > 0) {
                    for (int r = 0; r < preDeclOrderRows; r++) {
                        testGlobalPlainDeclGlobalCallAux(cmd, cls, legal, out);
                    }
                } else {
                    testGlobalPlainDeclGlobalCallAux(cmd, cls, legal, out);
                }
            }
        } else {
            testGlobalPlainDeclGlobalCallAux(cmd, cls, legal, out);
        }
    }
}
