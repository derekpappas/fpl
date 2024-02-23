// Verilog HDL for "gates.lib", "tff" "_functional"
// Module T flip-flop
module tff (in, out, nout);

input
	in;

output
	out, nout;
reg 
	out, nout;

parameter
	t_separation = 10,
	delay=15,

	warning_file=3;  // multichannel description of a warning file

reg
	t_state,  // internal state of T flip-flop
	sep_clr; // signal marking the end of the min separation zone
		 //  for the last pulse

integer
	last_t_time,    // time when the last t pulse appeared
	in_sep;	 // number of pulses within an interval t_sep before 
		 //  the last data pulse;

initial 
	begin
// clear internal registers and the output signal
	  t_state = 0;
	  in_sep = 0;
	  sep_clr = 0;
	  out = 0;
	  nout = 0;
	end


always @(posedge in)
	begin
	  out <= #delay (in_sep > 0) ? 1'bx : t_state;
	  out <= #(delay+2) 0;
	  nout <= #delay (in_sep > 0) ? 1'bx : ~t_state;
	  nout <= #(delay+2) 0;

	  if (in_sep == 0)
	    t_state <= t_state ^ in;
	  else
	    begin
	      t_state = 1'bx;

	    // generating a warning
	      $fwrite(warning_file, 
	       "Violation of separation time in module %m.\n");
	      $fwrite(warning_file,
	       "Input T pulses at %0d and at %0d.\n", last_t_time, 
	       $stime);
	    end
	  last_t_time <= $stime;

	  in_sep <= in_sep + 1;
	  sep_clr <= #(t_separation-1) 1;
	end

always @(posedge sep_clr)
	begin
	  in_sep <= in_sep - 1;
	  sep_clr <= 0;
	end


endmodule