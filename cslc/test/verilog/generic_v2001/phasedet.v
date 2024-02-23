module phasedet(clk,aquad,bquad,dir,cnten);
    input clk;
    input aquad;
    input bquad;
    output dir;
    output cnten;

//-------------------------------------------------
// this is a aquad-bquad phase detector intended
// for use in a motion controller
//
// Inputs are quadrature square waves.
// The clock should be a minimum of twice the edge
// rate (it will work if the clock is equal to the
// edge rate, but I like to be safe).
// The dir output will indicate forward or backward
// motion (which is which is arbitrary).
// cnten will go true when an edge has been detected..
// i.e. you should increment/decrement a counter at
// that time.
//
// Copyright (c) 2004 by James Patchell
// This module may be freely used as long as this
// Copyright notice is left intact
//
// File created on April 4, 2004
//
//--------------------------------------------------
	reg aq1,aq2,bq1,bq2;
	reg dir,cnten;
		
	always@(posedge clk)	//create 1 and 2 pipe dealys of inputs
	begin
		aq2 <= aq1;
		aq1 <= aquad;
		bq2 <= bq1;
		bq1 <= bquad;
	end

	always@(aq1 or aq2 or bq1 or bq2)
	begin
		//generate count enable and direction
		cnten = !aq1 & !aq2 & !bq1 & bq2
				| aq1 & aq2 & bq1 & !bq2
				| aq1 & !aq2 & !bq1 & !bq2
				| !aq1 & aq2 & bq1 & bq2
				| !aq1 & !aq2 & bq1 & !bq2
				| aq1 & aq2 & !bq1 & bq2
				| aq1 & !aq2 & bq1 & bq2
				| !aq1 & aq2 & !bq1 & !bq2;
		dir =  !aq1 & !aq2 & bq1 & !bq2
				| aq1 & aq2 & !bq1 & bq2
				| aq1 & !aq2 & bq1 & bq2
				| !aq1 & aq2 & !bq1 & !bq2;
	end
	

endmodule
