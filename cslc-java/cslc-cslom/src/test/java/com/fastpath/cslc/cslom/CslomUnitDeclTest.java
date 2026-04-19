package com.fastpath.cslc.cslom;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;

import org.junit.jupiter.api.Test;

class CslomUnitDeclTest {

    @Test
    void unitDeclIsNamedDeclWithDeclUnitType() {
        CslomUnitDecl u = new CslomUnitDecl("top", 10, 2, "f.csl");
        assertInstanceOf(CslomNamedDecl.class, u);
        assertEquals(CslomNodeType.TYPE_DECL_UNIT, u.getNodeType());
        assertEquals("top", u.declaredName().orElseThrow());
        assertEquals(10, u.getLineNumber());
    }
}
