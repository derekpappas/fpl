package com.fastpath.cslc.cslom;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;

class CslomNodeTypeTest {

    @Test
    void legacyCodesMatchTrunkHeader() {
        assertEquals(0, CslomNodeType.TYPE_ALL_TYPES.legacyCode());
        assertEquals(28, CslomNodeType.TYPE_COMMAND.legacyCode());
        assertEquals(40, CslomNodeType.TYPE_UNIT_INFO.legacyCode());
    }

    @Test
    void fromLegacyCodeRoundTrip() {
        assertEquals(CslomNodeType.TYPE_VECTOR, CslomNodeType.fromLegacyCode(34));
    }

    @Test
    void fromLegacyCodeRejectsUnknown() {
        assertThrows(IllegalArgumentException.class, () -> CslomNodeType.fromLegacyCode(99));
    }
}
