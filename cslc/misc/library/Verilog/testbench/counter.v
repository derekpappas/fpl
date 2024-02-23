`timescale 1 ps / 1 ps

module counter(clk, r_, en, q );
    parameter WIDTH = 0;
    
    input clk;
    input r_;
    input en;
    
    output [WIDTH - 1 : 0] q;
    reg    [WIDTH - 1 : 0] q;
    
    always@( posedge clk or negedge r_) begin
      if(~r_) begin
         q <= { WIDTH {1'b0}};
      end else if( en ) begin
         q <= q + 1'b1;
      end
    end
    
endmodule