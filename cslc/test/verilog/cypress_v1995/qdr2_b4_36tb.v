`timescale  1 ns / 10 ps
//
//                           QDR2 - Burst-of-4, x36
//                         Simulation of Verilog model
//
// --------------------------------------------------------------

module rw_test;

`define num_vectors 888
`define inp {A[16],A[15:13],A[12:8],A[7:0],RPS_n,WPS_n,BWS_n[1],BWS_n[0],testout[17:9],testout[8:0],testin[17:9],testin[8:0]}

reg     [58:1]  lsim_vectors    [1:`num_vectors];

reg     [35:0]  dIn;
wire    [35:0]  dOut;
reg     [16:0]  A;
reg     [17:0]  testin;
reg     [17:0]  testout;
reg            noti3;
reg            strb,j;
integer        vector,i,k;
wire		CQ, CQ_n, TDO;
reg       	TCK, TMS, TDI, K, K_n, C, C_n, RPS_n, WPS_n, ZQ, DOFF;
reg     [3:0]   BWS_n;
reg       	C1,K_delayed, K_delayed_b;
real     half_tcyc;
real     offset, tx01, tx02;

cyqdr2_b4 test_file (TCK, TMS, TDI, TDO, dIn, dOut, A, K, K_n, C, C_n, RPS_n, WPS_n, BWS_n[0], BWS_n[1] , BWS_n[2], BWS_n[3], CQ, CQ_n, ZQ, DOFF);

//Create a dump file for the outputs

initial
begin
  $dumpfile("vectors.dump");
  $dumpvars(0,rw_test);
end

//specify cycle time of operation

initial
begin
   half_tcyc = 3;
   offset = 1.5;
   tx01 = 0.01;
   tx02 = ((2 * half_tcyc) * 9);

end 

//Variable Initialization

initial
  begin

	j           =        1'b0;
        strb        =        1'b0 ;
	dIn         =        36'b000000000000000000000000000000000000;
	BWS_n        =        4'b0000;
	C 	    =	     1'b0;
	C1 	    =	     1'b0;
	C_n	    =	     1'b1;
	K	    =        1'b0;
	K_delayed   =        1'b0;
	K_n	    =        1'b1;
	K_delayed_b =        1'b1;
	RPS_n	    =	     1;
	WPS_n	    =	     1;
	DOFF	    =	     0;
	A	=	19'b0000000000000000000;
  end

//JTAG Variable Initialization

initial
begin
	TCK = 0;
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

//-------------------------Single Clock mode-----------------------------------
/*//Initialization
initial
  begin
	#0.8 ;
	forever #half_tcyc strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	forever #half_tcyc K =~K;
  end

initial
  begin
	forever #half_tcyc K_n = ~K_n;
  end

initial
  begin
//	forever #half_tcyc C =~C;
    	C = 1;
  end

initial
  begin
//	forever #half_tcyc C_n = ~C_n;
	C_n = 1;  
end
*/
//-------------------------Double Clock mode with zero skew------------------
/*
//Initialization
initial
  begin
	#0.8 ;
	forever #half_tcyc strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	forever #half_tcyc K =~K;
  end

initial
  begin
	forever #half_tcyc K_n = ~K_n;
  end

initial
  begin
	forever #half_tcyc C =~C;
  end

initial
  begin
	forever #half_tcyc C_n = ~C_n;
  end

*/
//---Double Clock mode with max. skew between K and C and between K_n and C_n--
//------------zero skew between K and K_n and between C and C_n-----------

///Initialization
initial
  begin
	#0.8 ;
	forever #half_tcyc strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	forever #half_tcyc K =~K;
  end

initial
  begin
	forever #half_tcyc K_n = ~K_n;
  end

initial
  begin
	#1.8 ;
	forever #half_tcyc C =~C;
  end

initial
  begin
	#1.8 ;
	forever #half_tcyc C_n = ~C_n;
  end

//---Double Clock mode with zero skew between K and C and between K_n and C_n--
//------------min skew between K and K_n and between C and C_n-----------
/*
//Initialization
initial
  begin
	#0.8 ;
	forever #half_tcyc strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	forever #half_tcyc K =~K;
  end

initial
  begin
	#0.2 ;
	forever #half_tcyc K_n = ~K_n;
  end

initial
  begin
	forever #half_tcyc C =~C;
  end

initial
  begin
	#0.2 ;
	forever #half_tcyc C_n = ~C_n;
  end
*/
//----------------------- On the fly change of mode --------------------------------
/*
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

initial
  begin
	#half_tcyc;
///	forever #tx02 C1 = ~C1;
        #tx02 C1 = ~C1;
  end

initial
  begin
       forever  #tx01 C = C1 & K_delayed;
  end

initial
  begin
       forever #tx01 C_n = C1 & K_delayed_b;
  end


always
begin
	#half_tcyc K=~K;
	K_n = ~K_n;
end

initial
begin
	#offset;
	forever #half_tcyc K_delayed = ~K_delayed;
end

initial
begin
	#offset;
	forever #half_tcyc K_delayed_b = ~K_delayed_b;
end
*/
//----------------------------------------------------------------------------------
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

$readmemb("qdr2_vectors.txt", lsim_vectors);     //load input vector file
 for (vector = 1; vector <= `num_vectors; vector = vector + 1)
   @(strb)
    begin
         `inp = lsim_vectors[vector];
          dIn[17:9] = testout[17:9];
          dIn[8:0] = testout[8:0];
    end
   #1000 $finish; // This prevents simulation beyond end of test patterns

end

always @(j)
begin
     if (dOut[17:0] === testin[17:0])
	$display("Line:%d OK  data = %b test = %b",vector -1, dOut,testin);
     else
        $display("Line:%d ERROR data = %b test = %b",vector -1,dOut,testin);
end 

endmodule



