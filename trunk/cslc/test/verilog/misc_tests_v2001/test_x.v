module x(inx,out1,out2,out3,outx);
    //memory [7:0] mem_x [0:127];
    //array  [7:0] mem_x [0:127];
    wire [-7:0] wi;
    output [-7:-5] out1;
    output [3:0] out2;
    output [2:7] out3;
    assign wi = 8'b11101010;
    assign out1 = 3'b011;
    assign out2 = 4'b1011;
    assign out3 = 6'b110000;
    output [6:0] outx;
    wire [6:0] outx;
    //wire [3:0] inx;
    input [3:0] inx;
endmodule

module checker(data_in,result_out);
  input data_in;
  output result_out;
  wire sgn_x;
  reference ref(.out_ref(sgn_x));
  comparator comp(.in_x(sgn_x),.data_in(data_in),.result_out(result_out));
endmodule
module reference(out_reg);
  output out_reg;
  reg out_reg;
endmodule
module comparator(in_x,data_in,result_out);
  input in_x, data_in;
  output result_out;
endmodule

module receiver(state,clk,in);
    input clk;
    output [1:0] state;
    input [3:0] in;
    reg [1:0] state;
    wire clk;
endmodule
module sender(state,clk,out);
    //wire clk;
    output [1:0] state;
    input clk;
    output [3:0] out;
    reg [1:0] state;
    wire clk;
endmodule
