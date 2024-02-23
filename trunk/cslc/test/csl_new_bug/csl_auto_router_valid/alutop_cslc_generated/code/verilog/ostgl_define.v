`ifndef INC_GUARD_ostgl
`define INC_GUARD_ostgl

`define IFC_OPIFC0_P_A_UPPER_INDEX  (DATA_WIDTH-1)
`define IFC_OPIFC0_P_A_LOWER_INDEX  (0)
`define IFC_OPIFC0_P_A_WIDTH  (DATA_WIDTH-1-0+1)
`define IFC_OPIFC0_P_A_RANGE `IFC_OPIFC0_P_A_UPPER_INDEX:`IFC_OPIFC0_P_A_LOWER_INDEX
`define IFC_OPIFC0_P_B_UPPER_INDEX  (DATA_WIDTH-1)
`define IFC_OPIFC0_P_B_LOWER_INDEX  (0)
`define IFC_OPIFC0_P_B_WIDTH  (DATA_WIDTH-1-0+1)
`define IFC_OPIFC0_P_B_RANGE `IFC_OPIFC0_P_B_UPPER_INDEX:`IFC_OPIFC0_P_B_LOWER_INDEX
`define IFC_SELIFC0_P_S_UPPER_INDEX  (0)
`define IFC_SELIFC0_P_S_LOWER_INDEX  (0)
`define IFC_SELIFC0_P_S_WIDTH  (0-0+1)
`define IFC_SELIFC0_P_S_RANGE `IFC_SELIFC0_P_S_UPPER_INDEX:`IFC_SELIFC0_P_S_LOWER_INDEX
`define IFC_OUTIFC0_P_O_UPPER_INDEX  (DATA_WIDTH-1)
`define IFC_OUTIFC0_P_O_LOWER_INDEX  (0)
`define IFC_OUTIFC0_P_O_WIDTH  (DATA_WIDTH-1-0+1)
`define IFC_OUTIFC0_P_O_RANGE `IFC_OUTIFC0_P_O_UPPER_INDEX:`IFC_OUTIFC0_P_O_LOWER_INDEX

`endif
