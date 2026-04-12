package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.RepeatedTest;

class CslGenRandStringTest {

    @RepeatedTest(20)
    void appendsTwoAsciiDigitsInLegacyRange() {
        String s = CslGenRandString.randString("pre_");
        assertEquals(6, s.length());
        assertTrue(s.startsWith("pre_"));
        char d0 = s.charAt(4);
        char d1 = s.charAt(5);
        assertTrue(d0 >= '0' && d0 <= '8');
        assertTrue(d1 >= '0' && d1 <= '8');
    }
}
