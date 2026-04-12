package com.fastpath.cslc.regression;

import com.fastpath.cslc.cdom.VeriNum;
import com.fastpath.cslc.cdom.VeriNumOperations;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class VeriNumPortTest {

    @Test
    void hexConstructionMatchesWidth() {
        VeriNum n = new VeriNum(VeriNum.TBase.HEX, "FF", false, 0);
        assertEquals(8, n.len());
        assertTrue(n.isDefined());
    }

    @Test
    void addSmallBinary() {
        VeriNum a = new VeriNum(5, 8);
        VeriNum b = new VeriNum(3, 8);
        VeriNum s = VeriNumOperations.add(a, b);
        assertEquals(8, s.asUInt());
    }
}
