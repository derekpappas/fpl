module test;
	reg clock;
	reg intr;
	reg reset;

    initial begin
//	$gr_waves ("clock", clock, "intr", intr, "reset", reset);
	$dumpvars;
    end

    always begin
	#100
	clock = 1;
	#100
	clock = 0;
    end

    always begin
	#200
	reset = 0;
	#800
	reset = 1;
    end	

    initial $intr_ctl ("intr", intr, reset, clock);

endmodule
