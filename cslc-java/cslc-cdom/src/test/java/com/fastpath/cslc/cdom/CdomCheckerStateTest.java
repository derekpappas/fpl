package com.fastpath.cslc.cdom;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import java.util.Set;
import org.junit.jupiter.api.Test;

class CdomCheckerStateTest {

    @Test
    void accumulatesTopModulePrefixesWithUnderscore() {
        CdomCheckerState s = new CdomCheckerState();
        s.appendTopModulePrefix("m1");
        s.appendTopModulePrefix("m2");
        assertEquals("m1_m2_", s.getTopModulePathPrefix());
    }

    @Test
    void recordsUndefinedWhenNotInScope() {
        CdomCheckerState s = new CdomCheckerState();
        s.recordUndefinedIfMissingFromScope("u1", n -> Set.of("x").contains(n));
        assertEquals(List.of("u1"), s.getUndefinedModuleNames());
        s.recordUndefinedIfMissingFromScope("u1", n -> false);
        assertEquals(List.of("u1"), s.getUndefinedModuleNames());
    }

    @Test
    void clearResets() {
        CdomCheckerState s = new CdomCheckerState();
        s.appendTopModulePrefix("a");
        s.recordUndefinedIfMissingFromScope("z", n -> false);
        s.clear();
        assertTrue(s.getTopModulePathPrefix().isEmpty());
        assertTrue(s.getUndefinedModuleNames().isEmpty());
    }
}
