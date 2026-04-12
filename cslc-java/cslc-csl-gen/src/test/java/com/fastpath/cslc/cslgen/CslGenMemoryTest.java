package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
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
}
