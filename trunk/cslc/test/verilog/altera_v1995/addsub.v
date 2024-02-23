module addsub (a, b, addnsub, result);

	input		[7:0] 		a;
	input  [7:0] 				b;
	input				addnsub;
	output		[8:0] 		result;
	reg			[8:0] 		result;

	always @(a or b or addnsub)
	begin
		if (addnsub)
			result = a + b;
		else
			result = a - b;
	end
endmodule
