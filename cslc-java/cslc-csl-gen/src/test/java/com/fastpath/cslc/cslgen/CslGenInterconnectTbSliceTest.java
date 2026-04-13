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
        int before = u0.getChildrenCount();
        boolean appended = false;
        /*
         * {@code randSelObj(CSL_UNIT)} from inside a unit may wander the subtree before reaching the design; a fixed
         * RNG stream can fail many times in a row. Use a fresh seed per attempt (still deterministic) so some draw reaches
         * the sibling unit with a non-colliding instance name.
         */
        for (int attempt = 0; attempt < 512; attempt++) {
            u0.addUnitInst(new Random(attempt));
            if (u0.getChildrenCount() > before) {
                appended = true;
                break;
            }
        }
        assertTrue(appended, "with two design units, addUnitInst should resolve a peer unit within many RNG trials");
        assertTrue(
                u0.getChildAt(u0.getChildrenCount() - 1).orElseThrow() instanceof CslGenUnitInst);
    }
}
