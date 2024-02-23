`include "defines.v"

module stim_expect_mem_template(clock,
                                reset_,
                                rd_en,
                                vector_out,
                                valid,
                                version_err,
                                id_err);
// Location of source csl unit: file name = tb_multi_instance.csl line number = 56
  parameter MEM_WIDTH = 0;
  parameter ADDR_WIDTH = 0;
  parameter VECTOR_ID = 0;
  parameter VECTOR_VERSION = 0;
  parameter VECTOR_NAME = "";
  parameter VECTOR_FILE = "";
  parameter VECTOR_RADIX = 0;
  parameter MEM_DEPTH = ((1 << ADDR_WIDTH) - 1'b1);
  input clock;
  input reset_;
  input rd_en;
  output [MEM_WIDTH - 1:0] vector_out;
  output valid;
  output version_err;
  output id_err;
  reg [MEM_WIDTH - 1:0] memory_out;
  reg [MEM_WIDTH - 1:0] stim_expect_memory[0:MEM_DEPTH] ;
  reg [ADDR_WIDTH - 1:0] rd_addr;
  reg mem_out_is_id;
  reg mem_out_is_version;
  integer mem_addr;
  reg stim_expect_memory_loaded;
  wire mem_out_is_id_or_version;
  wire mux_select;
  wire vector_id_match;
  wire vector_version_match;
  assign   mem_out_is_id_or_version = mem_out_is_id || mem_out_is_version;
  assign   mux_select = ~(mem_out_is_id_or_version) || rd_en;
  assign   vector_out = mux_select ? memory_out : {MEM_WIDTH {1'b0}};
  assign   vector_id_match = (memory_out == VECTOR_ID) & mem_out_is_id;
  assign   vector_version_match = (memory_out == VECTOR_VERSION) & mem_out_is_version;
  assign   version_err = mem_out_is_version & memory_out != VECTOR_VERSION;
  assign   id_err = mem_out_is_id & memory_out != VECTOR_ID;
  assign   valid = rd_en && ~(mem_out_is_id_or_version);

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~(reset_) )  begin 
      rd_addr <= {ADDR_WIDTH {1'b0}};
    end
    else if ( rd_en )  begin 
        rd_addr <= rd_addr + 1'b1;
        mem_out_is_id <= rd_addr == 0;
        mem_out_is_version <= rd_addr == 1;
      end
  end

  always @( posedge clock or negedge reset_ )  begin 
    if ( rd_en )  begin 
      memory_out <= stim_expect_memory[rd_addr];
    end
  end

  initial 
 begin 
    stim_expect_memory_loaded <= 1'b0;
    $display("VECTOR_FILE= %s", VECTOR_FILE);
    if ( VECTOR_RADIX == 0 )  begin 
      $readmemb(VECTOR_FILE, stim_expect_memory);
    end
    else  begin 
      $readmemh(VECTOR_FILE, stim_expect_memory);
    end
    stim_expect_memory_loaded <= 1'b1;
  end

  initial 
 begin 
    @ stim_expect_memory_loaded    ;
    if ( $test$plusargs("show_stim_expect_memory_init_state") )  begin 
      $display("Initial state of vector file %s ", VECTOR_FILE);

      for (         mem_addr = 0; mem_addr < MEM_DEPTH;         mem_addr = mem_addr + 1'b1)  begin 
        $display("mem[%d] = %x", mem_addr, stim_expect_memory[mem_addr]);
      end
    end
  end
  endmodule

