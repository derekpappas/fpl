`include "stim_expect_mem_template.v"
`include "a_unit.v"
`include "b_unit.v"
`include "c_unit.v"

module tb();                                                                              
//------------- stimulus vector parameters---------------------
  parameter SIM_TIMEOUT_CNT = 0 ;
  parameter STIM_MEM_WIDTH = 10 ;
  parameter STIM_ADDR_WIDTH = 2 ;
  parameter STIM_VECTOR_ID =   2 ;
  parameter STIM_VECTOR_VERSION =   4 ;
  parameter STIM_VECTOR_NAME = "stim" ;
  parameter STIM_VECTOR_FILE = "../systemC/stim_vec_c0_" ;
  parameter STIM_VECTOR_RADIX = 0 ;
  parameter STIM_VECTOR_MAX_ERR = 1 ;

//------------- expected vector parameters---------------------
  parameter EXP_MEM_WIDTH = 16 ;
  parameter EXP_ADDR_WIDTH = 2 ;
  parameter EXP_VECTOR_ID =   2 ;
  parameter EXP_VECTOR_VERSION =   4 ;
  parameter EXP_VECTOR_NAME = "exp" ;
  parameter EXP_VECTOR_FILE = "../systemC/exp_vec_c0_" ;
  parameter EXP_VECTOR_RADIX = 0 ;
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

  reg [EXP_ADDR_WIDTH -1 : 0] exp_c0_match_count ;
  reg [EXP_ADDR_WIDTH -1 : 0] exp_c0_mismatch_count ;
  reg [EXP_ADDR_WIDTH -1 : 0] exp_c0_transaction_count ;
   reg exp_c0_mismatch ;
  wire expect_out_valid ;
  wire rd_en ;
  wire stim_mem_version_err ;
  wire exp_mem_version_err ;
  wire stim_mem_id_err ;
  wire exp_mem_id_err ;
  wire stop_sim = cycle_cnt >= SIM_TIMEOUT_CNT;
//-----------DUT dependent signals-------------------------

 wire [4 -1 : 0] c0_in_in1;


 wire [4 -1 : 0] c0_in_in2;


 wire [1 -1 : 0] c0_in_in3;



  wire [4 -1 : 0] c0_out_out1;
  wire [4 -1 : 0] c0_out_out1_expected;


  wire [4 -1 : 0] c0_out_out2;
  wire [4 -1 : 0] c0_out_out2_expected;


  wire [4 -1 : 0] c0_out_out3;
  wire [4 -1 : 0] c0_out_out3_expected;


  wire [4 -1 : 0] c0_out_out4;
  wire [4 -1 : 0] c0_out_out4_expected;


  assign rd_en = rand_valid;

//----------------------------------------------------------------

 //----------------DUT instance--------------------

c_unit c0(.clk(clk), 
     .in1(c0_in_in1), 
     .in2(c0_in_in2), 
     .in3(c0_in_in3), 
     .in4(c0_in_in4), 
     .out1(c0_out_out1), 
     .out2(c0_out_out2), 
     .out3(c0_out_out3), 
     .out4(c0_out_out4)); 

                                                                              
//------------------------------------------------
//------------------STIM memory----------------------------------------------
stim_expect_mem_template #(.ADDR_WIDTH(STIM_ADDR_WIDTH),
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
                                           .vector_out({ c0_in_in4 ,  
 c0_in_in3 ,  
 c0_in_in2 ,  
 c0_in_in1  }), 

                                           .version_err(stim_mem_version_err));
//-----------------EXP memory----------------------------------------------
stim_expect_mem_template #(.ADDR_WIDTH(EXP_ADDR_WIDTH),
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
                                          .vector_out({ c0_out_out4_expected ,
 c0_out_out3_expected ,
 c0_out_out2_expected ,
 c0_out_out1_expected }),

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
//----------Open vectors file------------------------
     file_mcd = $fopen("vectors.txt");
     if(file_mcd == 0) begin
       $display("Error opening vectors.txt file");
       $finish;
     end
    $fwrite(file_mcd, "Dut outputs vs expected vectors:\n");
    $dumpfile("wavesDefaultOutputFile_dump");
    $dumpvars(0,tb);
    $dumpon;
 
//-----------------------------------------------------
       clk = 1'b0;
       rand_valid = 1'b1;
       testbench_reset_ = 1'b1; 
       exp_c0_match_count = 0;
       exp_c0_mismatch_count = 0;
       exp_c0_transaction_count = 0;
       #10 testbench_reset_ = 1'b0;
       #20 testbench_reset_ = 1'b1;
 end
//---------------------------------------------------       

//-----------------------match-mismatch enable---------------------------------

wire c0_out_out1_match_en = c0_out_out1 == c0_out_out1_expected;
wire c0_out_out1_mismatch_en = c0_out_out1 != c0_out_out1_expected;


wire c0_out_out2_match_en = c0_out_out2 == c0_out_out2_expected;
wire c0_out_out2_mismatch_en = c0_out_out2 != c0_out_out2_expected;


wire c0_out_out3_match_en = c0_out_out3 == c0_out_out3_expected;
wire c0_out_out3_mismatch_en = c0_out_out3 != c0_out_out3_expected;


wire c0_out_out4_match_en = c0_out_out4 == c0_out_out4_expected;
wire c0_out_out4_mismatch_en = c0_out_out4 != c0_out_out4_expected;


//----------------clock generation------------------------
  always # 20 clk <= ~(clk);

//--------------------------------------------------------

//------------------mismatches-------------------------------------------
always @(posedge clk or negedge testbench_reset_) begin
   if(~(testbench_reset_)) begin
   exp_c0_mismatch_count = {EXP_ADDR_WIDTH{1'b0}};
  end
  else begin

   if(c0_out_out1_mismatch_en) begin
    exp_c0_transaction_count = exp_c0_transaction_count+1'b1;
    exp_c0_mismatch_count = exp_c0_mismatch_count+1'b1;
$fwrite(file_mcd,"mismatch detected: DUT output %s = %x     Expected output %s = %x \n", "c0_out_out1",c0_out_out1,"c0_out_out1_expected",c0_out_out1_expected);
   end 


   if(c0_out_out2_mismatch_en) begin
    exp_c0_transaction_count = exp_c0_transaction_count+1'b1;
    exp_c0_mismatch_count = exp_c0_mismatch_count+1'b1;
$fwrite(file_mcd,"mismatch detected: DUT output %s = %x     Expected output %s = %x \n", "c0_out_out2",c0_out_out2,"c0_out_out2_expected",c0_out_out2_expected);
   end 


   if(c0_out_out3_mismatch_en) begin
    exp_c0_transaction_count = exp_c0_transaction_count+1'b1;
    exp_c0_mismatch_count = exp_c0_mismatch_count+1'b1;
$fwrite(file_mcd,"mismatch detected: DUT output %s = %x     Expected output %s = %x \n", "c0_out_out3",c0_out_out3,"c0_out_out3_expected",c0_out_out3_expected);
   end 


   if(c0_out_out4_mismatch_en) begin
    exp_c0_transaction_count = exp_c0_transaction_count+1'b1;
    exp_c0_mismatch_count = exp_c0_mismatch_count+1'b1;
$fwrite(file_mcd,"mismatch detected: DUT output %s = %x     Expected output %s = %x \n", "c0_out_out4",c0_out_out4,"c0_out_out4_expected",c0_out_out4_expected);
   end 


   if(exp_c0_mismatch_count > EXP_VECTOR_MAX_ERR) begin
   $display("Maximum number or errors allowed for vector %s has been reached", "exp_dut_i");
   end
  end
end
//---------------matches-------------------------------------
 always @(posedge clk or negedge testbench_reset_) begin
   if(~(testbench_reset_)) begin
   exp_c0_match_count = {EXP_ADDR_WIDTH{1'b0}};
  end
  else begin

   if(c0_out_out1_match_en) begin
    exp_c0_transaction_count = exp_c0_transaction_count+1'b1;
    exp_c0_match_count = exp_c0_match_count+1'b1;
$fwrite(file_mcd,"match detected: DUT output %s = %x     Expected output %s = %x \n", "c0_out_out1",c0_out_out1,"c0_out_out1_expected",c0_out_out1_expected);
   end 


   if(c0_out_out2_match_en) begin
    exp_c0_transaction_count = exp_c0_transaction_count+1'b1;
    exp_c0_match_count = exp_c0_match_count+1'b1;
$fwrite(file_mcd,"match detected: DUT output %s = %x     Expected output %s = %x \n", "c0_out_out2",c0_out_out2,"c0_out_out2_expected",c0_out_out2_expected);
   end 


   if(c0_out_out3_match_en) begin
    exp_c0_transaction_count = exp_c0_transaction_count+1'b1;
    exp_c0_match_count = exp_c0_match_count+1'b1;
$fwrite(file_mcd,"match detected: DUT output %s = %x     Expected output %s = %x \n", "c0_out_out3",c0_out_out3,"c0_out_out3_expected",c0_out_out3_expected);
   end 


   if(c0_out_out4_match_en) begin
    exp_c0_transaction_count = exp_c0_transaction_count+1'b1;
    exp_c0_match_count = exp_c0_match_count+1'b1;
$fwrite(file_mcd,"match detected: DUT output %s = %x     Expected output %s = %x \n", "c0_out_out4",c0_out_out4,"c0_out_out4_expected",c0_out_out4_expected);
   end 


 end
end
//------------------------------------------------------------------

 endmodule  


