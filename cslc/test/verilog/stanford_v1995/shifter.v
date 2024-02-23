/////////////////////////////////////////////////////////////////////////////
// Block Name:  shifter.v
// Author:      Lin Ma & Sopan Joshi
// Date:        1/21/96
/////////////////////////////////////////////////////////////////////////////

`define		ResetValue	4'b1000

module shifter(phi1, phi2, Reset_s2, Enable_s2, WordLines_s1);

/////////////////////////////////////////////////////////////////////////////

  input			phi1, 
			phi2;
  input			Reset_s2;
  input			Enable_s2;
  output	[3:0]	WordLines_s1;

/////////////////////////////////////////////////////////////////////////////

  reg		[3:0]	WordLines_s2;
  reg		[3:0]	WordLines_s1;

  // phi2 latch
  always @(phi2 or Reset_s2 or Enable_s2 or WordLines_s2)
    if (phi2)
      begin
	if (Reset_s2)
	  begin
	    WordLines_s1 = `ResetValue;
	  end
	else
	  begin
	    if (Enable_s2)
	      begin
		WordLines_s1[0] = WordLines_s2[1];
		WordLines_s1[1] = WordLines_s2[2];
		WordLines_s1[2] = WordLines_s2[3];
		WordLines_s1[3] = WordLines_s2[0];
	      end
	    else
	      begin
	        WordLines_s1 = WordLines_s2;
	      end
	  end
      end
  // phi1 latch
  always @(phi1 or WordLines_s1)
    if (phi1)
      begin
	WordLines_s2 = WordLines_s1;
      end

endmodule
