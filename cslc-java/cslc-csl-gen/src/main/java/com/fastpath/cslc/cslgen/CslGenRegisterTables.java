package com.fastpath.cslc.cslgen;

/**
 * Tables and scalars from {@code trunk/cslc/trunk/csl_gen/cslRegister.h}.
 */
public final class CslGenRegisterTables {

    public static final short R_INSTANCE_NO = 3;
    public static final short RF_INSTANCE_NO = 3;
    public static final short R_USED_VECTOR_SIZE = 34;
    public static final short RF_USED_VECTOR_SIZE = 14;
    public static final short R_TYPE_SIZE = 10;
    public static final short R_ATRIBUT_SIZE = 4;
    public static final short REG_FILE_CMD = 100;
    public static final short REG_CMD = 100;

    public static final String[] R_COUNT_DIR = {"up", "down"};

    public static final String[] R_ATRIBUT = {"read", "write", "shadow", "read_write"};

    public static final String[] R_TYPE = {
        "atom", "cnt", "ctl", "dff", "evnt", "int", "lfsr", "sema", "statistic", "status"
    };

    public static final String[] R_FUNCTION = {
        "set_range",
        "set_type",
        "set_width",
        "set_address",
        "index_data_pair",
        "set_attribute",
        "constant",
        "set_attributes",
        "get_attributes",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "add_logic",
        "get_input_field",
        "add_logic",
        "get_output_field",
        "init_value",
        "set_value",
        "reset_value",
        "clear_value",
        "set_lock_enable_bit",
        "get_lock_enable_bit",
        "add_logic",
        "set_count_amount",
        "set_count_direction",
        "set_end_value",
        "set_start_value",
        "stop_at_end_value",
        "add_logic",
        "get_cnt_dir_signal",
        "add_logic",
        "add_logic"
    };

    public static final String[] R_ADD_LOGIC_FCT = {
        "neg_output",
        "serial_input",
        "serial_output",
        "rd_en",
        "wr_en",
        "connect_input_to_field",
        "connect_output_to_field",
        "gray_output",
        "cnt_dir_signal",
        "inc_signal",
        "dec_signal"
    };

    public static final String[] RF_FUNCTION = {
        "set_width",
        "get_width",
        "set_depth",
        "get_depth",
        "add_logic",
        "create_rtl_module",
        "set_const_value",
        "set_field",
        "set_external",
        "add_logic",
        "set_prefix",
        "directive",
        "directive",
        "directive"
    };

    public static final String[] RF_ADD_LOGIC_FCT = {"read_valid", "bypass"};

    public static final String[] RF_IOPUT = {"input", "output"};

    public static final String[] RF_DIR_CONNECT = {"inputs", "outputs", "inouts"};

    public static final String[] RF_DIRECTIVE = {
        "register_group",
        "disconnect_register_fields_from_ios",
        "connect_register_fields_to_ios"
    };

    private CslGenRegisterTables() {}
}
