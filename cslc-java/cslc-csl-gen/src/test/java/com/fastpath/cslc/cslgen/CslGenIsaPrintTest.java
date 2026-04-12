package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenIsaPrintTest {

    @Test
    void isaFieldPrintContainsKeyword() {
        String text = "";
        for (long s = 0; s < 400; s++) {
            CslGenDesign d = new CslGenDesign("d");
            CslGenIsaField f = new CslGenIsaField(d, "if0");
            f.buildDecl(new Random(s));
            StringBuilder out = new StringBuilder();
            f.appendPrintedCsl(out);
            text = out.toString();
            if (text.contains("csl_isa_field")) {
                break;
            }
        }
        assertTrue(text.contains("csl_isa_field"));
    }

    @Test
    void isaElementPrintContainsKeyword() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenIsaElement el = new CslGenIsaElement(d, "ie0");
        el.buildDecl(new Random(13L));
        StringBuilder out = new StringBuilder();
        el.appendPrintedCsl(out);
        assertTrue(out.toString().contains("csl_isa_element"));
    }
}
