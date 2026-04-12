package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.RepeatedTest;
import org.junit.jupiter.api.Test;

class CslGenRandStringTest {

    @Test
    void randStringNoArgIsTwoDigits() {
        String s = CslGenRandString.randString();
        assertEquals(2, s.length());
        assertTrue(s.charAt(0) >= '0' && s.charAt(0) <= '8');
        assertTrue(s.charAt(1) >= '0' && s.charAt(1) <= '8');
    }

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
