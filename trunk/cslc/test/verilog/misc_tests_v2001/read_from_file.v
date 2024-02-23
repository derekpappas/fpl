module read_pattern();
    reg [5:0] my_mem[0:7];
    initial begin
 	  	$readmemb( "memory.list" , my_mem);
 	end
 	endmodule