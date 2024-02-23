`timescale  100ps /  10ps


//
//                              CY7C1306
//                      Simulatiom of Verilog model 
//
//



module rw_test;

`define num_vectors    160
`define inp {A[3:0], RPS_n, WPS_n , BWS_n[1:0], oe_n , testout[7:0], testin[7:0]}


reg     [25:1]  lsim_vectors    [1:`num_vectors];

reg     [35:0]  dIn;
wire    [35:0]  dOut;
reg     [17:0]  A;
reg     [17:0]  testin;
reg     [7:0]   testout;
reg             noti3;
reg             strb,j;
integer         vector,i;
reg  tck, tms, tdi, C, C_n, K, K_n, oe_n, RPS_n, WPS_n, ZQ;
reg     [3:0]   BWS_n;



cy1306 test_file (tck, tms, tdi, tdo_out, dIn, dOut, A, K, K_n, C, C_n, RPS_n, WPS_n, BWS_n[0], BWS_n[1],BWS_n[2],BWS_n[3], ZQ);


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
	dIn         =        36'b000000000000000000000000000000000000 ;
	BWS_n        =       4'b0000 ;
	C 	    =	     1'b0  ;
	C_n	    =	     1'b1 ;
	K	    =        1'b0  ;
	K_n	    =        1'b1 ;
	RPS_n	    =	     1 ;
	WPS_n	    =	     1 ;
	A[17:4]     =        14'b00000000000000 ; 

  end

//JTAG Variable Initialization

initial
  begin
	tck = 0;
	tms = 1;
	tdi = 1'bx;
  end
//Initialization
initial
  begin

	forever #30 strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	#15 ;
	forever #30 K =~K;
  end

initial
  begin
	#15 ;
	forever #30 K_n = ~K_n;
  end

initial
  begin
	#15 ;
	forever #30 C =~C;
  end

initial
  begin
	#15 ;
	forever #30 C_n = ~C_n;
  end

initial
 begin
 
 $readmemb("donato_vectors", lsim_vectors);     //load input vector file
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











