`include "defines.v"

module tb();
// Location of source csl unit: file name = tb_multi_instance.csl line number = 80
  parameter SIM_TIMEOUT_CNT = 100;
  parameter STIM_MEM_WIDTH = 11;
  parameter STIM_ADDR_WIDTH = 16;
  parameter STIM_VECTOR_ID = 0;
  parameter STIM_VECTOR_VERSION = 0;
  parameter STIM_VECTOR_NAME = "stim";
  parameter STIM_VECTOR_FILE = "stim_output.vec";
  parameter STIM_VECTOR_RADIX = 0;
  parameter STIM_VECTOR_MAX_ERR = 0;
  parameter EXP_MEM_WIDTH = 19;
  parameter EXP_ADDR_WIDTH = 16;
  parameter EXP_VECTOR_ID = 0;
  parameter EXP_VECTOR_VERSION = 0;
  parameter EXP_VECTOR_NAME = "exp";
  parameter EXP_VECTOR_FILE = "exp_output.vec";
  parameter EXP_VECTOR_RADIX = 0;
  parameter EXP_VECTOR_MAX_ERR = 0;
  reg clk;
  reg testbench_reset;
  reg rand_valid;
  integer file_mcd;
  integer report_file_mcd;
  integer cycle_cnt;
  reg [EXP_ADDR_WIDTH - 1:0] exp_c0_match_count;
  reg [EXP_ADDR_WIDTH - 1:0] exp_c0_mismatch_count;
  reg [EXP_ADDR_WIDTH - 1:0] exp_c0_transaction_count;
  reg exp_c0_mismatch;
  wire expect_out_valid;
  wire rd_en;
  wire version_err;
  wire id_err;
  wire stop_sim = cycle_cnt >= SIM_TIMEOUT_CNT;
  wire [3:0] c0_in_in1;
  wire [3:0] c0_in_in2;
  wire c0_in_in3;
  wire c0_in_in4;
  wire [3:0] c0_out_out1;
  wire [3:0] c0_out_out1_expect;
  wire [3:0] c0_out_out2;
  wire [3:0] c0_out_out2_expect;
  wire [3:0] c0_out_out3;
  wire [3:0] c0_out_out3_expect;
  wire [3:0] c0_out_out4;
  wire [3:0] c0_out_out4_expect;
  wire c0_out_out1_mismatch_en = c0_out_out1 != c0_out_out1_expect;
  wire c0_out_out2_mismatch_en = c0_out_out2 != c0_out_out2_expect;
  wire c0_out_out3_mismatch_en = c0_out_out3 != c0_out_out3_expect;
  wire c0_out_out4_mismatch_en = c0_out_out4 != c0_out_out4_expect;
  wire c0_out_out1_match_en = c0_out_out1 == c0_out_out1_expect;
  wire c0_out_out2_match_en = c0_out_out2 == c0_out_out2_expect;
  wire c0_out_out3_match_en = c0_out_out3 == c0_out_out3_expect;
  wire c0_out_out4_match_en = c0_out_out4 == c0_out_out4_expect;
  assign   rd_en = rand_valid;
  c_unit c0(.clk(clk),
            .in1(c0_in_in1),
            .in2(c0_in_in2),
            .in3(c0_in_in3),
            .in4(c0_in_in4),
            .out1(c0_out_out1),
            .out2(c0_out_out2),
            .out3(c0_out_out3),
            .out4(c0_out_out4));
  stim_expect_mem_template #(.ADDR_WIDTH(STIM_ADDR_WIDTH),
                           .MEM_WIDTH(STIM_MEM_WIDTH),
                           .VECTOR_FILE(STIM_VECTOR_FILE),
                           .VECTOR_ID(STIM_VECTOR_ID),
                           .VECTOR_NAME(STIM_VECTOR_NAME),
                           .VECTOR_RADIX(STIM_VECTOR_RADIX),
                           .VECTOR_VERSION(STIM_VECTOR_VERSION))
                           stim_c0(.clock(clk),
                                   .id_err(id_err),
                                   .rd_en(rd_en),
                                   .reset_(testbench_reset),
                                   .valid(expect_out_valid),
                                   .vector_out({c0_in_in1, c0_in_in2, c0_in_in3, c0_in_in4}),
                                   .version_err(version_err));
  stim_expect_mem_template #(.ADDR_WIDTH(EXP_ADDR_WIDTH),
                           .MEM_WIDTH(EXP_MEM_WIDTH),
                           .VECTOR_FILE(EXP_VECTOR_FILE),
                           .VECTOR_ID(EXP_VECTOR_ID),
                           .VECTOR_NAME(EXP_VECTOR_NAME),
                           .VECTOR_RADIX(EXP_VECTOR_RADIX),
                           .VECTOR_VERSION(EXP_VECTOR_VERSION))
                           exp_c0(.clock(clk),
                                  .id_err(id_err),
                                  .rd_en(rd_en),
                                  .reset_(testbench_reset),
                                  .valid(expect_out_valid),
                                  .vector_out({c0_out_out1_expect, c0_out_out2_expect, c0_out_out3_expect, c0_out_out4_expect}),
                                  .version_err(version_err));

  always @( posedge clk or negedge testbench_reset )  begin 
    if ( ~(testbench_reset) )  begin 
      cycle_cnt <= 0;
    end
    else  begin 
      cycle_cnt <= cycle_cnt + 1;
    end
  end

  initial 
 begin 
    $system("time stamp: +20%y %m %d");
    clk = 1'b0;
    rand_valid = 1'b1;
    testbench_reset = 1'b1;
    #10 testbench_reset = 1'b0;
    #20 testbench_reset = 1'b1;
    file_mcd = $fopen("vectors.txt");
    if ( file_mcd == 0 )  begin 
      $display("Error opening vectors.txt file");
      $finish;
    end
    $display(file_mcd, "Dut outputs vs expected vectors:\n");
    $dumpfile("wavesDefaultOutputFile_dump");
    $dumpvars(0, tb);
    $dumpon;
    exp_c0_match_count = 0;
    exp_c0_mismatch_count = 0;
    exp_c0_transaction_count = 0;
  end

  always #20 clk = ~(clk);

  always @( posedge clk or negedge testbench_reset )  begin 
    if ( ~(testbench_reset) )  begin 
      exp_c0_mismatch_count = {EXP_ADDR_WIDTH {1'b0}};
    end
    else  begin 
      if ( c0_out_out1_mismatch_en )  begin 
        exp_c0_transaction_count = exp_c0_transaction_count + 1'b1;
        exp_c0_mismatch_count = exp_c0_mismatch_count + 1'b1;
        $display("mismatch detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "c0", c0_out_out1, "exp_c0", c0_out_out1_expect);
      end
      if ( c0_out_out2_mismatch_en )  begin 
        exp_c0_transaction_count = exp_c0_transaction_count + 1'b1;
        exp_c0_mismatch_count = exp_c0_mismatch_count + 1'b1;
        $display("mismatch detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "c0", c0_out_out2, "exp_c0", c0_out_out2_expect);
      end
      if ( c0_out_out3_mismatch_en )  begin 
        exp_c0_transaction_count = exp_c0_transaction_count + 1'b1;
        exp_c0_mismatch_count = exp_c0_mismatch_count + 1'b1;
        $display("mismatch detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "c0", c0_out_out3, "exp_c0", c0_out_out3_expect);
      end
      if ( c0_out_out4_mismatch_en )  begin 
        exp_c0_transaction_count = exp_c0_transaction_count + 1'b1;
        exp_c0_mismatch_count = exp_c0_mismatch_count + 1'b1;
        $display("mismatch detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "c0", c0_out_out4, "exp_c0", c0_out_out4_expect);
      end
      if ( exp_c0_mismatch_count > EXP_VECTOR_MAX_ERR )  begin 
        $display("Maximum number or errors allowed for vector %s has been reached", "exp_c0");
      end
    end
  end

  always @( posedge clk or negedge testbench_reset )  begin 
    if ( ~(testbench_reset) )  begin 
      exp_c0_match_count = {EXP_ADDR_WIDTH {1'b0}};
    end
    else  begin 
      if ( c0_out_out1_match_en )  begin 
        exp_c0_transaction_count = exp_c0_transaction_count + 1'b1;
        exp_c0_match_count = exp_c0_match_count + 1'b1;
        $display("match detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "c0", c0_out_out1, "exp_c0", c0_out_out1_expect);
      end
      if ( c0_out_out2_match_en )  begin 
        exp_c0_transaction_count = exp_c0_transaction_count + 1'b1;
        exp_c0_match_count = exp_c0_match_count + 1'b1;
        $display("match detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "c0", c0_out_out2, "exp_c0", c0_out_out2_expect);
      end
      if ( c0_out_out3_match_en )  begin 
        exp_c0_transaction_count = exp_c0_transaction_count + 1'b1;
        exp_c0_match_count = exp_c0_match_count + 1'b1;
        $display("match detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "c0", c0_out_out3, "exp_c0", c0_out_out3_expect);
      end
      if ( c0_out_out4_match_en )  begin 
        exp_c0_transaction_count = exp_c0_transaction_count + 1'b1;
        exp_c0_match_count = exp_c0_match_count + 1'b1;
        $display("match detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "c0", c0_out_out4, "exp_c0", c0_out_out4_expect);
      end
    end
  end
  endmodule

