
// Produced by snoopgen from file dp.in

// Remember to run Verilog with -x if any variables are subscripted


// 2 Clock phases: phi1 phi2
// Input, Verilog: ClientData_s1, irsim: ClientData_s1, vector[7:0]
// Input, Verilog: CountReset_s1, irsim: CountReset_s1
// Input, Verilog: CRC16Reset_s1, irsim: CRC16Reset_s1
// Input, Verilog: CRC16Enb_s1, irsim: CRC16Enb_s1
// Input, Verilog: CRC5Reset_s1, irsim: CRC5Reset_s1
// Input, Verilog: CRC5Enb_s1, irsim: CRC5Enb_s1
// Input, Verilog: OutputSource_s1, irsim: OutputSource_s1, vector[1:0]
// Input, Verilog: CompSource_s1, irsim: CompSource_s1
// Input, Verilog: ClearAddr_s1, irsim: ClearAddr_s1
// Input, Verilog: StoreAddr_s1, irsim: StoreAddr_s1
// Input, Verilog: Load_s1, irsim: Load_s1
// Input, Verilog: OutShift_s1, irsim: OutShift_s1
// Input, Verilog: ClrBuff_s1, irsim: ClrBuff_s1
// Input, Verilog: InShift_s1, irsim: InShift_s1
// Input, Verilog: serial_in_s1, irsim: serial_in_s1
// Input, Verilog: phi2, irsim: phi2
// Input, Verilog: phi1, irsim: phi1
// Output, Verilog: curr_crcreg5_s1, irsim: curr_crcreg5_s1, vector[4:0], Stable phase 1
// Output, Verilog: CountVal_s1, irsim: CountVal_s1, vector[5:0], Stable phase 1
// Output, Verilog: InBuffShort_s1, irsim: InBuffShort_s1, vector[3:0], Stable phase 1
// Output, Verilog: SerialOut_s1, irsim: SerialOut_s1, Stable phase 1
// Output, Verilog: match16_s1, irsim: Match16_s1, Stable phase 1
// Output, Verilog: match10_s1, irsim: Match10_s1, Stable phase 1
// Output, Verilog: match8_s1, irsim: Match8_s1, Stable phase 1
// Output, Verilog: match7_s1, irsim: Match7_s1, Stable phase 1
// Output, Verilog: match5_s1, irsim: Match5_s1, Stable phase 1
// Output, Verilog: IDMatch_s1, irsim: IDMatch_s1, Stable phase 1
// Output, Verilog: ZeroMatch_s1, irsim: ZeroMatch_s1, Stable phase 1


module dpsnooper(
	phi1, phi2, serial_in_s1, InShift_s1, 
	ClrBuff_s1, OutShift_s1, Load_s1, StoreAddr_s1, 
	ClearAddr_s1, CompSource_s1, OutputSource_s1, CRC5Enb_s1, 
	CRC5Reset_s1, CRC16Enb_s1, CRC16Reset_s1, CountReset_s1, 
	ClientData_s1, ZeroMatch_s1, IDMatch_s1, match5_s1, 
	match7_s1, match8_s1, match10_s1, match16_s1, 
	SerialOut_s1, InBuffShort_s1, CountVal_s1, curr_crcreg5_s1);

input phi1;
input phi2;
input serial_in_s1;
input InShift_s1;
input ClrBuff_s1;
input OutShift_s1;
input Load_s1;
input StoreAddr_s1;
input ClearAddr_s1;
input CompSource_s1;
input [1:0] OutputSource_s1;
input CRC5Enb_s1;
input CRC5Reset_s1;
input CRC16Enb_s1;
input CRC16Reset_s1;
input CountReset_s1;
input [7:0] ClientData_s1;
input ZeroMatch_s1;
input IDMatch_s1;
input match5_s1;
input match7_s1;
input match8_s1;
input match10_s1;
input match16_s1;
input SerialOut_s1;
input [3:0] InBuffShort_s1;
input [5:0] CountVal_s1;
input [4:0] curr_crcreg5_s1;

initial
begin
	$rsim_init();
	$rsim_check_on();
end

// One always block per input

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
always @(CountReset_s1) $rsim_log_input(CountReset_s1, "CountReset_s1");
always @(CRC16Reset_s1) $rsim_log_input(CRC16Reset_s1, "CRC16Reset_s1");
always @(CRC16Enb_s1) $rsim_log_input(CRC16Enb_s1, "CRC16Enb_s1");
always @(CRC5Reset_s1) $rsim_log_input(CRC5Reset_s1, "CRC5Reset_s1");
always @(CRC5Enb_s1) $rsim_log_input(CRC5Enb_s1, "CRC5Enb_s1");
always @(OutputSource_s1)
begin
	$rsim_log_input(OutputSource_s1[1], "OutputSource_s1[1]");
	$rsim_log_input(OutputSource_s1[0], "OutputSource_s1[0]");
end
always @(CompSource_s1) $rsim_log_input(CompSource_s1, "CompSource_s1");
always @(ClearAddr_s1) $rsim_log_input(ClearAddr_s1, "ClearAddr_s1");
always @(StoreAddr_s1) $rsim_log_input(StoreAddr_s1, "StoreAddr_s1");
always @(Load_s1) $rsim_log_input(Load_s1, "Load_s1");
always @(OutShift_s1) $rsim_log_input(OutShift_s1, "OutShift_s1");
always @(ClrBuff_s1) $rsim_log_input(ClrBuff_s1, "ClrBuff_s1");
always @(InShift_s1) $rsim_log_input(InShift_s1, "InShift_s1");
always @(serial_in_s1) $rsim_log_input(serial_in_s1, "serial_in_s1");
always @(phi2) $rsim_log_input(phi2, "phi2");
always @(phi1) $rsim_log_input(phi1, "phi1");

// One always block per inout


// Let go of inouts


// Check stable signals

always @(phi1)
begin
	$rsim_log_output(curr_crcreg5_s1[4], "curr_crcreg5_s1[4]");
	$rsim_log_output(curr_crcreg5_s1[3], "curr_crcreg5_s1[3]");
	$rsim_log_output(curr_crcreg5_s1[2], "curr_crcreg5_s1[2]");
	$rsim_log_output(curr_crcreg5_s1[1], "curr_crcreg5_s1[1]");
	$rsim_log_output(curr_crcreg5_s1[0], "curr_crcreg5_s1[0]");
	$rsim_log_output(CountVal_s1[5], "CountVal_s1[5]");
	$rsim_log_output(CountVal_s1[4], "CountVal_s1[4]");
	$rsim_log_output(CountVal_s1[3], "CountVal_s1[3]");
	$rsim_log_output(CountVal_s1[2], "CountVal_s1[2]");
	$rsim_log_output(CountVal_s1[1], "CountVal_s1[1]");
	$rsim_log_output(CountVal_s1[0], "CountVal_s1[0]");
	$rsim_log_output(InBuffShort_s1[3], "InBuffShort_s1[3]");
	$rsim_log_output(InBuffShort_s1[2], "InBuffShort_s1[2]");
	$rsim_log_output(InBuffShort_s1[1], "InBuffShort_s1[1]");
	$rsim_log_output(InBuffShort_s1[0], "InBuffShort_s1[0]");
	$rsim_log_output(SerialOut_s1, "SerialOut_s1");
	$rsim_log_output(match16_s1, "Match16_s1");
	$rsim_log_output(match10_s1, "Match10_s1");
	$rsim_log_output(match8_s1, "Match8_s1");
	$rsim_log_output(match7_s1, "Match7_s1");
	$rsim_log_output(match5_s1, "Match5_s1");
	$rsim_log_output(IDMatch_s1, "IDMatch_s1");
	$rsim_log_output(ZeroMatch_s1, "ZeroMatch_s1");
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
