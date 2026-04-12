package com.fastpath.cslc.driver;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import org.junit.jupiter.api.Test;

class DriverMainsSmokeTest {

    @Test
    void adapterDriverMain() {
        assertDoesNotThrow(() -> AdapterDriverMain.main(new String[0]));
    }

    @Test
    void cdomVerilogGeneratorDriverMain() {
        assertDoesNotThrow(() -> CdomVerilogGeneratorDriverMain.main(new String[0]));
    }

    @Test
    void sdDriverMain() {
        assertDoesNotThrow(() -> SdDriverMain.main(new String[0]));
    }

    @Test
    void csimDriverMain() {
        assertDoesNotThrow(() -> CsimDriverMain.main(new String[0]));
    }
}
