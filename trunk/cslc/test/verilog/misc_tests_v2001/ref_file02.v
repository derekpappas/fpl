module reg_file (clk, rst, wr_en, rd_en, wr_a, rd_a, wr_d, rd_d);
	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 8;
	input clk, rst, wr_en, rd_en;
	input [ADDR_WIDTH - 1 : 0] wr_a;
	input [ADDR_WIDTH - 1 : 0] rd_a;
	input [DATA_WIDTH - 1 : 0] wr_d;
	output [DATA_WIDTH - 1 : 0] rd_d;
	reg [DATA_WIDTH - 1 : 0] rf [ADDR_WIDTH - 1 : 0], rd_d;
	reg [DATA_WIDTH - 1 : 0] data_in0;
	reg [DATA_WIDTH - 1 : 0] data_in1;
	reg [DATA_WIDTH - 1 : 0] data_in2;
	reg [DATA_WIDTH - 1 : 0] data_in3;
	reg [DATA_WIDTH - 1 : 0] data_in4;
	reg [DATA_WIDTH - 1 : 0] data_in5;
	reg [DATA_WIDTH - 1 : 0] data_in6;
	reg [DATA_WIDTH - 1 : 0] data_in7;
	wire [DATA_WIDTH - 1 : 0] data_out0;
	wire [DATA_WIDTH - 1 : 0] data_out1;
	wire [DATA_WIDTH - 1 : 0] data_out2;
	wire [DATA_WIDTH - 1 : 0] data_out3;
	wire [DATA_WIDTH - 1 : 0] data_out4;
	wire [DATA_WIDTH - 1 : 0] data_out5;
	wire [DATA_WIDTH - 1 : 0] data_out6;
	wire [DATA_WIDTH - 1 : 0] data_out7;
	wire ck, r;
	assign ck = clk;
	assign r = rst;
	regs r0 (.ck(ck), .r(r), .data_in(data_in0[DATA_WIDTH - 1 : 0]), .data_out(data_out0[DATA_WIDTH - 1 : 0]));
	regs r1 (.ck(ck), .r(r), .data_in(data_in1[DATA_WIDTH - 1 : 0]), .data_out(data_out1[DATA_WIDTH - 1 : 0]));
	regs r2 (.ck(ck), .r(r), .data_in(data_in2[DATA_WIDTH - 1 : 0]), .data_out(data_out2[DATA_WIDTH - 1 : 0]));
	regs r3 (.ck(ck), .r(r), .data_in(data_in3[DATA_WIDTH - 1 : 0]), .data_out(data_out3[DATA_WIDTH - 1 : 0]));
	regs r4 (.ck(ck), .r(r), .data_in(data_in4[DATA_WIDTH - 1 : 0]), .data_out(data_out4[DATA_WIDTH - 1 : 0]));
	regs r5 (.ck(ck), .r(r), .data_in(data_in5[DATA_WIDTH - 1 : 0]), .data_out(data_out5[DATA_WIDTH - 1 : 0]));
	regs r6 (.ck(ck), .r(r), .data_in(data_in6[DATA_WIDTH - 1 : 0]), .data_out(data_out6[DATA_WIDTH - 1 : 0]));
	regs r7 (.ck(ck), .r(r), .data_in(data_in7[DATA_WIDTH - 1 : 0]), .data_out(data_out7[DATA_WIDTH - 1 : 0]));
	always @ (posedge clk) begin
		if(!rst) begin
		end
	end
	always @ (posedge clk) begin
		if (wr_en) begin
			case (wr_a)
				3'b000 : data_in0 <= wr_d;
				3'b001 : data_in1 <= wr_d;
				3'b010 : data_in2 <= wr_d;
				3'b011 : data_in3 <= wr_d;
				3'b100 : data_in4 <= wr_d;
				3'b101 : data_in5 <= wr_d;
				3'b110 : data_in6 <= wr_d;
				3'b111 : data_in7 <= wr_d;
				default : $display ( "Error out of range" );
			endcase
		end
		if (rd_en) begin
			case (rd_a)
				3'b000 : rd_d <= data_out0;
				3'b001 : rd_d <= data_out1;
				3'b010 : rd_d <= data_out2;
				3'b011 : rd_d <= data_out3;
				3'b100 : rd_d <= data_out4;
				3'b101 : rd_d <= data_out5;
				3'b110 : rd_d <= data_out6;
				3'b111 : rd_d <= data_out7;
				default : $display ( "Error out of range" );
			endcase
		end
	end
endmodule
module regs (ck, r, data_in, data_out);
	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 8;
	input ck, r;
	input [DATA_WIDTH - 1 : 0] data_in;
	output [DATA_WIDTH - 1 : 0] data_out;
	reg [DATA_WIDTH - 1 : 0] data_out;
	always @ (posedge ck) begin
		if(!r) begin
			data_out = 32'b0;
		end
		else begin
			data_out = data_in;
		end
	end
endmodule