//-----------------------------------------------------
// Design Name : decoder_using_for
// File Name   : decoder_using_for.v
// Function    : decoder using for loop
// Coder       : Deepak Kumar Tala
//-----------------------------------------------------
module decoder_using_for (
binary_in   , //  4 bit binary input
decoder_out , //  16-bit  out 
enable        //  Enable for the decoder
);
input [3:0] binary_in  ;
input  enable ; 
output [15:0] decoder_out ; 
   
reg [15:0] decoder_out ; 
integer i ; 
 
always @ (enable or binary_in)
begin
  decoder_out = 0;
  if (enable) begin
    for (i = 0; i < 16; i = i +1 ) begin
      decoder_out = (i == binary_in) ? i + 1 : 16'h0;
    end
  end
end

endmodule

