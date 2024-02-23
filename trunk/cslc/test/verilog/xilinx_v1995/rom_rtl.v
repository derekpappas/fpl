/* 
 * ROM_RTL.V 
 * Behavioral Example of 16x4 ROM 
*/
 
module rom_rtl(ADDR, DATA) ; 
input [3:0] ADDR ; 
output [3:0] DATA ; 
reg [3:0] DATA ; 
 
// A memory is implemented 
// using a case statement 
 
always @(ADDR) 
begin 
    case (ADDR) 
      4'b0000 : DATA = 4'b0000 ; 
      4'b0001 : DATA = 4'b0001 ; 
      4'b0010 : DATA = 4'b0010 ; 
      4'b0011 : DATA = 4'b0100 ; 
      4'b0100 : DATA = 4'b1000 ; 
      4'b0101 : DATA = 4'b1000 ; 
      4'b0110 : DATA = 4'b1100 ; 
      4'b0111 : DATA = 4'b1010 ; 
      4'b1000 : DATA = 4'b1001 ; 
      4'b1001 : DATA = 4'b1001 ; 
      4'b1010 : DATA = 4'b1010 ; 
      4'b1011 : DATA = 4'b1100 ; 
      4'b1100 : DATA = 4'b1001 ; 
      4'b1101 : DATA = 4'b1001 ; 
      4'b1110 : DATA = 4'b1101 ; 
      4'b1111 : DATA = 4'b1111 ; 
    endcase 
end 
 
endmodule 
