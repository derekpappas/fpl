module ram (address, write, chip_select, data);

parameter WIDTH = 8;
parameter SIZE = 256;
localparam ADDRESS_SIZE = clogb2(SIZE);
input [ADDRESS_SIZE-1:0] address;
input write, chip_select;
inout [WIDTH-1:0] data;

reg [WIDTH-1:0] ram_data [0:SIZE-1];

//define the clogb2 constant function

function integer clogb2;
  input depth;
  integer i;
  begin
   clogb2 = 1;
   for (i = 0; 2**i < depth; i = i + 1)
      clogb2 = i + 1; 
  end
endfunction

endmodule
