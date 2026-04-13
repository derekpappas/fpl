package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;

/**
 * Decl TB harness trace ports: {@code testScopeDecl*} and {@code testPlainDecl*} ({@code cGenDecl_tb.h} /
 * {@code cGenDecl_tb.cpp}). Writes comment lines into {@code out} instead of {@code ofstream}.
 */
public final class CGenDeclTb {

    private CGenDeclTb() {}

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
}
