//
//  Title: 	Hack for tcompress
//  Created:	Tue Jan 17 10:23:03 1995
//  Author: 	Ricardo Gonzalez
//		<ricardog@fugue>
//
//
//  hack.v,v 7.3 1995/02/14 01:25:23 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: Hack to display the values of ent, fcode and i in the
//  inner loop of tcompress. Hopefully it will help in the debugging.
//
//	Hierarchy: 
//
//  Revision History:
//
`define PC_TO_MATCH	30'hde

module hack ( );

//---------------------------------------------------------------------------
//			     --- Wires ---
//---------------------------------------------------------------------------
wire	Phi1 = `PROCESSOR.Phi1;
wire	Stall_s1 = `PROCESSOR.Stall_s1;
wire	[29:0]	PC_s2e = `PCU.PCChain_s2e;
wire	[31:0]	AResultBus_v2e = `PROCESSOR.AResultBus_v2e;
wire	[31:0]	BResultBus_v2e = `PROCESSOR.BResultBus_v2e;
wire	[31:0]	BTBus_s1e = `PROCESSOR.BTBus_s1e;

integer outChannel;
integer dump;
initial begin
    if ($test$plusargs("hack")) begin
	outChannel = $fopen("cmp.log");
	dump = 1;
    end
    else
	dump = 0;
end

always @(negedge Phi1) begin
    #5
    if (dump == 1 & ~Stall_s1 & PC_s2e == `PC_TO_MATCH) begin
	$fwrite(outChannel, "ent: %d\ti: %d\tfcode: %d\tTIME: %t\n",
	    BTBus_s1e, AResultBus_v2e, BResultBus_v2e, $time);
    end
end

endmodule				 // hack
