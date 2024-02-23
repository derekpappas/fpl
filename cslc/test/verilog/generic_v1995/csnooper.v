
// Produced by snoopgen from file control.in

// Remember to run Verilog with -x if any variables are subscripted


// 2 Clock phases: phi1 phi2
// Input, Verilog: DataReady_s1, irsim: DataReady_s1
// Input, Verilog: InBuffShort_s1, irsim: InBuffShort_s1, vector[3:0]
// Input, Verilog: Match16_s1, irsim: Match16_s1
// Input, Verilog: Match10_s1, irsim: Match10_s1
// Input, Verilog: Match8_s1, irsim: Match8_s1
// Input, Verilog: Match7_s1, irsim: Match7_s1
// Input, Verilog: Match5_s1, irsim: Match5_s1
// Input, Verilog: PIDmatch_s1, irsim: PIDmatch_s1
// Input, Verilog: ZeroMatch_s1, irsim: ZeroMatch_s1
// Input, Verilog: CountVal_s1, irsim: CountVal_s1, vector[5:0]
// Input, Verilog: EOP_in_s1, irsim: EOP_in_s1
// Input, Verilog: SOP_in_s1, irsim: SOP_in_s1
// Input, Verilog: ControlReset_s1, irsim: ControlReset_s1
// Input, Verilog: phi2, irsim: phi2
// Input, Verilog: phi1, irsim: phi1
// Output, Verilog: curr_state_s1, irsim: curr_state_s1, vector[5:0], Stable phase 1
// Output, Verilog: ClearCnt_s1, irsim: ClearCnt_s1, Stable phase 1
// Output, Verilog: DataRead_s1, irsim: DataRead_s1, Stable phase 1
// Output, Verilog: CRC16Reset_s1, irsim: CRC16Reset_s1, Stable phase 1
// Output, Verilog: CRC16Enb_s1, irsim: CRC16Enb_s1, Stable phase 1
// Output, Verilog: CRC5Reset_s1, irsim: CRC5Reset_s1, Stable phase 1
// Output, Verilog: CRC5Enb_s1, irsim: CRC5Enb_s1, Stable phase 1
// Output, Verilog: OutputSource_s1, irsim: OutputSource_s1, vector[1:0], Stable phase 1
// Output, Verilog: CompSource_s1, irsim: CompSource_s1, Stable phase 1
// Output, Verilog: ClearAddr_s1, irsim: ClearAddr_s1, Stable phase 1
// Output, Verilog: StoreAddr_s1, irsim: StoreAddr_s1, Stable phase 1
// Output, Verilog: Load_s1, irsim: Load_s1, Stable phase 1
// Output, Verilog: OutShift_s1, irsim: OutShift_s1, Stable phase 1
// Output, Verilog: ClrBuff_s1, irsim: ClrBuff_s1, Stable phase 1
// Output, Verilog: InShift_s1, irsim: InShift_s1, Stable phase 1
// Output, Verilog: XmitEnb_s1, irsim: XmitEnb_s1, Stable phase 1
// Output, Verilog: EOP_out_s1, irsim: EOP_out_s1, Stable phase 1
// Output, Verilog: SOP_out_s1, irsim: SOP_out_s1, Stable phase 1


module csnooper(
	phi1, phi2, ControlReset_s1, SOP_in_s1, 
	EOP_in_s1, CountVal_s1, ZeroMatch_s1, PIDmatch_s1, 
	Match5_s1, Match7_s1, Match8_s1, Match10_s1, 
	Match16_s1, InBuffShort_s1, DataReady_s1, SOP_out_s1, 
	EOP_out_s1, XmitEnb_s1, InShift_s1, ClrBuff_s1, 
	OutShift_s1, Load_s1, StoreAddr_s1, ClearAddr_s1, 
	CompSource_s1, OutputSource_s1, CRC5Enb_s1, CRC5Reset_s1, 
	CRC16Enb_s1, CRC16Reset_s1, DataRead_s1, ClearCnt_s1, 
	curr_state_s1);

input phi1;
input phi2;
input ControlReset_s1;
input SOP_in_s1;
input EOP_in_s1;
input [5:0] CountVal_s1;
input ZeroMatch_s1;
input PIDmatch_s1;
input Match5_s1;
input Match7_s1;
input Match8_s1;
input Match10_s1;
input Match16_s1;
input [3:0] InBuffShort_s1;
input DataReady_s1;
input SOP_out_s1;
input EOP_out_s1;
input XmitEnb_s1;
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
input DataRead_s1;
input ClearCnt_s1;
input [5:0] curr_state_s1;

initial
begin
	$rsim_init();
	$rsim_check_on();
end

// One always block per input

always @(DataReady_s1) $rsim_log_input(DataReady_s1, "DataReady_s1");
always @(InBuffShort_s1)
begin
	$rsim_log_input(InBuffShort_s1[3], "InBuffShort_s1[3]");
	$rsim_log_input(InBuffShort_s1[2], "InBuffShort_s1[2]");
	$rsim_log_input(InBuffShort_s1[1], "InBuffShort_s1[1]");
	$rsim_log_input(InBuffShort_s1[0], "InBuffShort_s1[0]");
end
always @(Match16_s1) $rsim_log_input(Match16_s1, "Match16_s1");
always @(Match10_s1) $rsim_log_input(Match10_s1, "Match10_s1");
always @(Match8_s1) $rsim_log_input(Match8_s1, "Match8_s1");
always @(Match7_s1) $rsim_log_input(Match7_s1, "Match7_s1");
always @(Match5_s1) $rsim_log_input(Match5_s1, "Match5_s1");
always @(PIDmatch_s1) $rsim_log_input(PIDmatch_s1, "PIDmatch_s1");
always @(ZeroMatch_s1) $rsim_log_input(ZeroMatch_s1, "ZeroMatch_s1");
always @(CountVal_s1)
begin
	$rsim_log_input(CountVal_s1[5], "CountVal_s1[5]");
	$rsim_log_input(CountVal_s1[4], "CountVal_s1[4]");
	$rsim_log_input(CountVal_s1[3], "CountVal_s1[3]");
	$rsim_log_input(CountVal_s1[2], "CountVal_s1[2]");
	$rsim_log_input(CountVal_s1[1], "CountVal_s1[1]");
	$rsim_log_input(CountVal_s1[0], "CountVal_s1[0]");
end
always @(EOP_in_s1) $rsim_log_input(EOP_in_s1, "EOP_in_s1");
always @(SOP_in_s1) $rsim_log_input(SOP_in_s1, "SOP_in_s1");
always @(ControlReset_s1) $rsim_log_input(ControlReset_s1, "ControlReset_s1");
always @(phi2) $rsim_log_input(phi2, "phi2");
always @(phi1) $rsim_log_input(phi1, "phi1");

// One always block per inout


// Let go of inouts


// Check stable signals

always @(phi1)
begin
	$rsim_log_output(curr_state_s1[5], "curr_state_s1[5]");
	$rsim_log_output(curr_state_s1[4], "curr_state_s1[4]");
	$rsim_log_output(curr_state_s1[3], "curr_state_s1[3]");
	$rsim_log_output(curr_state_s1[2], "curr_state_s1[2]");
	$rsim_log_output(curr_state_s1[1], "curr_state_s1[1]");
	$rsim_log_output(curr_state_s1[0], "curr_state_s1[0]");
	$rsim_log_output(ClearCnt_s1, "ClearCnt_s1");
	$rsim_log_output(DataRead_s1, "DataRead_s1");
	$rsim_log_output(CRC16Reset_s1, "CRC16Reset_s1");
	$rsim_log_output(CRC16Enb_s1, "CRC16Enb_s1");
	$rsim_log_output(CRC5Reset_s1, "CRC5Reset_s1");
	$rsim_log_output(CRC5Enb_s1, "CRC5Enb_s1");
	$rsim_log_output(OutputSource_s1[1], "OutputSource_s1[1]");
	$rsim_log_output(OutputSource_s1[0], "OutputSource_s1[0]");
	$rsim_log_output(CompSource_s1, "CompSource_s1");
	$rsim_log_output(ClearAddr_s1, "ClearAddr_s1");
	$rsim_log_output(StoreAddr_s1, "StoreAddr_s1");
	$rsim_log_output(Load_s1, "Load_s1");
	$rsim_log_output(OutShift_s1, "OutShift_s1");
	$rsim_log_output(ClrBuff_s1, "ClrBuff_s1");
	$rsim_log_output(InShift_s1, "InShift_s1");
	$rsim_log_output(XmitEnb_s1, "XmitEnb_s1");
	$rsim_log_output(EOP_out_s1, "EOP_out_s1");
	$rsim_log_output(SOP_out_s1, "SOP_out_s1");
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
