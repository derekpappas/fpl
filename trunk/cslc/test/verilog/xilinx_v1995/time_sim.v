// Xilinx Verilog produced by program ngd2ver, Version M1.4.12
// Date: Tue Jan  6 20:00:39 1998
// Design file: time_sim.nga
// Device: 5202pc84-3
`timescale 1 ns/1 ps
//`uselib dir=/home/zeppelin2/tech_apps/m1_4.12/verilog/data libext=.vmd

  module preset_5k (Q, PRESET, DATA, CLK);
    output Q;
    input PRESET;
    input DATA;
    input CLK;

    wire n69, n63, n62, n61, \U21/$1I20_GTS_TRI , \Q_reg/D_IN , \Q_reg/Q_OUT , 
    \Q_reg/$1I13_GR_OR , \U24/clkio_bufsig , \U21/$1I20_GTS_TRI_2_INV , GND, VCC
    ;
    `ifdef GR_SIGNAL
      wire GR = `GR_SIGNAL ;
    `else
      wire GR ;
    `endif
    `ifdef GTS_SIGNAL
      wire GTS = `GTS_SIGNAL ;
    `else
      wire GTS ;
    `endif
    initial $sdf_annotate("time_sim.sdf");

    X_BUF U22 (.IN (PRESET), .OUT (n63));
    X_BUF U23 (.IN (DATA), .OUT (n62));
    X_OPAD Q_PAD (.PAD (Q));
    X_IPAD PRESET_PAD (.PAD (PRESET));
    X_IPAD DATA_PAD (.PAD (DATA));
    X_IPAD CLK_PAD (.PAD (CLK));
    X_BUF \U21/$1I20  (.IN (n69), .OUT (\U21/$1I20_GTS_TRI ));
    X_TRI \U21/$1I20_GTS_TRI_17  (.IN (\U21/$1I20_GTS_TRI ), .OUT (Q), .CTL 
    (\U21/$1I20_GTS_TRI_2_INV ));
    X_INV \Q_reg/SYM1  (.IN (n62), .OUT (\Q_reg/D_IN ));
    X_INV \Q_reg/SYM2  (.IN (\Q_reg/Q_OUT ), .OUT (n69));
    X_FF \Q_reg/$1I13  (.IN (\Q_reg/D_IN ), .CLK (n61), .CE (VCC), .SET (GND), 
    .RST (\Q_reg/$1I13_GR_OR ), .OUT (\Q_reg/Q_OUT ));
    X_OR2 \Q_reg/$1I13_GR_OR_16  (.IN0 (n63), .IN1 (GR), .OUT 
    (\Q_reg/$1I13_GR_OR ));
    X_CKBUF \U24/clkbuf  (.IN (\U24/clkio_bufsig ), .OUT (n61));
    X_BUF \U24/clkio_buf  (.IN (CLK), .OUT (\U24/clkio_bufsig ));
    X_INV \U21/$1I20_GTS_TRI_2_INV_18  (.IN (GTS), .OUT 
    (\U21/$1I20_GTS_TRI_2_INV ));
    X_ONE VCC_19 (.OUT (VCC));
    X_ZERO GND_20 (.OUT (GND));
    X_PD NGD2VER_PD_15 (.OUT (GR) );
    X_PD NGD2VER_PD_17 (.OUT (GTS) );
  endmodule

