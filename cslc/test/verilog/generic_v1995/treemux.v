//*****************************************************************************
//FILE NAME: treemux.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : This module models the 8:1 muxtree with 3 select inputs.This is 
//           used for the selection of both the even and odd clk. 
//*****************************************************************************

                                                                                module treemux(in_s1, select_s1, out_clk);

input [7:0] in_s1  ;
input [2:0] select_s1;

output out_clk;

reg out_clk;

always @(select_s1 or in_s1)
begin
	casex(select_s1)
		3'b000 : out_clk = in_s1[0];
		3'b001 : out_clk = in_s1[1];
		3'b010 : out_clk = in_s1[2];
		3'b011 : out_clk = in_s1[3];
		3'b100 : out_clk = in_s1[4];
		3'b101 : out_clk = in_s1[5];
		3'b110 : out_clk = in_s1[6];
		3'b111 : out_clk = in_s1[7];
	endcase
end

endmodule // end treemux module
