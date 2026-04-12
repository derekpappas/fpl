package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenFieldInstTest {

    @Test
    void addFieldInstanceAddsFieldInstUnderHost() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenField src = new CslGenField(d, "src");
        d.addChild(src);
        CslGenField host = new CslGenField(d, "host");
        host.addFieldInstance(d, new Random(7L));
        assertEquals(1, host.getChildrenCount());
        CslGenCslBase ch = host.getChildAt(0).orElseThrow();
        assertEquals(CslGenCslType.CSL_FIELD_INST, ch.getType());
        assertTrue(ch instanceof CslGenFieldInst);
        CslGenFieldInst fi = (CslGenFieldInst) ch;
        assertEquals("src", fi.getFieldObj().getName());
        assertEquals("src", fi.getFieldInstTypeName());
        assertSame(fi.getInstObj(), fi.getFieldObj());
        assertEquals("src", fi.getFieldInstText());
        assertEquals("src", fi.getInstField().getName());
    }

    @Test
    void constructorRejectsNonFieldType() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenEnum en = new CslGenEnum(d, "e");
        assertThrows(
                IllegalArgumentException.class,
                () -> new CslGenFieldInst(d, en, "bad"));
    }

    @Test
    void printWithoutSinkIsNoOp() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenField src = new CslGenField(d, "src");
        CslGenFieldInst fi = new CslGenFieldInst(d, src, "fi");
        fi.print();
    }

    @Test
    void appendPrintedCslEmitsDeclaration() {
        CslGenDesign d = new CslGenDesign("d");
        CslGenField src = new CslGenField(d, "myField");
        CslGenFieldInst fi = new CslGenFieldInst(d, src, "inst0");
        StringBuilder out = new StringBuilder();
        fi.appendPrintedCsl(out);
        String t = out.toString();
        assertTrue(t.contains("myField"));
        assertTrue(t.contains("inst0"));
    }
}
