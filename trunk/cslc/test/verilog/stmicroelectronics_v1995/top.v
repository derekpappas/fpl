module top;
  wire lframe, clk, ic, tbl_n, wp_n, init_n, rp_n;
  wire [4:0] gpi;
  wire [4:0] rfu;
  wire [3:0] lad;
  wire [3:0] id;
  
  wire vcc, vpp, vpph, vss; 

  stim mystim(lad, lframe, rfu, id, gpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);
  m50lpw116 memory(lad, lframe, rfu, id, gpi, clk, ic, rp_n, init_n, wp_n, tbl_n, vcc, vpp, vpph, vss);

endmodule
