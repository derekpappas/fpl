package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenIsaAoPrintTest {

    @Test
    void printContainsIsaAoKeywords() {
        String text = "";
        for (long seed = 0; seed < 5000; seed++) {
            Random rng = new Random(seed);
            CslGenDesign d = new CslGenDesign("design");
            d.buildDecl(rng);
            StringBuilder out = new StringBuilder();
            d.appendPrintedCsl(out);
            text = out.toString();
            if (text.contains("csl_isa_instruction_format")
                    && text.contains("csl_isa_instruction")
                    && text.contains("csl_isa ")) {
                break;
            }
        }
        assertTrue(text.contains("csl_isa_instruction_format"));
        assertTrue(text.contains("csl_isa_instruction"));
        assertTrue(text.contains("csl_isa "));
    }
}
