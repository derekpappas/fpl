package com.fastpath.cslc.cslgen;

/**
 * Legacy {@code FIFO_IMP_TYPE}, {@code SYNC}, {@code FIFO_FUNCTION}, {@code FIFO_USED_VECTOR_SIZE} ({@code
 * cGenFifo_ao.h}).
 */
public final class CslGenFifoTables {

    private CslGenFifoTables() {}

    public static final int FIFO_USED_VECTOR_SIZE = 28;

    public static final String[] FIFO_IMP_TYPE = {"SRAM", "FFA"};

    public static final String[] SYNC = {"sync_fifo", "async_fifo"};

    /** Parallel to legacy {@code CSLfifo::EFlags} indices. */
    public static final String[] FIFO_FUNCTION = {
        "set_depth",
        "set_width",
        "add_logic",
        "set_physical_implementation",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "set_prefix",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic"
    };
}
