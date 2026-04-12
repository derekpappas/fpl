package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenUnitBuildDeclTest {

    @Test
    void buildDeclAddsFifoAndRegisterFileInstancesFromDesign() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(44L);
        d.addFifo(rng);
        d.addRegisterFile(rng);
        d.addUnit(rng);
        CslGenUnit u = d.getChildren().stream()
                .filter(CslGenUnit.class::isInstance)
                .map(CslGenUnit.class::cast)
                .findFirst()
                .orElseThrow();
        long inst = u.getChildren().stream().filter(CslGenInstance.class::isInstance).count();
        assertEquals(2, inst);
    }

    @Test
    void buildDeclPopulatesExpectedRoughChildCounts() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(1L);
        d.addUnit(rng);
        CslGenUnit u = (CslGenUnit) d.getChildAt(0).orElseThrow();
        int n = u.getChildrenCount();
        /*
         * Legacy {@code newNameIsValid} walks to the design, so names cannot match the unit itself or siblings.
         * Not every add* loop iteration adds a child (unlike the old Java list-only check).
         */
        assertTrue(n >= 1, "expected at least one successful add* with seed 1, got " + n);
        assertTrue(n <= 5 + 6 + 4 + 6 + 5, "at most one child per add* attempt (fifo/regfile inst add none on empty design)");
    }
}
