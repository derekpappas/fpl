package com.fastpath.cslc.cslgen;

/**
 * Legacy {@code sig_portTypes[]} and {@code portDirections[]} ({@code csl_gen_base.h}).
 */
public final class CslGenWireTables {

    public static final short TYPE_VEC_SIZE = 16;
    public static final short DIR_VEC_SIZE = 3;

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

    private CslGenWireTables() {}
}
