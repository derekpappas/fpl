package com.fastpath.cslc.support;

/**
 * Java mapping notes for {@code trunk/cslc/trunk/src/support/TypeDefs.h}.
 * Prefer {@code int}/{@code long}, {@link Integer#toUnsignedLong(int)} for unsigned wideners, and
 * {@link java.util.Optional}{@code <String>} (or plain {@link String}) instead of {@code RefString}.
 */
public final class CslTypeDefs {

    private CslTypeDefs() {}

    /** Legacy {@code #define FALSE false}. */
    public static final boolean FALSE = false;

    /** Legacy {@code #define TRUE true}. */
    public static final boolean TRUE = true;
}
