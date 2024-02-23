module ram_32x8d_infer (o, we, d, raddr, waddr, 
 clk); 
parameter d_width = 8, addr_width = 5; 
output [d_width - 1:0] o; 
input we, clk; 
input [d_width - 1:0] d; 
input [addr_width - 1:0] raddr, waddr; 
reg [d_width - 1:0] o; 
reg [d_width - 1:0] mem [(1 << addr_width) - 1:0]; 
always @(posedge clk) 
  if (we) 
    mem[waddr] = d; 
always @(mem or raddr) 
  o = mem[raddr]; 
endmodule 
