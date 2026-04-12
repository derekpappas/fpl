package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenUnitTest {

    @Test
    void addRegFileInstCreatesInstancePerRegisterFileOnDesign() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(42L);
        d.addRegisterFile(rng);
        d.addRegisterFile(rng);
        CslGenUnit u = new CslGenUnit(d, "u");
        d.addChild(u);
        u.addRegFileInst(rng);
        assertEquals(2, u.getChildrenCount());
        for (int i = 0; i < 2; i++) {
            CslGenInstance inst = (CslGenInstance) u.getChildAt(i).orElseThrow();
            assertEquals(CslGenCslType.CSL_INSTANCE, inst.getType());
            assertInstanceOf(CslGenRegisterFile.class, inst.getInstantiatedObj());
        }
    }

    @Test
    void addFifoInstCreatesInstancePerFifoOnDesign() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(99L);
        d.addFifo(rng);
        d.addFifo(rng);
        CslGenUnit u = new CslGenUnit(d, "u");
        d.addChild(u);
        u.addFifoInst(rng);
        assertEquals(2, u.getChildrenCount());
        for (int i = 0; i < 2; i++) {
            CslGenInstance inst = (CslGenInstance) u.getChildAt(i).orElseThrow();
            assertInstanceOf(CslGenFifo.class, inst.getInstantiatedObj());
        }
    }

    @Test
    void instancePrintMatchesDecl0param() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(7L);
        d.addRegisterFile(rng);
        CslGenRegisterFile rf = (CslGenRegisterFile) d.getChildAt(0).orElseThrow();
        CslGenUnit u = new CslGenUnit(d, "u");
        d.addChild(u);
        u.addRegFileInst(rng);
        CslGenInstance inst = (CslGenInstance) u.getChildAt(0).orElseThrow();
        StringBuilder out = new StringBuilder();
        inst.appendPrintedCsl(out);
        String line = out.toString();
        assertTrue(line.startsWith("  "));
        assertTrue(line.contains(inst.getName()));
        assertTrue(line.contains(rf.getName()));
        assertTrue(line.endsWith(";\n"));
    }
}
