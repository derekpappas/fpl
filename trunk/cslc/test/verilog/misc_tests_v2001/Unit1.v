module cswitch(in0,out0, sel00,sel01,sel10,sel11);
    input [31:0] in0;
    input sel00,sel01,sel10,sel11;
    output [31:0] out0;
    wire sel00,sel01,sel10,sel11;
    wire [7:0] x00,x01,y00,y01;
    wire [7:0] x10,x11,y10,y11;
    wire [7:0] x20,x21,y20,y21;
    wire [7:0] x30,x31,y30,y31;
    assign x00 = in0[31:24];
    assign x01 = in0[23:16];
    assign x20 = in0[15:8];
    assign x21 = in0[7:0];
    assign y10 = out0[31:24];
    assign y11 = out0[23:16];
    assign y30 = out0[15:8];
    assign y31 = out0[7:0];
    sen sen0(x00,x01,y00,y01,sel00);
    sen sen1(x10,x11,y10,y11,sel01);
    sen sen2(x20,x21,y20,y21,sel10);
    sen sen3(x30,x31,y30,y31,sel11);
endmodule
module sen(x0,x1,y0,y1,sel);
    input [7:0] x0,x1;
    input sel;
    output [7:0] y0,y1;
endmodule
