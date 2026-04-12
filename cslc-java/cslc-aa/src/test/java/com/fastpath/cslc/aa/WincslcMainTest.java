package com.fastpath.cslc.aa;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import org.junit.jupiter.api.Test;

class WincslcMainTest {

    @Test
    void mainRuns() {
        assertDoesNotThrow(() -> WincslcMain.main(new String[0]));
    }
}
