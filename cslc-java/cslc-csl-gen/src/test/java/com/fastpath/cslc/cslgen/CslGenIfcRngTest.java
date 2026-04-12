package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Random;
import org.junit.jupiter.api.Test;

/** {@link CslGenIfc#buildDecl(RandomGenerator)} must drive name generation from the supplied RNG (legacy {@code randString()} parity). */
class CslGenIfcRngTest {

    @Test
    void buildDeclWithSameSeedProducesSameChildNames() {
        CslGenDesign d1 = new CslGenDesign("d");
        CslGenDesign d2 = new CslGenDesign("d");
        CslGenIfc i1 = new CslGenIfc(d1, "ifc");
        CslGenIfc i2 = new CslGenIfc(d2, "ifc");
        i1.buildDecl(new Random(99L));
        i2.buildDecl(new Random(99L));
        assertEquals(i1.getChildrenCount(), i2.getChildrenCount());
        for (int i = 0; i < i1.getChildrenCount(); i++) {
            assertEquals(
                    i1.getChildAt(i).orElseThrow().getName(),
                    i2.getChildAt(i).orElseThrow().getName());
        }
    }
}
