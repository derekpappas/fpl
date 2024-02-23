`timescale  1 ns / 10 ps
//
//                           QDR2 - Burst-of-4, x18
//                         Simulation of Verilog model
//
// --------------------------------------------------------------

module rw_test;

`define num_vectors 110
`define inp {A[19:18],A[17:16],A[15:13],A[12:8],A[7:0],RPSb,WPSb,BWSb[1],BWSb[0],testout[7:0],testin[7:0]}

reg     [41:1]  lsim_vectors    [1:`num_vectors];

reg     [7:0]  dIn;
wire    [7:0]  dOut;
reg     [19:0]  A;
reg     [7:0]  testin;
reg     [7:0]  testout;
reg            noti3;
reg            strb;
integer        vector,i,k;
wire		CQ, CQb, TDO;
reg       	TCK, TMS, TDI, K, Kb, C, Cb, RPSb, WPSb, ZQ, DOFF;
reg     [1:0]   BWSb;
reg       	C1,K_delayed, K_delayed_b;
real     half_tcyc;
real     offset, tx01, tx02;

cyqdr2_b4 test_file (TCK, TMS, TDI, TDO, dIn, dOut, A, K, Kb, C, Cb, RPSb, WPSb, BWSb[0], BWSb[1] ,CQ, CQb, ZQ, DOFF);

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

        strb        =        1'b0 ;
	dIn         =        18'b000000000000000000;
	BWSb        =        2'b00;
	C 	    =	     1'b0;
	C1 	    =	     1'b0;
	Cb	    =	     1'b1;
	K	    =        1'b0;
	K_delayed   =        1'b0;
	Kb	    =        1'b1;
	K_delayed_b =        1'b1;
	RPSb	    =	     1'b1;
	WPSb	    =	     1'b1;
	DOFF	    =	     1'b0;
	A	=	20'b00000000000000000000;
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
	forever #half_tcyc Kb = ~Kb;
  end

initial
  begin
//	forever #half_tcyc C =~C;
    	C = 1;
  end

initial
  begin
//	forever #half_tcyc Cb = ~Cb;
	Cb = 1;  
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
	forever #half_tcyc Kb = ~Kb;
  end

initial
  begin
	forever #half_tcyc C =~C;
  end

initial
  begin
	forever #half_tcyc Cb = ~Cb;
  end
*/

//---Double Clock mode with max. skew between K and C and between Kb and Cb--
//------------zero skew between K and Kb and between C and Cb-----------

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
	forever #half_tcyc Kb = ~Kb;
  end

initial
  begin
	#1.8 ;
	forever #half_tcyc C =~C;
  end

initial
  begin
	#1.8 ;
	forever #half_tcyc Cb = ~Cb;
  end

//---Double Clock mode with zero skew between K and C and between Kb and Cb--
//------------min skew between K and Kb and between C and Cb-----------
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
	forever #half_tcyc Kb = ~Kb;
  end

initial
  begin
	forever #half_tcyc C =~C;
  end

initial
  begin
	#0.2 ;
	forever #half_tcyc Cb = ~Cb;
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
       forever #tx01 Cb = C1 & K_delayed_b;
  end


always
begin
	#half_tcyc K=~K;
	Kb = ~Kb;
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
//	#10000	$finish;
end

initial
begin

$readmemb("qdr2_vectors.txt", lsim_vectors);     //load input vector file
 for (vector = 1; vector <= `num_vectors; vector = vector + 1)
   @(strb)
    begin
         `inp = lsim_vectors[vector];
          dIn[7:0] = testout[7:0];
    end
   #2 $finish; // This prevents simulation beyond end of test patterns

end


always @(K)
begin
if (vector > 1 && vector <= `num_vectors)
begin

     if (dOut[7:0] === testin[7:0])
	$display("Line:%d OK  data = %b test = %b",vector -1, dOut,testin);
     else
        $display("Line:%d ERROR data = %b test = %b",vector -1,dOut,testin);
end
end 


endmodule
