package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenBitrangeTest {

    @Test
    void buildDeclAndPrint() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenBitrange br = new CslGenBitrange(d, "br0");
        br.buildDecl(new Random(5L));
        StringBuilder out = new StringBuilder();
        br.appendPrintedCsl(out);
        String t = out.toString();
        assertTrue(t.startsWith("  csl_bitrange "));
        assertTrue(t.endsWith(";\n"));
    }
}
