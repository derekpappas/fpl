package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenRegisterTest {

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
