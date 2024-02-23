//modiffications by GabrielD at BigSurSoftware.com
module test_port_order;

wire [7:0] y,a,b,c,en;

//ansi_port_list c1 (y,a,b,c,en);
mux8_ansi_ports c1 (y,a,b,c,en);

endmodule


module reg_init_assign_test;



reg clock = 0;
reg clock2 =
	     0;


always
	begin
	#10 clock = ~clock;
	#10 clock2 = ~clock2;
	end


//(* new_attribute *)

/*(*
   multi,
   line,
   attribute = true
*)*/

endmodule
