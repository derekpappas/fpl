package com.fastpath.cslc.cslgen.tb;

/**
 * Legacy constants from {@code NSCslGen} in {@code trunk/cslc/trunk/csl_gen/cslGen_TB.h}.
 */
public final class CslGenTbConsts {

    private CslGenTbConsts() {}

    public static final int NAME_SIZE = 1;
    public static final int UNIT_MAX = 10;
    public static final int SIGN_MAX = 5;
    public static final int MAX_WIDTH = 32;

    public static final String[] SIGNAL_TYPES = {
        "trireg", "tri", "wire", "wor", "wand", "trior", "tri0", "tri1", "triand", "supply0", "supply1", "reg",
        "integer", "real", "realtime", "time"
    };

    public static final String[] SIGNAL_ATTR = {
        "ATTR_EN", "ATTR_STALL", "ATTR_PE", "ATTR_PS", "ATTR_MS", "ATTR_DEC", "ATTR_CLK", "ATTR_RST", "ATTR_WR_EN"
    };

    public static final String[] PORT_DIRECTIONS = {"input", "output", "inout"};
}
