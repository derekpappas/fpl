package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayDeque;
import java.util.Optional;
import java.util.Queue;
import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenUnitInstTest {

    @Test
    void getUnitMatchesGetInstUnitWhenBound() {
        CslGenUnitInst bound = findBoundUnitInstWithRetry();
        assertNotNull(bound, "expected a seeded design to produce at least one resolved CslGenUnitInst");
        assertSame(bound.getInstUnit(), bound.getUnit());
    }

    @Test
    void noArgBuildDeclUsesDefaultRandomGenerator() {
        CslGenUnitInst ui = new CslGenUnitInst(new CslGenDesign("d"), "solo");
        ui.buildDecl();
    }

    @Test
    void appendPrintedCslLeavesOutputEmptyWhenInstUnitNotResolved() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenUnitInst ui = new CslGenUnitInst(d, "orph");
        assertFalse(ui.buildDecl(new Random(42L)));
        assertNull(ui.getInstUnit());
        StringBuilder out = new StringBuilder();
        ui.appendPrintedCsl(out);
        assertEquals("", out.toString());
    }

    @Test
    void randSelUnitWalksManySeedsWhenUnbound() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenUnitInst ui = new CslGenUnitInst(d, "u0");
        d.addChild(ui);
        for (long s = 0; s < 400; s++) {
            ui.randSelUnit(new Random(s));
        }
    }

    private static CslGenUnitInst findBoundUnitInstWithRetry() {
        for (long seed = 0; seed < 20_000; seed++) {
            CslGenDesign d = new CslGenDesign("d");
            Random r = new Random(seed);
            for (int i = 0; i < 6; i++) {
                d.addUnit(r);
            }
            Optional<CslGenUnitInst> inst = firstBoundUnitInst(d);
            if (inst.isPresent()) {
                return inst.get();
            }
        }
        return null;
    }

    private static Optional<CslGenUnitInst> firstBoundUnitInst(CslGenCslBase root) {
        Queue<CslGenCslBase> q = new ArrayDeque<>();
        q.add(root);
        while (!q.isEmpty()) {
            CslGenCslBase n = q.remove();
            if (n instanceof CslGenUnitInst ui && ui.getInstUnit() != null) {
                return Optional.of(ui);
            }
            for (int i = 0; i < n.getChildrenCount(); i++) {
                n.getChildAt(i).ifPresent(q::add);
            }
        }
        return Optional.empty();
    }
}
