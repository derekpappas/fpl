`ifndef INC_GUARD_ISA
`define INC_GUARD_ISA

`define IF_OP_UPPER_INDEX  (2-1)
`define IF_OP_LOWER_INDEX (0)
`define IF_OP_WIDTH (2)
`define IF_OP_RANGE `IF_OP_UPPER_INDEX:`IF_OP_LOWER_INDEX

`define IF_OP2_UPPER_INDEX  (3-1)
`define IF_OP2_LOWER_INDEX (0)
`define IF_OP2_WIDTH (3)
`define IF_OP2_RANGE `IF_OP2_UPPER_INDEX:`IF_OP2_LOWER_INDEX

`define IF_FMT2BASE_UPPER_INDEX  (32-1)
`define IF_FMT2BASE_LOWER_INDEX (0)
`define IF_FMT2BASE_WIDTH (32)
`define IF_FMT2BASE_RANGE `IF_FMT2BASE_UPPER_INDEX:`IF_FMT2BASE_LOWER_INDEX

`define IF_FMT2BASE_IF_OP_INST_UPPER_INDEX  (1)
`define IF_FMT2BASE_IF_OP_INST_LOWER_INDEX (0)
`define IF_FMT2BASE_IF_OP_INST_RANGE `IF_FMT2BASE_IF_OP_INST_UPPER_INDEX:`IF_FMT2BASE_IF_OP_INST_LOWER_INDEX

`define IF_FMT2BASE_IF_OP2_INST_UPPER_INDEX  (2)
`define IF_FMT2BASE_IF_OP2_INST_LOWER_INDEX (0)
`define IF_FMT2BASE_IF_OP2_INST_RANGE `IF_FMT2BASE_IF_OP2_INST_UPPER_INDEX:`IF_FMT2BASE_IF_OP2_INST_LOWER_INDEX


`endif
