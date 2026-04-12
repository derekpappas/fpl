package com.fastpath.cslc.cslgen;

import java.util.Objects;
import java.util.concurrent.ThreadLocalRandom;
import java.util.random.RandomGenerator;

/**
 * Legacy {@code randString(string)} from {@code trunk/cslc/trunk/scripts/rand.cpp} (also referenced from
 * {@code csl_gen}). Appends two decimal digits using {@code rand() % ('9' - '0') + '0'} semantics (digits {@code 0}
 * through {@code 8} only).
 */
public final class CslGenRandString {

    private static final int DIGIT_MOD = '9' - '0';

    private CslGenRandString() {}

    /** Legacy {@code randString()} with no prefix ({@code support.h} — implementation was commented in {@code support.cpp}). */
    public static String randString() {
        return randString("");
    }

    /** Same as {@link #randString()} but draws digits from {@code rng} (deterministic tests). */
    public static String randString(RandomGenerator rng) {
        return randString("", Objects.requireNonNull(rng, "rng"));
    }

    public static String randString(String name) {
        return randString(name, ThreadLocalRandom.current());
    }

    public static String randString(String name, RandomGenerator rng) {
        Objects.requireNonNull(name, "name");
        Objects.requireNonNull(rng, "rng");
        return name + (char) ('0' + rng.nextInt(DIGIT_MOD)) + (char) ('0' + rng.nextInt(DIGIT_MOD));
    }
}
