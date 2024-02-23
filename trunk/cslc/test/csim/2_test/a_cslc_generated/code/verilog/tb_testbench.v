`timescale 1ns/10ps

`include "defines.v"

module tb();
// Location of source csl unit: file name = 2.csl line number = 28
  parameter SIM_TIMEOUT_CNT = 100;
  parameter STIM_MEM_WIDTH = 3;
  parameter STIM_ADDR_WIDTH = 16;
  parameter STIM_VECTOR_ID = 4;
  parameter STIM_VECTOR_VERSION = 5;
  parameter STIM_VECTOR_NAME = "stim";
  //parameter STIM_VECTOR_FILE = "stim_output.vec"; // modif
  parameter STIM_VECTOR_FILE = "stim";
  parameter STIM_VECTOR_RADIX = 1;
  parameter STIM_VECTOR_MAX_ERR = 0;
  parameter EXP_MEM_WIDTH = 3;
  parameter EXP_ADDR_WIDTH = 16;
  parameter EXP_VECTOR_ID = 6;
  parameter EXP_VECTOR_VERSION = 7;
  parameter EXP_VECTOR_NAME = "exp";
  //parameter EXP_VECTOR_FILE = "exp_output.vec"; // modif
  parameter EXP_VECTOR_FILE = "exp";
  parameter EXP_VECTOR_RADIX = 1;
  parameter EXP_VECTOR_MAX_ERR = 10;
  reg clk;
  reg testbench_reset_;
  reg rand_valid;
  integer file_mcd;
  integer report_file_mcd;
  integer cycle_cnt;
  reg [EXP_ADDR_WIDTH - 1:0] exp_a0_match_count;
  reg [EXP_ADDR_WIDTH - 1:0] exp_a0_mismatch_count;
  reg [EXP_ADDR_WIDTH - 1:0] exp_a0_transaction_count;
  reg exp_a0_mismatch;
  wire expect_out_valid;
  wire rd_en;
  wire stim_mem_version_err;
  wire exp_mem_version_err;
  wire stim_mem_id_err;
  wire exp_mem_id_err;
  wire stop_sim = cycle_cnt >= SIM_TIMEOUT_CNT;
  wire  [STIM_MEM_WIDTH - 1:0] a0_in_in;
  wire  [EXP_MEM_WIDTH - 1:0] a0_out_out;
  reg   [EXP_MEM_WIDTH - 1:0] a0_out_out_d1;
  wire  [EXP_MEM_WIDTH - 1:0] a0_out_out_expect;
  reg   [EXP_MEM_WIDTH - 1:0] a0_out_out_expect_d1;
  wire  a0_out_out_mismatch; 
  reg  a0_out_out_match;

  assign   rd_en = rand_valid;
  a a0(.clk(clk),
       .reset_(testbench_reset_),
       .in(a0_in_in),
       .valid_in(valid_in),
       .out(a0_out_out),
       .valid_out(valid_out)
       ); // fix add this to the compare equation

  stim_expect_mem_template #(.ADDR_WIDTH(STIM_ADDR_WIDTH),
                           .MEM_WIDTH(STIM_MEM_WIDTH),
                           .VECTOR_FILE(STIM_VECTOR_FILE),
                           .VECTOR_ID(STIM_VECTOR_ID),
                           .VECTOR_NAME(STIM_VECTOR_NAME),
                           .VECTOR_RADIX(STIM_VECTOR_RADIX),
                           .VECTOR_VERSION(STIM_VECTOR_VERSION))
                           stim_a0(.clk(clk),
                                   .id_err(stim_mem_id_err),
                                   .rd_en(rd_en),
                                   .reset_(testbench_reset_),
                                   .valid(expect_out_valid),
                                   .vector_out(a0_in_in),
                                   .version_err(stim_mem_version_err),
                                   .no_more_vectors(stim_no_more_vectors));
  stim_expect_mem_template #(.ADDR_WIDTH(EXP_ADDR_WIDTH),
                           .MEM_WIDTH(EXP_MEM_WIDTH),
                           .VECTOR_FILE(EXP_VECTOR_FILE),
                           .VECTOR_ID(EXP_VECTOR_ID),
                           .VECTOR_NAME(EXP_VECTOR_NAME),
                           .VECTOR_RADIX(EXP_VECTOR_RADIX),
                           .VECTOR_VERSION(EXP_VECTOR_VERSION))
                           exp_a0(.clk(clk),
                                  .id_err(exp_mem_id_err),
                                  .rd_en(rd_en),
                                  .reset_(testbench_reset_),
                                  .valid(expect_out_valid),
                                  .vector_out(a0_out_out_expect),
                                  .version_err(exp_mem_version_err),
                                   .no_more_vectors(exp_no_more_vectors));

  always @( posedge clk or negedge testbench_reset_ )  begin 
    if ( ~testbench_reset_ )  begin 
      cycle_cnt <= 0;
    end
    else  begin 
      cycle_cnt <= cycle_cnt + 1;
    end
  end

  initial 
 begin 
    file_mcd = $fopen("vectors.txt");
    if ( file_mcd == 0 )  begin 
      $display("Error opening vectors.txt file");
      $finish;
    end
    $display(file_mcd, "Dut outputs vs expected vectors:\n");
    $dumpfile("wavesDefaultOutputFile_dump");
    $dumpvars(0, tb);
    $dumpon;
    exp_a0_match_count <= 0;
    exp_a0_mismatch_count <= 0;
    exp_a0_transaction_count <= 0;

    //$system("time stamp: +20%y %m %d");
    clk                   <= 1'b0;
    rand_valid            <= 1'b1;
    testbench_reset_  <= 1'b1;
    @clk;
    @clk;
    @clk;
    @clk;
    @clk testbench_reset_  <= 1'b0;
    @clk;
    @clk;
    @clk testbench_reset_  <= 1'b1;
    @clk;
    @clk;
    @clk;
  end

  always #10 clk <= ~(clk);

// compare the DUT output vector with the expected memory vector

always @( posedge clk or negedge testbench_reset_ )  begin 
    if ( ~testbench_reset_ )  begin 
       a0_out_out_match           <= 1'b0;
       a0_out_out_d1              <= {STIM_MEM_WIDTH {1'b0}};
       a0_out_out_expect_d1       <= {EXP_MEM_WIDTH {1'b0}};
    end
    else  begin
       a0_out_out_match           <= a0_out_out == a0_out_out_expect_d1;
       a0_out_out_d1              <= a0_out_out;
       a0_out_out_expect_d1       <= a0_out_out_expect;
    end
  end

  assign a0_out_out_mismatch       = ~a0_out_out_match;


// detect mismatches

  always @( posedge clk or negedge testbench_reset_ )  begin 
   if ( ~testbench_reset_ )  begin 
      exp_a0_mismatch_count       <= {EXP_ADDR_WIDTH {1'b0}};
   end
   else  begin 
      if ( a0_out_out_mismatch && ~exp_no_more_vectors)  begin 
         exp_a0_transaction_count <= exp_a0_transaction_count + 1'b1;
         exp_a0_mismatch_count    <= exp_a0_mismatch_count + 1'b1;
         $display("cycle: %d mismatch detected: dut %s shows value %b; expect vector %s shows value %b\n ",
                  cycle_cnt,
                  "a0", 
                  a0_out_out, 
                  "exp_a0", 
                  a0_out_out_expect);
      end
      if ( exp_a0_mismatch_count > EXP_VECTOR_MAX_ERR )  begin 
         $display("Maximum number or errors allowed for vector %s has been reached", "exp_a0");
        report(exp_a0_match_count   ,   
               exp_a0_mismatch_count,   
               exp_a0_transaction_count);
         end
    end
  end


// detect matches

  always @( posedge clk or negedge testbench_reset_ )  begin 
    if ( ~testbench_reset_ )  begin 
      exp_a0_match_count         <= {EXP_ADDR_WIDTH {1'b0}};
    end
    else if ( a0_out_out_match && ~exp_no_more_vectors )  begin 
        exp_a0_transaction_count <= exp_a0_transaction_count + 1'b1;
        exp_a0_match_count       <= exp_a0_match_count + 1'b1;
        $display("match detected: dut %s shows value %b; evepect vector %s shows value %b\n ", 
                 "a0", 
                 a0_out_out, 
                 "exp_a0", 
                 a0_out_out_expect_d1);
    end
  end

// version and id vector mismatch error messages

  always @( posedge clk)  begin 
    if (stim_mem_version_err) begin
       $display("stimulus version vector mismatch\n ", );
        report(exp_a0_match_count,   
             exp_a0_mismatch_count,   
               exp_a0_transaction_count);
    end
  end

  always @( posedge clk)  begin 
    if (stim_mem_id_err) begin
       $display("stimulus id vector mismatch\n ", );
        report(exp_a0_match_count,   
             exp_a0_mismatch_count,   
               exp_a0_transaction_count);
    end
  end

  always @( posedge clk)  begin 
    if (exp_mem_version_err) begin
       $display("expected version vector mismatch\n ", );
        report(exp_a0_match_count,   
             exp_a0_mismatch_count,   
               exp_a0_transaction_count);
    end
  end

  always @( posedge clk)  begin 
    if (exp_mem_id_err) begin
       $display("expected id vector mismatch\n ", );
        report(exp_a0_match_count,   
             exp_a0_mismatch_count,   
               exp_a0_transaction_count);
    end
  end

  always @( posedge clk)  begin 
    if (exp_no_more_vectors) begin
       $display("no more expected vectors exiting\n ", );
        report(exp_a0_match_count,   
             exp_a0_mismatch_count,   
               exp_a0_transaction_count);
    end
  end


  task report; 
     input [31:0] match_count;   
   input    [31:0] mismatch_count; 
   input    [31:0] transaction_count; 
     begin
         @clk;
         @clk;
         @clk;
      $display("************************************************");
      $display("end of simulation");
      $display("Match count = %d\n    ", match_count   );
      $display("Mismatch count = %d\n ", mismatch_count);
      $display("Transaction count  = %d\n ", transaction_count);
      $display("************************************************");

         @clk;
         @clk;
         $finish;
     end
  endtask

endmodule

