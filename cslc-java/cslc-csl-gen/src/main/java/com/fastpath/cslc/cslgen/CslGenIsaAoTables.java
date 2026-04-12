package com.fastpath.cslc.cslgen;

/**
 * Legacy constants from {@code trunk/cslc/trunk/csl_gen/cGenIsa_ao.h} ({@code NSCSLinterconnect}).
 */
public final class CslGenIsaAoTables {

    public static final int ISA_INSTR_FORMAT_USED_VECTOR_SIZE = 5;
    public static final int ISA_INSTR_USED_VECTOR_SIZE = 2;
    public static final int ISA_USED_VECTOR_SIZE = 5;
    public static final int ISA_INSTANCE_NO = 25;
    public static final int ISA_INSTR_FORMAT_CMD = 100;
    public static final int ISA_INSTR_CMD = 100;
    public static final int ISA_CMD = 100;

    public static final String[] ISA_INSTR_FORMAT_FUNCTION = {
        "set_width",
        "set_position",
        "set_next",
        "set_previous",
        "gen_decoder"
    };

    public static final String[] ISA_INSTR_FUNCTION = {"set_asm_mnemonic", "get_asm_mnemonic"};

    public static final String[] ISA_FUNCTION = {
        "set_decoder_name",
        "set_decoder_out_name_prefix",
        "set_decoder_out_name_suffix",
        "gen_decoder",
        "print"
    };

    private CslGenIsaAoTables() {}
}
