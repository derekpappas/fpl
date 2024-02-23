//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2005, 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : verilog_generated_code.v
//FILE GENERATED ON : Thu Sep 20 16:43:14 2007

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
  parameter MEM_WIDTH = 1'd0;
  parameter ADDR_WIDTH = 1'd0;
  parameter MEM_DEPTH = (1'b1 << ADDR_WIDTH);
  input clock;
  input reset_;
  input rd_en;
  output [MEM_WIDTH - 1:0] vector_out;
  output valid;
  output version_err;
  output id_err;
  reg [MEM_WIDTH - 1:0] memory_out;
  reg [MEM_WIDTH - 1:0] stimvect_memory[1'd0:MEM_DEPTH - 1'd1] ; //codegen bug(AndreiB)
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
  assign   vector_out = mux_select ? {MEM_WIDTH {1}} : memory_out;//codegen bug (AndreiB)
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
  parameter MEM_WIDTH = 1'd0;
  parameter ADDR_WIDTH = 1'd0;
  parameter MEM_DEPTH = (1'b1 << ADDR_WIDTH);
  input clock;
  input reset_;
  input rd_en;
  output [MEM_WIDTH - 1:0] vector_out;
  output valid;
  output version_err;
  output id_err;
  reg [MEM_WIDTH - 1:0] memory_out;
  reg [MEM_WIDTH - 1:0] expectvect_memory[1'd0:MEM_DEPTH - 1'd1] ;//codegen bug (AndreiB)
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
  assign   vector_out = mux_select ? {MEM_WIDTH {1}} : memory_out;//codegen bug (AndreiB)
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
  parameter STIM_ADDR_WIDTH = 1'b0;
  parameter EXPECT_MEM_WIDTH = 1'b0;
  parameter STIM_MEM_WIDTH = 1'b0;
  parameter EXPECT_MEM_DEPTH = (1'b1 << EXPECT_ADDR_WIDTH);
  parameter STIM_MEM_DEPTH = (1'b1 << STIM_ADDR_WIDTH);
  parameter MAX_ERROR = 1'b0;
  parameter STIM_FILE = stimulus_vector_dut_vector_stimulus;
  parameter EXPECT_FILE = expected_vector_dut_vector_expected;
  reg testbench_clk;
  reg testbench_reset;
  integer mem_addr;
  reg stim_mem_loaded;
  reg [STIM_MEM_WIDTH - 1:0] stim_mem[1'd0:STIM_MEM_DEPTH - 1'd1] ;
  reg expect_mem_loaded;
  reg [EXPECT_MEM_WIDTH - 1:0] expect_mem[1'd0:EXPECT_MEM_DEPTH - 1'd1] ;
  reg [EXPECT_ADDR_WIDTH - 1:0] match_count;
  reg [EXPECT_ADDR_WIDTH - 1:0] mismatch_count;
  reg [EXPECT_ADDR_WIDTH - 1:0] transaction_count;
  reg mismatch;
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

  initial 
 begin 
    $system("time stamp: +20%y %m %d");
    testbench_clk = 1'b0;
    testbench_reset = 1'b1;
    #10 testbench_reset = 1'b0;
    #20 testbench_reset = 1'b1;
    $readmemb("stimulus_vector_dut_vector_stimulus", stimvect0.stimvect_memory);
    $readmemh("expected_vector_dut_vector_expected", expectvect0.expectvect_memory);
    $vsddumpfile("wavesDefaultOutputFile_dump");// cdom bug : cannot build a string that contains a "." character 
    $vsddumpvars(0, tbench);
    $vsddumpon;
  end

  always #10 testbench_clk = ~testbench_clk;

  initial 
 begin 
    stim_mem_loaded <= 1'b0;
    $display("STIM_FILE= %s", "STIM_FILE");//are you sure this is right? STIM_FILE is a module parameter 
    $readmemh(STIM_FILE, stim_mem);        //that already stores a string
    stim_mem_loaded <= 1'b1;
  end

  initial 
 begin 
    @ stim_mem_loaded    ;
    if ( $test$plusargs("show_stim_mem_init_state") )  begin 
      $display("Initial state of vector file %s ", "STIM_FILE");//are you sure this is right? STIM_FILE is a module parameter 
                                                                //that already stores a string

      for (         mem_addr = 0; mem_addr < STIM_MEM_DEPTH;         mem_addr = mem_addr + 1)  begin 
        $display("mem[%d] = %x", mem_addr, stim_mem[mem_addr]);
      end
    end
  end

  initial 
 begin 
    expect_mem_loaded <= 1'b0;
    $display("EXPECT_FILE= %s", "EXPECT_FILE");//are you sure this is right? STIM_FILE is a module parameter 
    $readmemh(EXPECT_FILE, expect_mem);        //that already stores a string
    expect_mem_loaded <= 1'b1;
  end

  initial 
 begin 
    @ expect_mem_loaded    ;
    if ( $test$plusargs("show_expect_mem_init_state") )  begin 
      $display("Initial state of vector file %s ", "EXPECT_FILE");//are you sure this is right? STIM_FILE is a module parameter 
                                                                  //that already stores a string
      for (         mem_addr = 0; mem_addr < EXPECT_MEM_DEPTH;         mem_addr = mem_addr + 1)  begin 
        $display("mem[%d] = %x", mem_addr, expect_mem[mem_addr]);
      end
    end
  end

  always @( posedge testbench_clk )  begin 
    mismatch <= 1'b0;
    if ( expect_out_valid )  begin 
      if ( dut_out_z != expect_out_z )  begin 
        mismatch = 1'b1;
        $display("Mismatch detected: expect vector %s shows value %s, design under test %s output vector shows value %s", "expectvect", "expect_out_z", "dut", "dut_out_z");
      end
      if ( dut_out_t != expect_out_t )  begin 
        mismatch = 1'b1;
        $display("Mismatch detected: expect vector %s shows value %s, design under test %s output vector shows value %s", "expectvect", "expect_out_t", "dut", "dut_out_t");
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

