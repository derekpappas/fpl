package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;

/**
 * Decl TB harness: {@code cGenDecl_tb.h} / {@code cGenDecl_tb.cpp}. Trace methods write {@code //} lines into {@code out}
 * instead of {@code ofstream}. Legacy {@code main} uses {@code runTestGen(TG_DECLARATION, argc, argv, &buildTests)} — see
 * {@link #runStubMain} / {@link #buildTests}.
 */
public final class CGenDeclTb {

    private CGenDeclTb() {}

    /**
     * Legacy {@code cGenDecl_tb.cpp} {@code buildTests()} — when {@link CGenTbRunStub} installs {@link CGenTbRunContext} with
     * {@link CGenTbTestGen#TG_DECLARATION}, {@link CGenTbDeclEmit} writes spec-driven legal decl files and increments
     * {@link CGenTbTestCounter} via {@link CGenTbGeneratedFile} ({@link CGenInstDeclTb} uses the same emitter with
     * {@link CGenTbTestGen#TG_INSTANCE_DECLARATION}).
     */
    public static void buildTests() {
        CGenTbRunContext.current()
                .ifPresentOrElse(
                        ctx -> {
                            CGenTbDeclEmit.emitForRunContext(ctx);
                            CGenTbStubBuild.emitMarkerOnlyIfRunContext();
                        },
                        () -> {});
    }

    /**
     * Stub for legacy {@code main}: {@link CGenTbMainArgs#validate} then {@link #buildTests()}. Generator loops are not ported;
     * {@code runTestGen} wiring is via {@link CGenTbRunStub} helpers.
     */
    public static int runStubMain(String[] argv) {
        return CGenTbRunStub.runAfterMainArgs(argv, CGenDeclTb::buildTests);
    }

    /**
     * Like {@link #runStubMain} but also enforces legacy {@code checkRepositoryPath} ({@link CGenTbRepositoryPath#check}).
     */
    public static int runStubMainWithRepository(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecks(argv, CGenDeclTb::buildTests);
    }

    /**
     * Like {@link #runStubMainWithRepository} plus {@code buildMakeDirs} layout ({@link CGenTbRunStub#runAfterLegacyRunChecksWithDirs}).
     */
    public static int runStubMainWithRepositoryAndDirs(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecksWithDirs(
                argv, CGenDeclTb::buildTests, CGenTbTestGen.TG_DECLARATION);
    }

    /**
     * Like {@link #runStubMainWithRepositoryAndDirs} and legacy {@code createReport} for {@link CGenTbTestGen#TG_DECLARATION}
     * ({@link CGenTbRunStub#runAfterLegacyRunChecksWithReport}).
     */
    public static int runStubMainWithRepositoryAndReport(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecksWithReport(
                argv, CGenDeclTb::buildTests, CGenTbTestGen.TG_DECLARATION);
    }

    /**
     * Legacy {@code testScopeDecl(CSLClassPoint cls)} — one {@link #testScopeDeclAux} per mandatory ordering row, or
     * one call when there are no mandatory objs (simplified: same aux for each mandatory placeholder).
     */
    public static void testScopeDecl(CGenTbClassRef cls, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        boolean legal = cls.scopeHolder();
        if (!cls.mandatory().isEmpty()) {
            for (int i = 0; i < cls.mandatory().size(); i++) {
                testScopeDeclAux(cls, legal, out);
            }
        } else {
            testScopeDeclAux(cls, legal, out);
        }
    }

    /** Legacy {@code testScopeDeclAux(cls, legal, mandatoryDecl)} — trace only (no {@code ofstream}). */
    public static void testScopeDeclAux(CGenTbClassRef cls, boolean legal, StringBuilder out) {
        out.append("// testScopeDeclAux kind=")
                .append(cls.kind().name())
                .append(" name=")
                .append(cls.name())
                .append(" legal=")
                .append(legal)
                .append('\n');
    }

    /**
     * Legacy {@code testPlainDecl(CSLClassPoint cls)} — {@code paramVectRowCount} is the number of parameter-vector
     * rows ({@code getParams()}); use {@code 0} for the empty-params branch (single aux call).
     */
    public static void testPlainDecl(CGenTbClassRef cls, int paramVectRowCount, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        boolean legal = !cls.scopeHolder() || (cls.scopeHolder() && paramVectRowCount > 0);
        if (paramVectRowCount > 0) {
            for (int i = 0; i < paramVectRowCount; i++) {
                testPlainDeclAux(cls, legal, CGenTbParamDecl.PD_GLOBAL, out);
            }
        } else {
            testPlainDeclAux(cls, legal, CGenTbParamDecl.PD_GLOBAL, out);
        }
    }

    /** Legacy {@code testPlainDeclAux(cls, legal, declType, paramVect)} — trace only. */
    public static void testPlainDeclAux(CGenTbClassRef cls, boolean legal, CGenTbParamDecl declType, StringBuilder out) {
        Objects.requireNonNull(declType, "declType");
        out.append("// testPlainDeclAux kind=")
                .append(cls.kind().name())
                .append(" name=")
                .append(cls.name())
                .append(" legal=")
                .append(legal)
                .append(" declType=")
                .append(declType.name())
                .append('\n');
    }

    /** Legacy {@code testScopeObjDeclAux}. */
    public static void testScopeObjDeclAux(
            CGenTbClassRef cls, CGenTbClassRef obj, boolean legal, CGenTbParamDecl declType, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(declType, "declType");
        Objects.requireNonNull(out, "out");
        out.append("// testScopeObjDeclAux outer=")
                .append(cls.name())
                .append(" inner=")
                .append(obj.name())
                .append(" legal=")
                .append(legal)
                .append(" declType=")
                .append(declType.name())
                .append('\n');
    }

    /**
     * Legacy {@code testScopeObjDecl}: {@code mandatoryDeclPasses} is the number of outer {@code createPreDeclVectOrder}
     * rows (0 means the no-mandatory branch); {@code paramVectRowCount} is {@code obj->getParams()} size (0 = empty-params
     * aux).
     */
    public static void testScopeObjDecl(
            CGenTbClassRef cls,
            CGenTbClassRef obj,
            boolean isLegal,
            int mandatoryDeclPasses,
            int paramVectRowCount,
            StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(out, "out");
        if (mandatoryDeclPasses > 0) {
            for (int m = 0; m < mandatoryDeclPasses; m++) {
                if (paramVectRowCount > 0) {
                    for (int p = 0; p < paramVectRowCount; p++) {
                        testScopeObjDeclAux(cls, obj, isLegal, CGenTbParamDecl.PD_GLOBAL, out);
                    }
                } else {
                    testScopeObjDeclAux(cls, obj, isLegal, CGenTbParamDecl.PD_GLOBAL, out);
                }
            }
        } else {
            if (paramVectRowCount > 0) {
                for (int p = 0; p < paramVectRowCount; p++) {
                    testScopeObjDeclAux(cls, obj, isLegal, CGenTbParamDecl.PD_GLOBAL, out);
                }
            } else {
                testScopeObjDeclAux(cls, obj, isLegal, CGenTbParamDecl.PD_GLOBAL, out);
            }
        }
    }

    /** Legacy {@code testScopeConstrObjDeclAux}. */
    public static void testScopeConstrObjDeclAux(
            CGenTbClassRef cls, CGenTbClassRef obj, boolean legal, CGenTbParamDecl declType, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(declType, "declType");
        Objects.requireNonNull(out, "out");
        out.append("// testScopeConstrObjDeclAux outer=")
                .append(cls.name())
                .append(" inner=")
                .append(obj.name())
                .append(" legal=")
                .append(legal)
                .append(" declType=")
                .append(declType.name())
                .append('\n');
    }

    /** Legacy {@code testScopeConstrObjDecl} — C++ uses {@code legal=false} in each aux. */
    public static void testScopeConstrObjDecl(CGenTbClassRef cls, CGenTbClassRef obj, int paramVectRowCount, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(out, "out");
        if (paramVectRowCount > 0) {
            for (int p = 0; p < paramVectRowCount; p++) {
                testScopeConstrObjDeclAux(cls, obj, false, CGenTbParamDecl.PD_GLOBAL, out);
            }
        } else {
            testScopeConstrObjDeclAux(cls, obj, false, CGenTbParamDecl.PD_GLOBAL, out);
        }
    }

    /** Legacy {@code testScopeObjScopeDecl}. */
    public static void testScopeObjScopeDecl(CGenTbClassRef cls, CGenTbClassRef obj, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(out, "out");
        out.append("// testScopeObjScopeDecl outer=")
                .append(cls.name())
                .append(" inner=")
                .append(obj.name())
                .append('\n');
    }

    /** Legacy {@code testScopeConstrObjScopeDecl}. */
    public static void testScopeConstrObjScopeDecl(CGenTbClassRef cls, CGenTbClassRef obj, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(out, "out");
        out.append("// testScopeConstrObjScopeDecl outer=")
                .append(cls.name())
                .append(" inner=")
                .append(obj.name())
                .append('\n');
    }
}
