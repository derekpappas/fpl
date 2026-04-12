package com.fastpath.cslc.cslgen;

import java.util.Objects;
import java.util.concurrent.ThreadLocalRandom;

/**
 * Legacy {@code randString(string)} from {@code trunk/cslc/trunk/scripts/rand.cpp} (also referenced from
 * {@code csl_gen}). Appends two decimal digits using {@code rand() % ('9' - '0') + '0'} semantics (digits {@code 0}
 * through {@code 8} only).
 */
public final class CslGenRandString {

    private static final int DIGIT_MOD = '9' - '0';

    private CslGenRandString() {}

    public static String randString(String name) {
        Objects.requireNonNull(name, "name");
        ThreadLocalRandom r = ThreadLocalRandom.current();
        return name + (char) ('0' + r.nextInt(DIGIT_MOD)) + (char) ('0' + r.nextInt(DIGIT_MOD));
    }
}
