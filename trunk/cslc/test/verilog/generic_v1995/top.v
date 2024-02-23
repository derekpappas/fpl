//*****************************************************************************
//FILE NAME: top.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : This is the top module where the whole system has been Integrated  
//*****************************************************************************

                                                                                module top( out1[3:0], out2[2:0]);

output [3:0] out1;
output [2:0] out2;

reg inclk, odd_early_s1, x_s2;
reg phi1, phi1_b, phi2_b, phi2 ;
reg reset_s1;

wire refclk;
wire reset_lin_s1;
wire [6:0] sum_s1;
wire [6:0] latchout_s1;
wire [6:0] fsm_s1;
wire [5:0] t_fsm_s1;
wire up_in_s1;
wire up_down;
wire analog_in, analog_in_b;
wire even_in, odd_in;
wire [7:0] thermo_sel_s1;
wire [7:0] therm_dec_s1;
wire [7:0] e_in, o_in;
wire [2:0] e_latchout_s1, o_latchout_s1;
wire [2:0] e_y_s1, o_z_s1;

`define ClkSpc 64  // Phi1 and Phi2 clk spacing 
`define ClkOn  128 // The on time for Phi1 and Phi2
`define ResetDelay 222 // The time after which the reset goes inactive
`define RefDelay 23  // The time by which the Refclk is delayed from the                             // Inclk 

initial
  begin
       $ssi_navdbase("nav.dbase","top.v");
       $ssi_navdump;
	inclk = 0;
 	phi1 = 0;
	phi1_b = 1;
        phi2 = 0;
	phi2_b = 1;
        reset_s1 = 1;
  end


always
#`ResetDelay reset_s1 = 1'b0;
 
always
begin
#`ClkSpc inclk = 1'b1;
#`ClkSpc inclk = 1'b0;
end

assign #`RefDelay refclk = inclk; 


always
begin
#`ClkSpc phi1 = 1'b1;
#`ClkOn phi1 = 1'b0;
#`ClkSpc phi2 = 1'b1;
#`ClkOn phi2 = 1'b0;
end

always
begin
#`ClkSpc phi1_b = 1'b0;
#`ClkOn phi1_b = 1'b1;
#`ClkSpc phi2_b = 1'b0;
#`ClkOn phi2_b = 1'b1;
end


assign reset_lin_s1 = 1'b0;
assign analog_in_b = ~analog_in;

// Since the FSM output bits 2 and 3 are the same therefore the FSM generates
// a 6-bit output which is then converted into a 7-bit input to the adder
assign fsm_s1 = {t_fsm_s1[5:1],t_fsm_s1[1],t_fsm_s1[0]};

latch7 latch7_1(phi1, phi1_b, phi2, phi2_b, reset_s1, sum_s1,latchout_s1);

adder7 adder7_1(latchout_s1, fsm_s1, sum_s1);

fsm_trial fsm_trial(up_in_s1, t_fsm_s1, phi1, phi2, reset_s1, reset_lin_s1);

synchronizer synchronizer_1(phi1, phi1_b, phi2, phi2_b, up_down,up_in_s1);

receiver receiver_1(analog_in, analog_in_b, analog_in_b, analog_in, refclk, up_down );

interpolator interp1(analog_in, even_in, odd_in, thermo_sel_s1 );

therm_decode therm_decode_1(sum_s1[3:0], therm_dec_s1);

therm_latch therm_latch_1(phi1, phi1_b, phi2, phi2_b, therm_dec_s1, thermo_sel_s1);

treemux e_treemux(e_in, e_latchout_s1 , even_in);

treemux o_treemux(o_in, o_latchout_s1 , odd_in);

mux_decoder mux_decoder_1(sum_s1[6:3], e_y_s1, o_z_s1);

mux_latch mux_latch_1(phi1, phi1_b, phi2, phi2_b, e_y_s1, o_z_s1, e_latchout_s1, o_latchout_s1 );

delayline delayline_1(inclk, e_in, o_in);

endmodule // end top module
