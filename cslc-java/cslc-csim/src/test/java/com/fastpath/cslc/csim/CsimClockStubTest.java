package com.fastpath.cslc.csim;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CsimClockStubTest {

    @BeforeEach
    void resetSingleton() {
        CsimSimulatorStub.getInstance().resetForTesting();
    }

    @Test
    void registerAndResolveClockByName() {
        CsimSimulatorStub sim = CsimSimulatorStub.getInstance();
        CsimClockStub clk = new CsimClockStub("clk1", 5L);
        sim.registerClock(clk);
        assertSame(clk, sim.getClockByName("clk1").orElseThrow());
        assertEquals(5L, clk.getPeriod());
        clk.next();
        assertEquals(1, clk.getCycleNo());
    }
}
