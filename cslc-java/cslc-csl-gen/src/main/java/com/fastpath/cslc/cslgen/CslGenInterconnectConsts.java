package com.fastpath.cslc.cslgen;

/**
 * Legacy constants from {@code cslInterconnectGen_TB.h} ({@code MAX_WIDTH}, {@code sig_portTypes}, {@code
 * portDirections}, etc.).
 */
public final class CslGenInterconnectConsts {

    private CslGenInterconnectConsts() {}

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
}
