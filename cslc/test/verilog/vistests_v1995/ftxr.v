module ftxr(clk);
input clk;

reg c;

initial c = 0;

always @(posedge clk) begin
    if (1) begin
	if (1) c = 0;
	else if (1) c = 0;
	else if (1) c = 0;
	else begin
	    if (1) begin
		if (1) begin c = 0; end
	    end
	end
    end
end
endmodule
