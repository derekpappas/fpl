package com.fastpath.cslc.support;

/**
 * Port of {@code trunk/cslc/trunk/src/support/Assert.h} ({@code ASSERT(smth, msg)}).
 * In debug-style builds use {@link #check(boolean, String)}; failures throw {@link IllegalStateException}.
 */
public final class CslcAssert {

    private CslcAssert() {}

    public static void check(boolean condition, String message) {
        if (!condition) {
            System.err.println(message);
            throw new IllegalStateException(message);
        }
    }
}
