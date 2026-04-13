package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.SplittableRandom;
import org.junit.jupiter.api.Test;

/**
 * Invariants for Java enum/field generators vs fixed {@code trunk/cslc/trunk/csl_gen/csl_enum_field.cpp} (alternate
 * path; primary port is interconnect + {@code cslField} / {@code cslGenEnumFieldEM} — see docs).
 */
class CslGenEnumFieldTraceTest {

    @Test
    void enumBuildDeclAndPrintContainCslEnum() {
        SplittableRandom rng = new SplittableRandom(91_283L);
        CslGenDesign design = new CslGenDesign("d");
        CslGenEnum en = new CslGenEnum(design, "MyEnum");
        assertTrue(en.buildDecl(rng));
        design.addChild(en);
        StringBuilder sb = new StringBuilder();
        en.appendPrintedCsl(sb);
        String text = sb.toString();
        assertTrue(text.contains("csl_enum"));
        assertTrue(text.contains("MyEnum"));
        assertFalse(en.getEnumItems().isEmpty());
    }

    @Test
    void fieldBuildDeclAndPrintContainCslField() {
        SplittableRandom rng = new SplittableRandom(71_414L);
        CslGenDesign design = new CslGenDesign("d");
        CslGenField field = new CslGenField(design, "MyField");
        assertTrue(field.buildDecl(rng));
        design.addChild(field);
        StringBuilder sb = new StringBuilder();
        field.appendPrintedCsl(sb);
        assertTrue(sb.toString().contains("csl_field"));
        assertTrue(sb.toString().contains("MyField"));
    }
}
