package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;

/**
 * Cmd TB harness: {@code cGenCmds_tb.cpp}. Trace methods mirror {@code test*Call*} helpers (no file I/O). Legacy {@code main}
 * uses {@code runTestGen(TG_COMMAND_CALL, argc, argv, &buildTests)} — see {@link #runStubMain} / {@link #buildTests}.
 */
public final class CGenCmdTb {

    private CGenCmdTb() {}

    /**
     * Legacy {@code cGenCmds_tb.cpp} {@code buildTests()} — with {@link CGenTbRunContext} and {@link CGenTbTestGen#TG_COMMAND_CALL},
     * {@link CGenTbCmdEmit} writes spec-driven legal cmd-call files and increments {@link CGenTbTestCounter} via
     * {@link CGenTbGeneratedFile} ({@link CGenInstCmdTb} uses the same emitter with {@link CGenTbTestGen#TG_INSTANCE_COMMAND_CALL}).
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
     * Stub for legacy {@code main}: {@link CGenTbMainArgs#validate} then {@link #buildTests()}. Class/cmd loops are not ported;
     * {@code runTestGen} wiring is via {@link CGenTbRunStub} helpers.
     */
    public static int runStubMain(String[] argv) {
        return CGenTbRunStub.runAfterMainArgs(argv, CGenCmdTb::buildTests);
    }

    /** Like {@link #runStubMain} plus {@link CGenTbRepositoryPath#check}. */
    public static int runStubMainWithRepository(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecks(argv, CGenCmdTb::buildTests);
    }

    /** Like {@link #runStubMainWithRepository} plus {@code buildMakeDirs} layout. */
    public static int runStubMainWithRepositoryAndDirs(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecksWithDirs(argv, CGenCmdTb::buildTests, CGenTbTestGen.TG_COMMAND_CALL);
    }

    /** Like {@link #runStubMainWithRepositoryAndDirs} plus {@code createReport} for {@link CGenTbTestGen#TG_COMMAND_CALL}. */
    public static int runStubMainWithRepositoryAndReport(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                argv, CGenCmdTb::buildTests, CGenTbTestGen.TG_COMMAND_CALL);
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

    /** Legacy {@code testGlobalPlainDeclScopeCallAux}. */
    public static void testGlobalPlainDeclScopeCallAux(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, boolean legal, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        out.append("// testGlobalPlainDeclScopeCallAux cmd=")
                .append(cmd.type().legacyCslCmdName())
                .append(" clsKind=")
                .append(cls.kind().name())
                .append(" scope=")
                .append(scope.name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /** Legacy {@code testGlobalPlainDeclScopeCall} — aux always uses {@code legal=false} like C++. */
    public static void testGlobalPlainDeclScopeCall(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, int paramVectRowCount, int preDeclOrderRows, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        if (paramVectRowCount > 0) {
            for (int p = 0; p < paramVectRowCount; p++) {
                if (preDeclOrderRows > 0) {
                    for (int r = 0; r < preDeclOrderRows; r++) {
                        testGlobalPlainDeclScopeCallAux(cmd, cls, scope, false, out);
                    }
                } else {
                    testGlobalPlainDeclScopeCallAux(cmd, cls, scope, false, out);
                }
            }
        } else {
            testGlobalPlainDeclScopeCallAux(cmd, cls, scope, false, out);
        }
    }

    /** Legacy {@code testGlobalPlainDeclConstrCallAux}. */
    public static void testGlobalPlainDeclConstrCallAux(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, boolean legal, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        out.append("// testGlobalPlainDeclConstrCallAux cmd=")
                .append(cmd.type().legacyCslCmdName())
                .append(" clsKind=")
                .append(cls.kind().name())
                .append(" scope=")
                .append(scope.name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /** Legacy {@code testGlobalPlainDeclConstrCall}. */
    public static void testGlobalPlainDeclConstrCall(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, int paramVectRowCount, int preDeclOrderRows, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        if (paramVectRowCount > 0) {
            for (int p = 0; p < paramVectRowCount; p++) {
                if (preDeclOrderRows > 0) {
                    for (int r = 0; r < preDeclOrderRows; r++) {
                        testGlobalPlainDeclConstrCallAux(cmd, cls, scope, false, out);
                    }
                } else {
                    testGlobalPlainDeclConstrCallAux(cmd, cls, scope, false, out);
                }
            }
        } else {
            testGlobalPlainDeclConstrCallAux(cmd, cls, scope, false, out);
        }
    }

    /** Legacy {@code testGlobalScopeDeclScopeCallAux}. */
    public static void testGlobalScopeDeclScopeCallAux(CGenTbCmdRef cmd, CGenTbClassRef cls, boolean legal, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        out.append("// testGlobalScopeDeclScopeCallAux cmd=")
                .append(cmd.type().legacyCslCmdName())
                .append(" clsKind=")
                .append(cls.kind().name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /** Legacy {@code testGlobalScopeDeclScopeCall}. */
    public static void testGlobalScopeDeclScopeCall(CGenTbCmdRef cmd, CGenTbClassRef cls, int preDeclOrderRows, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        if (preDeclOrderRows > 0) {
            for (int r = 0; r < preDeclOrderRows; r++) {
                testGlobalScopeDeclScopeCallAux(cmd, cls, false, out);
            }
        } else {
            testGlobalScopeDeclScopeCallAux(cmd, cls, false, out);
        }
    }

    /** Legacy {@code testGlobalScopeDeclConstrCallAux}. */
    public static void testGlobalScopeDeclConstrCallAux(CGenTbCmdRef cmd, CGenTbClassRef cls, boolean legal, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        out.append("// testGlobalScopeDeclConstrCallAux cmd=")
                .append(cmd.type().legacyCslCmdName())
                .append(" clsKind=")
                .append(cls.kind().name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /** Legacy {@code testGlobalScopeDeclConstrCall}. */
    public static void testGlobalScopeDeclConstrCall(CGenTbCmdRef cmd, CGenTbClassRef cls, int preDeclOrderRows, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        boolean isLegal = cmd.isCaller(cls);
        if (preDeclOrderRows > 0) {
            for (int r = 0; r < preDeclOrderRows; r++) {
                testGlobalScopeDeclConstrCallAux(cmd, cls, isLegal, out);
            }
        } else {
            testGlobalScopeDeclConstrCallAux(cmd, cls, isLegal, out);
        }
    }

    /** Legacy {@code testGlobalScopeDeclGlobalCallAux}. */
    public static void testGlobalScopeDeclGlobalCallAux(CGenTbCmdRef cmd, CGenTbClassRef cls, boolean legal, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        out.append("// testGlobalScopeDeclGlobalCallAux cmd=")
                .append(cmd.type().legacyCslCmdName())
                .append(" clsKind=")
                .append(cls.kind().name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /** Legacy {@code testGlobalScopeDeclGlobalCall}. */
    public static void testGlobalScopeDeclGlobalCall(CGenTbCmdRef cmd, CGenTbClassRef cls, int preDeclOrderRows, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        if (preDeclOrderRows > 0) {
            for (int r = 0; r < preDeclOrderRows; r++) {
                testGlobalScopeDeclGlobalCallAux(cmd, cls, false, out);
            }
        } else {
            testGlobalScopeDeclGlobalCallAux(cmd, cls, false, out);
        }
    }

    /** Legacy {@code testScopePlainDeclScopeCallAux}. */
    public static void testScopePlainDeclScopeCallAux(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, boolean legal, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        out.append("// testScopePlainDeclScopeCallAux cmd=")
                .append(cmd.type().legacyCslCmdName())
                .append(" clsKind=")
                .append(cls.kind().name())
                .append(" scope=")
                .append(scope.name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /** Legacy {@code testScopePlainDeclScopeCall}. */
    public static void testScopePlainDeclScopeCall(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, int paramVectRowCount, int preDeclOrderRows, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        if (paramVectRowCount > 0) {
            for (int p = 0; p < paramVectRowCount; p++) {
                if (preDeclOrderRows > 0) {
                    for (int r = 0; r < preDeclOrderRows; r++) {
                        testScopePlainDeclScopeCallAux(cmd, cls, scope, false, out);
                    }
                } else {
                    testScopePlainDeclScopeCallAux(cmd, cls, scope, false, out);
                }
            }
        } else {
            testScopePlainDeclScopeCallAux(cmd, cls, scope, false, out);
        }
    }

    /** Legacy {@code testScopePlainDeclConstrCallAux}. */
    public static void testScopePlainDeclConstrCallAux(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, boolean legal, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        out.append("// testScopePlainDeclConstrCallAux cmd=")
                .append(cmd.type().legacyCslCmdName())
                .append(" clsKind=")
                .append(cls.kind().name())
                .append(" scope=")
                .append(scope.name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /** Legacy {@code testScopePlainDeclConstrCall}. */
    public static void testScopePlainDeclConstrCall(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, int paramVectRowCount, int preDeclOrderRows, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        boolean isLegal = cmd.isCaller(cls);
        if (paramVectRowCount > 0) {
            for (int p = 0; p < paramVectRowCount; p++) {
                if (preDeclOrderRows > 0) {
                    for (int r = 0; r < preDeclOrderRows; r++) {
                        testScopePlainDeclConstrCallAux(cmd, cls, scope, isLegal, out);
                    }
                } else {
                    testScopePlainDeclConstrCallAux(cmd, cls, scope, isLegal, out);
                }
            }
        } else {
            testScopePlainDeclConstrCallAux(cmd, cls, scope, cmd.isCaller(cls), out);
        }
    }

    /** Legacy {@code testScopePlainDeclGlobalCallAux}. */
    public static void testScopePlainDeclGlobalCallAux(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, boolean legal, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        out.append("// testScopePlainDeclGlobalCallAux cmd=")
                .append(cmd.type().legacyCslCmdName())
                .append(" clsKind=")
                .append(cls.kind().name())
                .append(" scope=")
                .append(scope.name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /** Legacy {@code testScopePlainDeclGlobalCall}. */
    public static void testScopePlainDeclGlobalCall(
            CGenTbCmdRef cmd, CGenTbClassRef cls, CGenTbClassRef scope, int paramVectRowCount, int preDeclOrderRows, StringBuilder out) {
        Objects.requireNonNull(cmd, "cmd");
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(scope, "scope");
        Objects.requireNonNull(out, "out");
        if (paramVectRowCount > 0) {
            for (int p = 0; p < paramVectRowCount; p++) {
                if (preDeclOrderRows > 0) {
                    for (int r = 0; r < preDeclOrderRows; r++) {
                        testScopePlainDeclGlobalCallAux(cmd, cls, scope, false, out);
                    }
                } else {
                    testScopePlainDeclGlobalCallAux(cmd, cls, scope, false, out);
                }
            }
        } else {
            testScopePlainDeclGlobalCallAux(cmd, cls, scope, false, out);
        }
    }
}
