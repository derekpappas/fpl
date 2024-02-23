
// Produced by /usr/class/ee272/bin/snoopgen from file fsm.in

// Remember to run Verilog with -x if any variables are subscripted


// 2 Clock phases: phi1 phi2
// Input, Verilog: reset_lin_s1, irsim: reset_lin_s1
// Input, Verilog: reset_s1, irsim: reset_s1
// Input, Verilog: up_in_s1, irsim: up_in_s1
// Input, Verilog: phi2, irsim: phi2
// Input, Verilog: phi1, irsim: phi1
// Output, Verilog: d_state_s1, irsim: d_state_s1, vector[3:0], Stable phase 1
// Output, Verilog: curr_state_s1, irsim: curr_state_s1, vector[3:0], Stable phase 1
// Output, Verilog: add_reg_s1, irsim: add_reg_s1, vector[5:0], Stable phase 1


module fsm_snooper(
	phi1, phi2, up_in_s1, reset_s1, 
	reset_lin_s1, add_reg_s1, curr_state_s1, d_state_s1);

input phi1;
input phi2;
input up_in_s1;
input reset_s1;
input reset_lin_s1;
input [5:0] add_reg_s1;
input [3:0] curr_state_s1;
input [3:0] d_state_s1;

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
	$rsim_log_output(d_state_s1[3], "d_state_s1[3]");
	$rsim_log_output(d_state_s1[2], "d_state_s1[2]");
	$rsim_log_output(d_state_s1[1], "d_state_s1[1]");
	$rsim_log_output(d_state_s1[0], "d_state_s1[0]");
	$rsim_log_output(curr_state_s1[3], "curr_state_s1[3]");
	$rsim_log_output(curr_state_s1[2], "curr_state_s1[2]");
	$rsim_log_output(curr_state_s1[1], "curr_state_s1[1]");
	$rsim_log_output(curr_state_s1[0], "curr_state_s1[0]");
	$rsim_log_output(add_reg_s1[5], "add_reg_s1[5]");
	$rsim_log_output(add_reg_s1[4], "add_reg_s1[4]");
	$rsim_log_output(add_reg_s1[3], "add_reg_s1[3]");
	$rsim_log_output(add_reg_s1[2], "add_reg_s1[2]");
	$rsim_log_output(add_reg_s1[1], "add_reg_s1[1]");
	$rsim_log_output(add_reg_s1[0], "add_reg_s1[0]");
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
