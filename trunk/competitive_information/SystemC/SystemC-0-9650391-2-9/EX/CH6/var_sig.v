// Copyright 2003 Star Galaxy Publishing
// File: var_sig.v

module var_sig (clk_a, tmq, bds_1, bds_2, bds_3);
  input clk_a, tmq;

  output bds_1, bds_2, bds_3;
  reg bds_1, bds_2;

  reg qst_2;
  wire qst_1;

  assign qst_1 = tmq;

  always @(posedge clk_a) begin:var_sig_1
    bds_1 = qst_1;
  end

  always @(posedge clk_a) begin: var_sig_2
    qst_2 = ! tmq;
    bds_2 = qst_2;
  end

  assign bds_3 = qst_2;
endmodule
