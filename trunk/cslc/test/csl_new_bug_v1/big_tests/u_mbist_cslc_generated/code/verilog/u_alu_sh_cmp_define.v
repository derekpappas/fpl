`ifndef INC_GUARD_u_alu_sh_cmp
`define INC_GUARD_u_alu_sh_cmp

`define IFC_IFC_OP0_P_OP1_UPPER_INDEX  (15)
`define IFC_IFC_OP0_P_OP1_LOWER_INDEX  (0)
`define IFC_IFC_OP0_P_OP1_WIDTH  (15-0+1)
`define IFC_IFC_OP0_P_OP1_RANGE `IFC_IFC_OP0_P_OP1_UPPER_INDEX:`IFC_IFC_OP0_P_OP1_LOWER_INDEX
`define IFC_IFC_OP0_P_OP2_UPPER_INDEX  (15)
`define IFC_IFC_OP0_P_OP2_LOWER_INDEX  (0)
`define IFC_IFC_OP0_P_OP2_WIDTH  (15-0+1)
`define IFC_IFC_OP0_P_OP2_RANGE `IFC_IFC_OP0_P_OP2_UPPER_INDEX:`IFC_IFC_OP0_P_OP2_LOWER_INDEX
`define IFC_IFC_OUT0_P_O_UPPER_INDEX  (15)
`define IFC_IFC_OUT0_P_O_LOWER_INDEX  (0)
`define IFC_IFC_OUT0_P_O_WIDTH  (15-0+1)
`define IFC_IFC_OUT0_P_O_RANGE `IFC_IFC_OUT0_P_O_UPPER_INDEX:`IFC_IFC_OUT0_P_O_LOWER_INDEX
`define IFC_SEL_OP_P_P_SEL_UPPER_INDEX  (3)
`define IFC_SEL_OP_P_P_SEL_LOWER_INDEX  (0)
`define IFC_SEL_OP_P_P_SEL_WIDTH  (3-0+1)
`define IFC_SEL_OP_P_P_SEL_RANGE `IFC_SEL_OP_P_P_SEL_UPPER_INDEX:`IFC_SEL_OP_P_P_SEL_LOWER_INDEX
`define P_SHAM_UPPER_INDEX  (16-1)
`define P_SHAM_LOWER_INDEX  (0)
`define P_SHAM_WIDTH  (16)
`define P_SHAM_RANGE `P_SHAM_UPPER_INDEX:`P_SHAM_LOWER_INDEX
`define P_COMPRES_UPPER_INDEX  (0)
`define P_COMPRES_LOWER_INDEX  (0)
`define P_COMPRES_WIDTH  (0-0+1)
`define P_COMPRES_RANGE `P_COMPRES_UPPER_INDEX:`P_COMPRES_LOWER_INDEX
`define S_CIN_UPPER_INDEX  (0)
`define S_CIN_LOWER_INDEX  (0)
`define S_CIN_WIDTH  (0-0+1)
`define S_CIN_RANGE `S_CIN_UPPER_INDEX:`S_CIN_LOWER_INDEX
`define S_COUT_UPPER_INDEX  (0)
`define S_COUT_LOWER_INDEX  (0)
`define S_COUT_WIDTH  (0-0+1)
`define S_COUT_RANGE `S_COUT_UPPER_INDEX:`S_COUT_LOWER_INDEX
`define S_P_TOMUX40_UPPER_INDEX  (15)
`define S_P_TOMUX40_LOWER_INDEX  (0)
`define S_P_TOMUX40_WIDTH  (15-0+1)
`define S_P_TOMUX40_RANGE `S_P_TOMUX40_UPPER_INDEX:`S_P_TOMUX40_LOWER_INDEX
`define S_P_TOMUX41_UPPER_INDEX  (15)
`define S_P_TOMUX41_LOWER_INDEX  (0)
`define S_P_TOMUX41_WIDTH  (15-0+1)
`define S_P_TOMUX41_RANGE `S_P_TOMUX41_UPPER_INDEX:`S_P_TOMUX41_LOWER_INDEX
`define S_P_TOMUX42_UPPER_INDEX  (15)
`define S_P_TOMUX42_LOWER_INDEX  (0)
`define S_P_TOMUX42_WIDTH  (15-0+1)
`define S_P_TOMUX42_RANGE `S_P_TOMUX42_UPPER_INDEX:`S_P_TOMUX42_LOWER_INDEX
`define S_P_TOMUX43_UPPER_INDEX  (15)
`define S_P_TOMUX43_LOWER_INDEX  (0)
`define S_P_TOMUX43_WIDTH  (15-0+1)
`define S_P_TOMUX43_RANGE `S_P_TOMUX43_UPPER_INDEX:`S_P_TOMUX43_LOWER_INDEX
`define SG_TOMUX40_S_P_OP1_UPPER_INDEX  (15)
`define SG_TOMUX40_S_P_OP1_LOWER_INDEX  (0)
`define SG_TOMUX40_S_P_OP1_WIDTH  (15-0+1)
`define SG_TOMUX40_S_P_OP1_RANGE `SG_TOMUX40_S_P_OP1_UPPER_INDEX:`SG_TOMUX40_S_P_OP1_LOWER_INDEX
`define SG_TOMUX40_S_P_OP2_UPPER_INDEX  (15)
`define SG_TOMUX40_S_P_OP2_LOWER_INDEX  (0)
`define SG_TOMUX40_S_P_OP2_WIDTH  (15-0+1)
`define SG_TOMUX40_S_P_OP2_RANGE `SG_TOMUX40_S_P_OP2_UPPER_INDEX:`SG_TOMUX40_S_P_OP2_LOWER_INDEX
`define SG_TOMUX41_S_P_OP1_UPPER_INDEX  (15)
`define SG_TOMUX41_S_P_OP1_LOWER_INDEX  (0)
`define SG_TOMUX41_S_P_OP1_WIDTH  (15-0+1)
`define SG_TOMUX41_S_P_OP1_RANGE `SG_TOMUX41_S_P_OP1_UPPER_INDEX:`SG_TOMUX41_S_P_OP1_LOWER_INDEX
`define SG_TOMUX41_S_P_OP2_UPPER_INDEX  (15)
`define SG_TOMUX41_S_P_OP2_LOWER_INDEX  (0)
`define SG_TOMUX41_S_P_OP2_WIDTH  (15-0+1)
`define SG_TOMUX41_S_P_OP2_RANGE `SG_TOMUX41_S_P_OP2_UPPER_INDEX:`SG_TOMUX41_S_P_OP2_LOWER_INDEX
`define SG_TOMUX42_S_P_O_UPPER_INDEX  (15)
`define SG_TOMUX42_S_P_O_LOWER_INDEX  (0)
`define SG_TOMUX42_S_P_O_WIDTH  (15-0+1)
`define SG_TOMUX42_S_P_O_RANGE `SG_TOMUX42_S_P_O_UPPER_INDEX:`SG_TOMUX42_S_P_O_LOWER_INDEX

`endif
