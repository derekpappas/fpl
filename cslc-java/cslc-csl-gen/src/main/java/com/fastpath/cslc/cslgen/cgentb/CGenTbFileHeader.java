package com.fastpath.cslc.cslgen.cgentb;

import java.util.Objects;

/**
 * Legacy {@code buildHeader} ({@code cGenBase_tb.cpp}): primes {@code testFileHeader} with {@code "//Gen : " + binaryFileName}.
 * Generated TB sources prepend this (via {@code closeFile}) before {@code //File:} / {@code //Date:} lines.
 */
public final class CGenTbFileHeader {

    private CGenTbFileHeader() {}

    /** Same text as C++ {@code testFileHeader.append("//Gen : ").append(binaryFileName).append("\n")}. */
    public static String line(String binaryName) {
        return "//Gen : " + Objects.requireNonNull(binaryName, "binaryName") + '\n';
    }
}
