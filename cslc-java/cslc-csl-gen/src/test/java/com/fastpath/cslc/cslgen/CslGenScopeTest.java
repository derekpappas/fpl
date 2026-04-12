package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class CslGenScopeTest {

    @Test
    void addToScopeAppendsDot() {
        assertEquals("u.", CslGenScope.addToScope("", "u"));
        assertEquals("a.b.", CslGenScope.addToScope("a.", "b"));
    }

    @Test
    void removeFromScopeMatchesLegacyLoop() {
        assertEquals("", CslGenScope.removeFromScope(""));
        assertEquals("", CslGenScope.removeFromScope("x"));
        assertEquals("ab.", CslGenScope.removeFromScope("ab.cd."));
    }
}
