package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
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
    }
}
