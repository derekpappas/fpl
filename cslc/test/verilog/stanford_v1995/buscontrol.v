/////////////////////////////////////////////////////////////////////////////
// Block Name:  buscontrol.v
// Author:      Lin Ma & Sopan Joshi
/////////////////////////////////////////////////////////////////////////////

`define READY		3'b001
`define LATCHDATA	3'b010
`define	PUTDATA		3'b100

`define READY_X		3'bxx1
`define LATCHDATA_X	3'bx1x
`define PUTDATA_X	3'b1xx

`define Ready		0
`define LatchData	1
`define PutData		2

/////////////////////////////////////////////////////////////////////////////

module buscontrol(phi1, phi2, 
		SysBusRead_s1, SysBusRead_s2, BusGrant_s2, WriteDone_s1, 
		Reset_s2, newstate_s2[`LatchData], BusRelease_s2, WriteMem_s1,
		state_s1[`Ready]);

//
// the following assignments only rely on one state -- i.e. they will
// only be asserted when we are in that state.  since we are using a one-
// hot encoding, this translates into looking at that particular state
// bit.  therefore, instead of an explicit assign statement, we can just
// send out the bit itself and avoid any strange complications when we
// use synopsys to generate the netlist.  
//
// however, we leave these in here for readability and debugging purposes,
// so that we know what we were intending to send out....
//
//
// assign OKToLatch_s1 = (state_s1[`Ready]);
//
// assign BusRequest_s2 = (newstate_s2[`LatchData]);
//

/////////////////////////////////////////////////////////////////////////////

input			phi1,
			phi2;

input			SysBusRead_s1,
			SysBusRead_s2,
			BusGrant_s2,
			WriteDone_s1,
			Reset_s2;

output			BusRelease_s2,
			WriteMem_s1;

output 		[2:0]	state_s1,
			newstate_s2;

//////////////////////////////////////////////////////////////////////////////

reg		[2:0]	state_s1,
			state_s2,
			newstate_s2;

reg			WriteDone_s2;

/////////////////////////////////////////////////////////////////////////////

always@ (phi1 or state_s1 or WriteDone_s1)
  if (phi1)
    begin
      state_s2 = state_s1;
      WriteDone_s2 = WriteDone_s1;
    end

always@ (phi2 or newstate_s2 or Reset_s2)
  if (phi2)
    begin
      state_s1 = newstate_s2;
    end

always@ (state_s2 or Reset_s2 or SysBusRead_s2 or BusGrant_s2 or
	WriteDone_s2)  begin

  newstate_s2 = `READY;

  if (Reset_s2)
    newstate_s2 = `READY;
  else
    casex (state_s2)

	// synopsys parallel_case
	// synopsys full_case

	`READY_X:	if (SysBusRead_s2) newstate_s2 = `LATCHDATA;
			else newstate_s2 = `READY;

	`LATCHDATA_X:	if (BusGrant_s2) newstate_s2 = `PUTDATA;
			else newstate_s2 = `LATCHDATA;

	`PUTDATA_X:	if (WriteDone_s2) newstate_s2 = `READY;
			else newstate_s2 = `PUTDATA;
    endcase
end


assign BusRelease_s2 = (newstate_s2[`Ready] & state_s2[`PutData]);

assign WriteMem_s1 = (state_s1[`PutData]) & (~WriteDone_s1);

endmodule

///////////////////////////////////////////////////////////////////////
// 
// NOTES AND COMMENTS
//
// Since the physical address (stored as the "tag" field in our verilog
// model) is going to be read out as _s1 data (since it precharges on phi2)
// but our data is going to be _s2 (since it precharges on phi1), we have
// to find some way of latching both of those and holding the values until
// the bus is ready to read them.
//
// Latching them is no problem; we simply latch the control signal
// SysBusRead_s1 so that when it goes high, we latch the address bits;
// when SysBusRead_s2 goes high, we latch the data bits.
//
// However, once these are latched, they are fed into a tri-state buffer
// that shouldn't be activated until we are granted the bus, which comes in
// as an _s2 signal.
//
// Since we want to put info on the bus as _s1, we can simply use WriteMem_s1
// as the control signal for our tri-state buffer.
//
// By the way, although we call it a tri-state buffer, it will really be
// a tri-state *inverter*.  However, this is not a problem.  In our verilog 
// code, we assume the data bits that are used for the SysBusRead are the
// true values; in fact, with the actual dual-ported memory, the bit lines
// we will be using are Bit_b.  Therefore, by using a tri-state inverter, we
// will be reading out the correct values.  This simplifies things in hardware
// since an inverter is easier to build anyway.
//
// Well, enough babbling.  I hope this works...
//
