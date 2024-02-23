//
//                              CY7C1368B
//                      Test Bench for simulation of Verilog model 

module testbench;

`define num_vectors 120    

`define	inp {ZZ, MODE, ADDR[4:0], GW_N, BWE_N, BWd_N, BWc_N, BWb_N, BWa_N, CE1_N, CE2, CE3_N, ADSP_N, ADSC_N, ADV_N, OE_N, Data_in[35:0], Data_expected[35:0]}


reg     [92:1]  lsim_vectors    [1:`num_vectors];

reg             CLK;
reg             ADV_N;
reg             ADSP_N;
reg             ADSC_N;
reg             CE1_N;         
reg             CE2;          
reg             CE3_N;       
reg             GW_N;
reg     BWa_N;
reg     BWb_N;
reg     BWc_N;
reg     BWd_N;
reg             BWE_N;
reg             OE_N;
reg             ftb;
reg             MODE;       
reg             ZZ; 


reg     [35:0]  Data_in;
wire    [31:0]  Data_in1;
reg     [18:0]  ADDR;

wire		Rd_WrN;
reg     [35:0]  Data_expected;
wire    [31:0]  Data_expected1;
reg             strb,j;
integer         vector,i,k;

real		half_tcyc;

assign Data_in1 = {Data_in[34:27],Data_in[25:18],Data_in[16:9],Data_in[7:0]};
assign Data_expected1 = {Data_expected[34:27],Data_expected[25:18],Data_expected[16:9],Data_expected[7:0]};
   
//assign Data_in1 = Data_in [31:0];
//assign Data_expected1 = Data_expected [31:0];
assign Rd_WrN = (Data_in1[35:0] === 32'hZ) ? 1 : ((Data_expected1 === 32'bZ & Data_in1[31:0] !== 32'hZ ) ? 0 : 1);


wire	[31:0]	Data_IO = Rd_WrN ? 32'bZ : Data_in1[31:0];		// Rd_WrN: Write --> 1; Read --> 0;


CY7C1368_PLDCD test_file (ZZ, MODE, ADDR, GW_N, BWE_N, BWd_N, BWc_N, BWb_N, BWa_N, CE1_N, CE2, CE3_N, ADSP_N, ADSC_N, ADV_N, OE_N, Data_IO, CLK);


//Create a dump file for the outputs
initial
begin
  $dumpfile("vectors.dump");
  $dumpvars(0, testbench);
end

initial
begin
     half_tcyc = 2.5;
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

  ADDR[18:5] = 14'h0000;
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
 
 $readmemb(" SS_PL_DCD_X36_vect.txt", lsim_vectors);     //load input vector file
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

      if (Data_in1 !== 32'bZ)
	begin
	 $display("Write cycle              : line = %d data_in  = %b",
		vector - 1, Data_in1);
	end

      else
	begin

	  if (Data_IO === Data_expected1)
	    $display("OK     :Read or Deselect : line = %d data_out = %b expected_data = %b", vector -1, Data_IO, Data_expected1); 
	  else
	    $display("ERROR  :Read or Deselect : line = %d data_out = %b expected_data = %b", vector -1, Data_IO, Data_expected1); 
	end

    end

endmodule
