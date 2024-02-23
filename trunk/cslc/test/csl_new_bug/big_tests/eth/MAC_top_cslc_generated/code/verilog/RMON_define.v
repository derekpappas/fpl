`ifndef INC_GUARD_RMON
`define INC_GUARD_RMON

`define P_CLK_UPPER_INDEX  (0)
`define P_CLK_LOWER_INDEX  (0)
`define P_CLK_WIDTH  (0-0+1)
`define P_CLK_RANGE `P_CLK_UPPER_INDEX:`P_CLK_LOWER_INDEX
`define P_RESET_UPPER_INDEX  (0)
`define P_RESET_LOWER_INDEX  (0)
`define P_RESET_WIDTH  (0-0+1)
`define P_RESET_RANGE `P_RESET_UPPER_INDEX:`P_RESET_LOWER_INDEX
`define P_TX_PKT_TYPE_RMON_UPPER_INDEX  (3-1)
`define P_TX_PKT_TYPE_RMON_LOWER_INDEX  (0)
`define P_TX_PKT_TYPE_RMON_WIDTH  (3)
`define P_TX_PKT_TYPE_RMON_RANGE `P_TX_PKT_TYPE_RMON_UPPER_INDEX:`P_TX_PKT_TYPE_RMON_LOWER_INDEX
`define P_TX_PKT_LENGTH_RMON_UPPER_INDEX  (16-1)
`define P_TX_PKT_LENGTH_RMON_LOWER_INDEX  (0)
`define P_TX_PKT_LENGTH_RMON_WIDTH  (16)
`define P_TX_PKT_LENGTH_RMON_RANGE `P_TX_PKT_LENGTH_RMON_UPPER_INDEX:`P_TX_PKT_LENGTH_RMON_LOWER_INDEX
`define P_TX_APPLY_RMON_UPPER_INDEX  (0)
`define P_TX_APPLY_RMON_LOWER_INDEX  (0)
`define P_TX_APPLY_RMON_WIDTH  (0-0+1)
`define P_TX_APPLY_RMON_RANGE `P_TX_APPLY_RMON_UPPER_INDEX:`P_TX_APPLY_RMON_LOWER_INDEX
`define P_TX_PKT_ERR_TYPE_RMON_UPPER_INDEX  (3-1)
`define P_TX_PKT_ERR_TYPE_RMON_LOWER_INDEX  (0)
`define P_TX_PKT_ERR_TYPE_RMON_WIDTH  (3)
`define P_TX_PKT_ERR_TYPE_RMON_RANGE `P_TX_PKT_ERR_TYPE_RMON_UPPER_INDEX:`P_TX_PKT_ERR_TYPE_RMON_LOWER_INDEX
`define P_RX_PKT_TYPE_RMON_UPPER_INDEX  (3-1)
`define P_RX_PKT_TYPE_RMON_LOWER_INDEX  (0)
`define P_RX_PKT_TYPE_RMON_WIDTH  (3)
`define P_RX_PKT_TYPE_RMON_RANGE `P_RX_PKT_TYPE_RMON_UPPER_INDEX:`P_RX_PKT_TYPE_RMON_LOWER_INDEX
`define P_RX_PKT_LENGTH_RMON_UPPER_INDEX  (16-1)
`define P_RX_PKT_LENGTH_RMON_LOWER_INDEX  (0)
`define P_RX_PKT_LENGTH_RMON_WIDTH  (16)
`define P_RX_PKT_LENGTH_RMON_RANGE `P_RX_PKT_LENGTH_RMON_UPPER_INDEX:`P_RX_PKT_LENGTH_RMON_LOWER_INDEX
`define P_RX_APPLY_RMON_UPPER_INDEX  (0)
`define P_RX_APPLY_RMON_LOWER_INDEX  (0)
`define P_RX_APPLY_RMON_WIDTH  (0-0+1)
`define P_RX_APPLY_RMON_RANGE `P_RX_APPLY_RMON_UPPER_INDEX:`P_RX_APPLY_RMON_LOWER_INDEX
`define P_RX_PKT_ERR_TYPE_RMON_UPPER_INDEX  (3-1)
`define P_RX_PKT_ERR_TYPE_RMON_LOWER_INDEX  (0)
`define P_RX_PKT_ERR_TYPE_RMON_WIDTH  (3)
`define P_RX_PKT_ERR_TYPE_RMON_RANGE `P_RX_PKT_ERR_TYPE_RMON_UPPER_INDEX:`P_RX_PKT_ERR_TYPE_RMON_LOWER_INDEX
`define P_CPU_RD_ADDR_UPPER_INDEX  (6-1)
`define P_CPU_RD_ADDR_LOWER_INDEX  (0)
`define P_CPU_RD_ADDR_WIDTH  (6)
`define P_CPU_RD_ADDR_RANGE `P_CPU_RD_ADDR_UPPER_INDEX:`P_CPU_RD_ADDR_LOWER_INDEX
`define P_CPU_RD_APPLY_UPPER_INDEX  (0)
`define P_CPU_RD_APPLY_LOWER_INDEX  (0)
`define P_CPU_RD_APPLY_WIDTH  (0-0+1)
`define P_CPU_RD_APPLY_RANGE `P_CPU_RD_APPLY_UPPER_INDEX:`P_CPU_RD_APPLY_LOWER_INDEX
`define P_CPU_RD_GRANT_UPPER_INDEX  (0)
`define P_CPU_RD_GRANT_LOWER_INDEX  (0)
`define P_CPU_RD_GRANT_WIDTH  (0-0+1)
`define P_CPU_RD_GRANT_RANGE `P_CPU_RD_GRANT_UPPER_INDEX:`P_CPU_RD_GRANT_LOWER_INDEX
`define P_CPU_RD_DOUT_UPPER_INDEX  (32-1)
`define P_CPU_RD_DOUT_LOWER_INDEX  (0)
`define P_CPU_RD_DOUT_WIDTH  (32)
`define P_CPU_RD_DOUT_RANGE `P_CPU_RD_DOUT_UPPER_INDEX:`P_CPU_RD_DOUT_LOWER_INDEX

`endif