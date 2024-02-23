module oneshot(osin,clk,osout);
    input osin;
    input clk;
    output osout;

	reg osout;
	reg q;

always @(posedge osin or posedge osout)
begin
	if(osout)
		q <= 0;
	else
		q <= 1;
end

always @(posedge clk)
begin
	osout <= q;
end


endmodule
