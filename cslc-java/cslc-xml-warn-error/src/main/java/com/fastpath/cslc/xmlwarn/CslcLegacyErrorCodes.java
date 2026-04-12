package com.fastpath.cslc.xmlwarn;

/**
 * Numeric legacy codes from {@code trunk/cslc/trunk/src/csl_xml_warn_error/CSLC_Errors.h} ({@code NSWarningErr::all_errors}).
 * Expand incrementally; values must match the C++ headers exactly.
 */
public final class CslcLegacyErrorCodes {

    private static final long _CSE = 8L;
    private static final long _CSP = 3L;
    private static final long _FUNC = 7L;

    /** Same value as {@code CSE_CSP_FUNC_FCT_NON_BLOCK}. */
    public static final long CSE_CSP_FUNC_FCT_NON_BLOCK = (_CSE << 32) + (_CSP << 24) + (_FUNC << 16) + 1;

    private CslcLegacyErrorCodes() {}
}
