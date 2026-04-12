package com.fastpath.cslc.cslgen;

/**
 * Legacy {@code intToStr} ({@code csl_gen_base.cpp}) and {@code IntToString} ({@code trunk/cslc/trunk/csl_gen/support.cpp}).
 */
public final class CslGenInt {

    private CslGenInt() {}

    public static String intToStr(int no) {
        return Integer.toString(no);
    }

    /** Same role as {@code IntToString(int)} in {@code support.cpp}. */
    public static String intToString(int number) {
        return Integer.toString(number);
    }
}
