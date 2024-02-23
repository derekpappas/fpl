//
//                              CY7C1383KV25
//                      Test bench for simulation of Verilog model 


module testbench;

`define num_vectors 120    

`define	inp {ZZ, MODE, ADDR[4:0], GW_N, BWE_N, BWb_N, BWa_N, CE1_N, CE2, CE3_N, ADSP_N, ADSC_N, ADV_N, OE_N, Data_in[17:0], Data_expected[17:0]}


reg     [54:1]  lsim_vectors    [1:`num_vectors];

reg             CLK;
reg             ADV_N;
reg             ADSP_N;
reg             ADSC_N;
reg             CE1_N;           
reg             CE2;            
reg             CE3_N;         
reg             GW_N;
reg     	BWa_N;
reg     	BWb_N;
reg             BWE_N;
reg             OE_N;
reg             ftb;
reg             MODE;         
reg             ZZ; 


reg     [17:0]  Data_in;
reg     [19:0]  ADDR;

wire		Rd_WrN;
reg     [17:0]  Data_expected;
reg             strb,j;
integer         vector,i,k;

real		half_tcyc;

assign Rd_WrN = (Data_in[17:0] === 18'hZ) ? 1 : ((Data_expected === 18'bZ & Data_in[17:0] !== 18'hZ ) ? 0 : 1);


wire	[17:0]	Data_IO = Rd_WrN ? 18'bZ : Data_in[17:0];		// Rd_WrN: Write --> 1; Read --> 0;


CY7C1383_FT test_file (ZZ, MODE, ADDR, GW_N, BWE_N, BWb_N, BWa_N, CE1_N, CE2, CE3_N, ADSP_N, ADSC_N, ADV_N, OE_N, Data_IO, CLK);


//Create a dump file for the outputs
initial
begin
  $dumpfile("vectors.dump");
  $dumpvars(0, testbench);
end

initial
begin
     half_tcyc = 6.0;
end


initial
  begin
        #4;
        forever #half_tcyc strb = ~strb;
  end

initial
  begin
	#2.2 ;
        #4;
        forever #half_tcyc CLK = ~CLK;
  end

//Initialization of signals

initial
  begin

  ADDR[19:5] = 15'h0000;
  CLK	=	0;		//CLK 
  CE1_N	=	0;		//chip 	 	enable
  CE2	=	1;		//chip 	 	enable
  CE3_N	=	0;		//chip 	 	enable
  CE1_N	=	0;		//clock 	enable
  OE_N	=	0;		//op		normal
  ftb	=	0;		//flowthrough	enabled
  MODE	=	0;	 	//burstMODE     linear
  ZZ	=	0;		//Sleep MODE    disable
  GW_N   =       1;
  ADSP_N =       1;

	strb        =        1'b0 ;
	
  end


initial
 begin
 
 $readmemb("SS_FT_X18_vect.txt", lsim_vectors);     //load input vector file
 for (vector = 1; vector <= `num_vectors; vector = vector + 1)
   @(posedge strb)
    begin
       `inp <= lsim_vectors[vector];
	#0.03;

    end
	#2 $finish;
 end


always@(posedge CLK)
begin

      if (Data_in !== 18'bZ)
	 $display("Write cycle              : line = %d data_in  = %b",
		vector - 1, Data_in);
      else
	begin

	  if (Data_IO === Data_expected)
	    $display("OK     :Read or Deselect : line = %d data_out = %b expected_data = %b", vector -1, Data_IO, Data_expected); 
	  else
	    $display("ERROR  :Read or Deselect : line = %d data_out = %b expected_data = %b", vector -1, Data_IO, Data_expected); 
	end

    end

endmodule

