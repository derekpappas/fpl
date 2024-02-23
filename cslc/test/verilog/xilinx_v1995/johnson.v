module johnson (clk, reset, q); 

parameter size = 4; 

  input clk, reset; 

  output [size-1:0] q; 

  reg [size-1:0] q; 

  integer i; 

  always @(posedge clk or posedge reset) 

    if (reset) 

      q <= 0; 

    else 

      begin 

        for (i=1;i<size;i=i+1) 

            q[i] <= q[i-1]; 

            q[0] <= ~q[size-1]; 

      end 

endmodule // johnson 

