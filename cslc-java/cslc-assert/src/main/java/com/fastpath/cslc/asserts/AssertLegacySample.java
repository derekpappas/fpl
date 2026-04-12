package com.fastpath.cslc.asserts;

import com.fastpath.cslc.support.CslcAssert;

/**
 * Port of {@code trunk/cslc/trunk/assert/Assert.cpp} (debug sample using {@code Assert.h}).
 * Legacy {@code DCOUT} is represented as stderr logging.
 */
public final class AssertLegacySample {

    private AssertLegacySample() {}

    public static void runDebugSample() {
        System.err.println("salut");
        CslcAssert.check(true, "assert sample");
    }
}
