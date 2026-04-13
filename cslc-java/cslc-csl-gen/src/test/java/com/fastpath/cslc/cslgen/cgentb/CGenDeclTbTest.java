package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import org.junit.jupiter.api.Test;

class CGenDeclTbTest {

    @Test
    void stubMainAcceptsLegacyArgShape() {
        assertEquals(0, CGenDeclTb.runStubMain(new String[] {"cgen_decl_tb"}));
        assertEquals(0, CGenDeclTb.runStubMain(new String[] {"cgen_decl_tb", "interconnect"}));
        assertEquals(1, CGenDeclTb.runStubMain(new String[] {"cgen_decl_tb", "--help"}));
    }

    @Test
    void testScopeDeclNoMandatorySingleAuxLine() {
        CGenTbClassRef unit = new CGenTbClassRef("u1", CGenTbEslClass.CSL_UNIT, true);
        StringBuilder out = new StringBuilder();
        CGenDeclTb.testScopeDecl(unit, out);
        assertEquals("// testScopeDeclAux kind=CSL_UNIT name=u1 legal=true\n", out.toString());
    }

    @Test
    void testPlainDeclEmptyParamsSingleAux() {
        CGenTbClassRef port = new CGenTbClassRef("p1", CGenTbEslClass.CSL_PORT, false);
        StringBuilder out = new StringBuilder();
        CGenDeclTb.testPlainDecl(port, 0, out);
        assertEquals(
                "// testPlainDeclAux kind=CSL_PORT name=p1 legal=true declType=PD_GLOBAL\n", out.toString());
    }

    @Test
    void testPlainDeclScopeHolderNoParamsIllegal() {
        CGenTbClassRef unit = new CGenTbClassRef("u", CGenTbEslClass.CSL_UNIT, true);
        StringBuilder out = new StringBuilder();
        CGenDeclTb.testPlainDecl(unit, 0, out);
        assertTrue(out.toString().contains("legal=false"));
    }

    @Test
    void testPlainDeclWithParamRowsEmitsOneLinePerRow() {
        CGenTbClassRef unit = new CGenTbClassRef("u", CGenTbEslClass.CSL_UNIT, true);
        StringBuilder out = new StringBuilder();
        CGenDeclTb.testPlainDecl(unit, 2, out);
        assertEquals(2, out.toString().lines().count());
        assertTrue(out.toString().contains("legal=true"));
    }

    @Test
    void testScopeDeclWithMandatoryEmitsOneLinePerMandatory() {
        CGenTbClassRef inner = new CGenTbClassRef("inner", CGenTbEslClass.CSL_SIGNAL, false);
        CGenTbClassRef tb =
                new CGenTbClassRef("tb", CGenTbEslClass.CSL_TESTBENCH, true, List.of(inner, inner));
        StringBuilder out = new StringBuilder();
        CGenDeclTb.testScopeDecl(tb, out);
        String text = out.toString();
        assertEquals(2, text.lines().count());
        assertTrue(text.contains("kind=CSL_TESTBENCH"));
        assertTrue(text.contains("legal=true"));
    }

    @Test
    void testScopeObjDeclMultipliesMandatoryPassesByParamRows() {
        CGenTbClassRef u = new CGenTbClassRef("u", CGenTbEslClass.CSL_UNIT, true);
        CGenTbClassRef p = new CGenTbClassRef("p", CGenTbEslClass.CSL_PORT, false);
        StringBuilder out = new StringBuilder();
        CGenDeclTb.testScopeObjDecl(u, p, true, 2, 3, out);
        assertEquals(6, out.toString().lines().count());
    }

    @Test
    void testScopeConstrObjDeclUsesLegalFalse() {
        CGenTbClassRef u = new CGenTbClassRef("u", CGenTbEslClass.CSL_UNIT, true);
        CGenTbClassRef s = new CGenTbClassRef("s", CGenTbEslClass.CSL_SIGNAL, false);
        StringBuilder out = new StringBuilder();
        CGenDeclTb.testScopeConstrObjDecl(u, s, 1, out);
        assertTrue(out.toString().contains("legal=false"));
    }

    @Test
    void testScopeObjScopeDeclTrace() {
        CGenTbClassRef u = new CGenTbClassRef("u", CGenTbEslClass.CSL_UNIT, true);
        CGenTbClassRef v = new CGenTbClassRef("v", CGenTbEslClass.CSL_UNIT, true);
        StringBuilder out = new StringBuilder();
        CGenDeclTb.testScopeObjScopeDecl(u, v, out);
        CGenDeclTb.testScopeConstrObjScopeDecl(u, v, out);
        assertEquals(2, out.toString().lines().count());
    }
}
