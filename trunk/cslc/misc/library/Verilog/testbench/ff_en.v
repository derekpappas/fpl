`timescale 1 ps / 1 ps

module ff_en(clk, r_, en, d, q);
    parameter W = 0;
    
    input            clk;
    input            r_;
    input            en;
    input    [W-1:0] d;
    output   [W-1:0] q;
    reg      [W-1:0] q;
    
    always@(posedge clk or negedge clk) begin
       if( ~r_ ) begin
         q <= {W {1'b0}};
       end else begin
           if(en) begin
              q <= d;
          end
       end
    end
    
endmodule