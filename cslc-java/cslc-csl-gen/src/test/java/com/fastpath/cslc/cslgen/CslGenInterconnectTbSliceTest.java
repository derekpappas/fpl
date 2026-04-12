package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

/** Smoke tests for {@code cslInterconnectGen_TB.cpp} slice (Ifc, unit print, unit inst). */
class CslGenInterconnectTbSliceTest {

    @Test
    void ifcPrintsBlock() {
        CslGenDesign d = new CslGenDesign("d");
        d.addIfc(new Random(11L));
        CslGenIfc ifc = (CslGenIfc) d.getChildAt(0).orElseThrow();
        StringBuilder out = new StringBuilder();
        ifc.appendPrintedCsl(out);
        String t = out.toString();
        assertTrue(t.startsWith("csl_interface "));
        assertTrue(t.endsWith("};\n"));
    }

    @Test
    void unitInstResolvesWhenTwoUnitsOnDesign() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(3L);
        d.addUnit(rng);
        d.addUnit(rng);
        CslGenUnit u0 = (CslGenUnit) d.getChildAt(0).orElseThrow();
        u0.addUnitInst(rng);
        assertTrue(u0.getChildrenCount() >= 1);
        assertTrue(u0.getChildAt(0).orElseThrow() instanceof CslGenUnitInst);
    }
}
