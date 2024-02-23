//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : proc_ring.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module proc_ring();
// Location of source csl unit: file name = generated/mitch.csl line number = 22
  wire [17:0] rn1_rn2_addr;
  wire [31:0] rn1_rn2_data;
  wire [3:0] rn1_rn2_nid;
  wire rn1_rn2_ready;
  wire rn1_rn2_reject;
  wire [3:0] rn1_rn2_type;
  wire rn1_rn2_valid;
  wire [17:0] rn2_rn3_addr;
  wire [31:0] rn2_rn3_data;
  wire [3:0] rn2_rn3_nid;
  wire rn2_rn3_ready;
  wire rn2_rn3_reject;
  wire [3:0] rn2_rn3_type;
  wire rn2_rn3_valid;
  wire [17:0] rn3_rn4_addr;
  wire [31:0] rn3_rn4_data;
  wire [3:0] rn3_rn4_nid;
  wire rn3_rn4_ready;
  wire rn3_rn4_reject;
  wire [3:0] rn3_rn4_type;
  wire rn3_rn4_valid;
  wire [17:0] rn4_rn5_addr;
  wire [31:0] rn4_rn5_data;
  wire [3:0] rn4_rn5_nid;
  wire rn4_rn5_ready;
  wire rn4_rn5_reject;
  wire [3:0] rn4_rn5_type;
  wire rn4_rn5_valid;
  wire [17:0] rn5_rn6_addr;
  wire [31:0] rn5_rn6_data;
  wire [3:0] rn5_rn6_nid;
  wire rn5_rn6_ready;
  wire rn5_rn6_reject;
  wire [3:0] rn5_rn6_type;
  wire rn5_rn6_valid;
  wire [17:0] rn6_rn7_addr;
  wire [31:0] rn6_rn7_data;
  wire [3:0] rn6_rn7_nid;
  wire rn6_rn7_ready;
  wire rn6_rn7_reject;
  wire [3:0] rn6_rn7_type;
  wire rn6_rn7_valid;
  wire [17:0] rn7_rn8_addr;
  wire [31:0] rn7_rn8_data;
  wire [3:0] rn7_rn8_nid;
  wire rn7_rn8_ready;
  wire rn7_rn8_reject;
  wire [3:0] rn7_rn8_type;
  wire rn7_rn8_valid;
  wire [17:0] rn8_rn9_addr;
  wire [31:0] rn8_rn9_data;
  wire [3:0] rn8_rn9_nid;
  wire rn8_rn9_ready;
  wire rn8_rn9_reject;
  wire [3:0] rn8_rn9_type;
  wire rn8_rn9_valid;
  wire [17:0] rn9_rn1_addr;
  wire [31:0] rn9_rn1_data;
  wire [3:0] rn9_rn1_nid;
  wire rn9_rn1_ready;
  wire rn9_rn1_reject;
  wire [3:0] rn9_rn1_type;
  wire rn9_rn1_valid;
  pie_eth_nq11 pie_eth_nq11(.fab_add_addr(rn3_rn4_addr),
                            .fab_add_data(rn3_rn4_data),
                            .fab_add_nid(rn3_rn4_nid),
                            .fab_add_ready(rn3_rn4_ready),
                            .fab_add_reject(rn3_rn4_reject),
                            .fab_add_type(rn3_rn4_type),
                            .fab_add_valid(rn3_rn4_valid),
                            .fab_drop_addr(rn2_rn3_addr),
                            .fab_drop_data(rn2_rn3_data),
                            .fab_drop_nid(rn2_rn3_nid),
                            .fab_drop_ready(rn2_rn3_ready),
                            .fab_drop_reject(rn2_rn3_reject),
                            .fab_drop_type(rn2_rn3_type),
                            .fab_drop_valid(rn2_rn3_valid));
  pie_eth_nq01 pie_eth_nq01(.fab_add_addr(rn2_rn3_addr),
                            .fab_add_data(rn2_rn3_data),
                            .fab_add_nid(rn2_rn3_nid),
                            .fab_add_ready(rn2_rn3_ready),
                            .fab_add_reject(rn2_rn3_reject),
                            .fab_add_type(rn2_rn3_type),
                            .fab_add_valid(rn2_rn3_valid),
                            .fab_drop_addr(rn1_rn2_addr),
                            .fab_drop_data(rn1_rn2_data),
                            .fab_drop_nid(rn1_rn2_nid),
                            .fab_drop_ready(rn1_rn2_ready),
                            .fab_drop_reject(rn1_rn2_reject),
                            .fab_drop_type(rn1_rn2_type),
                            .fab_drop_valid(rn1_rn2_valid));
  pie_ex_nq1 pie_ex_nq1(.fab_add_addr(rn7_rn8_addr),
                        .fab_add_data(rn7_rn8_data),
                        .fab_add_nid(rn7_rn8_nid),
                        .fab_add_ready(rn7_rn8_ready),
                        .fab_add_reject(rn7_rn8_reject),
                        .fab_add_type(rn7_rn8_type),
                        .fab_add_valid(rn7_rn8_valid),
                        .fab_drop_addr(rn6_rn7_addr),
                        .fab_drop_data(rn6_rn7_data),
                        .fab_drop_nid(rn6_rn7_nid),
                        .fab_drop_ready(rn6_rn7_ready),
                        .fab_drop_reject(rn6_rn7_reject),
                        .fab_drop_type(rn6_rn7_type),
                        .fab_drop_valid(rn6_rn7_valid));
  pie_aud_dq1 pie_aud_dq1(.fab_add_addr(rn5_rn6_addr),
                          .fab_add_data(rn5_rn6_data),
                          .fab_add_nid(rn5_rn6_nid),
                          .fab_add_ready(rn5_rn6_ready),
                          .fab_add_reject(rn5_rn6_reject),
                          .fab_add_type(rn5_rn6_type),
                          .fab_add_valid(rn5_rn6_valid),
                          .fab_drop_addr(rn4_rn5_addr),
                          .fab_drop_data(rn4_rn5_data),
                          .fab_drop_nid(rn4_rn5_nid),
                          .fab_drop_ready(rn4_rn5_ready),
                          .fab_drop_reject(rn4_rn5_reject),
                          .fab_drop_type(rn4_rn5_type),
                          .fab_drop_valid(rn4_rn5_valid));
  ipc ipc(.fab_add_addr(rn6_rn7_addr),
          .fab_add_data(rn6_rn7_data),
          .fab_add_nid(rn6_rn7_nid),
          .fab_add_ready(rn6_rn7_ready),
          .fab_add_reject(rn6_rn7_reject),
          .fab_add_type(rn6_rn7_type),
          .fab_add_valid(rn6_rn7_valid),
          .fab_drop_addr(rn5_rn6_addr),
          .fab_drop_data(rn5_rn6_data),
          .fab_drop_nid(rn5_rn6_nid),
          .fab_drop_ready(rn5_rn6_ready),
          .fab_drop_reject(rn5_rn6_reject),
          .fab_drop_type(rn5_rn6_type),
          .fab_drop_valid(rn5_rn6_valid));
  pie_ex_dq1 pie_ex_dq1(.fab_add_addr(rn8_rn9_addr),
                        .fab_add_data(rn8_rn9_data),
                        .fab_add_nid(rn8_rn9_nid),
                        .fab_add_ready(rn8_rn9_ready),
                        .fab_add_reject(rn8_rn9_reject),
                        .fab_add_type(rn8_rn9_type),
                        .fab_add_valid(rn8_rn9_valid),
                        .fab_drop_addr(rn7_rn8_addr),
                        .fab_drop_data(rn7_rn8_data),
                        .fab_drop_nid(rn7_rn8_nid),
                        .fab_drop_ready(rn7_rn8_ready),
                        .fab_drop_reject(rn7_rn8_reject),
                        .fab_drop_type(rn7_rn8_type),
                        .fab_drop_valid(rn7_rn8_valid));
  sram0 sram0(.fab_add_addr(rn9_rn1_addr),
              .fab_add_data(rn9_rn1_data),
              .fab_add_nid(rn9_rn1_nid),
              .fab_add_ready(rn9_rn1_ready),
              .fab_add_reject(rn9_rn1_reject),
              .fab_add_type(rn9_rn1_type),
              .fab_add_valid(rn9_rn1_valid),
              .fab_drop_addr(rn8_rn9_addr),
              .fab_drop_data(rn8_rn9_data),
              .fab_drop_nid(rn8_rn9_nid),
              .fab_drop_ready(rn8_rn9_ready),
              .fab_drop_reject(rn8_rn9_reject),
              .fab_drop_type(rn8_rn9_type),
              .fab_drop_valid(rn8_rn9_valid));
  pie_aud_nq1 pie_aud_nq1(.fab_add_addr(rn4_rn5_addr),
                          .fab_add_data(rn4_rn5_data),
                          .fab_add_nid(rn4_rn5_nid),
                          .fab_add_ready(rn4_rn5_ready),
                          .fab_add_reject(rn4_rn5_reject),
                          .fab_add_type(rn4_rn5_type),
                          .fab_add_valid(rn4_rn5_valid),
                          .fab_drop_addr(rn3_rn4_addr),
                          .fab_drop_data(rn3_rn4_data),
                          .fab_drop_nid(rn3_rn4_nid),
                          .fab_drop_ready(rn3_rn4_ready),
                          .fab_drop_reject(rn3_rn4_reject),
                          .fab_drop_type(rn3_rn4_type),
                          .fab_drop_valid(rn3_rn4_valid));
  pie_eth_dq1 pie_eth_dq1(.fab_add_addr(rn1_rn2_addr),
                          .fab_add_data(rn1_rn2_data),
                          .fab_add_nid(rn1_rn2_nid),
                          .fab_add_ready(rn1_rn2_ready),
                          .fab_add_reject(rn1_rn2_reject),
                          .fab_add_type(rn1_rn2_type),
                          .fab_add_valid(rn1_rn2_valid),
                          .fab_drop_addr(rn9_rn1_addr),
                          .fab_drop_data(rn9_rn1_data),
                          .fab_drop_nid(rn9_rn1_nid),
                          .fab_drop_ready(rn9_rn1_ready),
                          .fab_drop_reject(rn9_rn1_reject),
                          .fab_drop_type(rn9_rn1_type),
                          .fab_drop_valid(rn9_rn1_valid));
  `include "proc_ring.logic.v"
endmodule

