//oanab
//17 mar 2008

module decoder(test_sel,out);
input [2:0] test_sel;
output [7:0] out;
wire [7:0] out;
assign out = (test_sel == 3'b000) ? 8'b0000_0001 : 
	      (test_sel == 3'b001) ? 8'b0000_0010 :
	       (test_sel == 3'b010) ? 8'b0000_0100 :
		(test_sel == 3'b011) ? 8'b0000_1000 :
		 (test_sel == 3'b100) ? 8'b0001_0000 :
		  (test_sel == 3'b101) ? 8'b0010_0000 :
		   (test_sel == 3'b110) ? 8'b0100_0000 :
		    (test_sel == 3'b111) ? 8'b1000_0000 : 8'b0000_0000;
endmodule
