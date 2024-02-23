`timescale 1ns/10ps
module test_testbench;
reg	[3:0]	wm_com;
reg	[12:0]	wm_addr;
reg	[31:0]	wm_datain;
reg     [0:0]  wm_dqs;
wire    [0:0]  wm_ds = wm_dqs;
wire	[31:0]	wm_dq_wire = wm_datain;
reg	[4:0]	wm_exsigin;
reg	CLK;
reg	CLKB;
reg	FinishFlag;
integer	testf;
integer	wm_clatency;
realtime 	wm_cycle;
SGDDR_64M i0 (
		.CLK(CLK),
		.CLKB(CLKB),
		.CSB(wm_com[3]),
		.RASB(wm_com[2]),
		.CASB(wm_com[1]),
		.WEB(wm_com[0]),
		.BA(wm_addr[12:11]),
		.ADDR(wm_addr[10:0]),
		.DQ(wm_dq_wire[31:0]),
		.DQS(wm_ds[0:0]),
		.CKE(wm_exsigin[4:4]),
		.DM(wm_exsigin[3:0])
		);

`include "64msgddr_task.v"
initial begin : init_block
	CLK = 1;
	CLKB = 0;
	wm_datain = 32'bz;
	wm_addr = 13'bx;
	wm_com = 4'b1111;
	wm_exsigin = 5'b10000;
	wm_dqs = 1'bz;
end

always begin: main_clk_blk
#0;
	case(wm_clatency)
		'b111: begin
			wm_cycle = 8.00;
			#(8.00/2) CLK = ~CLK;
			end
		'b010: begin
			wm_cycle = 8.00;
			#(8.00/2) CLK = ~CLK;
			end
		'b101: begin
			wm_cycle = 6.00;
			#(6.00/2) CLK = ~CLK;
			end
		'b100: begin
			wm_cycle = 6.00;
			#(6.00/2) CLK = ~CLK;
			end
		'b011: begin
			wm_cycle = 6.00;
			#(6.00/2) CLK = ~CLK;
			end
		default: begin
			#(6.00/2) CLK = ~CLK;
			wm_cycle = 6.00;
			end
	endcase
end

always @(CLK) CLKB = ~CLK;


initial begin : main_testbench
	#4.80;
		$fdisplay(testf,  ";FUNCTION : ACT-RD-PRE : read-interrupt-precharge ");
		INI (5'b10000);
		EMRS (3'b110);
		PRECHARGE (3'bXX1);
		MRS (1'b1, 3'b011, 1'b0, 3'b010);
	#(200.00*wm_cycle)	AREF (0);
		AREF (0);
		MRS (1'b0, 3'b011, 1'b0, 3'b010);
		ACTIVE (2'b00, 11'b00110111101);
		WRITE (2'b00, 1'b0, 8'b00000010, 32'b00111101001110000101000010011011, 4.00, 1'b0);
	#(3.00*wm_cycle)	PRECHARGE (3'b000);
	#(2.00*wm_cycle)	ACTIVE (2'b00, 11'b00110111101);
	#(2.00*wm_cycle)	READ (2'b00, 1'b0, 8'b00000010, 4.00);
	#(2.00*wm_cycle)	PRECHARGE (3'b000);
	#(4*wm_cycle);
		FinishFlag = 1;
		$finish;
end
endmodule
