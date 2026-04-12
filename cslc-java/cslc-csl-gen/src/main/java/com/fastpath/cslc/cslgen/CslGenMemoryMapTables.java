package com.fastpath.cslc.cslgen;

/**
 * Legacy constants from {@code trunk/cslc/trunk/csl_gen/cslMemoryMap.h} ({@code NSCSLinterconnect}).
 */
public final class CslGenMemoryMapTables {

    public static final int MMP_INSTANCE_NO = 3;
    public static final int MM_INSTANCE_NO = 3;
    public static final int MMP_USED_VECTOR_SIZE = 19;
    public static final int MM_USED_VECTOR_SIZE = 11;
    public static final int MM_TYPE_SIZE = 3;
    public static final int MMP_ACCESS_RIGHTS_SIZE = 4;
    public static final int MMP_CMD = 100;
    public static final int MM_CMD = 100;

    public static final String[] ENDIANESS_TYPE = {"little_endian", "big_endian"};

    public static final String[] MM_TYPE = {"hierarchical", "page", "flat"};

    public static final String[] MMP_ACCESS_RIGHTS = {
        "access_none", "access_read", "access_write", "access_read_write"
    };

    public static final String[] MMP_FUNCTION = {
        "add_address_range",
        "set_address_increment",
        "get_address_increment",
        "set_next_address",
        "get_next_address",
        "set_access_rights",
        "add_reserved_address_range",
        "add",
        "add",
        "get_lower_bound",
        "get_upper_bound",
        "set_data_word_width",
        "get_data_word_width",
        "set_alignment",
        "get_alignment",
        "set_endianess",
        "get_endianess",
        "set_symbol_max_length",
        "get_symbol_length"
    };

    public static final String[] MM_FUNCTION = {
        "auto_gen_memory_map",
        "set_top_unit",
        "add_to_memory_map",
        "set_type",
        "set_access_rights_enum",
        "set_data_word_width",
        "get_data_word_width",
        "set_prefix",
        "get_prefix",
        "set_suffix",
        "get_suffix"
    };

    private CslGenMemoryMapTables() {}
}
