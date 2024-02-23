module multiply (clk, ain, bin, q); 
      parameter size = 16; 
      parameter level = 4; 
      input     clk; 
      input [size-1:0] ain, bin; 
      output [2*size-1:0] q; 
      reg [size-1:0]      a, b; 
      reg [2*size-1:0]    reg_bank [level-1:0]; 
      integer             i; 
      always @(posedge clk) 
        begin 
          a <= ain; 
          b <= bin; 
        end 
      always @(posedge clk) 
        reg_bank[0] <= a * b; 
      always @(posedge clk) 
        for (i = 1;i < level; i=i+1) 
          reg_bank[i] <= reg_bank[i-1]; 
        assign q = reg_bank[level-1]; 
endmodule // multiply 
