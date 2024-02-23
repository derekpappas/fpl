`timescale 1 ps / 1 ps

module ff(clk, r_, d, q);
    parameter W = 0;
    
    input            clk;
    input            r_;
    input    [W-1:0] d;
    
    output   [W-1:0] q;
    reg      [W-1:0] q;
    
    always@(posedge clk or negedge clk) begin
       if( ~r_ ) begin
         q <= {W {1'b0}};
       end else begin
         q <= d;
       end
    end
    
endmodule