package com.fastpath.cslc.fastpath;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class FplOptionsTest {

    @Test
    void defaultsMatchLegacyConstructor() {
        FplOptions o = new FplOptions();
        assertFalse(o.isNetlisting());
        assertFalse(o.isFloorPlanning());
        assertFalse(o.isAddIncludes());
        assertEquals("", o.getStringDevice());
    }
}
