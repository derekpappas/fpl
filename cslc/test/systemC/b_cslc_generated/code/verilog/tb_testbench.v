`include "defines.v"

module tb();
// Location of source csl unit: file name = 2.csl line number = 35
  parameter SIM_TIMEOUT_CNT = 100;
  parameter STIM_MEM_WIDTH = 3;
  parameter STIM_ADDR_WIDTH = 16;
  parameter STIM_VECTOR_ID = 0;
  parameter STIM_VECTOR_VERSION = 0;
  parameter STIM_VECTOR_NAME = "stim";
  parameter STIM_VECTOR_FILE = "stim_output.vec";
  parameter STIM_VECTOR_RADIX = 0;
  parameter STIM_VECTOR_MAX_ERR = 0;
  parameter EXP_MEM_WIDTH = 3;
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
  reg [EXP_ADDR_WIDTH - 1:0] exp_b0_match_count;
  reg [EXP_ADDR_WIDTH - 1:0] exp_b0_mismatch_count;
  reg [EXP_ADDR_WIDTH - 1:0] exp_b0_transaction_count;
  reg exp_b0_mismatch;
  wire expect_out_valid;
  wire rd_en;
  wire version_err;
  wire id_err;
  wire stop_sim = cycle_cnt >= SIM_TIMEOUT_CNT;
  wire b0_in_in;
  wire b0_out_out;
  wire b0_out_out_expect;
  wire b0_out_out_mismatch_en = b0_out_out != b0_out_out_expect;
  wire b0_out_out_match_en = b0_out_out == b0_out_out_expect;
  assign   rd_en = rand_valid;
  b b0(.clk(clk),
       .in(b0_in_in),
       .out(b0_out_out));
  stim_expect_mem_template #(.ADDR_WIDTH(STIM_ADDR_WIDTH),
                           .MEM_WIDTH(STIM_MEM_WIDTH),
                           .VECTOR_FILE(STIM_VECTOR_FILE),
                           .VECTOR_ID(STIM_VECTOR_ID),
                           .VECTOR_NAME(STIM_VECTOR_NAME),
                           .VECTOR_RADIX(STIM_VECTOR_RADIX),
                           .VECTOR_VERSION(STIM_VECTOR_VERSION))
                           stim_b0(.clock(clk),
                                   .id_err(id_err),
                                   .rd_en(rd_en),
                                   .reset_(testbench_reset),
                                   .valid(expect_out_valid),
                                   .vector_out(b0_in_in),
                                   .version_err(version_err));
  stim_expect_mem_template #(.ADDR_WIDTH(EXP_ADDR_WIDTH),
                           .MEM_WIDTH(EXP_MEM_WIDTH),
                           .VECTOR_FILE(EXP_VECTOR_FILE),
                           .VECTOR_ID(EXP_VECTOR_ID),
                           .VECTOR_NAME(EXP_VECTOR_NAME),
                           .VECTOR_RADIX(EXP_VECTOR_RADIX),
                           .VECTOR_VERSION(EXP_VECTOR_VERSION))
                           exp_b0(.clock(clk),
                                  .id_err(id_err),
                                  .rd_en(rd_en),
                                  .reset_(testbench_reset),
                                  .valid(expect_out_valid),
                                  .vector_out(b0_out_out_expect),
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
    exp_b0_match_count = 0;
    exp_b0_mismatch_count = 0;
    exp_b0_transaction_count = 0;
  end

  always #20 clk = ~(clk);

  always @( posedge clk or negedge testbench_reset )  begin 
    if ( ~(testbench_reset) )  begin 
      exp_b0_mismatch_count = {EXP_ADDR_WIDTH {1'b0}};
    end
    else  begin 
      if ( b0_out_out_mismatch_en )  begin 
        exp_b0_transaction_count = exp_b0_transaction_count + 1'b1;
        exp_b0_mismatch_count = exp_b0_mismatch_count + 1'b1;
        $display("mismatch detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "b0", b0_out_out, "exp_b0", b0_out_out_expect);
      end
      if ( exp_b0_mismatch_count > EXP_VECTOR_MAX_ERR )  begin 
        $display("Maximum number or errors allowed for vector %s has been reached", "exp_b0");
      end
    end
  end

  always @( posedge clk or negedge testbench_reset )  begin 
    if ( ~(testbench_reset) )  begin 
      exp_b0_match_count = {EXP_ADDR_WIDTH {1'b0}};
    end
    else  begin 
      if ( b0_out_out_match_en )  begin 
        exp_b0_transaction_count = exp_b0_transaction_count + 1'b1;
        exp_b0_match_count = exp_b0_match_count + 1'b1;
        $display("match detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "b0", b0_out_out, "exp_b0", b0_out_out_expect);
      end
    end
  end
  endmodule

