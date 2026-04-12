package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayDeque;
import java.util.Optional;
import java.util.Queue;
import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenIfcInstTest {

    @Test
    void getInstTypeMatchesGetIfcTypeWhenBound() {
        CslGenIfcInst bound = findBoundIfcInstWithRetry();
        assertNotNull(bound, "expected a seeded design to produce at least one resolved CslGenIfcInst");
        assertSame(bound.getIfcType(), bound.getInstType());
        StringBuilder out = new StringBuilder();
        bound.appendPrintedCsl(out);
        assertTrue(out.length() > 0);
    }

    private static CslGenIfcInst findBoundIfcInstWithRetry() {
        for (long seed = 0; seed < 8000; seed++) {
            CslGenDesign d = new CslGenDesign("d");
            Random r = new Random(seed);
            d.addIfc(r);
            d.addIfc(r);
            Optional<CslGenIfcInst> inst = firstBoundIfcInst(d);
            if (inst.isPresent()) {
                return inst.get();
            }
        }
        return null;
    }

    private static Optional<CslGenIfcInst> firstBoundIfcInst(CslGenCslBase root) {
        Queue<CslGenCslBase> q = new ArrayDeque<>();
        q.add(root);
        while (!q.isEmpty()) {
            CslGenCslBase n = q.remove();
            if (n instanceof CslGenIfcInst ii && ii.getIfcType() != null) {
                return Optional.of(ii);
            }
            for (int i = 0; i < n.getChildrenCount(); i++) {
                n.getChildAt(i).ifPresent(q::add);
            }
        }
        return Optional.empty();
    }
}
