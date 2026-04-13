package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;

/**
 * Cmd TB trace ports toward {@code cGenCmds_tb.cpp} / {@code testGlobalPlainDeclGlobalCall*} (no file I/O).
 */
public final class CGenCmdTb {

    private CGenCmdTb() {}

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
