`ifndef INC_GUARD_proc_ring
`define INC_GUARD_proc_ring

`define SG_RN1_RN2_S_ADDR_UPPER_INDEX  17
`define SG_RN1_RN2_S_ADDR_LOWER_INDEX  0
`define SG_RN1_RN2_S_ADDR_WIDTH  18
`define SG_RN1_RN2_S_ADDR_RANGE `SG_RN1_RN2_S_ADDR_UPPER_INDEX:`SG_RN1_RN2_S_ADDR_LOWER_INDEX
`define SG_RN1_RN2_S_DATA_UPPER_INDEX  31
`define SG_RN1_RN2_S_DATA_LOWER_INDEX  0
`define SG_RN1_RN2_S_DATA_WIDTH  32
`define SG_RN1_RN2_S_DATA_RANGE `SG_RN1_RN2_S_DATA_UPPER_INDEX:`SG_RN1_RN2_S_DATA_LOWER_INDEX
`define SG_RN1_RN2_S_NID_UPPER_INDEX  3
`define SG_RN1_RN2_S_NID_LOWER_INDEX  0
`define SG_RN1_RN2_S_NID_WIDTH  4
`define SG_RN1_RN2_S_NID_RANGE `SG_RN1_RN2_S_NID_UPPER_INDEX:`SG_RN1_RN2_S_NID_LOWER_INDEX
`define SG_RN1_RN2_S_READY_UPPER_INDEX  0
`define SG_RN1_RN2_S_READY_LOWER_INDEX  0
`define SG_RN1_RN2_S_READY_WIDTH  1
`define SG_RN1_RN2_S_READY_RANGE `SG_RN1_RN2_S_READY_UPPER_INDEX:`SG_RN1_RN2_S_READY_LOWER_INDEX
`define SG_RN1_RN2_S_REJECT_UPPER_INDEX  0
`define SG_RN1_RN2_S_REJECT_LOWER_INDEX  0
`define SG_RN1_RN2_S_REJECT_WIDTH  1
`define SG_RN1_RN2_S_REJECT_RANGE `SG_RN1_RN2_S_REJECT_UPPER_INDEX:`SG_RN1_RN2_S_REJECT_LOWER_INDEX
`define SG_RN1_RN2_S_TYPE_UPPER_INDEX  3
`define SG_RN1_RN2_S_TYPE_LOWER_INDEX  0
`define SG_RN1_RN2_S_TYPE_WIDTH  4
`define SG_RN1_RN2_S_TYPE_RANGE `SG_RN1_RN2_S_TYPE_UPPER_INDEX:`SG_RN1_RN2_S_TYPE_LOWER_INDEX
`define SG_RN1_RN2_S_VALID_UPPER_INDEX  0
`define SG_RN1_RN2_S_VALID_LOWER_INDEX  0
`define SG_RN1_RN2_S_VALID_WIDTH  1
`define SG_RN1_RN2_S_VALID_RANGE `SG_RN1_RN2_S_VALID_UPPER_INDEX:`SG_RN1_RN2_S_VALID_LOWER_INDEX
`define SG_RN2_RN3_S_ADDR_UPPER_INDEX  17
`define SG_RN2_RN3_S_ADDR_LOWER_INDEX  0
`define SG_RN2_RN3_S_ADDR_WIDTH  18
`define SG_RN2_RN3_S_ADDR_RANGE `SG_RN2_RN3_S_ADDR_UPPER_INDEX:`SG_RN2_RN3_S_ADDR_LOWER_INDEX
`define SG_RN2_RN3_S_DATA_UPPER_INDEX  31
`define SG_RN2_RN3_S_DATA_LOWER_INDEX  0
`define SG_RN2_RN3_S_DATA_WIDTH  32
`define SG_RN2_RN3_S_DATA_RANGE `SG_RN2_RN3_S_DATA_UPPER_INDEX:`SG_RN2_RN3_S_DATA_LOWER_INDEX
`define SG_RN2_RN3_S_NID_UPPER_INDEX  3
`define SG_RN2_RN3_S_NID_LOWER_INDEX  0
`define SG_RN2_RN3_S_NID_WIDTH  4
`define SG_RN2_RN3_S_NID_RANGE `SG_RN2_RN3_S_NID_UPPER_INDEX:`SG_RN2_RN3_S_NID_LOWER_INDEX
`define SG_RN2_RN3_S_READY_UPPER_INDEX  0
`define SG_RN2_RN3_S_READY_LOWER_INDEX  0
`define SG_RN2_RN3_S_READY_WIDTH  1
`define SG_RN2_RN3_S_READY_RANGE `SG_RN2_RN3_S_READY_UPPER_INDEX:`SG_RN2_RN3_S_READY_LOWER_INDEX
`define SG_RN2_RN3_S_REJECT_UPPER_INDEX  0
`define SG_RN2_RN3_S_REJECT_LOWER_INDEX  0
`define SG_RN2_RN3_S_REJECT_WIDTH  1
`define SG_RN2_RN3_S_REJECT_RANGE `SG_RN2_RN3_S_REJECT_UPPER_INDEX:`SG_RN2_RN3_S_REJECT_LOWER_INDEX
`define SG_RN2_RN3_S_TYPE_UPPER_INDEX  3
`define SG_RN2_RN3_S_TYPE_LOWER_INDEX  0
`define SG_RN2_RN3_S_TYPE_WIDTH  4
`define SG_RN2_RN3_S_TYPE_RANGE `SG_RN2_RN3_S_TYPE_UPPER_INDEX:`SG_RN2_RN3_S_TYPE_LOWER_INDEX
`define SG_RN2_RN3_S_VALID_UPPER_INDEX  0
`define SG_RN2_RN3_S_VALID_LOWER_INDEX  0
`define SG_RN2_RN3_S_VALID_WIDTH  1
`define SG_RN2_RN3_S_VALID_RANGE `SG_RN2_RN3_S_VALID_UPPER_INDEX:`SG_RN2_RN3_S_VALID_LOWER_INDEX
`define SG_RN3_RN4_S_ADDR_UPPER_INDEX  17
`define SG_RN3_RN4_S_ADDR_LOWER_INDEX  0
`define SG_RN3_RN4_S_ADDR_WIDTH  18
`define SG_RN3_RN4_S_ADDR_RANGE `SG_RN3_RN4_S_ADDR_UPPER_INDEX:`SG_RN3_RN4_S_ADDR_LOWER_INDEX
`define SG_RN3_RN4_S_DATA_UPPER_INDEX  31
`define SG_RN3_RN4_S_DATA_LOWER_INDEX  0
`define SG_RN3_RN4_S_DATA_WIDTH  32
`define SG_RN3_RN4_S_DATA_RANGE `SG_RN3_RN4_S_DATA_UPPER_INDEX:`SG_RN3_RN4_S_DATA_LOWER_INDEX
`define SG_RN3_RN4_S_NID_UPPER_INDEX  3
`define SG_RN3_RN4_S_NID_LOWER_INDEX  0
`define SG_RN3_RN4_S_NID_WIDTH  4
`define SG_RN3_RN4_S_NID_RANGE `SG_RN3_RN4_S_NID_UPPER_INDEX:`SG_RN3_RN4_S_NID_LOWER_INDEX
`define SG_RN3_RN4_S_READY_UPPER_INDEX  0
`define SG_RN3_RN4_S_READY_LOWER_INDEX  0
`define SG_RN3_RN4_S_READY_WIDTH  1
`define SG_RN3_RN4_S_READY_RANGE `SG_RN3_RN4_S_READY_UPPER_INDEX:`SG_RN3_RN4_S_READY_LOWER_INDEX
`define SG_RN3_RN4_S_REJECT_UPPER_INDEX  0
`define SG_RN3_RN4_S_REJECT_LOWER_INDEX  0
`define SG_RN3_RN4_S_REJECT_WIDTH  1
`define SG_RN3_RN4_S_REJECT_RANGE `SG_RN3_RN4_S_REJECT_UPPER_INDEX:`SG_RN3_RN4_S_REJECT_LOWER_INDEX
`define SG_RN3_RN4_S_TYPE_UPPER_INDEX  3
`define SG_RN3_RN4_S_TYPE_LOWER_INDEX  0
`define SG_RN3_RN4_S_TYPE_WIDTH  4
`define SG_RN3_RN4_S_TYPE_RANGE `SG_RN3_RN4_S_TYPE_UPPER_INDEX:`SG_RN3_RN4_S_TYPE_LOWER_INDEX
`define SG_RN3_RN4_S_VALID_UPPER_INDEX  0
`define SG_RN3_RN4_S_VALID_LOWER_INDEX  0
`define SG_RN3_RN4_S_VALID_WIDTH  1
`define SG_RN3_RN4_S_VALID_RANGE `SG_RN3_RN4_S_VALID_UPPER_INDEX:`SG_RN3_RN4_S_VALID_LOWER_INDEX
`define SG_RN4_RN5_S_ADDR_UPPER_INDEX  17
`define SG_RN4_RN5_S_ADDR_LOWER_INDEX  0
`define SG_RN4_RN5_S_ADDR_WIDTH  18
`define SG_RN4_RN5_S_ADDR_RANGE `SG_RN4_RN5_S_ADDR_UPPER_INDEX:`SG_RN4_RN5_S_ADDR_LOWER_INDEX
`define SG_RN4_RN5_S_DATA_UPPER_INDEX  31
`define SG_RN4_RN5_S_DATA_LOWER_INDEX  0
`define SG_RN4_RN5_S_DATA_WIDTH  32
`define SG_RN4_RN5_S_DATA_RANGE `SG_RN4_RN5_S_DATA_UPPER_INDEX:`SG_RN4_RN5_S_DATA_LOWER_INDEX
`define SG_RN4_RN5_S_NID_UPPER_INDEX  3
`define SG_RN4_RN5_S_NID_LOWER_INDEX  0
`define SG_RN4_RN5_S_NID_WIDTH  4
`define SG_RN4_RN5_S_NID_RANGE `SG_RN4_RN5_S_NID_UPPER_INDEX:`SG_RN4_RN5_S_NID_LOWER_INDEX
`define SG_RN4_RN5_S_READY_UPPER_INDEX  0
`define SG_RN4_RN5_S_READY_LOWER_INDEX  0
`define SG_RN4_RN5_S_READY_WIDTH  1
`define SG_RN4_RN5_S_READY_RANGE `SG_RN4_RN5_S_READY_UPPER_INDEX:`SG_RN4_RN5_S_READY_LOWER_INDEX
`define SG_RN4_RN5_S_REJECT_UPPER_INDEX  0
`define SG_RN4_RN5_S_REJECT_LOWER_INDEX  0
`define SG_RN4_RN5_S_REJECT_WIDTH  1
`define SG_RN4_RN5_S_REJECT_RANGE `SG_RN4_RN5_S_REJECT_UPPER_INDEX:`SG_RN4_RN5_S_REJECT_LOWER_INDEX
`define SG_RN4_RN5_S_TYPE_UPPER_INDEX  3
`define SG_RN4_RN5_S_TYPE_LOWER_INDEX  0
`define SG_RN4_RN5_S_TYPE_WIDTH  4
`define SG_RN4_RN5_S_TYPE_RANGE `SG_RN4_RN5_S_TYPE_UPPER_INDEX:`SG_RN4_RN5_S_TYPE_LOWER_INDEX
`define SG_RN4_RN5_S_VALID_UPPER_INDEX  0
`define SG_RN4_RN5_S_VALID_LOWER_INDEX  0
`define SG_RN4_RN5_S_VALID_WIDTH  1
`define SG_RN4_RN5_S_VALID_RANGE `SG_RN4_RN5_S_VALID_UPPER_INDEX:`SG_RN4_RN5_S_VALID_LOWER_INDEX
`define SG_RN5_RN6_S_ADDR_UPPER_INDEX  17
`define SG_RN5_RN6_S_ADDR_LOWER_INDEX  0
`define SG_RN5_RN6_S_ADDR_WIDTH  18
`define SG_RN5_RN6_S_ADDR_RANGE `SG_RN5_RN6_S_ADDR_UPPER_INDEX:`SG_RN5_RN6_S_ADDR_LOWER_INDEX
`define SG_RN5_RN6_S_DATA_UPPER_INDEX  31
`define SG_RN5_RN6_S_DATA_LOWER_INDEX  0
`define SG_RN5_RN6_S_DATA_WIDTH  32
`define SG_RN5_RN6_S_DATA_RANGE `SG_RN5_RN6_S_DATA_UPPER_INDEX:`SG_RN5_RN6_S_DATA_LOWER_INDEX
`define SG_RN5_RN6_S_NID_UPPER_INDEX  3
`define SG_RN5_RN6_S_NID_LOWER_INDEX  0
`define SG_RN5_RN6_S_NID_WIDTH  4
`define SG_RN5_RN6_S_NID_RANGE `SG_RN5_RN6_S_NID_UPPER_INDEX:`SG_RN5_RN6_S_NID_LOWER_INDEX
`define SG_RN5_RN6_S_READY_UPPER_INDEX  0
`define SG_RN5_RN6_S_READY_LOWER_INDEX  0
`define SG_RN5_RN6_S_READY_WIDTH  1
`define SG_RN5_RN6_S_READY_RANGE `SG_RN5_RN6_S_READY_UPPER_INDEX:`SG_RN5_RN6_S_READY_LOWER_INDEX
`define SG_RN5_RN6_S_REJECT_UPPER_INDEX  0
`define SG_RN5_RN6_S_REJECT_LOWER_INDEX  0
`define SG_RN5_RN6_S_REJECT_WIDTH  1
`define SG_RN5_RN6_S_REJECT_RANGE `SG_RN5_RN6_S_REJECT_UPPER_INDEX:`SG_RN5_RN6_S_REJECT_LOWER_INDEX
`define SG_RN5_RN6_S_TYPE_UPPER_INDEX  3
`define SG_RN5_RN6_S_TYPE_LOWER_INDEX  0
`define SG_RN5_RN6_S_TYPE_WIDTH  4
`define SG_RN5_RN6_S_TYPE_RANGE `SG_RN5_RN6_S_TYPE_UPPER_INDEX:`SG_RN5_RN6_S_TYPE_LOWER_INDEX
`define SG_RN5_RN6_S_VALID_UPPER_INDEX  0
`define SG_RN5_RN6_S_VALID_LOWER_INDEX  0
`define SG_RN5_RN6_S_VALID_WIDTH  1
`define SG_RN5_RN6_S_VALID_RANGE `SG_RN5_RN6_S_VALID_UPPER_INDEX:`SG_RN5_RN6_S_VALID_LOWER_INDEX
`define SG_RN6_RN7_S_ADDR_UPPER_INDEX  17
`define SG_RN6_RN7_S_ADDR_LOWER_INDEX  0
`define SG_RN6_RN7_S_ADDR_WIDTH  18
`define SG_RN6_RN7_S_ADDR_RANGE `SG_RN6_RN7_S_ADDR_UPPER_INDEX:`SG_RN6_RN7_S_ADDR_LOWER_INDEX
`define SG_RN6_RN7_S_DATA_UPPER_INDEX  31
`define SG_RN6_RN7_S_DATA_LOWER_INDEX  0
`define SG_RN6_RN7_S_DATA_WIDTH  32
`define SG_RN6_RN7_S_DATA_RANGE `SG_RN6_RN7_S_DATA_UPPER_INDEX:`SG_RN6_RN7_S_DATA_LOWER_INDEX
`define SG_RN6_RN7_S_NID_UPPER_INDEX  3
`define SG_RN6_RN7_S_NID_LOWER_INDEX  0
`define SG_RN6_RN7_S_NID_WIDTH  4
`define SG_RN6_RN7_S_NID_RANGE `SG_RN6_RN7_S_NID_UPPER_INDEX:`SG_RN6_RN7_S_NID_LOWER_INDEX
`define SG_RN6_RN7_S_READY_UPPER_INDEX  0
`define SG_RN6_RN7_S_READY_LOWER_INDEX  0
`define SG_RN6_RN7_S_READY_WIDTH  1
`define SG_RN6_RN7_S_READY_RANGE `SG_RN6_RN7_S_READY_UPPER_INDEX:`SG_RN6_RN7_S_READY_LOWER_INDEX
`define SG_RN6_RN7_S_REJECT_UPPER_INDEX  0
`define SG_RN6_RN7_S_REJECT_LOWER_INDEX  0
`define SG_RN6_RN7_S_REJECT_WIDTH  1
`define SG_RN6_RN7_S_REJECT_RANGE `SG_RN6_RN7_S_REJECT_UPPER_INDEX:`SG_RN6_RN7_S_REJECT_LOWER_INDEX
`define SG_RN6_RN7_S_TYPE_UPPER_INDEX  3
`define SG_RN6_RN7_S_TYPE_LOWER_INDEX  0
`define SG_RN6_RN7_S_TYPE_WIDTH  4
`define SG_RN6_RN7_S_TYPE_RANGE `SG_RN6_RN7_S_TYPE_UPPER_INDEX:`SG_RN6_RN7_S_TYPE_LOWER_INDEX
`define SG_RN6_RN7_S_VALID_UPPER_INDEX  0
`define SG_RN6_RN7_S_VALID_LOWER_INDEX  0
`define SG_RN6_RN7_S_VALID_WIDTH  1
`define SG_RN6_RN7_S_VALID_RANGE `SG_RN6_RN7_S_VALID_UPPER_INDEX:`SG_RN6_RN7_S_VALID_LOWER_INDEX
`define SG_RN7_RN8_S_ADDR_UPPER_INDEX  17
`define SG_RN7_RN8_S_ADDR_LOWER_INDEX  0
`define SG_RN7_RN8_S_ADDR_WIDTH  18
`define SG_RN7_RN8_S_ADDR_RANGE `SG_RN7_RN8_S_ADDR_UPPER_INDEX:`SG_RN7_RN8_S_ADDR_LOWER_INDEX
`define SG_RN7_RN8_S_DATA_UPPER_INDEX  31
`define SG_RN7_RN8_S_DATA_LOWER_INDEX  0
`define SG_RN7_RN8_S_DATA_WIDTH  32
`define SG_RN7_RN8_S_DATA_RANGE `SG_RN7_RN8_S_DATA_UPPER_INDEX:`SG_RN7_RN8_S_DATA_LOWER_INDEX
`define SG_RN7_RN8_S_NID_UPPER_INDEX  3
`define SG_RN7_RN8_S_NID_LOWER_INDEX  0
`define SG_RN7_RN8_S_NID_WIDTH  4
`define SG_RN7_RN8_S_NID_RANGE `SG_RN7_RN8_S_NID_UPPER_INDEX:`SG_RN7_RN8_S_NID_LOWER_INDEX
`define SG_RN7_RN8_S_READY_UPPER_INDEX  0
`define SG_RN7_RN8_S_READY_LOWER_INDEX  0
`define SG_RN7_RN8_S_READY_WIDTH  1
`define SG_RN7_RN8_S_READY_RANGE `SG_RN7_RN8_S_READY_UPPER_INDEX:`SG_RN7_RN8_S_READY_LOWER_INDEX
`define SG_RN7_RN8_S_REJECT_UPPER_INDEX  0
`define SG_RN7_RN8_S_REJECT_LOWER_INDEX  0
`define SG_RN7_RN8_S_REJECT_WIDTH  1
`define SG_RN7_RN8_S_REJECT_RANGE `SG_RN7_RN8_S_REJECT_UPPER_INDEX:`SG_RN7_RN8_S_REJECT_LOWER_INDEX
`define SG_RN7_RN8_S_TYPE_UPPER_INDEX  3
`define SG_RN7_RN8_S_TYPE_LOWER_INDEX  0
`define SG_RN7_RN8_S_TYPE_WIDTH  4
`define SG_RN7_RN8_S_TYPE_RANGE `SG_RN7_RN8_S_TYPE_UPPER_INDEX:`SG_RN7_RN8_S_TYPE_LOWER_INDEX
`define SG_RN7_RN8_S_VALID_UPPER_INDEX  0
`define SG_RN7_RN8_S_VALID_LOWER_INDEX  0
`define SG_RN7_RN8_S_VALID_WIDTH  1
`define SG_RN7_RN8_S_VALID_RANGE `SG_RN7_RN8_S_VALID_UPPER_INDEX:`SG_RN7_RN8_S_VALID_LOWER_INDEX
`define SG_RN8_RN9_S_ADDR_UPPER_INDEX  17
`define SG_RN8_RN9_S_ADDR_LOWER_INDEX  0
`define SG_RN8_RN9_S_ADDR_WIDTH  18
`define SG_RN8_RN9_S_ADDR_RANGE `SG_RN8_RN9_S_ADDR_UPPER_INDEX:`SG_RN8_RN9_S_ADDR_LOWER_INDEX
`define SG_RN8_RN9_S_DATA_UPPER_INDEX  31
`define SG_RN8_RN9_S_DATA_LOWER_INDEX  0
`define SG_RN8_RN9_S_DATA_WIDTH  32
`define SG_RN8_RN9_S_DATA_RANGE `SG_RN8_RN9_S_DATA_UPPER_INDEX:`SG_RN8_RN9_S_DATA_LOWER_INDEX
`define SG_RN8_RN9_S_NID_UPPER_INDEX  3
`define SG_RN8_RN9_S_NID_LOWER_INDEX  0
`define SG_RN8_RN9_S_NID_WIDTH  4
`define SG_RN8_RN9_S_NID_RANGE `SG_RN8_RN9_S_NID_UPPER_INDEX:`SG_RN8_RN9_S_NID_LOWER_INDEX
`define SG_RN8_RN9_S_READY_UPPER_INDEX  0
`define SG_RN8_RN9_S_READY_LOWER_INDEX  0
`define SG_RN8_RN9_S_READY_WIDTH  1
`define SG_RN8_RN9_S_READY_RANGE `SG_RN8_RN9_S_READY_UPPER_INDEX:`SG_RN8_RN9_S_READY_LOWER_INDEX
`define SG_RN8_RN9_S_REJECT_UPPER_INDEX  0
`define SG_RN8_RN9_S_REJECT_LOWER_INDEX  0
`define SG_RN8_RN9_S_REJECT_WIDTH  1
`define SG_RN8_RN9_S_REJECT_RANGE `SG_RN8_RN9_S_REJECT_UPPER_INDEX:`SG_RN8_RN9_S_REJECT_LOWER_INDEX
`define SG_RN8_RN9_S_TYPE_UPPER_INDEX  3
`define SG_RN8_RN9_S_TYPE_LOWER_INDEX  0
`define SG_RN8_RN9_S_TYPE_WIDTH  4
`define SG_RN8_RN9_S_TYPE_RANGE `SG_RN8_RN9_S_TYPE_UPPER_INDEX:`SG_RN8_RN9_S_TYPE_LOWER_INDEX
`define SG_RN8_RN9_S_VALID_UPPER_INDEX  0
`define SG_RN8_RN9_S_VALID_LOWER_INDEX  0
`define SG_RN8_RN9_S_VALID_WIDTH  1
`define SG_RN8_RN9_S_VALID_RANGE `SG_RN8_RN9_S_VALID_UPPER_INDEX:`SG_RN8_RN9_S_VALID_LOWER_INDEX
`define SG_RN9_RN1_S_ADDR_UPPER_INDEX  17
`define SG_RN9_RN1_S_ADDR_LOWER_INDEX  0
`define SG_RN9_RN1_S_ADDR_WIDTH  18
`define SG_RN9_RN1_S_ADDR_RANGE `SG_RN9_RN1_S_ADDR_UPPER_INDEX:`SG_RN9_RN1_S_ADDR_LOWER_INDEX
`define SG_RN9_RN1_S_DATA_UPPER_INDEX  31
`define SG_RN9_RN1_S_DATA_LOWER_INDEX  0
`define SG_RN9_RN1_S_DATA_WIDTH  32
`define SG_RN9_RN1_S_DATA_RANGE `SG_RN9_RN1_S_DATA_UPPER_INDEX:`SG_RN9_RN1_S_DATA_LOWER_INDEX
`define SG_RN9_RN1_S_NID_UPPER_INDEX  3
`define SG_RN9_RN1_S_NID_LOWER_INDEX  0
`define SG_RN9_RN1_S_NID_WIDTH  4
`define SG_RN9_RN1_S_NID_RANGE `SG_RN9_RN1_S_NID_UPPER_INDEX:`SG_RN9_RN1_S_NID_LOWER_INDEX
`define SG_RN9_RN1_S_READY_UPPER_INDEX  0
`define SG_RN9_RN1_S_READY_LOWER_INDEX  0
`define SG_RN9_RN1_S_READY_WIDTH  1
`define SG_RN9_RN1_S_READY_RANGE `SG_RN9_RN1_S_READY_UPPER_INDEX:`SG_RN9_RN1_S_READY_LOWER_INDEX
`define SG_RN9_RN1_S_REJECT_UPPER_INDEX  0
`define SG_RN9_RN1_S_REJECT_LOWER_INDEX  0
`define SG_RN9_RN1_S_REJECT_WIDTH  1
`define SG_RN9_RN1_S_REJECT_RANGE `SG_RN9_RN1_S_REJECT_UPPER_INDEX:`SG_RN9_RN1_S_REJECT_LOWER_INDEX
`define SG_RN9_RN1_S_TYPE_UPPER_INDEX  3
`define SG_RN9_RN1_S_TYPE_LOWER_INDEX  0
`define SG_RN9_RN1_S_TYPE_WIDTH  4
`define SG_RN9_RN1_S_TYPE_RANGE `SG_RN9_RN1_S_TYPE_UPPER_INDEX:`SG_RN9_RN1_S_TYPE_LOWER_INDEX
`define SG_RN9_RN1_S_VALID_UPPER_INDEX  0
`define SG_RN9_RN1_S_VALID_LOWER_INDEX  0
`define SG_RN9_RN1_S_VALID_WIDTH  1
`define SG_RN9_RN1_S_VALID_RANGE `SG_RN9_RN1_S_VALID_UPPER_INDEX:`SG_RN9_RN1_S_VALID_LOWER_INDEX

`endif