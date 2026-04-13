package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class CGenInstDeclTbTest {

    @Test
    void stubMainMatchesInstCmdDriver() {
        assertEquals(0, CGenInstDeclTb.runStubMain(new String[] {"cgen_inst_decl_tb"}));
        assertEquals(1, CGenInstDeclTb.runStubMain(new String[] {"p", "nope"}));
    }

    @Test
    void globalInstPlainDeclRepeatsAuxPerParamRow() {
        CGenTbClassRef sig = new CGenTbClassRef("s", CGenTbEslClass.CSL_SIGNAL, false);
        StringBuilder out = new StringBuilder();
        CGenInstDeclTb.testGlobalInstPlainDecl(sig, 2, out);
        assertEquals(2, out.toString().lines().count());
    }

    @Test
    void scopeInstScopeDeclIncludesLegality() {
        CGenTbClassRef u = new CGenTbClassRef("u", CGenTbEslClass.CSL_UNIT, true);
        CGenTbClassRef p = new CGenTbClassRef("p", CGenTbEslClass.CSL_PORT, false);
        StringBuilder out = new StringBuilder();
        CGenInstDeclTb.testScopeInstScopeDecl(u, p, false, out);
        assertTrue(out.toString().contains("isLegal=false"));
    }
}
