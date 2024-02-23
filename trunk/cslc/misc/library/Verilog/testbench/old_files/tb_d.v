module dut(x,
           y,
           z);
  input x;
  input y;
  output [0:1] z;

// if this is a leaf level then put an include here

//`include " dut.user.v"

endmodule

module counter(vector_out,
                clock,
                reset_, 
                rd_en,
                data_out);
  parameter MEM_WIDTH  = 1'd0;
  parameter ADDR_WIDTH = 1'd0;
  integer   MEM_DEPTH  = (1'b1 << ADDR_WIDTH) -1;

  input clock;
  input reset_;

  reg [ADDR_WIDTH-1:0] stimvect_rd_addr; //<<<<<<<<<<<<<<<<<<<<<


  always @( posedge clock or negedge reset_)  begin 
    if ( stimvect_rd_en ) begin 
      stimvect_rd_addr <= {ADDR_WIDTH{1'b0}}; 
    end
    else if ( stimvect_rd_en ) begin 
      stimvect_rd_addr <= stimvect_rd_addr + 1'b1;
    end
  end

////////////////////////////////////////
// compare code
// put in test bench and use names that have the exp_<vec_name>_<signal_name>
////////////////////////////////////////

reg [31:0] dut_out_vec;
wire [7:0] dut_out_a;
wire [7:0] dut_out_b;
wire [7:0] dut_out_c;
wire [7:0] dut_out_d;

assign {dut_out_a, dut_out_b, dut_out_c, dut_out_d} = dut_out_vec;

reg [31:0] expect_out_vec;
wire [7:0] expect_out_a;
wire [7:0] expect_out_b;
wire [7:0] expect_out_c;
wire [7:0] expect_out_d;

assign {expect_out_a, expect_out_b, expect_out_c, expect_out_d} = expect_out_vec;

reg mismatch;

reg [ADDR_WIDTH-1:0] match_count;
reg [ADDR_WIDTH-1:0] mismatch_count;

initial begin
  match_count    = {ADDR_WIDTH{1'b0}}; 
  mismatch_count = {ADDR_WIDTH{1'b0}}; 
end


wire compare_transaction = dut_out_valid;

wire compare = compare_on & compare_transaction;

always @(posedge clk) begin

  mismatch = 1'b0;
  
  if (compare) begin
    if (dut_out_a != expect_out_a) begin mismatch = 1'b1; $display("%s %s mismatch exp = %x dut = %x\n", exp_vec_name, a, expect_out_a, dut_out_a); end
    if (dut_out_b != expect_out_b) begin mismatch = 1'b1; $display("%s %s mismatch exp = %x dut = %x\n", exp_vec_name, b, expect_out_b, dut_out_b); end
    if (dut_out_c != expect_out_c) begin mismatch = 1'b1; $display("%s %s mismatch exp = %x dut = %x\n", exp_vec_name, c, expect_out_c, dut_out_c); end
    if (dut_out_d != expect_out_d) begin mismatch = 1'b1; $display("%s %s mismatch exp = %x dut = %x\n", exp_vec_name, d, expect_out_d, dut_out_d); end
    
    if (mismatch) begin
      mismatch_count = mismatch_count + 1'b1;     
    end
    else begin
      match_count = match_count + 1'b1;     
    end
  end
end


////////////////////////////////////////////////////////////////
// put a comment here with the .csl file name and line number
////////////////////////////////////////////////////////////////

module stimvect(vector_out,
                clock,
                reset_, // << reset_ is a low true signal. 
                        // low true signals end with an underscore
                stimvect_rd_en,
                stimvect_ver_error,
                stimvect_id_error,
                stimvect_valid,
                data_out);
  parameter MEM_WIDTH  = 1'd0;
  parameter ADDR_WIDTH = 1'd0;
  integer   MEM_DEPTH  = (1'b1 << ADDR_WIDTH) -1;

  input clock;
  input reset_;
  input stimvect_rd_en;
  output stimvect_ver_error;
  output stimvect_id_error;
  output stimvect_valid;
  output [MEM_WIDTH - 1:0] data_out;

  reg [MEM_WIDTH - 1:0] stimvect_mem_out;

// memory which stores stimulus vectors
  reg [MEM_WIDTH - 1:0] stimvect_memory[1'd0:MEM_DEPTH - 1'd1] ;


  reg [ADDR_WIDTH-1:0] stimvect_rd_addr; <<<<<<<<<<<<<<<<<<<<<


  always @( posedge clock or negedge reset_)  begin 
    if ( stimvect_rd_en ) begin 
      stimvect_rd_addr <= {ADDR_WIDTH{1'b0}}; 
    end
    else if ( stimvect_rd_en ) begin 
      stimvect_rd_addr <= stimvect_rd_addr + 1'b1;
    end
  end

  always @( posedge clock )  begin 
    if ( stimvect_rd_en ) begin 
      stimvect_mem_out <= stimvect_memory[stimvect_rd_addr];
    end
  end

  wire vector_is_id_or_version; // vector number 0 or 1

// detect if the vector address is 0 or 1

  wire vector_zero = stimvect_rd_addr == 0;
  wire vector_one = stimvect_rd_addr == 1;

  assign vector_is_id_or_version = vector_zero || vector_one;

  wire valid = stimvect_rd_en;
  wire valid_off = ~valid;
  wire output_ms = valid_off | vector_is_id_or_version;

// if the vector address is 0 or 1 or valid is off then zero out the
// output vector

  assign data_out = output_ms ? {MEM_WIDTH{1'b0}} : stimvect_mem_out;

  wire vector_zero = stimvect_rd_addr == 0;
  wire vector_one = stimvect_rd_addr == 1;

  integer VECTOR_ID      = MEM_WIDTH'd123456;
  integer VECTOR_VERSION = MEM_WIDTH'd100000; // 1.0


  assign vector_id_match      = stimvect_mem_out == VECTOR_ID     ;
  assign vector_version_match = stimvect_mem_out == VECTOR_VERSION;

  assign stimvect_ver_error = vector_zero & vector_id_match     ;
  assign stimvect_id_error  = vector_one  & vector_version_match;
  assign stimvect_valid     = stimvect_rd_en;


endmodule

module expectvect(vector_out,
                  clock,
                  reset_,
                  expectvect_rd_addr,
                  expectvect_rd_en,
                  expectvect_data_out);
  parameter MEM_WIDTH = 1'd0;
  parameter MEM_DEPTH = 1'd0;
  input clock;
  input reset_;
  input [2:0] expectvect_rd_addr;
  input expectvect_rd_en;
  input [MEM_WIDTH - 1:0] expectvect_data_out;
  output reg [1:0] vector_out;
  reg [MEM_WIDTH - 1:0] expectvect_memory[1'd0:MEM_DEPTH - 1'd1] ;

  always @( posedge clock or negedge reset_ )  begin 
    if ( expectvect_rd_en ) expectvect_data_out <= expectvect_memory[expectvect_rd_addr];
  end
endmodule

module tbench();
  reg testbench_clk;
  reg testbench_reset_;
  wire dut_x_tb;
  wire dut_y_tb;
  stimvect #(2,4)
            stimvect0(.clock(testbench_clk),
                     .reset_(testbench_reset_),
                     .vector_out({dut_x_tb,dut_y_tb}));
  expectvect #(2,4)
              expectvect0(.clock(testbench_clk),
                         .reset_(testbench_reset_));
  dut design_under_test_instance(.x(dut_x_tb),
                                 .y(dut_y_tb));

  initial 
 begin 
    testbench_clk = 1'd0;
    testbench_reset_ = 1'd1;
    #10 testbench_reset_ = 1'd0;
    #20 testbench_reset_ = 1'd1;
    $readmemb("stimulus_vector_dut_vector_stimulus", stimvect0.stimvect_memory);
    $readmemh("expected_vector_dut_vector_expected", expectvect0.expectvect_memory);
  end

  always #10 testbench_clk = ~testbench_clk;
endmodule