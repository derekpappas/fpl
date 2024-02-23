module AND2 (O, I0, I1) /* synthesis syn_black_box xc_alias="AND"*/;
    output   O;
    input    I0, I1;
endmodule
module AND3 (O, I0, I1, I2) /* synthesis syn_black_box xc_alias="AND"*/;
    output   O;
    input    I0, I1, I2;
endmodule
module AND4 (O, I0, I1, I2, I3) /* synthesis syn_black_box xc_alias="AND"*/;
    output   O;
    input    I0, I1, I2, I3;
endmodule
module AND5 (O, I0, I1, I2, I3, I4) /* synthesis syn_black_box xc_alias="AND" */;
    output   O;
    input    I0, I1, I2, I3, I4;
endmodule
module TDI(I)/*synthesis syn_black_box*/;
output I /*synthesis .ispad=1*/;
endmodule

module TCK(I)/*synthesis syn_black_box*/;
output I /*synthesis .ispad=1*/;
endmodule

module TMS(I)/*synthesis syn_black_box*/;
output I /*synthesis .ispad=1*/;
endmodule

module TDO(O) /*synthesis syn_black_box .noprune=1 */;
input  O /*synthesis .ispad=1*/;
endmodule

//
// Note: Port directions are compatable with an M1.5 patch
// available from Xilinx.
//
module MD0(I)/* synthesis syn_black_box .noprune=1 */;
output I /* synthesis .ispad=1  */;
endmodule

module MD2(I)/* synthesis syn_black_box .noprune=1 */;
output I /* synthesis .ispad=1  */;
endmodule

module MD1(O)/* synthesis syn_black_box .noprune=1 */;
input O /* synthesis  .ispad=1 */;
endmodule

module BSCAN(DRCK, IDLE, SEL1, SEL2, TDO, TCK, TDI, TDO1, TDO2, TMS) /* synthesis syn_black_box */;
  output  DRCK, IDLE, SEL1, SEL2, TDO;
  input TCK, TDI, TDO1, TDO2, TMS;
endmodule
module BUFF (O, I) /* synthesis syn_black_box xc_alias="BUF"*/;
    output   O;
    input    I;
endmodule
/* for 4000X family only */
module BUFGE(O, I) /* synthesis syn_black_box */;
    output O;
    input I;
endmodule
module BUFGLS (O, I) /* synthesis syn_black_box */;
    output   O;
    input    I ;
endmodule
module BUFG (O, I) /* synthesis syn_black_box */;
    output   O;
    input    I ;
endmodule
module BUFG_F (O, I);
    output   O;
    input    I ;

      BUFG b(O,I) /* synthesis xc_props = "FAST" */;
endmodule
module BUFGP (O, I) /* synthesis syn_black_box */;
    output   O;
    input    I ;
endmodule
module BUFGP_F (O, I);
    output   O;
    input    I ;
      BUFGP b(O,I) /* synthesis xc_props = "FAST" */;
endmodule
module BUFGS (O, I) /* synthesis syn_black_box */;
    output   O;
    input    I ;
endmodule
module BUFGS_F (O, I);
    output   O;
    input    I; 
      BUFGS b(O, I) /* synthesis xc_props = "FAST" */;
endmodule
module BUFT (O, I, T) /* synthesis syn_black_box xc_alias="TBUF"*/;
    output   O /* synthesis syn_tristate=1 */;
    input    I, T;
assign O = ~T ? I : 'bz;
endmodule
module CY4 (COUT, COUT0, A0, A1, ADD, B0, B1, C0, C1, C2, C3, C4, C5, C6, C7, CIN ) /* synthesis syn_black_box */;
    output   COUT, COUT0;
    input    A0, A1, ADD, B0, B1, C0, C1, C2, C3, C4, C5, C6, C7, CIN;
    // default unconnected input pins to 0
endmodule
module CY4_01 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_02 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_03 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_04 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_05 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_06 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_07 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_08 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_09 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_10 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_11 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_12 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_13 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_14 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_15 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_16 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_17 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_18 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_19 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_20 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_21 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_22 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_23 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_24 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_25 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_26 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_27 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_28 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_29 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_30 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_31 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_32 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_33 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_34 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_35 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_36 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_37 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_38 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_39 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_40 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_41 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module CY4_42 (C0, C1, C2, C3, C4, C5, C6, C7) /* synthesis syn_black_box .noprune=1 */;
    output   C0, C1, C2, C3, C4, C5, C6, C7;
endmodule
module FDCE (Q, C, CE, CLR, D) /* synthesis syn_black_box */;
    output   Q;
    input    C, CE, CLR, D;
endmodule
module FDC (Q, C, CLR, D);
    output   Q;
    input    C, CLR, D;
      FDCE f1(Q, C, 1'b1, CLR, D);
endmodule
module FDCE_INT (Q, C, CE, CLR, D);
    output   Q;
    input    C, CE, CLR, D;
      FDCE f1(Q, C, CE, CLR, D);
endmodule
module FDPE (Q, C, CE, D, PRE) /* synthesis syn_black_box */;
    output   Q;
    input    C, CE, D, PRE;
endmodule
module FDP (Q, C, D, PRE);
    output   Q;
    input    C, D, PRE;
      FDPE f1(Q, C, 1'b1, D, PRE);
endmodule
module FDPE_INT (Q, C, CE, D, PRE);
    output   Q;
    input    C, CE, D, PRE;
      FDPE f1(Q, C, CE, D, PRE);
endmodule
module FMAP (I1, I2, I3, I4, O) /* synthesis syn_black_box */;
    input    I1, I2, I3, I4;
    output   O;
endmodule
module FMAP_PUC (I1, I2, I3, I4, O) /* synthesis syn_black_box xc_alias="FMAP" xc_props="MAP=PUC"*/;
    input    I1, I2, I3, I4;
    output   O;
endmodule
module FMAP_PLC (I1, I2, I3, I4, O) /* synthesis syn_black_box xc_alias="FMAP" xc_props="MAP=PLC"*/;
    input    I1, I2, I3, I4;
    output   O;
endmodule
module FMAP_PUO (I1, I2, I3, I4, O) /* synthesis syn_black_box xc_alias="FMAP" xc_props="MAP=PUO"*/;
    input    I1, I2, I3, I4;
    output   O;
endmodule
module FMAP_PLO (I1, I2, I3, I4, O) /* synthesis syn_black_box xc_alias="FMAP" xc_props="MAP=PLO"*/;
    input    I1, I2, I3, I4;
    output   O;
endmodule
module HMAP (I1, I2, I3, O) /* synthesis syn_black_box */;
    input    I1, I2, I3;
    output  O;
endmodule
module HMAP_PUC (I1, I2, I3, O) /* synthesis syn_black_box xc_alias="HMAP" xc_props="MAP=PUC"*/;
    input    I1, I2, I3;
    output  O;
endmodule
module IBUF (O, I) /* synthesis syn_black_box */; 
      output   O;
      input    I /* synthesis .ispad=1 */;
endmodule
module IBUF_U (O, I) /* synthesis syn_black_box xc_alias="IBUF" xc_props="UNBONDED"*/; 
      output   O;
      input    I /* synthesis .ispad=1 */;
endmodule
module IBUF_CMOS (O, I) /* synthesis syn_black_box xc_alias="IBUF" xc_props="CMOS"*/; 
      output   O;
      input    I /* synthesis .ispad=1 */;
endmodule
module IBUF_TTL (O, I) /* synthesis syn_black_box xc_alias="IBUF" xc_props="TTL"*/; 
      output   O;
      input    I /* synthesis .ispad=1 */;
endmodule
module IFD (Q, C, D)    /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C;
    input    D /* synthesis .ispad=1 */;
      IFDX if1(Q, C, 1'b1, D);
endmodule
module IFD_F (Q, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C;
    input    D /* synthesis .ispad=1 */;
      IFDX if1(Q, C, 1'b1, D) /* synthesis xc_props = "NODELAY" */;
endmodule
module IFD_U (Q, C, D) /* synthesis xc_padmacro=1 xc_props="UNBONDED" */;
    output   Q;
    input    C;
    input    D /* synthesis .ispad=1 */;
      IFDX if1(Q, C, 1'b1, D);
endmodule
module IFD_INT (Q, C, D)      /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C;
    input D /* synthesis .ispad=1 */;
      IFDX if1(Q, C, 1'b1, D);
endmodule
module IFDI (Q, C, D)   /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C;
    input D /* synthesis .ispad=1 */;
      IFDXI ifi1(Q, C, 1'b1, D);
endmodule
module IFDI_F (Q, C, D) /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C;
    input D /* synthesis .ispad=1 */;
      IFDXI ifi1(Q, C, 1'b1, D) /* synthesis xc_props="NODELAY"*/;
endmodule
module IFDI_U (Q, C, D) /* synthesis xc_padmacro=1 xc_props="UNBONDED"*/;
    output   Q;
    input    C;
    input D /* synthesis .ispad=1 */;
      IFDXI ifi1(Q, C, 1'b1, D);
endmodule
module IFDI_INT (Q, C, D)     /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C;
    input   D /* synthesis .ispad=1 */;
      IFDXI ifi1(Q, C, 1'b1, D);
endmodule
module IFDX (Q, C, CE, D) /* synthesis syn_black_box */;
    output Q;
      input C;
      input CE;
      input D /* synthesis .ispad= 1 */;
endmodule
module IFDXI (Q, C, CE, D) /* synthesis syn_black_box */;
    output Q;
      input C;
      input CE;
      input D /* synthesis .ispad= 1 */;
endmodule
module ILD_1 (Q, D, G)  /* synthesis xc_padmacro=1 */;
    output   Q;
    input    G;
    input    D /* synthesis .ispad=1 */;
      ILDX_1 il1(Q, D, G, 1'b1);
endmodule
module ILD_1F (Q, D, G) /* synthesis xc_padmacro=1 xc_props="NODELAY"*/;
    output   Q;
    input    G;
    input    D /* synthesis .ispad=1 */;
      ILDX_1 il1(Q, D, G, 1'b1);
endmodule
module ILD_1U (Q, D, G) /* synthesis xc_padmacro=1 xc_props="UNBONDED"*/;
    output   Q;
    input    G;
    input    D /* synthesis .ispad=1 */;
      ILDX_1 il1(Q, D, G, 1'b1);
endmodule
module ILD_1_INT (Q, D, G)    /* synthesis xc_padmacro=1 */;
    output   Q;
    input    G;
    input    D /* synthesis .ispad=1 */;
      ILDX_1 il1(Q, D, G, 1'b1);
endmodule
module ILDI_1 (Q, D, G)       /* synthesis xc_padmacro=1 */;
    output   Q;
    input    G;
    input    D /* synthesis .ispad=1 */;
      ILDXI_1 ili1(Q, D, G, 1'b1);
endmodule
module ILDI_1F (Q, D, G) /* synthesis xc_padmacro=1 xc_props="NODELAY"*/;
    output   Q;
    input    G;
    input    D /* synthesis .ispad=1 */;
      ILDXI_1 ili1(Q, D, G, 1'b1);
endmodule
module ILDI_1U (Q, D, G) /* synthesis xc_padmacro=1 xc_props="UNBONDED"*/;
    output   Q;
    input    G;
    input    D /* synthesis .ispad=1 */;
      ILDXI_1 ili1(Q, D, G, 1'b1);
endmodule
module ILDI_1_INT (Q, D, G)   /* synthesis xc_padmacro=1 */;
    output   Q;
    input    G;
    input    D /* synthesis .ispad=1 */;
      ILDXI_1 ili1(Q, D, G, 1'b1);
endmodule
module ILDX_1 (Q, D, G, GE) /* synthesis syn_black_box */;
    output   Q;
      input    G;
      input    GE;
      input    D /* synthesis .ispad=1 */;
endmodule
module ILDXI_1 (Q, D, G, GE) /* synthesis syn_black_box */;
    output   Q;
      input    G;
      input    GE;
      input    D /* synthesis .ispad=1 */;
endmodule
// For Spartan-xl and 4000X only
module ILFFX (Q, D, GF, CE, C) /* synthesis syn_black_box */;
    output   Q;
    input    D /* synthesis .ispad = 1 */;
    input   GF;
    input   CE;
    input    C;
endmodule
// For Spartan-xl and 4000X only
module ILFFXI (Q, D, GF, CE, C) /* synthesis syn_black_box */;
    output   Q;
    input    D /* synthesis .ispad = 1 */;
    input   GF;
    input   CE;
    input    C;
endmodule
// For Spartan-xl and 4000X only
module ILFLX_1 (Q, D, GF, GE, G) /* synthesis syn_black_box */;
    output   Q;
    input    D /* synthesis .ispad = 1 */;
    input   GF;
    input   GE;
    input    G;
endmodule
// For Spartan-xl and 4000X only
module ILFLXI_1 (Q, D, GF, GE, G) /* synthesis syn_black_box */;
    output   Q;
    input    D /* synthesis .ispad = 1 */;
    input   GF;
    input   GE;
    input    G;
endmodule
// For Spartan-xl and 4000X only
module ILFLX (Q, D, GF, GE, G) /* synthesis xc_padmacro=1 */;
    output   Q;
    input    D /* synthesis .ispad = 1 */;
    input   GF;
    input   GE;
    input    G;
        ILFLX_1 ilflx1(.Q(Q), .D(D), .GF(GF), .GE(GE), .G(~G));
endmodule
module LDCE_1 (Q, CLR, D, G, GE) /* synthesis syn_black_box */;
    output Q;
    input CLR;
    input D;
    input G;
    input GE;
endmodule
module INV (O, I) /* synthesis syn_black_box */;
    output   O;
    input    I;
endmodule
module NAND2 (O, I0, I1) /* synthesis syn_black_box xc_alias="NAND" */;
    output   O;
    input    I0, I1;
endmodule
module NAND3 (O, I0, I1, I2) /* synthesis syn_black_box xc_alias="NAND" */;
    output   O;
    input    I0, I1, I2;
endmodule
module NAND4 (O, I0, I1, I2, I3) /* synthesis syn_black_box xc_alias="NAND"*/;
    output   O;
    input    I0, I1, I2, I3;
endmodule
module NAND5 (O, I0, I1, I2, I3, I4) /* synthesis syn_black_box xc_alias="NAND"*/;
    output   O;
    input    I0, I1, I2, I3, I4;
endmodule
module NOR2 (O, I0, I1) /* synthesis syn_black_box xc_alias="NOR"*/;
    output   O;
    input    I0, I1;
endmodule
module NOR3 (O, I0, I1, I2) /* synthesis syn_black_box xc_alias="NOR" */;
    output   O;
    input    I0, I1, I2;
endmodule
module NOR4 (O, I0, I1, I2, I3) /* synthesis syn_black_box xc_alias="NOR" */;
    output   O;
    input    I0, I1, I2, I3;
endmodule
module NOR5 (O, I0, I1, I2, I3, I4) /* synthesis syn_black_box xc_alias="NOR"*/;
    output   O;
    input    I0, I1, I2, I3, I4;
endmodule
module OBUF (O, I) /* synthesis syn_black_box */;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_F (O, I) /* synthesis syn_black_box xc_alias="OBUF" xc_props="FAST"*/;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_S (O, I) /* synthesis syn_black_box xc_alias="OBUF" xc_props="SLOW"*/;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_U (O, I) /* synthesis syn_black_box xc_alias="OBUF" xc_props="UNBONDED"*/;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_MF (O, I) /* synthesis syn_black_box xc_alias="OBUF" xc_props="MEDFAST"*/;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_MS (O, I) /* synthesis syn_black_box xc_alias="OBUF" xc_props="MEDSLOW"*/;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_CMOSCAP (O, I) /* synthesis syn_black_box xc_alias="OBUF" xc_props="CMOS, CAP"*/;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_CMOSRES (O, I) /* synthesis syn_black_box xc_alias="OBUF" xc_props="CMOS, RES"*/;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_TTLCAP (O, I) /* synthesis syn_black_box xc_alias="OBUF" xc_props="TTL, CAP"*/;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_TTLRES (O, I) /* synthesis syn_black_box xc_alias="OBUF" xc_props="TTL, RES"*/;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUF_INT (O, I) /* synthesis syn_black_box xc_alias="OBUF" */;
    output   O /* synthesis .ispad=1 */;
    input    I;
endmodule
module OBUFT (O, I, T) /* synthesis syn_black_box */;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module OBUFT_F (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" xc_props="FAST"*/;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module IOBUF_N_F (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_F i0 (IO, I, T);
    IBUF i1 (O, IO);
endmodule
module OBUFT_S (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" xc_props="SLOW"*/;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module IOBUF (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_S i0 (IO, I, T);
    IBUF i1 (O, IO);
endmodule
module IOBUF_N_S (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_S i0 (IO, I, T);
    IBUF i1 (O, IO);
endmodule
module OBUFT_U (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" xc_props="UNBONDED"*/;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module OBUFT_MF (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" xc_props="MEDFAST"*/;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module IOBUF_N_MF (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_MF i0 (IO, I, T);
    IBUF i1 (O, IO);
endmodule
module OBUFT_MS  (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" xc_props="MEDSLOW"*/;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module IOBUF_N_MS (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_MS i0 (IO, I, T);
    IBUF i1 (O, IO);
endmodule
module OBUFT_CMOSCAP (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" xc_props="CMOS, CAP"*/;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module IOBUF_CMOS_CMOSCAP (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_CMOSCAP i0 (IO, I, T);
    IBUF_CMOS i1 (O, IO);
endmodule
module OBUFT_CMOSRES (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" xc_props="CMOS, RES"*/;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module IOBUF_CMOS_CMOSRES (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_CMOSRES i0 (IO, I, T);
    IBUF_CMOS i1 (O, IO);
endmodule
module OBUFT_TTLCAP (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" xc_props="TTL, CAP"*/;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module IOBUF_TTL_TTLCAP (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_TTLCAP i0 (IO, I, T);
    IBUF_TTL i1 (O, IO);
endmodule
module IOBUF_TTL_CMOSCAP (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_CMOSCAP i0 (IO, I, T);
    IBUF_TTL i1 (O, IO);
endmodule
module OBUFT_TTLRES (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" xc_props="TTL, RES"*/;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module IOBUF_TTL_TTLRES (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_TTLRES i0 (IO, I, T);
    IBUF_TTL i1 (O, IO);
endmodule
module IOBUF_TTL_CMOSRES (O, IO, I, T);
    output O;
    inout IO /* synthesis .ispad=1 */;
    input I,T;

    OBUFT_CMOSRES i0 (IO, I, T);
    IBUF_TTL i1 (O, IO);
endmodule
module OBUFT_INT (O, I, T) /* synthesis syn_black_box xc_alias="OBUFT" */;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    I, T;
endmodule
module OFD (Q, C, D)    /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDX of1(Q, C, 1'b1, D);
endmodule
module OFD_F (Q, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDX of1(Q, C, 1'b1, D) /* synthesis xc_props="FAST"*/;
endmodule
module OFD_FU (Q, C, D) /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDX of1(Q, C, 1'b1, D) /* synthesis xc_props="FAST, UNBONDED"*/;
endmodule
module OFD_S (Q, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDX of1(Q, C, 1'b1, D) /* synthesis xc_props="SLOW"*/;
endmodule
module OFD_U (Q, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDX of1(Q, C, 1'b1, D) /* synthesis xc_props="UNBONDED"*/;
endmodule
module OFD_MF (Q, C, D) /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDX of1(Q, C, 1'b1, D) /* synthesis xc_props="MEDFAST"*/;
endmodule
module OFD_MS (Q, C, D) /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDX of1(Q, C, 1'b1, D) /* synthesis xc_props="MEDSLOW"*/;
endmodule
module OFD_INT (Q, C, D)      /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDX of1(Q, C, 1'b1, D);
endmodule
module OFDI (Q, C, D)   /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDXI ofi1(Q, C, 1'b1, D);
endmodule
module OFDI_F (Q, C, D) /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDXI ofi1(Q, C, 1'b1, D) /* synthesis xc_props="FAST"*/;
endmodule
module OFDI_S (Q, C, D) /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDXI ofi1(Q, C, 1'b1, D) /* synthesis xc_props="SLOW"*/;
endmodule
module OFDI_MF (Q, C, D)      /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDXI ofi1(Q, C, 1'b1, D) /* synthesis xc_props="MEDFAST"*/;
endmodule
module OFDI_MS (Q, C, D)      /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDXI ofi1(Q, C, 1'b1, D) /* synthesis xc_props="MEDSLOW"*/;
endmodule
module OFDI_U (Q, C, D) /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDXI ofi1(Q, C, 1'b1, D) /* synthesis xc_props="UNBONDED"*/;
endmodule
module OFDI_INT (Q, C, D)     /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDXI ofi1(Q, C, 1'b1, D);
endmodule
module OFDT (O, C, D, T)      /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTX oft1(O, C, 1'b1, D, T);
endmodule
module OFDT_F (O, C, D, T)    /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTX oft1(O, C, 1'b1, D, T) /* synthesis xc_props="FAST"*/;
endmodule
module OFDT_S (O, C, D, T)    /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTX oft1(O, C, 1'b1, D, T) /* synthesis xc_props="SLOW"*/;
endmodule
module OFDT_MF (O, C, D, T)   /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTX oft1(O, C, 1'b1, D, T) /* synthesis xc_props="MEDFAST"*/;
endmodule
module OFDT_MS (O, C, D, T)   /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTX oft1(O, C, 1'b1, D, T) /* synthesis xc_props="MEDSLOW"*/;
endmodule
module OFDT_U (O, C, D, T)    /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTX oft1(O, C, 1'b1, D, T) /* synthesis xc_props="UNBONDED"*/;
endmodule
module OFDT_INT (O, C, D, T)  /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTX oft1(O, C, 1'b1, D, T);
endmodule
module OFDTI (O, C, D, T)     /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTXI ofti1(O, C, 1'b1, D, T);
endmodule
module OFDTI_F (O, C, D, T)   /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTXI ofti1(O, C, 1'b1, D, T) /* synthesis xc_props="FAST"*/;
endmodule
module OFDTI_S (O, C, D, T)   /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTXI ofti1(O, C, 1'b1, D, T)/* synthesis xc_props="SLOW"*/;
endmodule
module OFDTI_U (O, C, D, T)   /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTXI ofti1(O, C, 1'b1, D, T) /* synthesis xc_props="UNBONDED"*/;
endmodule
module OFDTI_MF (O, C, D, T)  /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTXI ofti1(O, C, 1'b1, D, T) /* synthesis xc_props="MEDFAST"*/;
endmodule
module OFDTI_MS (O, C, D, T)  /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTXI ofti1(O, C, 1'b1, D, T)  /* synthesis xc_props="MEDSLOW"*/;
endmodule
module OFDTI_INT (O, C, D, T) /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTXI ofti1(O, C, 1'b1, D, T);
endmodule
module OFDTX (O, C, CE, D, T) /* synthesis syn_black_box */;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    C, CE, D, T;
endmodule
module OFDTXI (O, C, CE, D, T) /* synthesis syn_black_box */;
    output   O /* synthesis .ispad=1 syn_tristate=1 */;
    input    C, CE, D, T;
endmodule
module OFDX ( Q, C, CE, D) /* synthesis syn_black_box */;
    output   Q /* synthesis .ispad=1 */;
      input    C;
      input    CE;
      input    D;
endmodule
module OFDXI ( Q, C, CE, D) /* synthesis syn_black_box */;
    output   Q /* synthesis .ispad=1 */;
      input    C;
      input    CE;
      input    D;
endmodule
module OR2 (O, I0, I1) /* synthesis syn_black_box xc_alias="OR"*/;
    output   O;
    input    I0, I1;
endmodule
module OR3 (O, I0, I1, I2) /* synthesis syn_black_box xc_alias="OR" */;
    output   O;
    input    I0, I1, I2;
endmodule
module OR4 (O, I0, I1, I2, I3) /* synthesis syn_black_box xc_alias="OR" */;
    output   O;
    input    I0, I1, I2, I3;
endmodule
module OR5 (O, I0, I1, I2, I3, I4) /* synthesis syn_black_box xc_alias="OR" */;
    output   O;
    input    I0, I1, I2, I3, I4;
endmodule
module OSC4 (F8M, F500K, F16K, F490, F15) /* synthesis syn_black_box .noprune=1 */;
  output     F8M, F500K, F16K, F490, F15;
endmodule
module PULLDOWN(O) /* synthesis syn_black_box .noprune=1 */;
output O /* synthesis syn_not_a_driver=1 */;
endmodule
module PULLDOWN1 (O) /* synthesis .noprune=1 */;
output O;
 PULLDOWN p(O);
endmodule
module PULLUP(O) /* synthesis syn_black_box .noprune=1 */;
output O /* synthesis syn_not_a_driver=1 */;
endmodule
module PULLUP1 (O) /* synthesis .noprune=1 */;
output O;
 PULLUP p(O);
endmodule
// Only applicable for XC4000E, XC4000X families
module RAM16X1 (O, A0, A1, A2, A3, D, WE) /* synthesis syn_black_box */;
  output   O;
  input    A0, A1, A2, A3, D, WE;
endmodule
// Only applicable for XC4000E, XC4000X families
module RAM32X1 (O, A0, A1, A2, A3, A4, D, WE) /* synthesis syn_black_box */;
  output   O;
  input    A0, A1, A2, A3, A4, D, WE;
endmodule
module RAM16X1D (A3,A2,A1,A0,DPRA3,DPRA2,DPRA1,DPRA0,D,DPO,SPO,WE,WCLK ); // synthesis syn_black_box xc_alias="RAMD"
input D,A3,A2,A1,A0,DPRA3,DPRA2,DPRA1,DPRA0,WE,WCLK;
output DPO,SPO;
endmodule
module RDBK(DATA, RIP, TRIG) /* synthesis syn_black_box */;
  output DATA, RIP;
  input  TRIG;
endmodule
module READBACK(DATA, RIP, CLK, TRIG)/* synthesis .noprune=1 */;
  output DATA, RIP;
  input  CLK, TRIG;
  RDBK r1(.DATA(DATA), .RIP(RIP), .TRIG(TRIG));
  RDCLK r2(.I(CLK));
endmodule
module RDCLK(I) /* synthesis syn_black_box .noprune=1 */;
  input I;
endmodule
module ROM16X1 (O, A0, A1, A2, A3) /* synthesis syn_black_box */;
  output   O;
  input    A0, A1, A2, A3;
endmodule
module ROM32X1 (O, A0, A1, A2, A3, A4) /* synthesis syn_black_box */;
  output   O;
  input    A0, A1, A2, A3, A4;
endmodule
module STARTUP_CLK (CLK, Q2, Q3, Q1Q4, DONEIN) 
/* synthesis syn_black_box .noprune=1 xc_alias="STARTUP"*/ ;
    output   Q2, Q3, Q1Q4, DONEIN;
    input  CLK;
endmodule
module STARTUP_GSR (GSR) /* synthesis syn_black_box .noprune=1 */;
    input  GSR;
endmodule
module STARTUP_GTS (GTS) /* synthesis syn_black_box .noprune=1 xc_alias="STARTUP"*/;
    input  GTS;
endmodule
module STARTUP_ALL(Q2,Q3,Q1Q4,DONEIN, GSR,GTS,CLK)
/* synthesis syn_black_box .noprune=1 xc_alias="STARTUP" */ ;
output Q2,Q3, Q1Q4, DONEIN;
input GSR /* synthesis syn_defaultvalue=0 */,
      GTS /* synthesis syn_defaultvalue=0 */,
      CLK /* synthesis syn_defaultvalue=0 */;
endmodule
module STARTUP(Q2,Q3,Q1Q4,DONEIN, GSR,GTS,CLK)
/* synthesis .noprune=1 */;
output Q2,Q3, Q1Q4, DONEIN;
input GSR /* synthesis syn_defaultvalue=0 */,
      GTS /* synthesis syn_defaultvalue=0 */,
      CLK /* synthesis syn_defaultvalue=0 */;
STARTUP_GSR gsr( GSR );
STARTUP_GTS gts( GTS );
STARTUP_CLK clk(.CLK(CLK), .Q2(Q2), .Q3(Q3), .Q1Q4(Q1Q4), .DONEIN(DONEIN));
endmodule
module WAND1 (O, I) /* synthesis syn_black_box xc_alias="WAND"*/;
  output   O /* synthesis syn_tristate=1 */;
  input    I;
endmodule
module DECODE1_IO (O, I) /* synthesis xc_props="DECODE"*/;
  inout   O;
  input    I;
  WAND1 i1 (O, I);
endmodule
module DECODE1_INT (O, I) /* synthesis xc_props="DECODE"*/;
  inout   O;
  input    I;
  WAND1 i1 (O, I);
endmodule
module DECODE4 (O, A) /* synthesis xc_props="DECODE" */;
  inout O;
  input [3:0] A;
  WAND1 i0 (O, A[0]);
  WAND1 i1 (O, A[1]);
  WAND1 i2 (O, A[2]);
  WAND1 i3 (O, A[3]);
endmodule
module DECODE8 (O, A) /* synthesis xc_props="DECODE" */;
  inout O;
  input [7:0] A;
  WAND1 i0 (O, A[0]);
  WAND1 i1 (O, A[1]);
  WAND1 i2 (O, A[2]);
  WAND1 i3 (O, A[3]);
  WAND1 i4 (O, A[4]);
  WAND1 i5 (O, A[5]);
  WAND1 i6 (O, A[6]);
  WAND1 i7 (O, A[7]);
endmodule
module DECODE16 (O, A) /* synthesis xc_props="DECODE" */;
  inout O;
  input [15:0] A;
  WAND1 i0 (O, A[0]);
  WAND1 i1 (O, A[1]);
  WAND1 i2 (O, A[2]);
  WAND1 i3 (O, A[3]);
  WAND1 i4 (O, A[4]);
  WAND1 i5 (O, A[5]);
  WAND1 i6 (O, A[6]);
  WAND1 i7 (O, A[7]);
  WAND1 i8 (O, A[8]);
  WAND1 i9 (O, A[9]);
  WAND1 i10 (O, A[10]);
  WAND1 i11 (O, A[11]);
  WAND1 i12 (O, A[12]);
  WAND1 i13 (O, A[13]);
  WAND1 i14 (O, A[14]);
  WAND1 i15 (O, A[15]);
endmodule
module WOR2AND (O, I0, I1) /* synthesis syn_black_box xc_alias="WORAND"*/;
  output   O;
  input    I0, I1;
endmodule
module XGND(GROUND) /* synthesis syn_black_box .noprune=1 xc_alias="GND"*/;
  output GROUND;
endmodule
module XNOR2 (O, I0, I1) /* synthesis syn_black_box xc_alias="XNOR"*/;
    output   O;
    input    I0, I1;
endmodule
module XNOR3 (O, I0, I1, I2) /* synthesis syn_black_box xc_alias=XNOR"*/;
    output   O;
    input    I0, I1, I2;
endmodule
module XNOR4 (O, I0, I1, I2, I3) /* synthesis syn_black_box xc_alias="XNOR"*/;
    output   O;
    input    I0, I1, I2, I3;
endmodule
module XNOR5 (O, I0, I1, I2, I3, I4) /* synthesis syn_black_box xc_alias="XNOR"*/;
    output   O;
    input    I0, I1, I2, I3, I4;
endmodule
module XOR2 (O, I0, I1) /* synthesis syn_black_box xc_alias="XOR"*/;
    output   O;
    input    I0, I1;
endmodule
module XOR3 (O, I0, I1, I2) /* synthesis syn_black_box xc_alias="XOR"*/;
    output   O;
    input    I0, I1, I2;
endmodule
module XOR4 (O, I0, I1, I2, I3) /* synthesis syn_black_box xc_alias="XOR"*/;
    output   O;
    input    I0, I1, I2, I3;
endmodule
module XOR5 (O, I0, I1, I2, I3, I4) /* synthesis syn_black_box xc_alias="XOR"*/;
    output   O;
    input    I0, I1, I2, I3, I4;
endmodule
module XVCC(POWER) /* synthesis syn_black_box .noprune=1 xc_alias="VCC"*/;
  output POWER;
endmodule
module FDP_1 (Q, C, D, PRE) ;
    output   Q;
    input    C, D, PRE;
      FDPE f1(.Q(Q), .C(~C), .CE(1'b1), .D(D), .PRE(PRE));
endmodule
module FDPE_1 (Q, C, CE, D, PRE);
    output   Q;
    input    C, CE, D, PRE;
      FDPE f1(.Q(Q), .C(~C), .CE(CE), .D(D), .PRE(PRE));
endmodule
module IFD_1 (Q, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C;
    input    D /* synthesis .ispad=1 */;
      IFDX if1 (.Q(Q), .C(~C), .CE(1'b1), .D(D));
endmodule
module IFDX_F (Q, C, D, CE)   /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C, CE;
    input    D /* synthesis .ispad=1 */;
      IFDX if1 (.Q(Q), .C(C), .CE(CE), .D(D)) /* synthesis xc_props="NODELAY"*/;
endmodule
module IFDX_1 (Q, C, D, CE)   /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C, CE;
    input    D /* synthesis .ispad=1 */;
      IFDX if1 (.Q(Q), .C(~C), .CE(CE), .D(D));
endmodule
module IFDXI_F (Q, CE, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C, CE;
    input D /* synthesis .ispad=1 */;
      IFDXI ifi1 (.Q(Q), .C(C), .CE(CE), .D(D)) /* synthesis xc_props="NODELAY"*/;
endmodule
module IFDXI_1 (Q, CE, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q;
    input    C, CE;
    input D /* synthesis .ispad=1 */;
      IFDXI ifi1 (.Q(Q), .C(~C), .CE(CE), .D(D));
endmodule
module ILD (Q, D, G)    /* synthesis xc_padmacro=1 */;
    output   Q;
    input    G;
    input    D /* synthesis .ispad=1 */;
      ILDX_1 il1( .Q(Q), .D(D), .G(~G), .GE(1'b1) );
endmodule
module ILDX (Q, D, GE, G)     /* synthesis xc_padmacro=1 */;
    output   Q;
    input    G, GE;
    input    D /* synthesis .ispad=1 */;
      ILDX_1 il1( .Q(Q), .D(D), .G(~G), .GE(GE) );
endmodule
module ILDXI (Q, D, GE, G)    /* synthesis xc_padmacro=1 */;
    output   Q;
    input    G, GE;
    input    D /* synthesis .ispad=1 */;
      ILDXI_1 ili1(.Q(Q), .D(D), .G(~G), .GE(GE));
endmodule
module OFD_1 (Q, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D;
      OFDX of1(.Q(Q), .C(~C), .CE(1'b1), .D(D));
endmodule
module OFDT_1 (O, C, D, T)    /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, T;
      OFDTX of1 (.O(O), .C(~C), .CE(1'b1), .D(D), .T(T));
endmodule
module OFDTX_F (O, CE, C, D, T)     /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, CE, T;
      OFDTX of1 (.O(O), .C(C), .CE(CE), .D(D), .T(T))  /* synthesis xc_props="FAST"*/ ;
endmodule
module OFDTX_1 (O, C, CE, D, T)     /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, CE, D, T;
      OFDTX of1 (.O(O), .C(~C), .CE(CE), .D(D), .T(T));
endmodule
module OFDTXI_F (O, CE, C, D, T)    /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, D, CE, T;
      OFDTXI ofi1 (.O(O), .C(C), .CE(CE), .D(D), .T(T)) /* synthesis xc_props="FAST"*/;
endmodule
module OFDTXI_1 (O, C, CE, D, T)    /* synthesis xc_padmacro=1 */;
    output   O /* synthesis .ispad=1 */;
    input    C, CE, D, T;
      OFDTXI ofi1 (.O(O), .C(~C), .CE(CE), .D(D), .T(T));
endmodule
module OFDX_F (Q, CE, C, D)   /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D, CE;
      OFDX of1(.Q(Q), .CE(CE), .C(C), .D(D)) /* synthesis xc_props="FAST"*/;
endmodule
module OFDX_1 (Q, CE, C, D)   /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D, CE;
      OFDX of1(.Q(Q), .CE(CE), .C(~C), .D(D));
endmodule
module OFDXI_F (Q, CE, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D, CE ;
      OFDXI ofi1(.Q(Q), .CE(CE), .C(C), .D(D)) /* synthesis xc_props="FAST"*/;
endmodule
module OFDXI_1 (Q, CE, C, D)  /* synthesis xc_padmacro=1 */;
    output   Q /* synthesis .ispad=1 */;
    input    C, D, CE ;
      OFDXI ofi1(.Q(Q), .CE(CE), .C(~C), .D(D));
endmodule
module RAM16X1S (O,A3,A2,A1,A0,D,WE,WCLK ); // synthesis syn_black_box
input D,A3,A2,A1,A0,WE,WCLK;
output O;
endmodule
module RAM32X1S (O,A4,A3,A2,A1,A0,D,WE,WCLK ); // synthesis syn_black_box
input D,A4,A3,A2,A1,A0,WE,WCLK;
output O;
endmodule

