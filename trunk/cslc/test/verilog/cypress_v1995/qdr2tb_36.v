`timescale  1 ns / 10 ps
//
//                           QDR2 - Burst-of-2, x36
//                         Simulation of Verilog model
//
// --------------------------------------------------------------

module rw_test;

`define num_vectors 61
`define inp {A[17:16],A[15:13],A[12:8],A[7:0],RPSb,WPSb,BWSb[1],BWSb[0],testout[17:9],testout[8:0],testin[17:9],testin[8:0]}

reg     [59:1]  lsim_vectors    [1:`num_vectors];

reg     [35:0]  dIn;
wire    [35:0]  dOut;
reg     [18:0]  A;
reg     [35:0]  testin;
reg     [35:0]  testout;
reg            noti3;
reg            strb,j;
integer        vector,i,k;
wire		CQ, CQb, TDO;
reg       	TCK, TMS, TDI, K, Kb, C, Cb, RPSb, WPSb, ZQ, DOFF;
reg     [3:0]   BWSb;
real     half_tcyc;


cyqdr2_b2 test_file (TCK, TMS, TDI, TDO, dIn, dOut, A, K, Kb, C, Cb, RPSb, WPSb, BWSb[0], BWSb[1], BWSb[2],BWSb[3] ,CQ, CQb, ZQ, DOFF);

//Create a dump file for the outputs

initial
begin
  $dumpfile("vectors.dump");
  $dumpvars(0,rw_test);
end

//specify cycle time of operation

initial
begin
   half_tcyc = 4;
end 

//Variable Initialization

initial
  begin

	j           =        1'b0;
        strb        =        1'b0 ;
	dIn         =        36'b000000000000000000000000000000000000;
	BWSb        =        4'b0000 ;
	C 	    =	     1'b0;
	Cb	    =	     1'b1;
	K	    =        1'b0;
	Kb	    =        1'b1;
	RPSb	    =	     1;
	WPSb	    =	     1;
	DOFF	    =	     0;
	A	=	19'b0000000000000000000;
  end

//JTAG Variable Initialization

initial
begin
	TCK= 0;
	TMS = 1;
	TDI = 1'bx;
end

//Initialization of TCK signal
/*
initial
begin
	#0.1;
	forever #5 TCK = ~TCK;
end
*/

initial
begin
	for(k = 0; k <= 1000; k=k+1)
	begin
		#10 TCK = 0;
		#90 TCK = 1;
	end
end

//Initialization of strb signal

initial
begin
	#0.8;
	forever #half_tcyc strb = ~strb;
end
initial 
begin
	#1.2;
	forever #half_tcyc j = ~j;
end


always
begin
	#half_tcyc K=~K;
	Kb = ~Kb;
	C = ~C;
	Cb = ~Cb;
end

initial
begin
	#100	TMS = 1;	
	#10	TMS = 1;	
	#10	TMS = 0;	// Go to idle (on next TCLK)
	#10	TMS = 0;
	#10	TMS = 0;
	#10	TMS = 1;	// Go to Sel-DR Scan
	TDI = 0;
   	#10	TMS = 0;	// Go to Capture-DR (should load bsr, all I/O)
	#10	TMS = 0;	// Go to Shift-DR
	#100	TMS = 1;
	#100	TMS = 0;
	#10000	$finish;
end

initial
begin

$readmemb("pksvectors.txt", lsim_vectors);     //load input vector file
 for (vector = 1; vector <= `num_vectors; vector = vector + 1)
   @(strb)
    begin
         `inp = lsim_vectors[vector];
          dIn[17:9] = testout[17:9];
          dIn[8:0] = testout[8:0];
    end
   #1 $finish; // This prevents simulation beyond end of test patterns

end

always @(j)
begin
     if (dOut[17:0] === testin[17:0])
	$display("Line:%d OK  data = %b test = %b",vector -1, dOut,testin);
     else
        $display("Line:%d ERROR data = %b test = %b",vector -1,dOut,testin);
end 

endmodule



