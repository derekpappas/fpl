module fir321_st (clk, 
              rst, 
              data_in, 
              coef_we, 
              coef_in, 
              coef_in_clk, 
              coef_set, 
              coef_set_in, 
              fir_result, 
              rdy_to_ld, 
              done); 
parameter DATA_WIDTH  = 16;
parameter COEF_WIDTH  = 16;
parameter COEF_WIDTH_IN = 18;
parameter COEF_SET_WIDTH = 2;
parameter ACCUM_WIDTH = 35;

 input clk, rst;
 input [DATA_WIDTH-1:0] data_in;
input coef_we; 
input [COEF_WIDTH_IN -1 :0] coef_in; 
input coef_in_clk; 
input [COEF_SET_WIDTH-1:0] coef_set; 
input [COEF_SET_WIDTH-1:0] coef_set_in; 
 output rdy_to_ld;
 output done;
output [ACCUM_WIDTH-1:0] fir_result;
wire clk_en;
assign clk_en = 1'b1;
wire [22:0] fir_res_0_n;
wire temp_0_1_n;
wire temp_0_2_n;
fir321_st_u U0_n (.clk(clk),
                       .rst(rst),
                       .data_in(data_in[3:0]),
                       .coef_we(coef_we), 
                       .coef_in(coef_in), 
                   .coef_in_clk(coef_in_clk), 
                       .coef_set(coef_set), 
                       .coef_set_in(coef_set_in), 
                       .fir_result(fir_res_0_n),
                       .rdy_to_ld(temp_0_1_n),
                       .done(temp_0_2_n)
);
wire [22:0] fir_res_1_n;
wire temp_1_1_n;
wire temp_1_2_n;
fir321_st_u U1_n (.clk(clk),
                       .rst(rst),
                       .data_in(data_in[7:4]),
                       .coef_we(coef_we), 
                       .coef_in(coef_in), 
                   .coef_in_clk(coef_in_clk), 
                       .coef_set(coef_set), 
                       .coef_set_in(coef_set_in), 
                       .fir_result(fir_res_1_n),
                       .rdy_to_ld(temp_1_1_n),
                       .done(temp_1_2_n)
);
wire [22:0] fir_res_2_n;
wire temp_2_1_n;
wire temp_2_2_n;
fir321_st_u U2_n (.clk(clk),
                       .rst(rst),
                       .data_in(data_in[11:8]),
                       .coef_we(coef_we), 
                       .coef_in(coef_in), 
                   .coef_in_clk(coef_in_clk), 
                       .coef_set(coef_set), 
                       .coef_set_in(coef_set_in), 
                       .fir_result(fir_res_2_n),
                       .rdy_to_ld(temp_2_1_n),
                       .done(temp_2_2_n)
);
wire [22:0] fir_res_3_n;
fir321_st_s U3_n (.clk(clk),
                       .rst(rst),
                       .data_in(data_in[15:12]),
                       .coef_we(coef_we), 
                       .coef_in(coef_in), 
                   .coef_in_clk(coef_in_clk), 
                       .coef_set(coef_set), 
                       .coef_set_in(coef_set_in), 
                       .fir_result(fir_res_3_n),
                       .rdy_to_ld(rdy_to_ld),
                       .done(done)
 );
wire [11:0] mbs_fill_lt_0_n;
wire [34:0] mbs_fill_0_n;
assign mbs_fill_lt_0_n[0] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[1] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[2] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[3] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[4] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[5] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[6] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[7] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[8] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[9] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[10] = fir_res_0_n[22];
assign mbs_fill_lt_0_n[11] = fir_res_0_n[22];
assign mbs_fill_0_n = {mbs_fill_lt_0_n, fir_res_0_n};
wire [3:0] mbs_fill_rt_1_n;
wire [7:0] mbs_fill_lt_1_n;
wire [34:0] mbs_fill_1_n;
assign mbs_fill_rt_1_n = 4'd0;
assign mbs_fill_lt_1_n[0] = fir_res_1_n[22];
assign mbs_fill_lt_1_n[1] = fir_res_1_n[22];
assign mbs_fill_lt_1_n[2] = fir_res_1_n[22];
assign mbs_fill_lt_1_n[3] = fir_res_1_n[22];
assign mbs_fill_lt_1_n[4] = fir_res_1_n[22];
assign mbs_fill_lt_1_n[5] = fir_res_1_n[22];
assign mbs_fill_lt_1_n[6] = fir_res_1_n[22];
assign mbs_fill_lt_1_n[7] = fir_res_1_n[22];
assign mbs_fill_1_n = {mbs_fill_lt_1_n, fir_res_1_n, mbs_fill_rt_1_n};
wire [7:0] mbs_fill_rt_2_n;
wire [3:0] mbs_fill_lt_2_n;
wire [34:0] mbs_fill_2_n;
assign mbs_fill_rt_2_n = 8'd0;
assign mbs_fill_lt_2_n[0] = fir_res_2_n[22];
assign mbs_fill_lt_2_n[1] = fir_res_2_n[22];
assign mbs_fill_lt_2_n[2] = fir_res_2_n[22];
assign mbs_fill_lt_2_n[3] = fir_res_2_n[22];
assign mbs_fill_2_n = {mbs_fill_lt_2_n, fir_res_2_n, mbs_fill_rt_2_n};
wire [11:0] mbs_fill_rt_3_n;
wire [34:0] mbs_fill_3_n;
assign mbs_fill_rt_3_n = 12'd0;
assign mbs_fill_3_n = {fir_res_3_n, mbs_fill_rt_3_n};
wire [35:0] mbs_atree_l_0_n_0_n;
sadd_lpm_cen Uadd_l_0_n_0_n (.clk(clk),  .gclk_en(clk_en), .ain(mbs_fill_0_n), .bin(mbs_fill_1_n), .res(mbs_atree_l_0_n_0_n) );
defparam Uadd_l_0_n_0_n.IN_WIDTH = 35;
defparam Uadd_l_0_n_0_n.PIPE_DEPTH = 1;
wire [35:0] mbs_atree_l_0_n_1_n;
sadd_lpm_cen Uadd_l_0_n_1_n (.clk(clk),  .gclk_en(clk_en), .ain(mbs_fill_2_n), .bin(mbs_fill_3_n), .res(mbs_atree_l_0_n_1_n) );
defparam Uadd_l_0_n_1_n.IN_WIDTH = 35;
defparam Uadd_l_0_n_1_n.PIPE_DEPTH = 1;

wire [35:0] mbs_atree_l_1_n_0_n;
sadd_lpm_cen Uadd_l_1_n_0_n (.clk(clk),  .gclk_en(clk_en), .ain(mbs_atree_l_0_n_0_n), .bin(mbs_atree_l_0_n_1_n), .res(mbs_atree_l_1_n_0_n) );
defparam Uadd_l_1_n_0_n.IN_WIDTH = 35;
defparam Uadd_l_1_n_0_n.PIPE_DEPTH = 1;

wire [35:0] mbs_atree_res;
assign mbs_atree_res=mbs_atree_l_1_n_0_n;
assign fir_result = mbs_atree_res[ACCUM_WIDTH-1:0];

endmodule
