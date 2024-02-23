
// Produced by snoopgen from file top2.in

// Remember to run Verilog with -x if any variables are subscripted


// 2 Clock phases: phi1 phi2
// Input, Verilog: Match16_s1, irsim: Match16_s1
// Input, Verilog: Match5_s1, irsim: Match5_s1
// Input, Verilog: ControlReset_s1, irsim: ControlReset_s1
// Input, Verilog: ClientData_s1, irsim: ClientData_s1, vector[7:0]
// Input, Verilog: DataReady_s1, irsim: DataReady_s1
// Input, Verilog: serial_in_s1, irsim: serial_in_s1
// Input, Verilog: EOP_in_s1, irsim: EOP_in_s1
// Input, Verilog: SOP_in_s1, irsim: SOP_in_s1
// Input, Verilog: phi2, irsim: phi2
// Input, Verilog: phi1, irsim: phi1
// Output, Verilog: CountVal_s1, irsim: CountVal_s1, vector[2:1], Stable phase 1
// Output, Verilog: CRC16Reset_s1, irsim: CRC16Reset_s1, Stable phase 1
// Output, Verilog: CRC16Enb_s1, irsim: CRC16Enb_s1, Stable phase 1
// Output, Verilog: CRC5Reset_s1, irsim: CRC5Reset_s1, Stable phase 1
// Output, Verilog: CRC5Enb_s1, irsim: CRC5Enb_s1, Stable phase 1
// Output, Verilog: curr_state_s1, irsim: curr_state_s1, vector[5:0], Stable phase 1
// Output, Verilog: XmitEnb_s1, irsim: XmitEnb_s1, Stable phase 1
// Output, Verilog: EOP_out_s1, irsim: EOP_out_s1, Stable phase 1
// Output, Verilog: SOP_out_s1, irsim: SOP_out_s1, Stable phase 1
// Output, Verilog: DataRead_s1, irsim: DataRead_s1, Stable phase 1
// Output, Verilog: DataReady_s1, irsim: DataReady_s1, Stable phase 1
// Output, Verilog: SerialOut_s1, irsim: SerialOut_s1, Stable phase 1


module topsnooper2(
	phi1, phi2, SOP_in_s1, EOP_in_s1, 
	serial_in_s1, DataReady_s1, ClientData_s1, ControlReset_s1, 
	Match5_s1, Match16_s1, SerialOut_s1, DataRead_s1, 
	SOP_out_s1, EOP_out_s1, XmitEnb_s1, curr_state_s1, 
	CRC5Enb_s1, CRC5Reset_s1, CRC16Enb_s1, CRC16Reset_s1, 
	CountVal_s1);

input phi1;
input phi2;
input SOP_in_s1;
input EOP_in_s1;
input serial_in_s1;
input DataReady_s1;
input [7:0] ClientData_s1;
input ControlReset_s1;
input Match5_s1;
input Match16_s1;
input SerialOut_s1;
input DataRead_s1;
input SOP_out_s1;
input EOP_out_s1;
input XmitEnb_s1;
input [5:0] curr_state_s1;
input CRC5Enb_s1;
input CRC5Reset_s1;
input CRC16Enb_s1;
input CRC16Reset_s1;
input [2:1] CountVal_s1;

initial
begin
	$rsim_init();
	$rsim_check_on();
end

// One always block per input

always @(Match16_s1) $rsim_log_input(Match16_s1, "Match16_s1");
always @(Match5_s1) $rsim_log_input(Match5_s1, "Match5_s1");
always @(ControlReset_s1) $rsim_log_input(ControlReset_s1, "ControlReset_s1");
always @(ClientData_s1)
begin
	$rsim_log_input(ClientData_s1[7], "ClientData_s1[7]");
	$rsim_log_input(ClientData_s1[6], "ClientData_s1[6]");
	$rsim_log_input(ClientData_s1[5], "ClientData_s1[5]");
	$rsim_log_input(ClientData_s1[4], "ClientData_s1[4]");
	$rsim_log_input(ClientData_s1[3], "ClientData_s1[3]");
	$rsim_log_input(ClientData_s1[2], "ClientData_s1[2]");
	$rsim_log_input(ClientData_s1[1], "ClientData_s1[1]");
	$rsim_log_input(ClientData_s1[0], "ClientData_s1[0]");
end
always @(DataReady_s1) $rsim_log_input(DataReady_s1, "DataReady_s1");
always @(serial_in_s1) $rsim_log_input(serial_in_s1, "serial_in_s1");
always @(EOP_in_s1) $rsim_log_input(EOP_in_s1, "EOP_in_s1");
always @(SOP_in_s1) $rsim_log_input(SOP_in_s1, "SOP_in_s1");
always @(phi2) $rsim_log_input(phi2, "phi2");
always @(phi1) $rsim_log_input(phi1, "phi1");

// One always block per inout


// Let go of inouts


// Check stable signals

always @(phi1)
begin
	$rsim_log_output(CountVal_s1[2], "CountVal_s1[2]");
	$rsim_log_output(CountVal_s1[1], "CountVal_s1[1]");
	$rsim_log_output(CRC16Reset_s1, "CRC16Reset_s1");
	$rsim_log_output(CRC16Enb_s1, "CRC16Enb_s1");
	$rsim_log_output(CRC5Reset_s1, "CRC5Reset_s1");
	$rsim_log_output(CRC5Enb_s1, "CRC5Enb_s1");
	$rsim_log_output(curr_state_s1[5], "curr_state_s1[5]");
	$rsim_log_output(curr_state_s1[4], "curr_state_s1[4]");
	$rsim_log_output(curr_state_s1[3], "curr_state_s1[3]");
	$rsim_log_output(curr_state_s1[2], "curr_state_s1[2]");
	$rsim_log_output(curr_state_s1[1], "curr_state_s1[1]");
	$rsim_log_output(curr_state_s1[0], "curr_state_s1[0]");
	$rsim_log_output(XmitEnb_s1, "XmitEnb_s1");
	$rsim_log_output(EOP_out_s1, "EOP_out_s1");
	$rsim_log_output(SOP_out_s1, "SOP_out_s1");
	$rsim_log_output(DataRead_s1, "DataRead_s1");
	$rsim_log_output(DataReady_s1, "DataReady_s1");
	$rsim_log_output(SerialOut_s1, "SerialOut_s1");
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



endmodule
