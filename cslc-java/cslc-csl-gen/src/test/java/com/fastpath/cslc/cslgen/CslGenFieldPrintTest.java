package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenFieldPrintTest {

    @Test
    void fieldPrintContainsKeyword() {
        String text = "";
        for (long s = 0; s < 400; s++) {
            CslGenDesign d = new CslGenDesign("d");
            CslGenField f = new CslGenField(d, "f0");
            f.buildDecl(new Random(s));
            StringBuilder out = new StringBuilder();
            f.appendPrintedCsl(out);
            text = out.toString();
            if (text.contains("csl_field")) {
                break;
            }
        }
        assertTrue(text.contains("csl_field"));
    }
}
