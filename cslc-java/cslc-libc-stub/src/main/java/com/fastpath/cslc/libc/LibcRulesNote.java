package com.fastpath.cslc.libc;

/**
 * {@code trunk/cslc/trunk/libc/} only contains a {@code Makefile} that includes {@code ../scripts/Rules.make}.
 * There is no C runtime to port; build integration moves to Maven. JNI or {@code java.lang.foreign}
 * can be introduced here if legacy native calls appear.
 */
public final class LibcRulesNote {

    private LibcRulesNote() {}
}
