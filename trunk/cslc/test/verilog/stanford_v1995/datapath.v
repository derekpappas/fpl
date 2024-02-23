/////////////////////////////////////////////////////////////////////////////
// Block Name:  datapath.v
// Author:      Lin Ma & Sopan Joshi
// Date:        1/21/96
/////////////////////////////////////////////////////////////////////////////

`define		MISS			4'b0000

module datapath(phi1, phi2, CacheAddr_v1, CacheAddr_s1, CacheData_v2, 
		WriteTag_s1, WriteValid_s1, ValidValue_v1, 
		CacheReset_s1, CacheWrite_s2, CacheRead_s2, 
		SysBusRead_s1, SysBusRead_s2,
		HeadShiftEnable_s2, TailShiftEnable_s2, 
		Match_v1, SysBusData_s1, SysBusAddr_s2, 
		HeadTailReset_s2, HeadTailSelect_s1);

/////////////////////////////////////////////////////////////////////////////

  input			phi1,
			phi2;
  input		[3:0]	CacheAddr_s1;	// address bus from cache for
					// read or write
  input		[3:0]	CacheAddr_v1;

  inout		[3:0]	CacheData_v2;	// data bus from/to cache
					// bi-directional for read and
					// write
  input			WriteTag_s1,	// control signal
					// write tag bits on a cache write
			WriteValid_s1;	// control signal
					// validate/invalidate valid
					// bit on a sys read or cache write
  inout			ValidValue_v1;
					// new value for valid bits
					// from controller
  input			CacheReset_s1,	// reset signal from cache
			CacheWrite_s2,	// control signal
					// write data to queue
			CacheRead_s2;	// control signal
					// read data from queue back
					// to cache
  input			SysBusRead_s1,
			SysBusRead_s2;	// control signal
					// write data from queue to memory

  input			HeadTailReset_s2;
					// resets head and tail
					// pointers

  input			HeadTailSelect_s1;

  input			HeadShiftEnable_s2,
			TailShiftEnable_s2;
  output		Match_v1;	// signal to controller
					// indicate a cache read or
					// write is to an existing entry
  output 	[3:0]	SysBusData_s1;	// data bus to memory
  output	[3:0]	SysBusAddr_s2;	// address bus to memory

/////////////////////////////////////////////////////////////////////////////

  // storage for outputs
  reg		[3:0]	SysBusData_s1;
  reg		[3:0]	SysBusAddr_s2;

  // intermediate signals
  wire		[3:0]	HeadLines_s1;
  wire		[3:0]	TailLines_s1;
  wire		[3:0]	WordLines_s1;

  wire		[3:0]	ValidMatch_v1;
  wire		[3:0]	TagMatch_v1;
  wire		[3:0]	EntryMatch_v1;

  wire		[3:0]	SysBusAddr_v1;
  wire		[3:0]	SysBusData_v2;

  reg		[3:0]	EntryMatch_s2;
  reg		[3:0]	WordLines_s2;

  wire		[3:0]	RegNum0_s2;
  wire		[3:0]	RegNum1_s2;

/////////////////////////////////////////////////////////////////////////////

  // instantiate elements of the datapath
  shifter	head(phi1, phi2, HeadTailReset_s2,
			HeadShiftEnable_s2, HeadLines_s1);

  shifter	tail(phi1, phi2, HeadTailReset_s2,
			TailShiftEnable_s2, TailLines_s1);

  validbit	validbit(phi1, phi2, WordLines_s1, 
			ValidValue_v1, WriteValid_s1, CacheReset_s1,
			ValidMatch_v1);

  tag		tag(phi1, phi2, CacheAddr_v1, CacheAddr_s1, 
			WriteTag_s1, WordLines_s1, TagMatch_v1, CacheReset_s1);

  regfile	regfile(phi1, phi2, CacheData_v2, 
			SysBusData_v2, 
			RegNum0_s2, RegNum1_s2, 
			CacheWrite_s2);

  // latch system bus address bits
  always @(phi1 or SysBusRead_s1 or CacheAddr_v1)
    if (phi1 & SysBusRead_s1)
      SysBusAddr_s2 = CacheAddr_v1;

  // latching system bus data bits
  always @(phi2 or SysBusRead_s2 or SysBusData_v2)
    if (phi2 & SysBusRead_s2)
      SysBusData_s1 = SysBusData_v2;

  assign WordLines_s1 = (HeadTailSelect_s1) ? TailLines_s1 : HeadLines_s1;

  assign EntryMatch_v1 = ValidMatch_v1 & TagMatch_v1;

  assign Match_v1 = (EntryMatch_v1 != `MISS);

  always @(phi1 or EntryMatch_v1 or WordLines_s1)
    if (phi1)
      begin
	EntryMatch_s2 = EntryMatch_v1;
	WordLines_s2 = WordLines_s1;
      end

  assign RegNum0_s2 = 
	(CacheWrite_s2) 
	? 
	((EntryMatch_s2 != `MISS) ? EntryMatch_s2 : WordLines_s2) 
	: 
	((CacheRead_s2) ? EntryMatch_s2 : `MISS);

  assign RegNum1_s2 = 
	(CacheWrite_s2) 
	? 
	((EntryMatch_s2 != `MISS) ? EntryMatch_s2 : WordLines_s2) 
	: 
	((SysBusRead_s2) ? WordLines_s2 : `MISS);

endmodule
