module net();

	wire bus;

	/******************************************************/
	/*** stations *****************************************/
	/******************************************************/

	station #( 1, 1) station_001 (bus);
	station #( 6, 0) station_002 (bus);
	station #(11, 8) station_003 (bus);
	station #(16, 0) station_004 (bus);
	station #(21, 0) station_005 (bus);
	station #(26, 4) station_006 (bus);
	station #(31, 0) station_007 (bus);
	station #(36, 6) station_008 (bus);
	station #(41, 0) station_009 (bus);
	station #(46, 0) station_010 (bus);
	station #(51, 2) station_011 (bus);
	station #(56, 0) station_012 (bus);
	station #(61, 9) station_013 (bus);
	station #(66, 0) station_014 (bus);
	station #(71, 0) station_015 (bus);
	station #(76, 5) station_016 (bus);
	station #(81, 0) station_017 (bus);
	station #(86, 7) station_018 (bus);
	station #(91, 0) station_019 (bus);
	station #(96, 3) station_020 (bus);

	/******************************************************/
	/*** act **********************************************/
	/******************************************************/

	reg [`NUM_OF_STATIONS-1:0] act;
	initial act = `NUM_OF_STATIONS'h0;

	// num_of_trns
	integer i, num_of_trns;

	initial num_of_trns = 0;

	always @(act) begin
		num_of_trns = 0;
		for(i=0 ; i<`NUM_OF_STATIONS ; i=i+1) begin
			num_of_trns = num_of_trns + act[i];
		end
	end

	// collision
	wire collision = (num_of_trns > 1);

	/******************************************************/
	/*** rt state *****************************************/
	/******************************************************/

	reg [1:0]           rt_state;    // real-time state of the net
	reg [`ID_LNGTH-1:0] transmiter;  // current transmiter of real-time packet
	reg [`ID_LNGTH-1:0] next;        // next transmiter of real-time packet
	reg                 fic;         // current transmiter is first in chain
	reg                 finish;      // finish (it's the last packet of this rt station)

	initial begin
		rt_state   = `NS_IDLE;
		transmiter = `NO_ONE;
		next       = `UNKNOWN;
		fic        = 1'b0;
		finish     = 1'b0;
	end


endmodule

