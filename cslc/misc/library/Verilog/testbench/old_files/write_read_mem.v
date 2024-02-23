module memory (rd_addr, wr_addr, en,we, data_in, data_out);
parameter addr_width=8;
parameter  data_width=8;
parameter  depth=256;

input [addr_width-1:0] rd_addr;
input [addr_width-1:0] wr_addr;
input en;
input we;
input [data_width-1:0] data_in;
output [data_width-1:0] data_out;
reg [data_width-1:0] data_out;
reg [data_width-1:0] mem[0:depth-1];


always@(en & !we) begin
 data_out<=mem[rd_addr];
end
always@(en & we) begin
 mem[wr_addr]<=data_in;

end
endmodule

module top;
parameter addr_width=8;
parameter  data_width=8;
parameter  depth=256;
    reg [addr_width-1:0] rd_adr;
    reg [addr_width-1:0] wr_adr;
    reg [data_width-1:0] dt_in;
    reg [data_width-1:0] dt_out;
    reg en_s;
    reg we_s;
    initial begin
    #5
    #5 en_s=0;
    #5 en_s=1;
    we_s=1;
    wr_adr=8'b0011;
    dt_in=8'hAA; 
    #30 we_s=0;
    rd_adr=8'b0011;
    $monitor(" en=%d, we=%d, data_in=%d, data_out=%d",en,we,data_in,data_out);
end
memory memory(.rd_addr(rd_adr),.wr_addr(wr_adr),.en(en_s),.we(we_s),.data_in(dt_in),.data_out(dt_out));
endmodule