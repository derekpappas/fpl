package com.fastpath.cslc.cslgen.tb;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.SplittableRandom;
import org.junit.jupiter.api.Test;

class CslGenTbGeneratorTest {

    @Test
    void randStringUsesLegacyNameSize() {
        CslGenTbGenerator g = new CslGenTbGenerator(new StringBuilder(), new SplittableRandom(1L));
        assertEquals(CslGenTbConsts.NAME_SIZE, g.randString().length());
    }

    @Test
    void buildEmitsCslUnitsAndDeclarations() {
        StringBuilder out = new StringBuilder();
        CslGenTbGenerator g = new CslGenTbGenerator(out, new SplittableRandom(9_021_773L));
        g.build();
        String text = out.toString();
        assertFalse(text.isEmpty());
        assertTrue(text.contains("csl_unit "));
        assertTrue(text.contains("csl_bitrange "));
        assertTrue(text.contains("csl_signal "));
        assertTrue(text.contains("};"));
        assertFalse(g.getUnits().isEmpty());
    }
}
