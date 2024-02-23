
// Produced by /usr/class/ee272/bin/snoopgen from file digital.in

// Remember to run Verilog with -x if any variables are subscripted


// 2 Clock phases: phi1 phi2
// Input, Verilog: reset_lin_s1, irsim: reset_lin_s1
// Input, Verilog: reset_s1, irsim: reset_s1
// Input, Verilog: up_in_s1, irsim: up_in_s1
// Input, Verilog: phi2, irsim: phi2
// Input, Verilog: phi1, irsim: phi1
// Output, Verilog: thermo_sel_s1, irsim: thermo_sel_s1, vector[7:0], Stable phase 1
// Output, Verilog: o_latchout_s1, irsim: o_latchout_s1, vector[2:0], Stable phase 1
// Output, Verilog: e_latchout_s1, irsim: e_latchout_s1, vector[2:0], Stable phase 1
// Output, Verilog: sum_s1, irsim: sum_s1, vector[6:0], Stable phase 1


module digital_snooper(
	phi1, phi2, up_in_s1, reset_s1, 
	reset_lin_s1, sum_s1, e_latchout_s1, o_latchout_s1, 
	thermo_sel_s1);

input phi1;
input phi2;
input up_in_s1;
input reset_s1;
input reset_lin_s1;
input [6:0] sum_s1;
input [2:0] e_latchout_s1;
input [2:0] o_latchout_s1;
input [7:0] thermo_sel_s1;

initial
begin
	$rsim_init();
	$rsim_check_on();
end

// One always block per input

always @(reset_lin_s1) $rsim_log_input(reset_lin_s1, "reset_lin_s1");
always @(reset_s1) $rsim_log_input(reset_s1, "reset_s1");
always @(up_in_s1) $rsim_log_input(up_in_s1, "up_in_s1");
always @(phi2) $rsim_log_input(phi2, "phi2");
always @(phi1) $rsim_log_input(phi1, "phi1");

// One always block per inout


// Let go of inouts


// Check stable signals

always @(phi1)
begin
	$rsim_log_output(thermo_sel_s1[7], "thermo_sel_s1[7]");
	$rsim_log_output(thermo_sel_s1[6], "thermo_sel_s1[6]");
	$rsim_log_output(thermo_sel_s1[5], "thermo_sel_s1[5]");
	$rsim_log_output(thermo_sel_s1[4], "thermo_sel_s1[4]");
	$rsim_log_output(thermo_sel_s1[3], "thermo_sel_s1[3]");
	$rsim_log_output(thermo_sel_s1[2], "thermo_sel_s1[2]");
	$rsim_log_output(thermo_sel_s1[1], "thermo_sel_s1[1]");
	$rsim_log_output(thermo_sel_s1[0], "thermo_sel_s1[0]");
	$rsim_log_output(o_latchout_s1[2], "o_latchout_s1[2]");
	$rsim_log_output(o_latchout_s1[1], "o_latchout_s1[1]");
	$rsim_log_output(o_latchout_s1[0], "o_latchout_s1[0]");
	$rsim_log_output(e_latchout_s1[2], "e_latchout_s1[2]");
	$rsim_log_output(e_latchout_s1[1], "e_latchout_s1[1]");
	$rsim_log_output(e_latchout_s1[0], "e_latchout_s1[0]");
	$rsim_log_output(sum_s1[6], "sum_s1[6]");
	$rsim_log_output(sum_s1[5], "sum_s1[5]");
	$rsim_log_output(sum_s1[4], "sum_s1[4]");
	$rsim_log_output(sum_s1[3], "sum_s1[3]");
	$rsim_log_output(sum_s1[2], "sum_s1[2]");
	$rsim_log_output(sum_s1[1], "sum_s1[1]");
	$rsim_log_output(sum_s1[0], "sum_s1[0]");
end

always @(phi2)
begin
end


// Check valid signals

always @(negedge phi1)
begin
end

always @(negedge phi2)
begin
end


// Check qualified signals

always @(phi1)
begin
end

always @(phi2)
begin
end



endmodule
