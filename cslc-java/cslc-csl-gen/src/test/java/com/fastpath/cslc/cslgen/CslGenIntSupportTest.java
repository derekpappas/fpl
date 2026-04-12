package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CslGenIntSupportTest {

    @Test
    void intToStringMatchesIntToStr() {
        assertEquals("-1", CslGenInt.intToString(-1));
        assertEquals(CslGenInt.intToStr(42), CslGenInt.intToString(42));
    }
}
