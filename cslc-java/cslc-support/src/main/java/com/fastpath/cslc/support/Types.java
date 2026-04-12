package com.fastpath.cslc.support;

/**
 * Ported naming from {@code trunk/cslc/trunk/src/support/TypeDefs.h} (TInt, TUInt, TBool, …).
 */
public final class Types {
    private Types() {}

    /** Prefer {@code int} for signed widths compatible with legacy {@code TInt}. */
    public static int checkedUInt(long v) {
        if (v < 0 || v > Integer.MAX_VALUE) {
            throw new IllegalArgumentException("Value out of int range: " + v);
        }
        return (int) v;
    }
}
