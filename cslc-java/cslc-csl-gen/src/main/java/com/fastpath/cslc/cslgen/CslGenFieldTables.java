package com.fastpath.cslc.cslgen;

/**
 * Legacy constants from {@code trunk/cslc/trunk/csl_gen/cslField.h} ({@code NSCSLinterconnect}).
 */
public final class CslGenFieldTables {

    public static final int FIELD_INSTANCE_NO = 3;
    public static final int FIELD_USED_VECTOR_SIZE = 18;
    public static final int FIELD_CMD = 200;
    public static final int FIELD_TYPE_DECL_SIZE = 4;
    public static final int FIELDS_NO = 3;

    public static final String[] FIELD_FUNCTION = {
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
        "add_allowed_range"
    };

    private CslGenFieldTables() {}
}
