package com.fastpath.cslc.fastpath;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import org.junit.jupiter.api.Test;

class FastPathMainTest {

    @Test
    void mainRuns() {
        assertDoesNotThrow(() -> FastPathMain.main(new String[] {"--dry-run"}));
    }
}
