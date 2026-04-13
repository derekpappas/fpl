package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;

/**
 * Instance-declaration TB harness: {@code trunk/cslc/trunk/csl_gen/cGenInstDecl_tb.cpp} / {@code cGenInstDecl_tb.h}.
 *
 * <p>Legacy {@code main} calls {@code runTestGen(TG_INSTANCE_DECLARATION, argc, argv, &buildTests)}. Trace methods write
 * {@code //} lines into a {@link StringBuilder} instead of {@code ofstream}, matching {@link CGenDeclTb}. {@code buildTests}
 * is a no-op here; the C++ loop over {@code cslClasses} is not ported.
 */
public final class CGenInstDeclTb {

    private CGenInstDeclTb() {}

    /** Legacy {@code cGenInstDecl_tb.cpp} {@code buildTests()} body — not ported (requires {@code cslClasses} graph). */
    public static void buildTests() {}

    /**
     * Stub for legacy {@code main}: {@link CGenTbMainArgs#validate} then {@link #buildTests()}. {@code runTestGen} repo /
     * container / report steps are not ported.
     */
    public static int runStubMain(String[] argv) {
        return CGenTbRunStub.runAfterMainArgs(argv, CGenInstDeclTb::buildTests);
    }

    /** Like {@link #runStubMain} plus {@link CGenTbRepositoryPath#check}. */
    public static int runStubMainWithRepository(String[] argv) {
        return CGenTbRunStub.runAfterLegacyRunChecks(argv, CGenInstDeclTb::buildTests);
    }

    /** Legacy {@code testGlobalInstDecl}. */
    public static void testGlobalInstDecl(CGenTbClassRef cls, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        out.append("// testGlobalInstDecl kind=")
                .append(cls.kind().name())
                .append(" name=")
                .append(cls.name())
                .append('\n');
    }

    /** Legacy {@code testGlobalInstPlainDeclAux}. */
    public static void testGlobalInstPlainDeclAux(
            CGenTbClassRef cls, boolean legal, CGenTbParamDecl declType, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(declType, "declType");
        Objects.requireNonNull(out, "out");
        out.append("// testGlobalInstPlainDeclAux kind=")
                .append(cls.kind().name())
                .append(" name=")
                .append(cls.name())
                .append(" legal=")
                .append(legal)
                .append(" declType=")
                .append(declType.name())
                .append('\n');
    }

    /**
     * Legacy {@code testGlobalInstPlainDecl}: one aux per parameter-vector row, or a single aux when {@code obj} has no param
     * rows ({@code paramVectRowCount == 0}).
     */
    public static void testGlobalInstPlainDecl(CGenTbClassRef cls, int paramVectRowCount, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(out, "out");
        if (paramVectRowCount > 0) {
            for (int i = 0; i < paramVectRowCount; i++) {
                testGlobalInstPlainDeclAux(cls, false, CGenTbParamDecl.PD_GLOBAL, out);
            }
        } else {
            testGlobalInstPlainDeclAux(cls, false, CGenTbParamDecl.PD_GLOBAL, out);
        }
    }

    /**
     * Legacy {@code testScopeInstScopeDecl}; {@code isLegal} matches {@code cls->isLegalInst(obj->getClass())} in C++
     * (caller supplies — no {@code CSLClass} graph yet).
     */
    public static void testScopeInstScopeDecl(
            CGenTbClassRef cls, CGenTbClassRef obj, boolean isLegal, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(out, "out");
        out.append("// testScopeInstScopeDecl outer=")
                .append(cls.name())
                .append(" inner=")
                .append(obj.name())
                .append(" isLegal=")
                .append(isLegal)
                .append('\n');
    }

    /** Legacy {@code testScopeConstrInstScopeDecl} ({@code determineFileName(..., false, ...)} in C++). */
    public static void testScopeConstrInstScopeDecl(CGenTbClassRef cls, CGenTbClassRef obj, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(out, "out");
        out.append("// testScopeConstrInstScopeDecl outer=")
                .append(cls.name())
                .append(" inner=")
                .append(obj.name())
                .append('\n');
    }

    /** Legacy {@code testScopeInstPlainDeclAux}. */
    public static void testScopeInstPlainDeclAux(
            CGenTbClassRef cls,
            CGenTbClassRef obj,
            boolean legal,
            CGenTbParamDecl declType,
            StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(declType, "declType");
        Objects.requireNonNull(out, "out");
        out.append("// testScopeInstPlainDeclAux outer=")
                .append(cls.name())
                .append(" inner=")
                .append(obj.name())
                .append(" legal=")
                .append(legal)
                .append(" declType=")
                .append(declType.name())
                .append('\n');
    }

    /** Legacy {@code testScopeInstPlainDecl}. */
    public static void testScopeInstPlainDecl(CGenTbClassRef cls, CGenTbClassRef obj, int paramVectRowCount, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(out, "out");
        if (paramVectRowCount > 0) {
            for (int i = 0; i < paramVectRowCount; i++) {
                testScopeInstPlainDeclAux(cls, obj, false, CGenTbParamDecl.PD_GLOBAL, out);
            }
        } else {
            testScopeInstPlainDeclAux(cls, obj, false, CGenTbParamDecl.PD_GLOBAL, out);
        }
    }

    /** Legacy {@code testScopeConstrInstPlainDeclAux}. */
    public static void testScopeConstrInstPlainDeclAux(
            CGenTbClassRef cls,
            CGenTbClassRef obj,
            boolean legal,
            CGenTbParamDecl declType,
            StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(declType, "declType");
        Objects.requireNonNull(out, "out");
        out.append("// testScopeConstrInstPlainDeclAux outer=")
                .append(cls.name())
                .append(" inner=")
                .append(obj.name())
                .append(" legal=")
                .append(legal)
                .append(" declType=")
                .append(declType.name())
                .append('\n');
    }

    /** Legacy {@code testScopeConstrInstPlainDecl}. */
    public static void testScopeConstrInstPlainDecl(
            CGenTbClassRef cls, CGenTbClassRef obj, int paramVectRowCount, StringBuilder out) {
        Objects.requireNonNull(cls, "cls");
        Objects.requireNonNull(obj, "obj");
        Objects.requireNonNull(out, "out");
        if (paramVectRowCount > 0) {
            for (int i = 0; i < paramVectRowCount; i++) {
                testScopeConstrInstPlainDeclAux(cls, obj, false, CGenTbParamDecl.PD_GLOBAL, out);
            }
        } else {
            testScopeConstrInstPlainDeclAux(cls, obj, false, CGenTbParamDecl.PD_GLOBAL, out);
        }
    }
}
