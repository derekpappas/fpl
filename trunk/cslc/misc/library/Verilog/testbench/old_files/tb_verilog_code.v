//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2005, 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : verilog_generated_code.v
//FILE GENERATED ON : Tue Sep 18 15:30:06 2007

module dut(x,
           y,
           z,
           t);
// Location of source csl unit: file name =  line number = 97
  input x;
  input y;
  output [0:2] z;
  output [0:2] t;
endmodule

module stimvect(clock,
                reset_,
                rd_en,
                vector_out,
                valid,
                version_err,
                id_err);
// Location of source csl unit: file name =  line number = 105
  parameter MEM_WIDTH = 1'b0;
  parameter ADDR_WIDTH = 1'b0;
  parameter MEM_DEPTH = (1'b1 << ADDR_WIDTH);
  input clock;
  input reset_;
  input rd_en;
  output [MEM_WIDTH - 1:0] vector_out;
  output valid;
  output version_err;
  output id_err;
  reg [MEM_WIDTH - 1:0] memory_out;
  reg [MEM_WIDTH - 1:0] stimvect_memory[0:MEM_DEPTH - 1] ; //Don't use here 1'b0 and 1'b1
  reg [ADDR_WIDTH - 1:0] rd_addr;
  integer VECTOR_ID = 4'b0010;
  integer VECTOR_VERSION = 1'b1;
  wire mem_out_is_id;
  wire mem_out_is_version;
  wire mem_out_is_id_or_version;
  wire mux_select;
  wire vector_id_match;
  wire vector_version_match;
  wire [ADDR_WIDTH - 2:0] zero;
  assign   mem_out_is_id = rd_addr == 0;
  assign   mem_out_is_version = rd_addr == 1;
  assign   mem_out_is_id_or_version = mem_out_is_id || mem_out_is_version;
  assign   mux_select = ~rd_en || mem_out_is_id_or_version;
  assign   vector_out = mux_select ? {MEM_WIDTH {1'b1}} : memory_out; // I wrote {1'b1} not {1}
  assign   vector_id_match = memory_out == VECTOR_ID;
  assign   vector_version_match = memory_out == VECTOR_VERSION;
  assign   version_err = mem_out_is_id && ~vector_id_match;
  assign   id_err = mem_out_is_version && ~vector_version_match;
  assign   valid = rd_en;

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~reset_ )  begin 
      rd_addr <= {ADDR_WIDTH {1'b0}};
    end
    else       if ( rd_en )  begin 
        rd_addr <= rd_addr + {zero,1'b1};
      end
  end

  always @( posedge clock or negedge reset_ )  begin 
    if ( rd_en )  begin 
      memory_out <= stimvect_memory[rd_addr];
    end
  end
endmodule

module expectvect(clock,
                  reset_,
                  rd_en,
                  vector_out,
                  valid,
                  version_err,
                  id_err);
// Location of source csl unit: file name =  line number = 117
  parameter MEM_WIDTH = 1'b0;
  parameter ADDR_WIDTH = 1'b0;
  parameter MEM_DEPTH = (1'b1 << ADDR_WIDTH);
  input clock;
  input reset_;
  input rd_en;
  output [MEM_WIDTH - 1:0] vector_out;
  output valid;
  output version_err;
  output id_err;
  reg [MEM_WIDTH - 1:0] memory_out;
  reg [MEM_WIDTH - 1:0] expectvect_memory[0:MEM_DEPTH - 1] ;
  reg [ADDR_WIDTH - 1:0] rd_addr;
  integer VECTOR_ID = 4'b0011;
  integer VECTOR_VERSION = 1'b0;
  wire mem_out_is_id;
  wire mem_out_is_version;
  wire mem_out_is_id_or_version;
  wire mux_select;
  wire vector_id_match;
  wire vector_version_match;
  wire [ADDR_WIDTH - 2:0] zero;
  assign   mem_out_is_id = rd_addr == 0;
  assign   mem_out_is_version = rd_addr == 1;
  assign   mem_out_is_id_or_version = mem_out_is_id || mem_out_is_version;
  assign   mux_select = ~rd_en || mem_out_is_id_or_version;
  assign   vector_out = mux_select ? {MEM_WIDTH {1'b1}} : memory_out; // use {1'b1}
  assign   vector_id_match = memory_out == VECTOR_ID;
  assign   vector_version_match = memory_out == VECTOR_VERSION;
  assign   version_err = mem_out_is_id && ~vector_id_match;
  assign   id_err = mem_out_is_version && ~vector_version_match;
  assign   valid = rd_en;

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~reset_ )  begin 
      rd_addr <= {ADDR_WIDTH {1'b0}};
    end
    else       if ( rd_en )  begin 
        rd_addr <= rd_addr + {zero,1'b1};
      end
  end

  always @( posedge clock or negedge reset_ )  begin 
    if ( rd_en )  begin 
      memory_out <= expectvect_memory[rd_addr];
    end
  end
endmodule

module tbench();
// Location of source csl unit: file name =  line number = 130
  parameter EXPECT_ADDR_WIDTH = 1'b0;
  parameter MAX_ERROR = 1'b0;
  reg testbench_clk;
  reg testbench_reset;
  reg [EXPECT_ADDR_WIDTH - 1:0] match_count;
  reg [EXPECT_ADDR_WIDTH - 1:0] mismatch_count;
  reg [EXPECT_ADDR_WIDTH - 1:0] transaction_count;
  wire dut_in_x;
  wire dut_in_y;
  wire [2:0] dut_out_z;
  wire [2:0] expect_out_z;
  wire [2:0] dut_out_t;
  wire [2:0] expect_out_t;
  wire expect_out_valid;
 stimvect #(2,2)
            stimvect0(.clock(testbench_clk),
                     .reset_(testbench_reset),
                     .vector_out({dut_in_x,dut_in_y}));
  expectvect #(6,6)
              expectvect0(.clock(testbench_clk),
                         .reset_(testbench_reset),
                         .valid(expect_out_valid),
                         .vector_out({expect_out_z,expect_out_t}));
  dut design_under_test_instance(.t(dut_out_t),
                                 .x(dut_in_x),
                                 .y(dut_in_y),
                                 .z(dut_out_z));
reg mismatch;  //I defined the register mismatch
  initial 
 begin 
    $system("time stamp: +20%y %m %d");
    testbench_clk = 1'b0;
    testbench_reset = 1'b1;
    #10 testbench_reset = 1'b0;
    #20 testbench_reset = 1'b1;
    $readmemb("stimulus_vector_dut_vector_stimulus", stimvect0.stimvect_memory);
    $readmemh("expected_vector_dut_vector_expected", expectvect0.expectvect_memory);
    
    $vsddumpfile("wavesDefaultOutputFile.dump"); //put the extension and "" 
    $vsddumpvars(0, tbench);
    $vsddumpon;
  end

  always #10 testbench_clk = ~testbench_clk;

  always @( posedge testbench_clk )  begin 
    mismatch <= 1'b0;
    if ( expect_out_valid )  begin 
      if ( dut_out_z != expect_out_z )  begin 
        mismatch = 1'b1;
        // For  display command use "" for string parameters
        $display("Mismatch detected: expect vector %s shows value %s, design under test %s output vector shows value %s", "expectvect", "expect_out_z", "dut", "dut_out_z");
      end
      if ( dut_out_t != expect_out_t )  begin 
        mismatch = 1'b1;
        $display("Mismatch detected: expect vector %s shows value %s, design under test %s output vector shows value %s", "expectvect", "expect_out_t", "dut","dut_out_t");
      end
    end
    if ( mismatch )  begin 
      mismatch_count <= mismatch_count + 1'b1;
    end
    else  begin 
      match_count <= match_count + 1'b1;
    end
    if ( mismatch_count > MAX_ERROR )  begin 
      $display("current transaction index = %d, mismatches so far = %d, current test status = %s", transaction_count, mismatch_count, mismatch?"failed":"passed");
      $finish;
    end
  end
endmodule

