module lanal(clk,reset,din,enable,dout,arm,rd,ready,trigger,triggerd,wdtrig);
//-----------------------------------------------------------
// Logic Analyzer Module
//
// Well, this is a way to record what is going on inside of
// an FPGA so that the circuits can be debugged
//
// parameter:
//	clk.............system clock
//	reset...........system reset
//	din.............this is the data to record
//	enable..........causes the data to be recorded
//	dout............output data port
//	arm.............arm trigger unit
//	rd..............read data from recording
//	ready...........indicates that memory is full
//	trigger.........trigger word
//	triggerd........enables trigger bit
//-----------------------------------------------------------
	input clk;
	input reset;
	input [31:0] din;
	input enable;
	output [7:0] dout;
	input arm;
	input rd;
	output ready;
	input [31:0] trigger;
	input [31:0] triggerd;
 	input wdtrig;			//writes data to trigger registers

	reg [31:0] treg;	//contains bit 0 of trigger for each bit (polarity)
	reg [31:0] dreg;	//contians bit 1 of trigger for each bit (enable)
	reg [31:0] Ireg;		//data input reg
	reg [8:0] WdCntr;		//address counter for writing data
	reg [10:0] RdCntr;		//address counter for reading data
	reg [7:0] dout;		//data output register
	reg [1:0] CS;			//state indicates that the system was triggered
	reg [1:0] NS;
	reg Done;				//indicates memory is full
	reg TC;
	reg ClearCntr;			//clear the address counters
	wire [31:0] TCout;
	reg wd,WdRam;
	wire [7:0] RamA,RamB,RamC,RamD;
	reg ready,setready,clearready;

	parameter [1:0] //synopsys enum STATE_TYPE
	TRIG_IDLE = 2'b00,	//do nothing
	TRIG_ARMED = 2'b01,	//arm trigger mechanism
	TRIG_TRIG = 2'b10;	//record data

	//------------------------------------------------------
	// ready status flipflop
	//------------------------------------------------------

	always @(posedge clk or posedge reset)
	begin
		if(reset)
			ready <= 0;
		else
		begin
			if(setready)
				ready <= 1;	//set
			else if (clearready)
				ready <= 0;	//clear
			else
				ready <= ready;	//hold
		end
	end

	//------------------------------------------------------
	// data input reg
	//------------------------------------------------------

	always @(posedge clk or posedge reset)
	begin
		if(reset)
			Ireg <= 0;
		else
		begin
			if(enable)	//do we record data on this clock?
				Ireg <= din;	//record data
			else
				Ireg <= Ireg;	//hold
		end
	end

	//------------------------------------------------------
	// trigger registers
	//------------------------------------------------------

	always @ (posedge clk or posedge reset)
	begin
		if (reset)
		begin
			treg <= 0;
			dreg <= 0;
		end
		else
		begin
			if(wdtrig)
			begin
				treg <= trigger;		//load trigger words
				dreg <= triggerd;
			end
			else
			begin
				treg <= treg;	//hold
				dreg <= dreg;	//hold
			end
		end
	end

	//----------------------------------------------------------
	// address counter for reading data out of the logic analyzer
	// ram
	//----------------------------------------------------------

	always @ (posedge clk or posedge reset)
	begin
		if(reset)
			RdCntr <= 0;	//reset back to zero
		else
		begin
			if(rd)
				RdCntr <= RdCntr + 1;	//count
			else if (ClearCntr)
				RdCntr <= 0;
			else
				RdCntr <= RdCntr;	//hold
		end			
	end

	//-------------------------------------------------------------
	// pipeline delay for enable
	//-------------------------------------------------------------

	always @ (posedge clk)
		wd <= enable;

	//-------------------------------------------------------------
	// Address counter for writing data into the logic analyzer ram
	//-------------------------------------------------------------

	always @ (posedge clk or posedge reset)
	begin
		if(reset)
			WdCntr <= 0;	//reset back to zero
		else
		begin
			if(wd && (CS == TRIG_TRIG))
				WdCntr <= WdCntr + 1;	//increment address
			else if (ClearCntr)
				WdCntr <= 0;	//clear to zero
			else
				WdCntr <= WdCntr;	//hold
		end
	end

	always @ (WdCntr)
	begin
		if(WdCntr == 9'b111111111)	//end or memory?
			Done = 1;
		else
			Done = 0;
	end

	//----------------------------------------------------------
	// Trigger compare logic
	//----------------------------------------------------------

	TrigCompare T0 (.A(Ireg[ 0]),.B(treg[ 0]),.C(dreg[ 0]),.T(TCout[ 0]));
	TrigCompare T1 (.A(Ireg[ 1]),.B(treg[ 1]),.C(dreg[ 1]),.T(TCout[ 1]));
	TrigCompare T2 (.A(Ireg[ 2]),.B(treg[ 2]),.C(dreg[ 2]),.T(TCout[ 2]));
	TrigCompare T3 (.A(Ireg[ 3]),.B(treg[ 3]),.C(dreg[ 3]),.T(TCout[ 3]));
	TrigCompare T4 (.A(Ireg[ 4]),.B(treg[ 4]),.C(dreg[ 4]),.T(TCout[ 4]));
	TrigCompare T5 (.A(Ireg[ 5]),.B(treg[ 5]),.C(dreg[ 5]),.T(TCout[ 5]));
	TrigCompare T6 (.A(Ireg[ 6]),.B(treg[ 6]),.C(dreg[ 6]),.T(TCout[ 6]));
	TrigCompare T7 (.A(Ireg[ 7]),.B(treg[ 7]),.C(dreg[ 7]),.T(TCout[ 7]));
	TrigCompare T8 (.A(Ireg[ 8]),.B(treg[ 8]),.C(dreg[ 8]),.T(TCout[ 8]));
	TrigCompare T9 (.A(Ireg[ 9]),.B(treg[ 9]),.C(dreg[ 9]),.T(TCout[ 9]));
	TrigCompare T10(.A(Ireg[10]),.B(treg[10]),.C(dreg[10]),.T(TCout[10]));
	TrigCompare T11(.A(Ireg[11]),.B(treg[11]),.C(dreg[11]),.T(TCout[11]));
	TrigCompare T12(.A(Ireg[12]),.B(treg[12]),.C(dreg[12]),.T(TCout[12]));
	TrigCompare T13(.A(Ireg[13]),.B(treg[13]),.C(dreg[13]),.T(TCout[13]));
	TrigCompare T14(.A(Ireg[14]),.B(treg[14]),.C(dreg[14]),.T(TCout[14]));
	TrigCompare T15(.A(Ireg[15]),.B(treg[15]),.C(dreg[15]),.T(TCout[15]));
	TrigCompare T16(.A(Ireg[16]),.B(treg[16]),.C(dreg[16]),.T(TCout[16]));
	TrigCompare T17(.A(Ireg[17]),.B(treg[17]),.C(dreg[17]),.T(TCout[17]));
	TrigCompare T18(.A(Ireg[18]),.B(treg[18]),.C(dreg[18]),.T(TCout[18]));
	TrigCompare T19(.A(Ireg[19]),.B(treg[19]),.C(dreg[19]),.T(TCout[19]));
	TrigCompare T20(.A(Ireg[20]),.B(treg[20]),.C(dreg[20]),.T(TCout[20]));
	TrigCompare T21(.A(Ireg[21]),.B(treg[21]),.C(dreg[21]),.T(TCout[21]));
	TrigCompare T22(.A(Ireg[22]),.B(treg[22]),.C(dreg[22]),.T(TCout[22]));
	TrigCompare T23(.A(Ireg[23]),.B(treg[23]),.C(dreg[23]),.T(TCout[23]));
	TrigCompare T24(.A(Ireg[24]),.B(treg[24]),.C(dreg[24]),.T(TCout[24]));
	TrigCompare T25(.A(Ireg[25]),.B(treg[25]),.C(dreg[25]),.T(TCout[25]));
	TrigCompare T26(.A(Ireg[26]),.B(treg[26]),.C(dreg[26]),.T(TCout[26]));
	TrigCompare T27(.A(Ireg[27]),.B(treg[27]),.C(dreg[27]),.T(TCout[27]));
	TrigCompare T28(.A(Ireg[28]),.B(treg[28]),.C(dreg[28]),.T(TCout[28]));
	TrigCompare T29(.A(Ireg[29]),.B(treg[29]),.C(dreg[29]),.T(TCout[29]));
	TrigCompare T30(.A(Ireg[30]),.B(treg[30]),.C(dreg[30]),.T(TCout[30]));
	TrigCompare T31(.A(Ireg[31]),.B(treg[31]),.C(dreg[31]),.T(TCout[31]));

	always @ (TCout)
		TC = TCout[31] & TCout[30] & TCout[29] & TCout[28] & TCout[27] &
			TCout[26] & TCout[25] & TCout[24] & TCout[23] & TCout[22] &
			TCout[21] & TCout[20] & TCout[19] & TCout[18] & TCout[17] &
			TCout[16] & TCout[15] & TCout[14] & TCout[13] & TCout[12] &
			TCout[11] & TCout[10] & TCout[9] & TCout[8] & TCout[7] &
			TCout[6] & TCout[5] & TCout[4] & TCout[3] & TCout[2] & TCout[1] & TCout[0];

	//----------------------------------------------------------------
	// Trigger State machine
	//----------------------------------------------------------------			
	always @ (posedge clk or posedge reset)
	begin
		if(reset)
			CS <= 0;	//reset triggered status
		else
			CS <= NS;	//goto next state
	end

	always @(CS or Done or TC or arm)
	begin
		case (CS)
			TRIG_IDLE: begin
				if(arm)
				begin
					NS = TRIG_ARMED;	//arm system?
					ClearCntr = 1;		//clear address counters
					clearready = 1;	//put into not ready state
					setready = 0;
				end
				else
				begin
					NS = TRIG_IDLE;
					ClearCntr = 0;	
					clearready = 0;
					setready = 0;
				end
			end
			TRIG_ARMED: begin
				if(TC)
				begin
					NS = TRIG_TRIG;	//triggered...record
					ClearCntr = 0;	
					clearready = 0;
					setready = 0;
				end
				else
				begin
					ClearCntr = 0;	
					NS = TRIG_ARMED;
					clearready = 0;
					setready = 0;
				end
			end
			TRIG_TRIG: begin
				if(Done)
				begin
					NS = TRIG_IDLE;	//done, stop
					ClearCntr = 0;	
					clearready = 0;
					setready = 1;		//put into ready state
				end
				else
				begin
					NS = TRIG_TRIG;
					ClearCntr = 0;	
					clearready = 0;
					setready = 0;
				end
			end
			default: begin
				NS = TRIG_IDLE;
				ClearCntr = 0;	
				clearready = 1;
				setready = 0;
			end
		endcase
	end

	//***********************************************************************************************
	// Memory
	//***********************************************************************************************
    	always @ (wd or CS)
		WdRam = wd && (CS == TRIG_TRIG);
/*
	RAMB4_S8_S8 RAM1(.DOA(), .DOB(RamA), .ADDRA(WdCntr), .CLKA(clk), .DIA(Ireg[7:0]  ), .ENA(1'b1), .RSTA(1'b0), .WEA(WdRam), .ADDRB(RdCntr[10:2]), .CLKB(clk), .DIB(8'b0), .ENB(1'b1), .RSTB(1'b0), .WEB(1'b0));
	RAMB4_S8_S8 RAM2(.DOA(), .DOB(RamB), .ADDRA(WdCntr), .CLKA(clk), .DIA(Ireg[15:8] ), .ENA(1'b1), .RSTA(1'b0), .WEA(WdRam), .ADDRB(RdCntr[10:2]), .CLKB(clk), .DIB(8'b0), .ENB(1'b1), .RSTB(1'b0), .WEB(1'b0));
	RAMB4_S8_S8 RAM3(.DOA(), .DOB(RamC), .ADDRA(WdCntr), .CLKA(clk), .DIA(Ireg[23:16]), .ENA(1'b1), .RSTA(1'b0), .WEA(WdRam), .ADDRB(RdCntr[10:2]), .CLKB(clk), .DIB(8'b0), .ENB(1'b1), .RSTB(1'b0), .WEB(1'b0));
	RAMB4_S8_S8 RAM4(.DOA(), .DOB(RamD), .ADDRA(WdCntr), .CLKA(clk), .DIA(Ireg[31:24]), .ENA(1'b1), .RSTA(1'b0), .WEA(WdRam), .ADDRB(RdCntr[10:2]), .CLKB(clk), .DIB(8'b0), .ENB(1'b1), .RSTB(1'b0), .WEB(1'b0));
*/
 
	ram8 RAM1 (.addra(WdCntr),.addrb(RdCntr[10:2]),.clka(clk),.clkb(clk),.dina(Ireg[7:0]  ),.doutb(RamA),.wea(WdRam));
	ram8 RAM2 (.addra(WdCntr),.addrb(RdCntr[10:2]),.clka(clk),.clkb(clk),.dina(Ireg[15:8] ),.doutb(RamB),.wea(WdRam));
	ram8 RAM3 (.addra(WdCntr),.addrb(RdCntr[10:2]),.clka(clk),.clkb(clk),.dina(Ireg[23:16]),.doutb(RamC),.wea(WdRam));
	ram8 RAM4 (.addra(WdCntr),.addrb(RdCntr[10:2]),.clka(clk),.clkb(clk),.dina(Ireg[31:24]),.doutb(RamD),.wea(WdRam));

	//-----------------------------------------------------------------------------------------------
	// output mux
	//-----------------------------------------------------------------------------------------------

	always @(RdCntr[1:0] or RamA or RamB or RamC or RamD)
	begin
		case (RdCntr[1:0])
			2'b00:dout = RamA;
			2'b01:dout = RamB;
			2'b10:dout = RamC;
			2'b11:dout = RamD;
			default:dout = 8'bx;
		endcase
	end
endmodule

module TrigCompare(A,B,C,T);
	input A;	//data input
	input B;	//tirgger input
	input C;	//trigger enable
	output T;	//output

	reg T;

	always @ (A or B or C)
	begin
		if(C)	//we do care
		begin
			if(A == B)
				T = 1;	//triggered
			else
				T = 0;	//not triggered
		end
		else
			T = 1;	//if it is don't care, indicate a trigger			
	end
endmodule

