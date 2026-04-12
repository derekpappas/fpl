package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
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
        assertFalse(fifo.getDepthText().isEmpty());
        assertFalse(fifo.getWidthText().isEmpty());
        assertEquals(fifo.getDepthText().length(), 2);
        assertEquals(fifo.getWidthText().length(), 2);
        StringBuilder out = new StringBuilder();
        fifo.appendPrintedCsl(out);
        String text = out.toString();
        assertTrue(text.startsWith("csl_fifo "));
        assertTrue(text.contains("set_depth"));
        assertTrue(text.contains("set_width"));
        assertTrue(text.endsWith(";\n"));
    }

    @Test
    void fifoLegacyStringBuffersStartEmpty() {
        CslGenFifo f = new CslGenFifo(new CslGenDesign("d"), "f");
        assertTrue(f.getPhImplText().isEmpty());
        assertTrue(f.getPrefixText().isEmpty());
        assertTrue(f.getDefaultDepthText().isEmpty());
        assertTrue(f.getSyncText().isEmpty());
        assertTrue(f.getNumExprDepthExtText().isEmpty());
        assertTrue(f.getNumExprWidthExtText().isEmpty());
        assertTrue(f.getNumExprWrHoldText().isEmpty());
        assertTrue(f.getRdWordsAddrText().isEmpty());
        assertTrue(f.getWrWordsAddrText().isEmpty());
        assertTrue(f.getFlowNumExprText().isEmpty());
        assertTrue(f.getEmptyAddressText().isEmpty());
        assertTrue(f.getFullAddressText().isEmpty());
        assertEquals(0, f.getFifoUsedAt(CslGenFifo.SET_DEPTH));
    }

    @Test
    void fifoUsedAtRejectsOutOfRange() {
        CslGenFifo f = new CslGenFifo(new CslGenDesign("d"), "f");
        assertThrows(IndexOutOfBoundsException.class, () -> f.getFifoUsedAt(-1));
        assertThrows(IndexOutOfBoundsException.class, () -> f.getFifoUsedAt(CslGenFifoTables.FIFO_USED_VECTOR_SIZE));
    }

    @Test
    void fifoBuildDeclMarksDepthAndWidthUsed() {
        CslGenFifo f = new CslGenFifo(new CslGenDesign("d"), "f");
        f.buildDecl(new Random(0L));
        assertEquals(1, f.getFifoUsedAt(CslGenFifo.SET_DEPTH));
        assertEquals(1, f.getFifoUsedAt(CslGenFifo.SET_WIDTH));
    }
}
