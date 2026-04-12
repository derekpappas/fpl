package com.fastpath.cslc.xmlwarn;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CslcLegacyErrorCodesTest {

    @Test
    void cseCspFuncFctNonBlockMatchesHeader() {
        assertEquals(34410528769L, CslcLegacyErrorCodes.CSE_CSP_FUNC_FCT_NON_BLOCK);
    }
}
