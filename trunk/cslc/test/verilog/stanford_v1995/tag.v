/////////////////////////////////////////////////////////////////////////////
// Block Name:  tag.v
// Author:      Lin Ma & Sopan Joshi
// Date:        1/22/96
/////////////////////////////////////////////////////////////////////////////

module tag(phi1, phi2, Addr_v1, CacheAddr_s1, Write_s1, WordLine_s1, 
	EntryMatch_v1, Reset_s1);

/////////////////////////////////////////////////////////////////////////////

  input			phi1,
			phi2;
  inout		[3:0]	Addr_v1;
  input		[3:0]	CacheAddr_s1;
  input			Write_s1;
  input		[3:0]	WordLine_s1;
  output	[3:0]	EntryMatch_v1;
  input			Reset_s1;

/////////////////////////////////////////////////////////////////////////////

  reg		[3:0]	TagReg[3:0];

  always @(phi1 or Write_s1 or WordLine_s1 or Addr_v1)
    if (phi1)
      begin
//	if (Reset_s1)
//	  begin
//	    TagReg[0] = 4'b0000;
//	    TagReg[1] = 4'b0000;
//	    TagReg[2] = 4'b0000;
//	    TagReg[3] = 4'b0000;
//	  end
        if (Write_s1)
	  begin
	    case (WordLine_s1)
	      4'b0001:
		TagReg[0] = Addr_v1;
  	      4'b0010:
		TagReg[1] = Addr_v1;
	      4'b0100:
		TagReg[2] = Addr_v1;
	      4'b1000:
		TagReg[3] = Addr_v1;
  	    endcase
	  end
      end

  assign EntryMatch_v1[0] = (TagReg[0] == CacheAddr_s1);
  assign EntryMatch_v1[1] = (TagReg[1] == CacheAddr_s1);
  assign EntryMatch_v1[2] = (TagReg[2] == CacheAddr_s1);
  assign EntryMatch_v1[3] = (TagReg[3] == CacheAddr_s1);

  assign Addr_v1 = Write_s1 ? 4'bz : 
		((WordLine_s1 == 4'b0001) ? TagReg[0] : 
		((WordLine_s1 == 4'b0010) ? TagReg[1] : 
		((WordLine_s1 == 4'b0100) ? TagReg[2] : TagReg[3])));

endmodule
