`define IO_DIM 4
`define LINK_DIM 32
`define HALF_DIM `LINK_DIM/2

module top(in,out);
    input [`IO_DIM-1:0] in;
    output [`IO_DIM-1:0] out;
    swap swp0();
endmodule
module swap;
    wire [`LINK_DIM-1:0] lnk1, lnk2;
    first x0(lnk1,lnk2);
    last x1(lnk1,lnk2);    
endmodule
module first(lnk1,lnk2);
    output [`LINK_DIM-1:0] lnk1, lnk2;
    wire [`HALF_DIM-1:0] lnk1_0,lnk1_1,lnk2_0,lnk2_1;
    wire [`IO_DIM-1:0] x0_000,x0_001,x0_010,x0_011,x0_100,x0_101,x0_110,x0_111;
    wire [`IO_DIM-1:0] x1_000,x1_001,x1_010,x1_011,x1_100,x1_101,x1_110,x1_111;
    assign lnk1_0 = {x0_000,x0_001,x0_010,x0_011};
    assign lnk1_1 = {x0_100,x0_101,x0_110,x0_111};
    assign lnk2_0 = {x1_000,x1_001,x1_010,x1_011};
    assign lnk2_1 = {x1_100,x1_101,x1_110,x1_111};
    assign lnk1 = {lnk1_0,lnk1_1};
    assign lnk2 = {lnk2_0,lnk2_1};
endmodule
module last (lnk1,lnk2);
    input [31:0] lnk1,lnk2;
    wire [`HALF_DIM-1:0] lnk1_0,lnk1_1,lnk2_0,lnk2_1;
    wire [3:0] y0_000,y0_001,y0_010,y0_011,y0_100,y0_101,y0_110,y0_111;
    wire [3:0] y1_000,y1_001,y1_010,y1_011,y1_100,y1_101,y1_110,y1_111;
    assign lnk1_0 = {y0_011,y0_010,y0_001,y0_000};
    assign lnk1_1 = {y0_111,y0_110,y0_101,y0_100};
    assign lnk2_0 = {y1_011,y1_010,y1_001,y1_000};
    assign lnk2_1 = {y1_111,y1_110,y1_101,y1_100};
    assign lnk1 = {lnk1_1,lnk1_0}; 
    assign lnk1 = {lnk2_1,lnk2_0};
endmodule
                                                                            