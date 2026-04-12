package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenInterconnectTbParityTest {

    @Test
    void tbRandStringMatchesNamesSizeAndSuffix() {
        String s = CslGenInterconnectConsts.tbRandString(new Random(0L));
        assertEquals(CslGenInterconnectConsts.NAMES_SIZE, s.length());
        assertEquals('1', s.charAt(s.length() - 1));
    }

    @Test
    void bitrangeCopyBitrangeCopiesState() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenBitrange a = new CslGenBitrange(d, "a");
        a.setRange(2, 7);
        CslGenBitrange b = new CslGenBitrange(d, "b");
        b.copyBitrange(a);
        assertEquals(2, b.getLower());
        assertEquals(7, b.getUpper());
    }

    @Test
    void scopedSelectionFirstSecondMatchesScopeSelected() {
        CslGenBitrange br = new CslGenBitrange(new CslGenDesign("d"), "b");
        CslGenScopedSelection s = new CslGenScopedSelection("u.", br);
        assertEquals(s.scope(), s.first());
        assertEquals(s.selected(), s.second());
    }

    @Test
    void scopedSelectionSecondMayBeNull() {
        CslGenScopedSelection s = new CslGenScopedSelection("", null);
        assertNull(s.second());
    }

    @Test
    void isaInstrGetInstReflectsSetInst() {
        CslGenIsaInstr instr = new CslGenIsaInstr(new CslGenDesign("d"), "i0");
        assertEquals("", instr.getInst());
        instr.setInst("fmt_a");
        assertEquals("fmt_a", instr.getInst());
    }
}
