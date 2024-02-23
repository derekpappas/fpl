
module rf(wr_addr, rd_addr, wr_data, rd_data, wr_en, rd_en, valid, clk, reset_);

parameter ADDR_WIDTH = 5; // log base 2(DEPTH)
parameter DATA_WIDTH = 32;
parameter NUM_WORDS = (1<<ADDR_WIDTH)-1;
input [ADDR_WIDTH-1:0] wr_addr;
input [ADDR_WIDTH-1:0] rd_addr;
input [DATA_WIDTH-1:0] wr_data;
output [DATA_WIDTH-1:0] rd_data;
reg [DATA_WIDTH-1:0] rd_data;
input wr_en;
input rd_en;
input clk, reset_;
output valid;
reg valid;


reg [DATA_WIDTH-1:0] mem [0:NUM_WORDS-1];
integer i;
always @(posedge clk or negedge reset_) begin
  if (~reset_) begin
    valid <= 1'b0;
    for(i = 0; i < NUM_WORDS; i=i+1)
       mem[i] = 0;
  end
  else begin
    valid <= rd_en;
    rd_data <= mem[rd_addr];
    if (wr_en) begin
      mem[wr_addr] = wr_data;
    end
  end
end

endmodule


module tb_rf();
    parameter ADDR_WIDTH = 5; // log base 2(DEPTH)
    parameter DATA_WIDTH = 32;
    parameter NUM_WORDS = (1<<ADDR_WIDTH)-1;
    reg [ADDR_WIDTH-1:0] wr_addr;
    reg [ADDR_WIDTH-1:0] rd_addr;
    reg [DATA_WIDTH-1:0] wr_data;
    reg wr_en;
    reg rd_en;
    reg clk, reset_;
    wire [DATA_WIDTH-1:0] rd_data;
    wire  valid;
    rf dut(wr_addr, rd_addr, wr_data, rd_data, wr_en, rd_en, valid, clk, reset_);
    
    initial begin
        clk = 0;
        reset_ = 1;
        wr_en = 0;
        rd_en = 0;
        #3
        reset_ = 0;
        #4
        reset_ = 1;
        wr_addr = 5'b00000;
        wr_data = 32'h55aa1010;
        #4
        wr_en = 1;
        wr_addr = 5'b00111;
        wr_data = 32'h55aa1010;
        #4
        rd_addr = 5'b00111;
        #4
        rd_en = 1;
        rd_addr = 5'b1;
        #5
        wr_addr = 5'b10101;
        wr_data = 32'b11111111;
        #4
        wr_addr = 5'b01010;
        wr_data = 32'b11110000;
        #4
        rd_addr = 5'b10101;     
    end   
        always #1 clk = ~clk;
endmodule


