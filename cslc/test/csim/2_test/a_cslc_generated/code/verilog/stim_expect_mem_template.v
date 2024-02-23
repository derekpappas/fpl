`include "defines.v"

module stim_expect_mem_template(clk,
                                reset_,
                                rd_en,
                                vector_out,
                                valid,
                                version_err,
                                id_err,
                                no_more_vectors);
// Location of source csl unit: file name = 2.csl line number = 14
  parameter MEM_WIDTH = 0;
  parameter ADDR_WIDTH = 0;
  parameter VECTOR_ID = 0;
  parameter VECTOR_VERSION = 0;
  parameter VECTOR_NAME = "";
  parameter VECTOR_FILE = "";
  parameter VECTOR_RADIX = 0;
  parameter MEM_DEPTH = ((1 << ADDR_WIDTH) - 1'b1);
  input clk;
  input reset_;
  input rd_en;
  output [MEM_WIDTH - 1:0] vector_out;
  output valid;
  output version_err;
  output id_err;
  output no_more_vectors;

  reg rd_en_d1;

  reg [MEM_WIDTH - 1:0] memory_out;
  reg [MEM_WIDTH - 1:0] stim_expect_memory[0:MEM_DEPTH] ;
  reg [ADDR_WIDTH - 1:0] rd_addr;
  reg mem_out_is_id;
  reg   mem_out_is_version;

  wire [31:0] version = VECTOR_VERSION;
  wire [31:0]      id = VECTOR_ID;

  integer mem_addr;
  reg stim_expect_memory_loaded;
  wire mem_out_is_id_or_version;
  wire mux_select;
  wire vector_id_match;
  wire vector_version_match;

always @( posedge clk or negedge reset_ )  begin 
   if ( ~reset_ )  begin 
       rd_en_d1                     <= 1'b0;
    end
    else if ( rd_en )  begin 
       rd_en_d1                     <= rd_en;
    end
  end

// the first two vectors are the id and version vectors
  assign valid                       = rd_en_d1 && ~(mem_out_is_id_or_version);

  always @( posedge clk or negedge reset_ )  begin 
    if ( ~reset_ )  begin 
      rd_addr               <= {ADDR_WIDTH {1'b0}};
      mem_out_is_id         <= 1'b0;
      mem_out_is_version    <= 1'b0;
    end
    else if ( rd_en )  begin
      rd_addr               <= rd_addr + 1'b1;
      mem_out_is_id         <= rd_addr == 0;
      mem_out_is_version    <= rd_addr == 1;
    end
  end

  assign   mem_out_is_id_or_version  = mem_out_is_id || mem_out_is_version;


  always @( posedge clk or negedge reset_ )  begin 
    if ( rd_en )  begin 
      memory_out <= stim_expect_memory[rd_addr];
    end
  end

// check that the vector file id and version vectors match
  assign   vector_id_match           = (memory_out == VECTOR_ID) & mem_out_is_id;
  assign   vector_version_match      = (memory_out == VECTOR_VERSION) & mem_out_is_version;


  assign   version_err               = mem_out_is_version & memory_out != VECTOR_VERSION;
  assign   id_err                    = mem_out_is_id & memory_out != VECTOR_ID;

// the vector out mux selects the output of the memory when
// rd_en is on and the memory address counter is past 2
// (past the id and version vectors)

  assign   mux_select                = rd_en && ~mem_out_is_id_or_version;
  assign   vector_out                = mux_select ? memory_out : {MEM_WIDTH {1'b0}};

  initial 
    begin
    stim_expect_memory_loaded       <= 1'b0;
       @clk
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


  always @( posedge clk)  begin 
    if (version_err) begin
       $display("expected version vector mismatch version vector = %h version expected %h \n ", 
                memory_out,
                VECTOR_VERSION);
    end
  end

  always @( posedge clk)  begin 
    if (id_err) begin
       $display("expected id vector mismatch\n ",
                memory_out,
                VECTOR_ID);

    end
  end

  assign no_more_vectors = rd_en_d1 && (vector_out === {MEM_WIDTH {1'bX}});

endmodule

