// Copyright 2003 Star Galaxy Publishing
// File: johnson_decoder.v

module johnson_decoder (sel, enable, y);
  input [2:0] sel;
  input enable;

  output [5:0] y;
  reg [5:0] y, address;

  integer i;

  always @(sel or enable) begin
    if (!enable)
      y = 0;
    else begin
      address = 0;
      y = 0;
 
     for (i=0; i<3; i=i+1)
       if (sel[i])
         address = address + 1;

     if (sel[2])
       address = 6 - address;

     y[address] = 1;
     end
  end
endmodule
