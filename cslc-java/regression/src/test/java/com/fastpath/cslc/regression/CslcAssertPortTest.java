package com.fastpath.cslc.regression;

import com.fastpath.cslc.support.CslcAssert;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertThrows;

class CslcAssertPortTest {

    @Test
    void checkPasses() {
        CslcAssert.check(true, "ok");
    }

    @Test
    void checkFails() {
        assertThrows(IllegalStateException.class, () -> CslcAssert.check(false, "boom"));
    }
}
