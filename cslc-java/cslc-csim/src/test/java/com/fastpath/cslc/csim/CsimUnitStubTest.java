package com.fastpath.cslc.csim;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CsimUnitStubTest {

    @BeforeEach
    void resetSingleton() {
        CsimSimulatorStub.getInstance().resetForTesting();
    }

    @Test
    void registerAndResolveUnitByName() {
        CsimSimulatorStub sim = CsimSimulatorStub.getInstance();
        CsimUnitStub u = new CsimUnitStub("top", "top_i");
        sim.registerUnit(u);
        assertSame(u, sim.getUnitByName("top").orElseThrow());
        assertEquals("top_i", u.instanceName());
    }
}
