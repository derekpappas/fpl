package com.fastpath.cslc.cslgen;

import java.util.Arrays;

/**
 * Legacy constants from {@code trunk/cslc/trunk/csl_gen/cslIsa.h} ({@code NSCSLinterconnect}).
 */
public final class CslGenIsaTables {

    public static final int RANDOMS_NO = 10;
    public static final int ISA_FIELD_TYPE_DECL_SIZE = 4;
    public static final int ISA_FIELD_USED_VECTOR_SIZE = 24;
    public static final int ISA_FIELD_CMD = 100;
    public static final int ISA_FIELD_TYPE_NO = 5;
    public static final int ISA_FIELD_INSTANCE_NO = 2;
    public static final int ISA_FIELDS_NO = 2;

    public static final int ISA_ELEMENT_USED_VECTOR_SIZE = 24;
    public static final int ISA_ELEMENT_CMD = 100;
    public static final int ISA_ELEMENT_TYPE_NO = 3;
    public static final int ISA_ELEMENT_INSTANCE_NO = 2;
    public static final int ISA_ELEMENTS_NO = 2;

    public static final String[] ISA_FIELD_FUNCTION = {
        "set_type",
        "get_type",
        "set_width",
        "set_range",
        "set_bitrange",
        "set_enum",
        "get_enum",
        "set_enum_item",
        "get_enum_item",
        "set_value",
        "get_value",
        "set_position",
        "set_next",
        "set_previous",
        "get_width",
        "get_upper",
        "get_lower",
        "set_offset",
        "get_offset",
        "add_allowed_range",
        "set_name",
        "get_name",
        "set_mnemonic",
        "get_mnemonic"
    };

    public static final String[] ISA_FIELD_TYPE = {"opcode", "subopcode", "address", "selector", "constant"};

    public static final String[] ISA_ELEMENT_FUNCTION = padElementFunctions();

    public static final String[] ISA_ELEMENT_TYPE = {"root_format", "instr_format", "instr"};

    private static String[] padElementFunctions() {
        String[] a = new String[ISA_ELEMENT_USED_VECTOR_SIZE];
        Arrays.fill(a, "");
        a[0] = "set_type";
        a[1] = "get_type";
        a[2] = "set_width";
        a[3] = "get_width";
        a[4] = "set_position";
        a[5] = "set_next";
        a[6] = "set_previous";
        return a;
    }

    private CslGenIsaTables() {}
}
