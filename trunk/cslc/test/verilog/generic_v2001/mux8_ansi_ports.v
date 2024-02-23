//modiffications by GabrielD at BigSurSoftware.com
module mux8_ansi_ports ( 
//	output reg [7:0] y = 0,
	output reg [7:0] y,
	input wire [7:0] a,
	input wire [7:0] b,
	input wire en );   

function [63:0] alu (
	input [63:0] a,
	input[63:0] b,
	input [7:0] opcode);
	alu = (opcode==1) ? a+b : a-b;
endfunction

reg [63:0] GDalu;

task ansi_port_task (
	input [63:0] a,
	input[63:0] b,
	input [7:0] opcode);
	GDalu = (opcode==1) ? a+b : a-b;
endtask

endmodule

