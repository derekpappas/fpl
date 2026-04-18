package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;
import org.junit.jupiter.api.Test;

class CGenTbPreDeclOrderTest {

    @Test
    void cartesianIndicesMatchesLegacyStyleIncrement() {
        List<int[]> out = CGenTbPreDeclOrder.cartesianIndices(List.of(2, 3));
        assertEquals(6, out.size());
        assertEquals(0, out.get(0)[0]);
        assertEquals(0, out.get(0)[1]);
        assertEquals(1, out.get(1)[0]);
        assertEquals(0, out.get(1)[1]);
        assertEquals(0, out.get(2)[0]);
        assertEquals(1, out.get(2)[1]);
        assertEquals(1, out.get(3)[0]);
        assertEquals(1, out.get(3)[1]);
        assertEquals(0, out.get(4)[0]);
        assertEquals(2, out.get(4)[1]);
        assertEquals(1, out.get(5)[0]);
        assertEquals(2, out.get(5)[1]);
    }
}

