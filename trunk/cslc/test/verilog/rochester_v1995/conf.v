// Verilog HDL for "gates.lib", "conf_buff" "_functional"
// Module CONFLUENCE BUFFER
module conf_buff (in1, in2, out);

input
	in1, in2;

output
	out;
reg 
	out;

parameter
	t_separation = 10,
	delay=15,

	warning_file=3;  // multichannel description of a warning file

reg
	sep_clr; // signal marking the end of the min separation zone
		 //  for the last pulse

integer
	last_in_time,    // time when the last t pulse appeared
	in_sep;	 // number of pulses within an interval t_sep before 
		 //  the last data pulse;

initial 
	begin
// clear internal registers and the output signal
		last_in_time = 0;
		in_sep = 0;
		sep_clr = 0;
		out = 0;
	end

always @(posedge in1)
	begin
		out <= #delay ((in_sep > 0) || (in2 == 1)) ? 1'bx : 1;
		out <= #(delay+2) 0;
		
		if((in_sep>0) || (in2 == 1))
	          begin
	        // generating a warning
	            $fwrite(warning_file, 
	            "Violation of separation time in module %m.\n");
	            $fwrite(warning_file,
	            "Input pulses at ");
		    if(in_sep>0)
			$fwrite(warning_file,
			"%0d and at %0d.\n", last_in_time, $stime);
		    else
			$fwrite(warning_file,
			"%0d and at %0d.\n", $stime, $stime);
	    	  end
	  	last_in_time <= $stime;

		in_sep <= in_sep + 1;
		sep_clr <= #(t_separation-1) 1;
	end

always @(posedge in2)
	begin
		out <= #delay ((in_sep > 0) || (in1 == 1)) ? 1'bx : 1;
		out <= #(delay+2) 0;

		if((in_sep>0) || (in1 == 1))
	          begin
	        // generating a warning
	            $fwrite(warning_file, 
	            "Violation of separation time in module %m.\n");
	            $fwrite(warning_file,
	            "Input pulses at ");
		    if(in_sep>0)
			$fwrite(warning_file,
			"%0d and at %0d.\n", last_in_time, $stime);
		    else
			$fwrite(warning_file,
			"%0d and at %0d.\n", $stime, $stime);
	    	  end
	  	last_in_time <= $stime;

		in_sep <= in_sep + 1;
		sep_clr <= #(t_separation-1) 1;
	end

always @(posedge sep_clr)
	begin
	  	in_sep <= in_sep - 1;
		sep_clr <= 0;
	end


endmodule