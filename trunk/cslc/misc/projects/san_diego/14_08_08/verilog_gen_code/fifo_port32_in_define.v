`ifndef INC_GUARD_fifo_port32_in
`define INC_GUARD_fifo_port32_in

`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_PKT_TAG_UPPER_INDEX  16-1
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_PKT_TAG_LOWER_INDEX  0
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_PKT_TAG_WIDTH  16
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_PKT_TAG_RANGE `IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_PKT_TAG_UPPER_INDEX:`IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_PKT_TAG_LOWER_INDEX
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_DATA_UPPER_INDEX  32-1
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_DATA_LOWER_INDEX  0
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_DATA_WIDTH  32
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_DATA_RANGE `IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_DATA_UPPER_INDEX:`IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_DATA_LOWER_INDEX
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_UPPER_INDEX  0
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_LOWER_INDEX  0
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_WIDTH  0-0+1
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_RANGE `IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_UPPER_INDEX:`IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_LOWER_INDEX
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_COUNT_UPPER_INDEX  5-1
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_COUNT_LOWER_INDEX  0
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_COUNT_WIDTH  5
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_COUNT_RANGE `IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_COUNT_UPPER_INDEX:`IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_EMPTY_COUNT_LOWER_INDEX
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_RD_UPPER_INDEX  0
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_RD_LOWER_INDEX  0
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_RD_WIDTH  0-0+1
`define IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_RD_RANGE `IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_RD_UPPER_INDEX:`IFC_IFIFO_AG_IFC_FF_P_FP_INFIFO_RD_LOWER_INDEX
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_DATA_TO_AGENTS_UPPER_INDEX  32-1
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_DATA_TO_AGENTS_LOWER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_DATA_TO_AGENTS_WIDTH  32
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_DATA_TO_AGENTS_RANGE `IFC_ACC_IFIFO_IFC_FF_P_ACC_DATA_TO_AGENTS_UPPER_INDEX:`IFC_ACC_IFIFO_IFC_FF_P_ACC_DATA_TO_AGENTS_LOWER_INDEX
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_PTAG_TO_AGENTS_UPPER_INDEX  16-1
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_PTAG_TO_AGENTS_LOWER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_PTAG_TO_AGENTS_WIDTH  16
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_PTAG_TO_AGENTS_RANGE `IFC_ACC_IFIFO_IFC_FF_P_ACC_PTAG_TO_AGENTS_UPPER_INDEX:`IFC_ACC_IFIFO_IFC_FF_P_ACC_PTAG_TO_AGENTS_LOWER_INDEX
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_WR_TO_AGENTS_UPPER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_WR_TO_AGENTS_LOWER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_WR_TO_AGENTS_WIDTH  0-0+1
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_WR_TO_AGENTS_RANGE `IFC_ACC_IFIFO_IFC_FF_P_ACC_WR_TO_AGENTS_UPPER_INDEX:`IFC_ACC_IFIFO_IFC_FF_P_ACC_WR_TO_AGENTS_LOWER_INDEX
`define IFC_ACC_IFIFO_IFC_FF_P_FP_FULL_TO_AGENTS_UPPER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_FP_FULL_TO_AGENTS_LOWER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_FP_FULL_TO_AGENTS_WIDTH  0-0+1
`define IFC_ACC_IFIFO_IFC_FF_P_FP_FULL_TO_AGENTS_RANGE `IFC_ACC_IFIFO_IFC_FF_P_FP_FULL_TO_AGENTS_UPPER_INDEX:`IFC_ACC_IFIFO_IFC_FF_P_FP_FULL_TO_AGENTS_LOWER_INDEX
`define IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_REQ_UPPER_INDEX  4-1
`define IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_REQ_LOWER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_REQ_WIDTH  4
`define IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_REQ_RANGE `IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_REQ_UPPER_INDEX:`IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_REQ_LOWER_INDEX
`define IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_DATA_UPPER_INDEX  128-1
`define IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_DATA_LOWER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_DATA_WIDTH  128
`define IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_DATA_RANGE `IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_DATA_UPPER_INDEX:`IFC_ACC_IFIFO_IFC_FF_P_FPI_CREDIT_DATA_LOWER_INDEX
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ACK_UPPER_INDEX  4-1
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ACK_LOWER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ACK_WIDTH  4
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ACK_RANGE `IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ACK_UPPER_INDEX:`IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ACK_LOWER_INDEX
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ENABLE_UPPER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ENABLE_LOWER_INDEX  0
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ENABLE_WIDTH  0-0+1
`define IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ENABLE_RANGE `IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ENABLE_UPPER_INDEX:`IFC_ACC_IFIFO_IFC_FF_P_ACC_CREDIT_ENABLE_LOWER_INDEX

`endif
