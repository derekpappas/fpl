package com.fastpath.cslc.cslgen;

/**
 * Legacy {@code NSCSLinterconnect::ECSLtype} ({@code trunk/cslc/trunk/csl_gen/csl_gen_base.h}).
 */
public enum CslGenCslType {
    CSL_DESIGN,
    CSL_IFC,
    CSL_UNIT,
    CSL_UNIT_INST,
    CSL_IFC_INST,
    CSL_PORT,
    CSL_SIGNAL,
    CSL_BITRANGE,
    CSL_FIELD,
    CSL_FIELD_INSTANCE,
    CSL_ENUM,
    CSL_ENUM_ITEM,
    CSL_ISA_INSTR_FORMAT,
    CSL_ISA_INSTR,
    CSL_ISA,
    /** Interconnect generator ({@code cslInterconnectGen_TB.h} / {@code cslMemory.h}) — beyond base {@code csl_gen_base.h} slice. */
    CSL_MEMORY,
    /** CDom-style names from {@code cGen_Declarations.h}; interconnect also uses {@code CSL_MEM_MAP} ({@code cslInterconnectGen_TB.h}). */
    CSL_MEMORY_MAP,
    CSL_MEMORY_MAP_PAGE,
    CSL_INSTANCE,
    CSL_ISA_FIELD,
    CSL_ISA_ELEMENT,
    CSL_FIFO,
    CSL_MEM_MAP_PAGE,
    CSL_MEM_MAP,
    /** Interconnect {@code CSL_FIELD_INST} ({@code cslInterconnectGen_TB.h}); distinct from {@link #CSL_FIELD_INSTANCE}. */
    CSL_FIELD_INST,
    CSL_REG,
    CSL_REG_FILE
}
