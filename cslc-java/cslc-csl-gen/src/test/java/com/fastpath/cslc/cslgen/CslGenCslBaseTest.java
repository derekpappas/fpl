package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class CslGenCslBaseTest {

    @Test
    void tracksChildrenAndNameValidity() {
        CslGenDesign d = new CslGenDesign("top");
        CslGenUnit u = new CslGenUnit(d, "u1");
        d.registerName("reserved");
        assertTrue(d.getRegisteredNames().contains("reserved"));
        assertThrows(UnsupportedOperationException.class, () -> d.getRegisteredNames().clear());
        assertFalse(d.newNameIsValid("reserved"));
        assertTrue(d.newNameIsValid("other"));
        d.addChild(u);
        assertEquals(1, d.getChildrenCount());
        assertSame(u, d.getChildAt(0).orElseThrow());
        assertEquals(1, d.getChildrenOfType(CslGenCslType.CSL_UNIT).size());
        assertSame(u, d.getChildrenOfType(CslGenCslType.CSL_UNIT).get(0));
        assertTrue(d.getChildrenOfType(CslGenCslType.CSL_IFC).isEmpty());
        assertThrows(UnsupportedOperationException.class, () -> d.getChildrenOfType(CslGenCslType.CSL_UNIT).remove(0));
        assertFalse(d.newNameIsValid("u1"), "legacy newNameIsValid rejects names of existing design children");
    }

    @Test
    void designBuildDeclSucceeds() {
        assertTrue(new CslGenDesign("design").buildDecl());
    }
}
