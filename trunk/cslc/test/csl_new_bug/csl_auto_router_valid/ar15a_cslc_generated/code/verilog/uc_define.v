`ifndef INC_GUARD_uc
`define INC_GUARD_uc

`define P_PCIN_UPPER_INDEX  (8-1)
`define P_PCIN_LOWER_INDEX  (0)
`define P_PCIN_WIDTH  (8)
`define P_PCIN_RANGE `P_PCIN_UPPER_INDEX:`P_PCIN_LOWER_INDEX
`define P_PCOUT_UPPER_INDEX  (16-1)
`define P_PCOUT_LOWER_INDEX  (0)
`define P_PCOUT_WIDTH  (16)
`define P_PCOUT_RANGE `P_PCOUT_UPPER_INDEX:`P_PCOUT_LOWER_INDEX
`define IFC_IFCRC_P_RESET_UPPER_INDEX  (0)
`define IFC_IFCRC_P_RESET_LOWER_INDEX  (0)
`define IFC_IFCRC_P_RESET_WIDTH  (0-0+1)
`define IFC_IFCRC_P_RESET_RANGE `IFC_IFCRC_P_RESET_UPPER_INDEX:`IFC_IFCRC_P_RESET_LOWER_INDEX
`define IFC_IFCRC_P_CLOCK_UPPER_INDEX  (0)
`define IFC_IFCRC_P_CLOCK_LOWER_INDEX  (0)
`define IFC_IFCRC_P_CLOCK_WIDTH  (0-0+1)
`define IFC_IFCRC_P_CLOCK_RANGE `IFC_IFCRC_P_CLOCK_UPPER_INDEX:`IFC_IFCRC_P_CLOCK_LOWER_INDEX

`endif