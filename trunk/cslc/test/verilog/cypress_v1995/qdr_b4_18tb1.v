`timescale  100ps /  10ps


//
//                              CY7C1304CV25
//                      Simulatiom of Verilog model 
//
//

`define tx05 #100                
`define tx04 #80                 
`define tx01 #10                 
`define tx02 #30                 


module rw_test;

`define num_vectors    299
`define inp {A[3:0], RPSb, WPSb , BWSb[1:0], oeb , testout[7:0], testin[7:0]}


reg     [25:1]  lsim_vectors    [1:`num_vectors];

reg     [17:0]  dIn;
wire    [17:0]  dOut;
reg     [16:0]  A;
reg     [17:0]  testin;
reg     [7:0]   testout;
reg             noti3;
reg             strb,j;
integer         vector,i,k;
reg C, Cb,TCK,TMS,TDI, K, Kb, oeb, RPSb, WPSb, ZQ;
reg     [1:0]   BWSb;
wire TDO;


cy1304 test_file (TCK, TMS, TDI, TDO, dIn, dOut, A, K, Kb, RPSb, WPSb, BWSb[0], BWSb[1],C,Cb, ZQ);


//Create a dump file for the outputs
initial
begin
  $dumpfile("vectors.dump");
  $dumpvars(0,rw_test);
end

//Variable Initialization

initial
  begin

	strb        =        1'b0 ;
	dIn         =        18'b000000000000000000 ;
	BWSb        =       2'b00 ;
	C 	    =	     1'b0  ;
	Cb	    =	     1'b1 ;
	K	    =        1'b0  ;
	Kb	    =        1'b1 ;
	RPSb	    =	     1 ;
	WPSb	    =	     1 ;
	A[16:4]     =        13'b0000000000000 ; 

  end
//JTAG Variable Initialization

initial
begin
	TCK = 0;
	TMS = 1;
	TDI = 1'bx;
end

initial
begin
	for(k = 0; k <= 1000; k=k+1)
	begin
		#1000 TCK = 0;
		#9000 TCK = 1;
	end
end

//Initialization
initial
  begin

	forever `tx02 strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	`tx01 ;
	forever `tx02 K =~K;
  end

initial
  begin
	`tx01 ;
	forever `tx02 Kb = ~Kb;
  end

initial
  begin
	`tx01 ;
	forever `tx02 C =~C;
  end

initial
  begin
	`tx01 ;
	forever `tx02 Cb = ~Cb;
  end
initial
begin

	#10000	TMS = 1;	
	#1000	TMS = 1;	
	#1000	TMS = 0;	// Go to idle (on next TCLK)
	#1000	TMS = 0;
	#1000	TMS = 0;
	#1000	TMS = 1;	// Go to Sel-DR Scan
	TDI = 0;
   	#1000	TMS = 0;	// Go to Capture-DR (should load bsr, all I/O)
	#1000	TMS = 0;	// Go to Shift-DR
	#10000	TMS = 1;
	#10000	TMS = 0;
	#500000	$finish;
end

initial
 begin
 
 $readmemb("test_vectors.txt", lsim_vectors);     //load input vector file
 for (vector = 1; vector <= `num_vectors; vector = vector + 1)
   @(strb)
    begin
         `inp = lsim_vectors[vector];
          dIn[17] = 0;
          dIn[8]  = 0;
          dIn[16:13] = testout[7:4];
          dIn[12:9] = testout[7:4];
          dIn[7:4] = testout[3:0];
          dIn[3:0] = testout[3:0];
    end
   #1 $finish; // This prevents simulation beyond end of test patterns
 end

always@(K)
begin
    testin[17] = 0;
    testin[8]  = 0;
    testin[16:13] = testin[7:4];
    testin[12:9] = testin[7:4];
    testin[7:4] = testin[3:0];
    if ( dOut[3:0] === testin[3:0] && dOut[7:4] === testin[7:4] )
    	$display("OUTPUT	: 001: line = %d data = %b test = %b",
         vector-1,dOut,testin);
    else
        $display("ERROR   *** : 003 : line = %d data = %b test = %b",vector -1,dOut,testin);

end
endmodule












