package com.fastpath.cslc.cslgen;

/**
 * Port of string/numeric constants from {@code trunk/cslc/trunk/csl_gen/cGen_Consts.h}.
 * Macros like {@code GET_CLASS} are omitted (use Java methods on enums when CSLOM is ported).
 */
public final class CGenConsts {

    private CGenConsts() {}

    public static final String ENV_VAR_NAME = "WORK";
    public static final String ARG_HELP = "--help";
    public static final String RELATIVE_TEST_PATH = "/test/csl_test_gen/";
    public static final String REPORT_FILE_NAME = "/report_cg";

    public static final String VALID_TEST_DIR_SUFFIX = "_valid/";
    public static final String INVALID_TEST_DIR_SUFFIX = "_invalid/";
    public static final String VALID_TEST_HEADER = "//Type: valid\n";
    public static final String INVALID_TEST_HEADER = "//Type: invalid\n";
    public static final String TEST_EXTENSION = ".csl";

    public static final String REGRESSION_CTRL_FILE_NAME = "regression_control";
    public static final String REGRESSION_CTRL_VALID =
            "default_test_list = PF          #pass/fail\n"
                    + "execute_testsuite = 1           #enable/disable testing current testsuite\n"
                    + "is_valid = 1                    #tells if the current testsuite contains valid test\n";
    public static final String REGRESSION_CTRL_INVALID =
            "default_test_list = PF          #pass/fail\n"
                    + "execute_testsuite = 1           #enable/disable testing current testsuite\n"
                    + "is_valid = 0                    #tells if the current testsuite contains valid test\n";

    public static final String ALIGN_NONE = "";
    public static final String ALIGN_SCOPE = "  ";
    public static final String ALIGN_CSTR = "    ";
    public static final String EMPTY_STRING = "";

    public static final int OBJ_COUNT_ZERO = 0;
    public static final int OBJ_COUNT_ONE = 1;
    public static final int OBJ_COUNT_TWO = 2;

    public static final int WIDTH_DEFAULT = 1;
    public static final int DEPTH_DEFAULT = 1;
    public static final int LSB_DEFAULT = 1;
    public static final int MSB_DEFAULT = 2;
    public static final int OFFSET_DEFAULT = 1;
    public static final int CONST_ZERO = 0;
    public static final int CONST_ONE = 1;
    public static final int LOW_ALLOWED_RANGE_DEFAULT = 0;
    public static final int UP_ALLOWED_RANGE_DEFAULT = 1;
    public static final int POSITION_DEFAULT = 1;
    public static final int VALUE_DEFAULT = 1;
    public static final int WORD_WIDTH_DEFAULT = 1;
    public static final int LOW_ADDRESS_RANGE_DEFAULT = 1;
    public static final int UP_ADDRESS_RANGE_DEFAULT = 2;
    public static final int LOW_RESERVED_ADDRESS_RANGE_DEFAULT = 1;
    public static final int UP_RESERVED_ADDRESS_RANGE_DEFAULT = 2;
    public static final int ADDRESS_INCREMENT_DEFAULT = 1;
    public static final int ALIGNMENT_DEFAULT = 1;
    public static final int NEXT_ADDRESS_DEFAULT = 1;
    public static final int SYMBOL_MAX_LENGHT_DEFAULT = 1;
    public static final int DIMENSION_DEFAULT = 1;
    public static final int DIM_DEFAULT = 0;
    public static final int ID_DEFAULT = 1;
    public static final int MAX_CAPTURE_EVENTS_DEFAULT = 1;
    public static final int MAX_MISMATCHES_DEFAULT = 1;
    public static final int MAX_TRANSACTION_EVENTS_DEFAULT = 1;
    public static final int MAX_STATES_DEFAULT = 1;
    public static final int TIMEOUT_DEFAULT = 1;
    public static final int VERSION_DEFAULT = 1;
}
