package com.fastpath.cslc.cslgen;

import java.util.Objects;
import java.util.random.RandomGenerator;

/**
 * Legacy constants from {@code cslInterconnectGen_TB.h} ({@code MAX_WIDTH}, {@code sig_portTypes}, {@code
 * portDirections}, etc.).
 */
public final class CslGenInterconnectConsts {

    private CslGenInterconnectConsts() {}

    /** Legacy {@code NAMES_SIZE} ({@code cslInterconnectGen_TB.h}). */
    public static final int NAMES_SIZE = 5;

    public static final int TYPE_VEC_SIZE = 16;
    public static final int DIR_VEC_SIZE = 3;
    public static final int MAX_WIDTH = 16;
    public static final int MAX_OFFSET = 16;

    public static final String[] SIG_PORT_TYPES = {
        "trireg",
        "tri",
        "wire",
        "wor",
        "wand",
        "trior",
        "tri0",
        "tri1",
        "triand",
        "supply0",
        "supply1",
        "reg",
        "integer",
        "time",
        "real",
        "realtime"
    };

    public static final String[] PORT_DIRECTIONS = {"input", "output", "inout"};

    /** Legacy {@code ECSLportModif} / {@code rand() % CSL_PORT_MODIF_MAX}. */
    public static final int PORT_MODIF_RANGE = 0;
    public static final int PORT_MODIF_WIDTH = 1;
    public static final int PORT_MODIF_OFFSET = 2;
    public static final int PORT_MODIF_MAX = 3;

    /** Legacy {@code ECSLsigModif} / {@code rand() % CSL_SIG_MODIF_MAX}. */
    public static final int SIG_MODIF_RANGE = 0;
    public static final int SIG_MODIF_WIDTH = 1;
    public static final int SIG_MODIF_OFFSET = 2;
    public static final int SIG_MODIF_BITR = 3;
    public static final int SIG_MODIF_MAX = 4;

    /** Legacy {@code ECSLbitrModif} / {@code rand() % CSL_BITR_MODIF_MAX} (always offset in trunk). */
    public static final int BITR_MODIF_OFFSET = 0;
    public static final int BITR_MODIF_MAX = 1;

    /**
     * Legacy protected {@code CSLbase::randString()} ({@code cslInterconnectGen_TB.cpp}): {@code NAMES_SIZE - 1}
     * random lowercase letters and a trailing {@code '1'}. The ported Java tree uses {@link CslGenRandString} for
     * deterministic digit names; use this when matching TB string shape exactly.
     */
    public static String tbRandString(RandomGenerator rng) {
        Objects.requireNonNull(rng, "rng");
        StringBuilder sb = new StringBuilder();
        int letters = NAMES_SIZE - 1;
        int span = 'z' - 'a';
        for (int i = 0; i < letters; i++) {
            sb.append((char) ('a' + rng.nextInt(span)));
        }
        sb.append('1');
        return sb.toString();
    }
}
