module ram_32x8s_infer (o, we, d, addr, wclk); 
parameter d_width = 8, addr_width = 5; 
output [d_width - 1:0] o; 
input we, wclk; 
input [d_width - 1:0] d; 
input [addr_width - 1:0] addr; 
reg [d_width - 1:0] mem [(1 << addr_width) - 1:0]; 
always @(posedge wclk) 
  if (we) 
    mem[addr] = d; 
assign o = mem[addr]; 
endmodule 
