package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class CslGenCslBaseTest {

    @Test
    void tracksChildrenAndNameValidity() {
        CslGenDesign d = new CslGenDesign("top");
        CslGenUnit u = new CslGenUnit(d, "u1");
        d.registerName("reserved");
        assertFalse(d.newNameIsValid("reserved"));
        assertTrue(d.newNameIsValid("other"));
        d.addChild(u);
        assertEquals(1, d.getChildrenCount());
        assertSame(u, d.getChildAt(0).orElseThrow());
    }

    @Test
    void designBuildDeclSucceeds() {
        assertTrue(new CslGenDesign("design").buildDecl());
    }
}
