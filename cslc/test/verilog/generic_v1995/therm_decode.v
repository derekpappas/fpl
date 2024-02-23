//*****************************************************************************
//FILE NAME: therm_decode.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : This module takes the lower four bits of the adder output as inputs//           and generates the corresponding  bits which will be used as inputs
//           by the interpolator   
//*****************************************************************************

                                                                                module therm_decode(xin_s1, therm_dec_s1);

input [3:0] xin_s1;

output [7:0] therm_dec_s1;

reg [7:0] therm_dec_s1;


        
always @(xin_s1[2:0])
  if(xin_s1[3]) 
    case (xin_s1[2:0])  // synopsys parallel_case full_case
	3'b000:   therm_dec_s1 = 8'b00000000;
        3'b001:   therm_dec_s1 = 8'b10000000;
	3'b010:   therm_dec_s1 = 8'b11000000;
	3'b011:   therm_dec_s1 = 8'b11100000; 
	3'b100:   therm_dec_s1 = 8'b11110000;
	3'b101:   therm_dec_s1 = 8'b11111000;
	3'b110:   therm_dec_s1 = 8'b11111100;
	3'b111:   therm_dec_s1 = 8'b11111110;
		
      endcase
  else
    case (xin_s1[2:0])  // synopsys parallel_case full_case
	3'b000:   therm_dec_s1 = 8'b11111111;
        3'b001:   therm_dec_s1 = 8'b11111110;
	3'b010:   therm_dec_s1 = 8'b11111100;
	3'b011:   therm_dec_s1 = 8'b11111000; 
	3'b100:   therm_dec_s1 = 8'b11110000;
	3'b101:   therm_dec_s1 = 8'b11100000;
	3'b110:   therm_dec_s1 = 8'b11000000;
	3'b111:   therm_dec_s1 = 8'b10000000;
		
      endcase

endmodule // end therm_decode module
