package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CGenTbBuildContainersTest {

    @Test
    void runInitializesContainers() {
        CGenTbBuildContainers.run();
        assertEquals(CGenTbEslClass.CSL_FIFO, CGenTbContainers.get().eslClassForLegacyGenericStem("fifo"));
    }
}
