module paramter_port_list 
  #( parameter integer p1 = 1 , p2 = { 2'b01, 1'b01 } ,
     parameter real p3 = (34 * 72.9),
     parameter p4 = 5 , p5 = 6 )
  ( input  a,
    output b );


initial
	begin
	b = p1;
	#10
	b = p2 > 4;
	#10
	b = (p3 < 75.743);
	#10;
	b = p4 < 2;
	#10;
	b = p5 > 1;
	end

endmodule
