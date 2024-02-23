module barrel(clock);
    input clock;

    reg   b[0:1];
    reg   r[0:1];
    reg   tmp;
    integer i;

    initial begin
	for (i = 0; i < 2; i = i + 1)
	  r[i] = $ND(0,1);
	for (i = 0; i < 2; i = i + 1)
	  b[i] = r[i];
	tmp = 0;
    end

    always @ (posedge clock) begin
	tmp = b[1];
	b[1] = b[0];
	b[0] = tmp;
    end // always @ (posedge clock)

endmodule // barrel
