package com.fastpath.cslc.cslgen.cgentb;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CGenTbTestCounterTest {

    @Test
    void increments() {
        CGenTbTestCounter c = new CGenTbTestCounter();
        assertEquals(0, c.get());
        c.increment();
        assertEquals(1, c.get());
        c.increment();
        assertEquals(2, c.get());
    }
}
