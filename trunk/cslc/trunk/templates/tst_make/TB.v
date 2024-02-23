                                                                              
//------------- stimulus vector parameters---------------------
  parameter SIM_TIMEOUT_CNT = 100 ;
  parameter STIM_MEM_WIDTH = 3 ;
  parameter STIM_ADDR_WIDTH = 16 ;
  parameter STIM_VECTOR_ID = 4 ;
  parameter STIM_VECTOR_VERSION = 5 ;
  parameter STIM_VECTOR_NAME = "stim" ;
  parameter STIM_VECTOR_FILE = "stim" ;
  parameter STIM_VECTOR_RADIX = 1 ;
  parameter STIM_VECTOR_MAX_ERR = 0 ;

//------------- expected vector parameters---------------------
  parameter EXP_MEM_WIDTH = 3 ;
  parameter EXP_ADDR_WIDTH = 16 ;
  parameter EXP_VECTOR_ID = 6 ;
  parameter EXP_VECTOR_VERSION = 7 ;
  parameter EXP_VECTOR_NAME = "exp" ;
  parameter EXP_VECTOR_FILE = "exp" ;
  parameter EXP_VECTOR_RADIX = 1 ;
  parameter EXP_VECTOR_MAX_ERR = 10 ;
//--------------------------------------------------------------
//------------------testbench signals---------------------------
//-------------------fixed signals-----------------------------
  reg clk ;
  reg testbench_reset_ ;
  reg rand_valid ;
  integer file_mcd ;
  integer report_file_mcd ;
  integer cycle_cnt ;

  reg [EXP_ADDR_WIDTH -1 : 0] exp_a0_match_count ;
  reg [EXP_ADDR_WIDTH -1 : 0] exp_a0_mismatch_count ;
  reg [EXP_ADDR_WIDTH -1 : 0] exp_a0_transaction_count ;
  reg exp_a0_mismatch_count ;
  wire expect_out_valid ;
  wire rd_en ;
  wire stim_mem_version_err ;
  wire exp_mem_version_err ;
  wire stim_mem_id_err ;
  wire exp_mem_id_err ;
  wire stop_sim = cycle_cnt >= SIM_TIMEOUT_CNT;
//-----------DUT dependent signals-------------------------

 wire [STIM_MEM_WIDTH -1 : 0] a0_in_p_in1;


 wire [STIM_MEM_WIDTH -1 : 0] a0_in_p_in2;



  reg [EXP_MEM_WIDTH -1 : 0] a0_out_p_out1;
  reg [EXP_MEM_WIDTH -1 : 0] a0_out_p_out1_expect;


  wire [EXP_MEM_WIDTH -1 : 0] a0_out_p_out2;
  wire [EXP_MEM_WIDTH -1 : 0] a0_out_p_out2_expect;


  assign rd_en = rand_valid;

//----------------------------------------------------------------
//----------------DUT instance--------------------

a a0( .p_in1(a0_in_p_in1), 
 .p_in2(a0_in_p_in2), 
 .p_out1(a0_out_p_out1), 
 .p_out2(a0_out_p_out2)); 

                                                                              
//------------------------------------------------
//------------------STIM memory----------------------------------------------
stim_exp_mem #(.STIM_ADDR_WIDTH(STIM_ADDR_WIDTH),
	      .MEM_WIDTH(STIM_MEM_WIDTH),
	      .VECTOR_FILE(STIM_VECTOR_FILE),
              .VECTOR_ID(STIM_VECTOR_ID),
              .VECTOR_NAME(STIM_VECTOR_NAME),
              .VECTOR_RADIX(STIM_VECTOR_RADIX),
              .VECTOR_VERSION(STIM_VECTOR_VERSION))
               stim_mem_inst (.clock(clk),
                             .id_err(stim_mem_id_err),
                             .rd_en(rd_en),
                             .reset_(testbench_reset_),
                             .valid(expect_out_valid),
                             .vector_out({ a0_in_p_in1 ,
 a0_in_p_in2 
}),
                             .version_err(stim_mem_version_err));
//-----------------EXP memory----------------------------------------------
stim_exp_mem #(.EXP_ADDR_WIDTH(EXP_ADDR_WIDTH),
             .MEM_WIDTH(EXP_MEM_WIDTH),
             .VECTOR_FILE(EXP_VECTOR_FILE),
             .VECTOR_ID(EXP_VECTOR_ID),
             .VECTOR_NAME(EXP_VECTOR_NAME),
             .VECTOR_RADIX(EXP_VECTOR_RADIX),
             .VECTOR_VERSION(EXP_VECTOR_VERSION))
              exp_mem_inst (.clock(clk),
                           .id_err(exp_mem_id_err),
                           .rd_en(rd_en),
                           .reset_(testbench_reset_),
                           .valid(expect_out_valid),
                           .vector_out({ a0_out_p_out1_expected ,
 a0_out_p_out2_expected 
}),
                           .version_err(exp_mem_version_err));
//----------------------------------------------------------------------------
//----------------# of cycles----------------------
always @(posedge clk or negedge testbench_reset_) begin
 if(~(testbench_reset_)) begin
 	cycle_cnt <= 0;
 end
 else begin
	cycle_cnt <= cycle_cnt + 1;   
 end
end
//--------------------------------------------------
//---------------initial---------------------------
   initial
   begin
       clk = 1'b0;
       rand_valid = 1'b1;
       testbench_reset_ = 1'b1; 
       exp_a0_match_count = 0;
       exp_a0_mismatch_count = 0;
       exp_a0_transaction_count = 0;
       #10 testbench_reset_ = 1'b0;
       #20 testbench_reset_ = 1'b1;
//---------------------------------------------------       
//----------Open vectors file------------------------
     file_mcd = $fopen("vectors.txt");
     if(file_mcd == 0) begin
       $display("Error opening vectors.txt file");
       $finish;
     end
    $display(file_mcd, "Dut outputs vs expected vectors:\n");
    $dumpfile("wavesDefaultOutputFile_dump");
    $dumpvars(0,TB);
    $dumpon;
  end
//-----------------------------------------------------
//-----------------------match-mismatch enable---------------------------------

wire a0_out_p_out1_match_en = a0_out_p_out1 == a0_out_p_out1_expected;
wire a0_out_p_out1_mismatch_en = a0_out_p_out1 != a0_out_p_out1_expected;


wire a0_out_p_out2_match_en = a0_out_p_out2 == a0_out_p_out2_expected;
wire a0_out_p_out2_mismatch_en = a0_out_p_out2 != a0_out_p_out2_expected;


//----------------clock generation------------------------
  always #10 clk <= ~(clk);

//--------------------------------------------------------

//------------------mismatches-------------------------------------------
always @(posedge clk or negedge testbench_reset_) begin
   if(~(testbench_reset_)) begin
   exp_a0_mismatch_count = {EXP_ADDR_WIDTH{1'b0}};
  end
  else begin

   if(a0_out_p_out1_mismatch_en) begin
    exp_a0_transaction_count = exp_a0_transaction_count+1'b1;
    exp_a0_mismatch_count = exp_a0_mismatch_count+1'b1;
   end 


   if(a0_out_p_out2_mismatch_en) begin
    exp_a0_transaction_count = exp_a0_transaction_count+1'b1;
    exp_a0_mismatch_count = exp_a0_mismatch_count+1'b1;
   end 


   if(exp_a0_mismatch_count > EXP_VECTOR_MAX_ERR) begin
   $display("Maximum number or errors allowed for vector %s has been reached", "exp_dut_i");
   end
  end
end
//---------------matches-------------------------------------
 always @(posedge clk or negedge testbench_reset_) begin
   if(~(testbench_reset_)) begin
   exp_a0_match_count = {EXP_ADDR_WIDTH{1'b0}};
  end
  else begin

   if(a0_out_p_out2_mismatch_en) begin
    exp_a0_transaction_count = exp_a0_transaction_count+1'b1;
    exp_a0_match_count = exp_a0_match_count+1'b1;
   end 


   if(a0_out_p_out2_mismatch_en) begin
    exp_a0_transaction_count = exp_a0_transaction_count+1'b1;
    exp_a0_match_count = exp_a0_match_count+1'b1;
   end 


 end
end
//------------------------------------------------------------------

 endmodule  



module TB();
