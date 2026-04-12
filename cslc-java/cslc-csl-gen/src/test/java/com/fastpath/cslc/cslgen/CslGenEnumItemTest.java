package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenEnumItemTest {

    @Test
    void valueUnsetUntilBuildDecl() {
        CslGenEnum en = new CslGenEnum(new CslGenDesign("d"), "e");
        CslGenEnumItem it = new CslGenEnumItem(en, "x");
        assertFalse(it.isValueSet());
        assertFalse(it.isValueF());
    }

    @Test
    void buildDeclSetsValueInRange() {
        CslGenEnum en = new CslGenEnum(new CslGenDesign("d"), "e");
        CslGenEnumItem it = new CslGenEnumItem(en, "x");
        it.buildDecl(new Random(1L));
        assertTrue(it.isValueSet());
        assertTrue(it.isValueF());
        int v = it.getValue();
        assertTrue(v >= 0 && v < 100, () -> "legacy m_value = rand() % 100, got " + v);
    }
}
