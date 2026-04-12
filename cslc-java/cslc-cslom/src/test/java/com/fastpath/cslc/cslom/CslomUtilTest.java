package com.fastpath.cslc.cslom;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Optional;
import org.junit.jupiter.api.Test;

class CslomUtilTest {

    @Test
    void ltosMatchesUnsignedDecimal() {
        assertEquals("0", CslomUtil.ltos(0L));
        assertEquals("42", CslomUtil.ltos(42L));
        assertEquals("18446744073709551615", CslomUtil.ltos(-1L));
    }

    @Test
    void checkIdNameRejectsDot() {
        Optional<com.fastpath.cslc.errors.CslcMessage> msg =
                CslomUtil.checkIdName("a.b", 1, Optional.of("f.csl"));
        assertTrue(msg.isPresent());
        assertEquals("CSE_CSC_ID_ILLEGAL", msg.get().code());
    }

    @Test
    void checkIdNameAcceptsSimple() {
        assertTrue(CslomUtil.checkIdName("id_ok", 1, Optional.empty()).isEmpty());
    }

    @Test
    void checkIdNameRejectsEmpty() {
        assertThrows(IllegalArgumentException.class, () -> CslomUtil.checkIdName("", 1, Optional.empty()));
    }
}
