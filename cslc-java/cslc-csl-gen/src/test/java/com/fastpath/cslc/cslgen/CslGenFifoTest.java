package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenFifoTest {

    @Test
    void addFifoEmitsCsl() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(100L);
        d.addFifo(rng);
        CslGenFifo fifo = (CslGenFifo) d.getChildAt(0).orElseThrow();
        StringBuilder out = new StringBuilder();
        fifo.appendPrintedCsl(out);
        String text = out.toString();
        assertTrue(text.startsWith("csl_fifo "));
        assertTrue(text.contains("set_depth"));
        assertTrue(text.contains("set_width"));
        assertTrue(text.endsWith(";\n"));
    }
}
