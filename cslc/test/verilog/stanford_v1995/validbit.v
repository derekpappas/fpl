/////////////////////////////////////////////////////////////////////////////
// Block Name:  validbit.v
// Author:      Lin Ma & Sopan Joshi
// Date:        1/22/96
/////////////////////////////////////////////////////////////////////////////

`define RESET_VALUE 4'b0000

module validbit(phi1, phi2, WordLine_s1, 
		ValidValue_v1, Write_s1, Reset_s1, ValidMatch_v1);
/////////////////////////////////////////////////////////////////////////////
  input			phi1, 
			phi2; 
  input		[3:0]	WordLine_s1;
  inout			ValidValue_v1;
  input			Write_s1;
  input			Reset_s1;
  output	[3:0]	ValidMatch_v1;
/////////////////////////////////////////////////////////////////////////////
  reg		[3:0]	ValidReg;

  always @(phi1 or Write_s1 or WordLine_s1 or ValidValue_v1 or Reset_s1)
    if (phi1)
      begin
	if (Reset_s1)
	  ValidReg = `RESET_VALUE;
	else
	  if (Write_s1)
	    begin
	      case (WordLine_s1)
                4'b0001:
                  ValidReg[0] = ValidValue_v1;
                4'b0010:
                  ValidReg[1] = ValidValue_v1;
                4'b0100:
                  ValidReg[2] = ValidValue_v1;
                4'b1000:
                  ValidReg[3] = ValidValue_v1;
              endcase
	    end
      end

  assign ValidValue_v1 = (Write_s1) ? 1'bz : 
			((WordLine_s1[0]) ? ValidReg[0] : 
			((WordLine_s1[1]) ? ValidReg[1] : 
			((WordLine_s1[2]) ? ValidReg[2] : 
			ValidReg[3])));

  assign ValidMatch_v1 = ValidReg;

endmodule
