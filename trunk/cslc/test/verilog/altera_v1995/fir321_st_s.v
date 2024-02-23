// Generated by FIR Compiler
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
// ************************************************************
// Copyright (C) 1991-2004 Altera Corporation
// Any megafunction design, and related net list (encrypted or decrypted),
// support information, device programming or simulation file, and any other
// associated documentation or information provided by Altera or a partner
// under Altera's Megafunction Partnership Program may be used only to
// program PLD devices (but not masked PLD devices) from Altera.  Any other
// use of such megafunction design, net list, support information, device
// programming or simulation file, or any other related documentation or
// information is prohibited for any other purpose, including, but not
// limited to modification, reverse engineering, de-compiling, or use with
// any other silicon devices, unless such use is explicitly licensed under
// a separate agreement with Altera or a megafunction partner.  Title to
// the intellectual property, including patents, copyrights, trademarks,
// trade secrets, or maskworks, embodied in any such megafunction design,
// net list, support information, device programming or simulation file, or
// any other related documentation or information provided by Altera or a
// megafunction partner, remains with Altera, the megafunction partner, or
// their respective licensors.  No other licenses, including any licenses
// needed under any third party's intellectual property, are provided herein.
module fir321_st_s (clk, 
              rst, 
              data_in, 
              coef_we, 
              coef_in, 
			 coef_in_clk,
              coef_set, 
              coef_set_in, 
              rdy_to_ld, 
              done, 
              fir_result); 
parameter DATA_WIDTH  = 4;
parameter COEF_WIDTH  = 16;
parameter COEF_WIDTH_IN = 18;
parameter COEF_SET_WIDTH = 2;
parameter ACCUM_WIDTH = 23;

input clk, rst;
input [DATA_WIDTH-1:0] data_in;
input coef_we; 
input [COEF_WIDTH_IN -1 :0] coef_in; 
input coef_in_clk;
input [COEF_SET_WIDTH-1:0] coef_set; 
input [COEF_SET_WIDTH-1:0] coef_set_in; 
output rdy_to_ld;
wire rdy_to_ld;
wire rdy_int;
wire rdy_int_ph;
output done;
wire done;
wire done_int;
output [ACCUM_WIDTH-1:0] fir_result;
wire tdl_ld;
wire sa_rst;
wire sa_inv;
wire pre_rdy;
wire sym_rst;
wire addr_low;
assign addr_low = 1'b0;
wire clk_en;
assign clk_en = 1'b1;
wire [COEF_SET_WIDTH-1 :0]coef_set_dly;
delay_trig_cen coef_set_reg(.clk(clk),.gclk_en(1'b1),.enable(pre_rdy), .data_in(coef_set),.data_out(coef_set_dly));
defparam coef_set_reg.IN_WIDTH = COEF_SET_WIDTH;
defparam coef_set_reg.WHOLE_DELAY = 1;
defparam coef_set_reg.FINE_DELAY = 1;
wire ser_eab_0_n;
wire ser_eab_1_n;
wire ser_dat_0_n;
par_ld_ser_tdl_wr Utdl_0_a(.clk(clk), .clk_en(clk_en), .rst(rst), .data_in(data_in), .tdl_upd(pre_rdy), .tdl_ld(rdy_int_ph),.data_out(ser_eab_0_n) );
defparam Utdl_0_a.WIDTH = 4;
assign ser_dat_0_n = ser_eab_0_n; 
wire ser_dat_1_n;
wire ser_dat_2_n;
wire ser_dat_3_n;
wire ser_dat_4_n;
wire [15:0]tdl_data_0_n;
lc_tdl_strat Utdl_0_n (
  .clk(clk),
  .rst(rst),
  .data_in(ser_eab_0_n),
  .data_out(tdl_data_0_n),
  .ntdl(ser_eab_1_n) 
);
defparam Utdl_0_n.CORE_WIDTH = 16;
defparam Utdl_0_n.DEPTH = 256;
defparam Utdl_0_n.DEPTH_ADDR = 8;
defparam Utdl_0_n.WIDTH = 4;
assign ser_dat_1_n = tdl_data_0_n[0];
assign ser_dat_2_n = tdl_data_0_n[1];
assign ser_dat_3_n = tdl_data_0_n[2];
assign ser_dat_4_n = tdl_data_0_n[3];
// --- ROM LUTs ---- 
wire [2:0]mem_wr_addr;
wire [4:0]wr_addr_comb;
assign wr_addr_comb = {coef_set_in_dly, mem_wr_addr };
wire [COEF_SET_WIDTH-1:0] coef_set_in_dly;
delay_mul_cen set_in_dly(.clk(coef_in_clk),
.rst(rst), .gclk_en(1'b1), .data_in(coef_set_in), 
.data_out(coef_set_in_dly));
defparam set_in_dly.IN_WIDTH = COEF_SET_WIDTH;
defparam set_in_dly.STORE_CELL = COEF_SET_WIDTH *3;
wire [1:0]coef_wr_mem;
wire one_mem_done;
addr_cnt_up addr_cnt(.clk(coef_in_clk), .cnt_out(mem_wr_addr),.cnt_done(one_mem_done), .enable(coef_we));
defparam addr_cnt.NUM_DATA = 8;
defparam addr_cnt.DATA_ADDR_WIDTH = 3;
defparam addr_cnt.STARTER = 6;	
mr_ser_shift_wr we_shift(.clk(coef_in_clk), .shift_out(coef_wr_mem),.shift_trig(one_mem_done), .enable(coef_we));	
defparam we_shift.SHIFT_WIDTH =2;	
defparam we_shift.OUT_WIDTH =2;	
defparam we_shift.POLY_FACT =4;	
defparam we_shift.POLY_WIDTH =2;	
wire [17:0] lut_val_0_n;
ram_lut Ur0_n(.clk_in(coef_in_clk), .clk_out(clk), .addr_in( {coef_set_dly[1],coef_set_dly[0],ser_dat_2_n,ser_dat_1_n,ser_dat_0_n } ), .wr_addr(wr_addr_comb),.wr_en(coef_wr_mem[1]),.data_in(coef_in),.data_out( lut_val_0_n[17:0]) ) ;
defparam Ur0_n.device_family = "stratix";
defparam Ur0_n.init_file = "fir321_coef_0.hex";
defparam Ur0_n.data_width = 18;
defparam Ur0_n.addr_width = 5;
defparam Ur0_n.depth = 32;
defparam Ur0_n.mem_core = "M512";
wire [17:0] lut_val_1_n;
ram_lut Ur1_n(.clk_in(coef_in_clk), .clk_out(clk), .addr_in( {coef_set_dly[1],coef_set_dly[0],addr_low,ser_dat_4_n,ser_dat_3_n } ), .wr_addr(wr_addr_comb),.wr_en(coef_wr_mem[0]),.data_in(coef_in),.data_out( lut_val_1_n[16:0]) ) ;
defparam Ur1_n.device_family = "stratix";
defparam Ur1_n.init_file = "fir321_coef_1.hex";
defparam Ur1_n.data_width = 17;
defparam Ur1_n.addr_width = 5;
defparam Ur1_n.depth = 32;
defparam Ur1_n.mem_core = "M512";
assign lut_val_1_n[17] = lut_val_1_n[16];
wire [18:0] tree_l_0_n_0_n;
sadd_lpm_cen Uaddl_0_n_0_n (.clk(clk),  .gclk_en(clk_en), .ain(lut_val_0_n), .bin(lut_val_1_n), .res(tree_l_0_n_0_n) );
defparam Uaddl_0_n_0_n.IN_WIDTH = 18;
defparam Uaddl_0_n_0_n.PIPE_DEPTH = 1;

wire [18:0] mac_res;
assign mac_res=tree_l_0_n_0_n;
wire [18:0] atree_res;
mac_tl Umtl (.clk(clk), 
             .data_in(mac_res),
             .data_out(atree_res));
defparam Umtl.DATA_WIDTH = 19;

// ---- Adder Tree Complete ---- 


wire [2:0] shft;
wire [19:0] accum;
scale_accum Usa ( .clk(clk), .rst(sa_rst), .inv(sa_inv), .ain(atree_res), .accum_out(accum) );
defparam Usa.WIDTH_A = 19;


ser_shft Usershft( .clk(clk), .rst(1'b0), .ain(accum[0]), .shft_out(shft) );
defparam Usershft.SHIFT_WIDTH = 3;


wire    [22:0] fir_int_res;
scale_shft_comb Usscx (.clk(clk), .ce(done_int), .accum(accum), .shft(shft), .res(fir_int_res) );
defparam Usscx.WIDTH_ACCM = 20;
defparam Usscx.WIDTH_SHFT = 3;
defparam Usscx.WIDTH_RES = 23;

assign fir_result = fir_int_res[ACCUM_WIDTH-1:0];
assign rdy_to_ld = rdy_int;
ser_ctrl_cen Usc (.rst(rst), .clk(clk), .clk_en(1'b1), 
              .pre_rdy(pre_rdy), 
              .sa_rst_out(sa_rst), .ser_inv_out(sa_inv), 
              .rdy_to_ld(rdy_int), .sym_rst(sym_rst), 
              .tdl_ld(tdl_ld), .done_int(done_int), .done(done) ); 

defparam Usc.REG_LEN =4; 
defparam Usc.PIPE_DLY =1; 
defparam Usc.RST_DLY =3; 
defparam Usc.INV_DLY =0; 
defparam Usc.DONE_DLY =2; 
defparam Usc.DONE_HLD =4; 
defparam Usc.DONE_CNT_BIT =3; 

mr_lrdy_wr udsmrtdl(.clk(clk),										
                    .rst(rst),                               
                    .clk_en(1'b1),                 
                    .rdy_to_ld_int(rdy_int),                 
                    .rdy_out(rdy_int_ph)                     
				      );                                        
					                                        
defparam udsmrtdl.SIZE = 16;                      
defparam udsmrtdl.OUT_WIDTH = 4;
defparam udsmrtdl.CNT_VAL = 5;
endmodule
