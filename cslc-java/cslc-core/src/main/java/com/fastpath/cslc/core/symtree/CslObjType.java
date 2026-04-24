package com.fastpath.cslc.core.symtree;

/**
 * Minimal Java port of legacy {@code NSSymbolTable::EObjType} (trunk {@code SymTree.h}).
 *
 * <p>This is intentionally small and can be expanded as real symbol-table users are ported.
 */
public enum CslObjType {
    DESIGN,
    USER_DEFINED,
    UNIT_DECL,
    IFC_DECL,
    SIGNAL_DECL,
    PORT_DECL,
    FIELD_DECL,
    REGISTER_FILE_DECL,
    FIFO_DECL,
    MEMMAP_DECL,
    SIGNAL_GROUP_DECL,
    BITRANGE_DECL,
    LIST_DECL,
    TESTBENCH_DECL,
    EVENT_DECL,
    ISA_FIELD_DECL,
    ISA_ELEMENT_DECL,
    ENUM_DECL,
    ENUM_ITEM_DECL,
    MEMMAP_PAGE_DECL,
    REGISTER_DECL,
    STATE_DATA_DECL,
    VECTOR_DECL,
    MEMORY_DECL,
    PIPELINE_DECL,
    PIPESTAGE_DECL,
    CONST_INT_DECL,
    PARAM_DECL
}

