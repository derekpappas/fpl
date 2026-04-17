package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class CGenCmdTbTest {

    @Test
    void stubMainAcceptsLegacyArgShape() {
        assertEquals(0, CGenCmdTb.runStubMain(new String[] {"cgen_cmds_tb"}));
        assertEquals(1, CGenCmdTb.runStubMain(new String[] {"cgen_cmds_tb", "not_a_chapter"}));
    }

    @Test
    void globalPlainCallNoParamsSingleAux() {
        CGenTbCmdRef cmd = new CGenTbCmdRef(CGenTbCmdType.CMD_PRINT, CGenTbEslClass.CSL_PORT, true);
        CGenTbClassRef cls = new CGenTbClassRef("p1", CGenTbEslClass.CSL_PORT, false);
        StringBuilder out = new StringBuilder();
        CGenCmdTb.testGlobalPlainDeclGlobalCall(cmd, cls, 0, 0, out);
        assertTrue(out.toString().contains("cmd=print"));
        assertTrue(out.toString().contains("legal=true"));
    }

    @Test
    void globalPlainCallMismatchCallerIllegal() {
        CGenTbCmdRef cmd = new CGenTbCmdRef(CGenTbCmdType.CMD_ADD, CGenTbEslClass.CSL_SIGNAL, true);
        CGenTbClassRef cls = new CGenTbClassRef("u", CGenTbEslClass.CSL_UNIT, false);
        StringBuilder out = new StringBuilder();
        CGenCmdTb.testGlobalPlainDeclGlobalCall(cmd, cls, 0, 0, out);
        assertTrue(out.toString().contains("legal=false"));
    }

    @Test
    void globalPlainCallParamAndPredeclRowsMultiplyAuxLines() {
        CGenTbCmdRef cmd = new CGenTbCmdRef(CGenTbCmdType.CMD_GET_WIDTH, CGenTbEslClass.CSL_SIGNAL, true);
        CGenTbClassRef cls = new CGenTbClassRef("s", CGenTbEslClass.CSL_SIGNAL, false);
        StringBuilder out = new StringBuilder();
        CGenCmdTb.testGlobalPlainDeclGlobalCall(cmd, cls, 2, 3, out);
        assertEquals(6, out.toString().lines().count());
    }

    @Test
    void cmdRefIsCallerMatchesKindOnly() {
        CGenTbCmdRef cmd = new CGenTbCmdRef(CGenTbCmdType.CMD_PRINT, CGenTbEslClass.CSL_PORT, false);
        CGenTbClassRef port = new CGenTbClassRef("p", CGenTbEslClass.CSL_PORT, false);
        CGenTbClassRef unit = new CGenTbClassRef("u", CGenTbEslClass.CSL_UNIT, true);
        assertTrue(cmd.isCaller(port));
        assertTrue(!cmd.isCaller(unit));
    }

    @Test
    void globalPlainDeclScopeCallEmitsScopeName() {
        CGenTbCmdRef cmd = new CGenTbCmdRef(CGenTbCmdType.CMD_PRINT, CGenTbEslClass.CSL_PORT, true);
        CGenTbClassRef sig = new CGenTbClassRef("s", CGenTbEslClass.CSL_SIGNAL, false);
        CGenTbClassRef tb = new CGenTbClassRef("tb", CGenTbEslClass.CSL_TESTBENCH, true);
        StringBuilder out = new StringBuilder();
        CGenCmdTb.testGlobalPlainDeclScopeCall(cmd, sig, tb, 1, 1, out);
        assertTrue(out.toString().contains("scope=tb"));
    }

    @Test
    void globalScopeDeclScopeCallRepeatsByPredeclRows() {
        CGenTbCmdRef cmd = new CGenTbCmdRef(CGenTbCmdType.CMD_PRINT, CGenTbEslClass.CSL_UNIT, true);
        CGenTbClassRef u = new CGenTbClassRef("u", CGenTbEslClass.CSL_UNIT, true);
        StringBuilder out = new StringBuilder();
        CGenCmdTb.testGlobalScopeDeclScopeCall(cmd, u, 3, out);
        assertEquals(3, out.toString().lines().count());
    }
}
