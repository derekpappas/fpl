package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenRegisterTest {

    @Test
    void registerStringsStartEmptyAndUsedBounds() {
        CslGenRegister r = new CslGenRegister(new CslGenDesign("d"), "r");
        assertTrue(r.getRangeText().isEmpty());
        assertTrue(r.getCntDirSgnText().isEmpty());
        assertThrows(IndexOutOfBoundsException.class, () -> r.getRegisterUsedAt(-1));
        assertThrows(
                IndexOutOfBoundsException.class,
                () -> r.getRegisterUsedAt(CslGenRegisterTables.R_USED_VECTOR_SIZE));
    }

    @Test
    void buildDeclSetsAtLeastOneUsedSlotForSomeSeed() {
        int sum = 0;
        for (long seed = 0L; seed < 300L && sum == 0; seed++) {
            CslGenRegister r = new CslGenRegister(new CslGenDesign("d"), "r");
            r.buildDecl(new Random(seed));
            sum = 0;
            for (int i = 0; i < CslGenRegisterTables.R_USED_VECTOR_SIZE; i++) {
                sum += r.getRegisterUsedAt(i);
            }
        }
        assertTrue(sum > 0, "expected REG_CMD loop to mark a slot for some seed");
    }

    @Test
    void addRegisterBuildsAndPrints() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(12345L);
        d.addRegister(rng);
        assertInstanceOf(CslGenRegister.class, d.getChildAt(0).orElseThrow());
        CslGenRegister r = (CslGenRegister) d.getChildAt(0).orElseThrow();
        StringBuilder out = new StringBuilder();
        r.appendPrintedCsl(out);
        String text = out.toString();
        assertTrue(text.startsWith("csl_register "));
        assertTrue(text.contains("set_range") || text.contains("set_type") || text.contains("set_width"));
        assertTrue(text.endsWith(";\n"));
    }
}
