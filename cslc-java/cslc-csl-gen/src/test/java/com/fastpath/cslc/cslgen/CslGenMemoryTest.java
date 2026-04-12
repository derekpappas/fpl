package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenMemoryTest {

    @Test
    void addMemoryCreatesChildWithCslOutput() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(7L);
        d.addMemory(rng);
        assertEquals(1, d.getChildrenCount());
        assertInstanceOf(CslGenMemory.class, d.getChildAt(0).orElseThrow());
        CslGenMemory m = (CslGenMemory) d.getChildAt(0).orElseThrow();
        assertEquals(2, m.getDepthText().length());
        assertEquals(2, m.getWidthText().length());
        StringBuilder out = new StringBuilder();
        m.appendPrintedCsl(out);
        String text = out.toString();
        assertTrue(text.startsWith("csl_memory "));
        assertTrue(text.contains("set_depth"));
        assertTrue(text.contains("set_width"));
        assertTrue(text.endsWith(";\n"));

        StringBuilder out2 = new StringBuilder();
        CslGenCslBase.runWithPrintSink(out2, m::print);
        assertEquals(text, out2.toString());
    }

    @Test
    void memoryTablesMatchHeader() {
        assertEquals(CslGenMemoryTables.M_USED_VECTOR_SIZE, CslGenMemoryTables.M_FUNCTION.length);
    }

    @Test
    void memoryUsedAtRejectsOutOfRange() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenMemory m = new CslGenMemory(d, "mem");
        assertThrows(IndexOutOfBoundsException.class, () -> m.getMemoryUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> m.getMemoryUsedAt(CslGenMemoryTables.M_USED_VECTOR_SIZE));
    }

    @Test
    void memoryUsedSlotsAfterBuildDecl() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenMemory m = new CslGenMemory(d, "mem");
        m.buildDecl(new Random(1L));
        assertEquals(1, m.getMemoryUsedAt(CslGenMemory.SET_DEPTH));
        assertEquals(0, m.getMemoryUsedAt(CslGenMemory.GET_DEPTH));
        assertEquals(1, m.getMemoryUsedAt(CslGenMemory.SET_WIDTH));
        assertEquals(0, m.getMemoryUsedAt(CslGenMemory.GET_WIDTH));
    }
}
