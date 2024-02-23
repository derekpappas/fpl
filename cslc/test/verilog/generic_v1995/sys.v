// time scale
`timescale 1ns/1ns   // (time is measured in [ns] ; resolution is [ns])

// simulation parameters
`include "params.v"

/******************************************************/
/*** definitions **************************************/
/******************************************************/

// id
`define ID_LNGTH          10   // length (in bits) of a station id number
`define NO_ONE  `ID_LNGTH'b0
`define UNKNOWN `ID_LNGTH'bx

// global variables
`define RESOLUTION 100000000   // resolution for random functions
`define seed   sys.seed            // seed for random functions
`define act    sys.net.act         // which stations are active
`define rts    sys.net.rt_state    // real-time state
`define trns   sys.net.transmiter  // current transmiter of real-time packet
`define next   sys.net.next        // next transmiter of real-time packet
`define finish sys.net.finish      // finish (it's the last packet of this rt station)
`define fic    sys.net.fic         // first in chain
`define lic    (`next === `NO_ONE) // last in chain
`define sim_end sys.sim_end        // simulation end

// rts - real time state (Net State -> NS)
`define NS_IDLE 2'h0  // no station is transmiting real-time packet
`define NS_HEAD 2'h1  // a station is transmiting head
`define NS_DATA 2'h2  // a station is transmiting data
`define NS_TAIL 2'h3  // a station is transmiting tail

// state_rt - real-time state of one station (Real-time State -> RS)
`define RS_IDLE  2'h0 // the station doesn't have a real-time file to send
`define RS_WAIT  2'h1 // the station received a rt file, didn't start sending
`define RS_FIRST 2'h2 // the station is the first station in a rt chain
`define RS_CHAIN 2'h3 // the station is part of a rt chain (not the first) 

// send_status - (Send Status -> SS)
`define SS_IDLE     3'h0 // not in a sending process
`define SS_WAIT     3'h1 // wait till can start transmiting
`define SS_HEAD     3'h2 // transmiting head
`define SS_DATA     3'h3 // transmiting data
`define SS_TAIL     3'h4 // transmiting tail
`define SS_IFG      3'h5 // waiting IFG (Inter Frame Gap) time
`define SS_JAM      3'h6 // jamming (after collision detected)
`define SS_COL_WAIT 3'h7 // waiting random time after collision


module sys();

	/******************************************************/
	/*** simulation ***************************************/
	/******************************************************/

	reg [31:0] input_data [0:9];
	reg [31:0] seed;
	time end_time;
	reg sim_end;

	initial begin
		$readmemh("input.dat", input_data);
		seed  = input_data[0];
		end_time = `SIM_TIME * 1e9;
	end

	initial begin
		sim_end = 1'b0;
		if(`DUMP) begin
			$recordfile("net.trn");
			$recordvars;
			$recordon;
		end
		#(end_time);
		$display("\n\n",$realtime," simulation finished successfully\n\n");
		sim_end = 1'b1;
		#(`NUM_OF_STATIONS);
		$finish;
	end

	always begin
		#(`MSG_TIME * 1e9) $display("time is %t", $realtime);
	end

	/******************************************************/
	/*** net **********************************************/
	/******************************************************/

	net net();

endmodule


