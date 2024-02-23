/////////////////////////////////////////////////////////////////////////////
// Block Name:  regfile.v
// Author:      Lin Ma & Sopan Joshi
// Date:        1/22/96
/////////////////////////////////////////////////////////////////////////////

module regfile(phi1, phi2, CacheData_v2, 
		SysBusData_v2, 
		WordLine0_s2, WordLine1_s2, 
		CacheWrite_s2);
/////////////////////////////////////////////////////////////////////////////
  input			phi1, 
			phi2;
  inout		[3:0]	CacheData_v2;
  inout		[3:0]	SysBusData_v2;
  input		[3:0]	WordLine0_s2;
  input		[3:0]	WordLine1_s2;
  input			CacheWrite_s2;
//////////////////////////////////////////////////////////////////////////////

  reg		[3:0]	RegFile[3:0];

  always @(phi2 or CacheWrite_s2 or CacheData_v2 or WordLine0_s2)
    if (phi2)
      begin
	if (CacheWrite_s2)
	  begin
	    case (WordLine0_s2)
	      4'b0001:
		RegFile[0] = CacheData_v2;
	      4'b0010:
		RegFile[1] = CacheData_v2;
	      4'b0100:
		RegFile[2] = CacheData_v2;
	      4'b1000:
		RegFile[3] = CacheData_v2;
	    endcase
	  end
      end

  assign CacheData_v2 = CacheWrite_s2 ? 4'bz : 
			(WordLine0_s2[0] ? RegFile[0] : 
			(WordLine0_s2[1] ? RegFile[1] : 
			(WordLine0_s2[2] ? RegFile[2] : 
			RegFile[3])));

  assign SysBusData_v2 = CacheWrite_s2 ? 4'bz : 
			(WordLine1_s2[0] ? RegFile[0] : 
			(WordLine1_s2[1] ? RegFile[1] : 
			(WordLine1_s2[2] ? RegFile[2] : 
			RegFile[3])));

endmodule
