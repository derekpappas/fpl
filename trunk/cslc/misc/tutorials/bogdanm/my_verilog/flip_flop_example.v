module ff_testbench;// the tesbench for the dut module
	reg in, en1, en2, en3, reset1, reset2, reset3, clk;
	wire out, vb1, vb2, vb3;
	dut d1(in, en1, en2, en3, reset1, reset2, reset3, clk, vb1, vb2, vb3, out);
	initial begin //init of the input signals (done at time 0)
		in = 1'b0;
		en1 = 1'b1;
		en2 = 1'b1;
		en3 = 1'b1;
		reset1 = 1'b1;
		reset2 = 1'b1;
		reset3 = 1'b1;
	end
	initial begin // clock signal generation
		clk = 1'b1;
		forever #2 clk  = ~clk;
	end
	initial begin //driving of the input signals
		#16 en1 = 0;
		#2 en2 = 0;
		#2 en3 = 0;
		#10 en1 = 1;
		#2 en2 = 1;
		#2 en3 = 1;
		#10 reset1 = 0;
		#2 reset2 = 0;
		#2 reset3 = 0;
		#10 reset1 = 1; reset2 = 1; reset3 = 1;
	end
	initial begin // drinving of the data input
	@(posedge clk);
		in = 1'b0;
	@(posedge clk);
		in = 1'b1;
	@(posedge clk);
		in = 1'b0;
	@(posedge clk);
		in = 1'b1;
	@(posedge clk);
		in = 1'b0;
	@(posedge clk);
		in = 1'b0;
	@(posedge clk);
		in = 1'b1;
	@(posedge clk);
		in = 1'b1;
	@(posedge clk);
		in = 1'b1;
	@(posedge clk);
		in = 1'b0;
	@(posedge clk);
		in = 1'b0;
	@(posedge clk);
		in = 1'b1;
	@(posedge clk);
		in = 1'b1;
	@(posedge clk);
		in = 1'b0;
	@(posedge clk);
		in = 1'b0;
	@(posedge clk);
		in = 1'b1;
	@(posedge clk);
		in = 1'b1;
	end
endmodule
//ala bala portocala
module dut(in, en1, en2, en3, reset1, reset2, reset3, clk, vb1, vb2, vb3, out);
//the dut module contains the 3 ff's, having individual enable and reset inputs(clk is common to all 3), as well as individual valid bit outputs
	input in, en1, en2, en3, reset1, reset2, reset3, clk;
	output out, vb1, vb2, vb3;
	wire out, vb1, vb2, vb3, out1, out2;
	flip_flop_enable_validBit ff1(in, clk, en1, reset1, vb1, out1);
	flip_flop_enable_validBit ff2(out1, clk, en2, reset2, vb2, out2);
	flip_flop_enable_validBit ff3(out2, clk, en3, reset3, vb3, out);
endmodule

module flip_flop_enable_validBit(in, clk, en, reset, vb, out);
//this module describes a ff with enable and reset inputs and a valid bit output
	input in, clk, reset, en;
	output out, vb;
	reg out, vb;
	always @(posedge clk or reset) begin
		if(en == 1'b1) begin
	 		out = (reset == 1'b1) ? in : 1'b0; //If enable is activated then the ff acts normally
	 		vb = 1'b1;
	 	end
	 	else begin
	 		vb = 1'b0;	
	 		out = 1'bx;//if not enabled, out is don't care and valid bit is 0
	 	end	
	end
endmodule