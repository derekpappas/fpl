/////////////////////////////////////////////////////////////////////////////

`define INIT		5'b00001
`define	WRITETAG	5'b00010
`define	LATCHBUS	5'b00100
`define	INVALIDATE	5'b01000
`define FULL		5'b10000

`define INIT_X		5'bxxxx1
`define WRITETAG_X	5'bxxx1x
`define LATCHBUS_X	5'bxx1xx
`define INVALIDATE_X	5'bx1xxx
`define FULL_X		5'b1xxxx

`define Init		0
`define WriteTag	1
`define LatchBus	2
`define Invalidate	3
`define Full		4

/////////////////////////////////////////////////////////////////////////////

module dpcontrol(phi1, phi2,
		ExtCacheWrite_s1, ExtCacheRead_s1, ExtCacheReset_s1,
		OKToLatch_s1, Match_v1,
		WriteStall_s2, ReadStall_s2, ReadMatch_s2,
		present_state_s1[`WriteTag], WriteValid_s1, ValidValue_v1,
		CacheWrite_s2, CacheRead_s2,
		present_state_s1[`LatchBus], SysBusRead_s2,
		BusReset_s2,
		CacheAddrDrv_q1, CacheDataDrvChip_q2, ChipDataDrvCache_q2,
	   	HeadShiftEnable_s2, TailShiftEnable_s2,
		HeadTailReset_s2, HeadTailSelect_s1);

//
// the following 2 output assign statements only rely on a single state bit,
// and so we will simply send out that state bit instead.
// 
// this is done for synopsys purposes.  we will leave the statement in here
// (commented out) for readability and debugging purposes.
//
// assign WriteTag_s1 = (present_state_s1[`WriteTag]);
//
// assign SysBusRead_s1 = (present_state_s1[`LatchBus]);
//

/////////////////////////////////////////////////////////////////////////////

input			phi1,
			phi2;

input			ExtCacheWrite_s1,
			ExtCacheRead_s1,
			ExtCacheReset_s1,
		  	OKToLatch_s1,
			Match_v1;

output			WriteStall_s2,
			ReadStall_s2,
			ReadMatch_s2,
			WriteValid_s1; 

inout			ValidValue_v1;

output			CacheWrite_s2,
			CacheRead_s2;

output			SysBusRead_s2;

output			BusReset_s2;

output			CacheAddrDrv_q1,
			CacheDataDrvChip_q2,
			ChipDataDrvCache_q2;

output			HeadShiftEnable_s2,
			TailShiftEnable_s2,
			HeadTailReset_s2,
			HeadTailSelect_s1;

output 		[4:0]	present_state_s1;

//////////////////////////////////////////////////////////////////////////////

// storage for outputs
reg			WriteStall_s2,
			ReadStall_s2,
			CacheWrite_s2,
			CacheRead_s2,
			SysBusRead_s2,
			BusReset_s2,
			ReadMatch_s2,
			TailShiftEnable_s2,
			HeadShiftEnable_s2,
			HeadTailReset_s2;

// storgae for state bits
reg		[4:0]	present_state_s1,
			new_state_s2;

/////////////////////////////////////////////////////////////////////////////

always @(phi1 or present_state_s1 or ExtCacheWrite_s1 or 
	ExtCacheRead_s1 or ExtCacheReset_s1 or OKToLatch_s1 or 
	Match_v1 or ValidValue_v1)
  if (phi1)
    begin
      ReadMatch_s2 = Match_v1 & ExtCacheRead_s1;
      HeadShiftEnable_s2 = present_state_s1[`Invalidate] | ExtCacheReset_s1;
      TailShiftEnable_s2 = present_state_s1[`WriteTag] | ExtCacheReset_s1;
      SysBusRead_s2 = present_state_s1[`LatchBus];
      HeadTailReset_s2 = ExtCacheReset_s1;
      BusReset_s2 = ExtCacheReset_s1;
      CacheWrite_s2 = 
        ExtCacheWrite_s1 & present_state_s1[`Init] & 
	(~ValidValue_v1 | Match_v1);
      CacheRead_s2 = 
        ExtCacheRead_s1 & 
        (present_state_s1[`Init] | present_state_s1[`LatchBus] |
        present_state_s1[`Full]) & Match_v1;
				// used to be ValidValue_v1, incorrect
		
      ReadStall_s2 = ExtCacheRead_s1 & 
	(present_state_s1[`WriteTag] | present_state_s1[`Invalidate]);
      WriteStall_s2 = ExtCacheWrite_s1 & 
	((present_state_s1[`Init] & ~Match_v1) | 
	present_state_s1[`LatchBus] | 
	present_state_s1[`Invalidate] | 
	present_state_s1[`Full]);

      if (ExtCacheReset_s1) new_state_s2 = `INIT;
      else casex (present_state_s1)

	// synopsys parallel_case
	// synopsys full_case

	`INIT_X:
	  begin
	  if (ExtCacheWrite_s1)
	    begin
	      if (Match_v1) new_state_s2 = `INIT;
	      else
		begin
		  // invalid entry, proceed with write
		  if (~ValidValue_v1) new_state_s2 = `WRITETAG;
		  else
		    // valid entry, buffer full
		    begin
		      // perform mem read
		      if (OKToLatch_s1) new_state_s2 = `LATCHBUS;
		      // cannot perform mem read, stall
		      else new_state_s2 = `FULL;
		    end
		end
	    end
	  else
	    begin
	      // invalid entry or bus busy, no need to perform mem read
	      if (~ValidValue_v1 | ~OKToLatch_s1) new_state_s2 = `INIT;
	      // perform mem read
	      else new_state_s2 = `LATCHBUS;
	    end
	  end
	`WRITETAG_X:
	  new_state_s2 = `INIT;
	`LATCHBUS_X:
	  new_state_s2 = `INVALIDATE;
	`INVALIDATE_X:
	  new_state_s2 = `INIT;
	`FULL_X:
	  if (OKToLatch_s1) new_state_s2 = `LATCHBUS;
	  else new_state_s2 = `FULL;
      endcase
    end

always @(phi2 or new_state_s2)
  if (phi2)
    present_state_s1 = new_state_s2;

assign WriteValid_s1 = (present_state_s1[`WriteTag]) | 
			(present_state_s1[`Invalidate]);

assign ValidValue_v1 = 
	((present_state_s1[`WriteTag]) | (present_state_s1[`Invalidate])) 
	? 
	((present_state_s1[`WriteTag]) | ~(present_state_s1[`Invalidate]))
	: 
	1'bz;

assign CacheAddrDrv_q1 = present_state_s1[`WriteTag] & phi1;

assign CacheDataDrvChip_q2 = CacheWrite_s2 & phi2;

assign ChipDataDrvCache_q2 = CacheRead_s2 & phi2;

// 1 to select tail
assign HeadTailSelect_s1 = 
	(ExtCacheWrite_s1 & present_state_s1[`Init]) | 
	(present_state_s1[`WriteTag]);

endmodule
