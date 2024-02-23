module top_backup_12_30 (result, result_valid, data_in, coef_in, add_in, sload_data, coef_wren, sclr, clock);

parameter sign_cal = 98304;
/*	sign_cal is the operator used when you have negative 2's complement inputs.
	The formula is the memory output for the last computation minus (2^(n-1) * coefficient value)
	where n is the # input bits.
	
	Therefore, in this example, since input bit width = 16 and coefficient value = 3, then
	sign_cal = 2^15 * 3 = 98304.
*/

output [29:0] result;
output result_valid;
input [15:0] data_in;
input [17:0] coef_in;
input [3:0] add_in;
input sload_data, coef_wren, sclr, clock;

reg [29:0] result;
reg result_valid;
wire [17:0] mem_out;
reg [17:0] mem_final;
reg [3:0] mem_address;
reg [2:0] state;
reg [4:0] count;
reg cnt_en;
reg neg_flag;
reg rden;

main_mem mult_mem (.address(mem_address),.clock(clock),.data(coef_in),.wren(coef_wren),.q(mem_out));

always @(posedge clock)
begin
	if (sclr)
		mem_final = 18'b0;
	else if (rden)
		mem_final = mem_out;
	else if (coef_wren)
		mem_final = 18'b0;
end

always @(posedge clock)
begin
	if (sclr)
		result = 30'b0;
	else if ((count == 4'd5) && (neg_flag == 1'b1))
		result = {mem_final,12'b0} + {4'b0,result[29:4]} - sign_cal;
	else if (result_valid)
		result = {mem_final,12'b0} + 30'b0;
	else
		result = {mem_final,12'b0} + {4'b0,result[29:4]};
end

always @(posedge clock)
begin
	if (sclr)
		count = 4'd0;
	else if (result_valid)	// count preset
		count = 4'd3;
	else if (cnt_en)
		count = count + 1;
	else
		count = 4'd0;
end

always @(posedge clock)
begin
	if (sclr)
		result_valid = 1'b0;
	else if (count == 4'd5)
		result_valid = 1'b1;
	else
		result_valid = 1'b0;
end

always @(posedge clock)
begin
	if (sclr)
		neg_flag = 1'b0;
	else if ((state == 3'd3) && (data_in[15]))
		neg_flag = 1'b1;
	else if (result_valid)
		neg_flag = 1'b0;
end

always @(posedge clock)
begin
	if (sclr)
	begin
		state = 2'd0;
	end
	else
		case (state)
			3'd0: begin				// start computation mode
				if (sload_data)
				begin
					mem_address = data_in[3:0];
					cnt_en = 1'b1;
					rden = 1'b1;
					state = 2'd1;
				end
				else if (coef_wren)
					state = 3'd5;
				else
					state = 3'd0;
			end
			3'd1: begin		// multiply mode
				mem_address = data_in[7:4];
				rden = 1'b1;
				cnt_en = 1'b1;
				
				state = 3'd2;
			end
			3'd2: begin
				mem_address = data_in[11:8];
				rden = 1'b1;
				cnt_en = 1'b1;
				
				state = 3'd3;
			end
			3'd3: begin
				cnt_en = 1'b1;
				rden = 1'b1;
				
				if (data_in[15])
					mem_address = {1'b0,data_in[14:12]};
				else
					mem_address = data_in[15:12];
				
				state = 3'd4;
			end
			3'd4: begin
				mem_address = data_in[3:0];
				cnt_en = 1'b1;
				rden = 1'b1;
				
				if (sload_data)
					state = 3'd1;
				else if (count == 4'd5)
				begin
					cnt_en = 1'b0;
					state = 3'd0;
				end
				else
					state = 3'd4;
			end
			3'd5: begin		// coefficient update mode
				mem_address = add_in;
				rden = 1'b0;
								
				if (coef_wren)
					state = 3'd5;
				else
					state = 3'd0;
			end
		endcase
end

endmodule
					