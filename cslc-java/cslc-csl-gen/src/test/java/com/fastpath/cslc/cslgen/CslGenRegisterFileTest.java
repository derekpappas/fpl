package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenRegisterFileTest {

    @Test
    void addRegisterFileEmitsCsl() {
        CslGenDesign d = new CslGenDesign("d");
        Random rng = new Random(999L);
        d.addRegisterFile(rng);
        assertInstanceOf(CslGenRegisterFile.class, d.getChildAt(0).orElseThrow());
        CslGenRegisterFile rf = (CslGenRegisterFile) d.getChildAt(0).orElseThrow();
        StringBuilder out = new StringBuilder();
        rf.appendPrintedCsl(out);
        String text = out.toString();
        assertTrue(text.startsWith("csl_register_file "));
        assertTrue(text.contains("set_width"));
        assertTrue(text.contains("set_depth"));
        assertTrue(text.endsWith(";\n"));
    }
}
