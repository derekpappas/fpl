package com.fastpath.cslc.csim;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertSame;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CsimSimulatorStubTest {

    @BeforeEach
    void resetSingleton() {
        CsimSimulatorStub.getInstance().resetForTesting();
    }

    @Test
    void instanceIsSingleton() {
        assertSame(CsimSimulatorPort.instance(), CsimSimulatorPort.instance());
    }

    @Test
    void cycleIsNoOp() {
        assertDoesNotThrow(() -> CsimSimulatorPort.instance().cycle());
    }
}
