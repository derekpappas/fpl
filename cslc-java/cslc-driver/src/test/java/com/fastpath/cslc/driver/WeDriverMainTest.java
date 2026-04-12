package com.fastpath.cslc.driver;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.fastpath.cslc.xmlwarn.CslWeCollector;
import com.fastpath.cslc.xmlwarn.CslcLegacyErrorCodes;
import org.junit.jupiter.api.Test;

class WeDriverMainTest {

    @Test
    void mainRegistersExpectedError() {
        WeDriverMain.main(new String[0]);
        var snap = CslWeCollector.instance().snapshot();
        assertEquals(1, snap.size());
        assertEquals(CslcLegacyErrorCodes.CSE_CSP_FUNC_FCT_NON_BLOCK, snap.getFirst().code());
        assertEquals("mata.xml", snap.getFirst().arguments().getFirst());
        assertEquals("10", snap.getFirst().arguments().get(1));
    }
}
