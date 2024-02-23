//
//                              CY7C1416
//                      Simulation of Verilog model 


/*`define tx10 #200                //1.0 period
`define tx08 #160                //0.8 period
`define tx05 #100                //0.5 period  50MHZ
`define tx04 #80                 //0.4 period
`define tx03 #60                 //0.3 period
`define tx02 #40                 //0.2 period*/


module tb_ddr2_burst2;

`define num_vectors 220    
`define inp {A[20:0], Load_bar, WE_bar , BWS[1:0], Data_in[7:0], Data_expected[7:0]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        }

reg     [42:1]  lsim_vectors    [1:`num_vectors];
reg     [7:0]  Data_in;
reg     [20:0]  A;
reg		read_write;
reg     [7:0]  Data_expected;
reg             strb,j;
reg		echo, echo_bar;
integer         vector,i,k;
wire 		CQ, CQ_bar,TDO; 
reg		K, K_bar, C, C_bar, Load_bar, WE_bar,ZQ,DOFF;
reg     [1:0]   BWS;
reg       	TCK, TMS, TDI;
real		half_tcyc;

wire	[7:0]	Data_IO = read_write ? Data_in[7:0] : 8'bZ;

ddr2_burst2 test_file (TCK,TMS,TDI,TDO,K, K_bar, CQ, CQ_bar, C, C_bar, BWS, Load_bar, WE_bar, A, Data_IO,ZQ,DOFF); 

//Create a dump file for the outputs
initial
begin
  $dumpfile("vectors.dump");
  $dumpvars(0, tb_ddr2_burst2);
end

//specify cycle time of operation
initial
begin
     half_tcyc = 1.65;
end



//Initialization of signals

initial
  begin
	strb        =        1'b0 ;
	C 	    =	     1'b0  ;
	C_bar	    =	     1'b1 ;
	K	    =        1'b0  ;
	K_bar	    =        1'b1 ;
  end
//JTAG Variable Initialization

initial
begin
	TCK= 0;
	TMS = 1;
	TDI = 1'bx;
end

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
	#3.075 ;
	forever #half_tcyc strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	#4 ;
	forever #half_tcyc K =~K;
  end

initial
  begin
	#4 ;
	forever #half_tcyc K_bar = ~K_bar;
  end

initial
  begin
//	#4 ;
//	forever #half_tcyc C =~C;
    	C = 1;
  end

initial
  begin
//	#4 ;
//	forever #half_tcyc C_bar = ~C_bar;
	C_bar = 1;  
end
*/
//-------------------------Double Clock mode with zero skew------------------
//Initialization
initial
  begin
	#3.075 ;
	forever #half_tcyc strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	#4 ;
	forever #half_tcyc K =~K;
  end

initial
  begin
	#4 ;
	forever #half_tcyc K_bar = ~K_bar;
  end

initial
  begin
	#4 ;
	forever #half_tcyc C =~C;
  end

initial
  begin
	#4 ;
	forever #half_tcyc C_bar = ~C_bar;
  end



//---Double Clock mode with max. skew between K and C and between K_bar and C_bar--
//------------zero skew between K and K_bar and between C and C_bar-----------
/*//Initialization
initial
  begin
	#3.075 ;
	forever #half_tcyc strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	#4 ;
	forever #half_tcyc K =~K;
  end

initial
  begin
	#4 ;
	forever #half_tcyc K_bar = ~K_bar;
  end

initial
  begin
	#5.3 ;
	forever #half_tcyc C =~C;
  end

initial
  begin
	#5.3 ;
	forever #half_tcyc C_bar = ~C_bar;
  end
*/

//---Double Clock mode with zero skew between K and C and between K_bar and C_bar--
//------------min skew between K and K_bar and between C and C_bar-----------
//Initialization
/*initial
  begin
	#3.075 ;
	forever #half_tcyc strb = ~strb;
  end

// All the four clocks are generated here.
initial
  begin
	#4 ;
	forever #half_tcyc K =~K;
  end

initial
  begin
	#3.65 ;
	forever #half_tcyc K_bar = ~K_bar;
  end

initial
  begin
	#4 ;
	forever #half_tcyc C =~C;
  end

initial
  begin
	#3.65 ;
	forever #half_tcyc C_bar = ~C_bar;
  end*/



//------------------------------------------------------------------------------
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
 
 $readmemb("ddr2_burst2_vectors.txt", lsim_vectors);     //load input vector file
 for (vector = 1; vector <= `num_vectors; vector = vector + 1)
   @(strb)
    begin
         `inp = lsim_vectors[vector];
	  if (Data_in[7:0] === 8'hZ)
		read_write = 1'b0;
	      else
	        read_write = 1'b1;

    end
   #2 $finish; // This prevents simulation beyond end of test patterns
 end

always @(CQ)
begin
    #0.605 echo <= CQ;
end

always @(CQ_bar)
begin
    #0.605 echo_bar <= CQ_bar;
end

always@(posedge echo)
begin
      if (Data_in !== 8'bZ)
	 $display("Write cycle              : line = %d data_in  = %b",
		vector - 1, Data_in);
      else
	begin
//	  $display("Read or Deselect cycle: line = %d", vector);
	  if (Data_IO === Data_expected)
	    $display("OK     :Read or Deselect : line = %d data_out = %b expected_data = %b", vector -1, Data_IO, Data_expected); 
	  else
	    $display("ERROR  :Read or Deselect : line = %d data_out = %b expected_data = %b", vector -1, Data_IO, Data_expected); 
	end

    end

always@(posedge echo_bar)
begin
      if (Data_in !== 8'bZ)
	 $display("Write cycle              : line = %d data_in  = %b",
		vector - 1, Data_in);
      else
	begin
//	  $display("Read or Deselect cycle: line = %d", vector);
	  if (Data_IO === Data_expected)
	    $display("OK     :Read or Deselect : line = %d data_out = %b expected_data = %b", vector -1, Data_IO, Data_expected); 
	  else
	    $display("ERROR  :Read or Deselect : line = %d data_out = %b expected_data = %b", vector -1, Data_IO, Data_expected); 
	end

    end
endmodule

