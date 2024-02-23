module wallace8x8(a,b,z);
    input [7:0] a,b;
    output [15:0] z;

    wire [7:0]   ab0,ab1,ab2,ab3,ab4,ab5,ab6,ab7;
    wire [15:0]  s0,c0,s1,c2,s2,c2,s3,c3,s4,c4,s5,c5;

    prods pp (a,b,ab0,ab1,ab2,ab3,ab4,ab5,ab6,ab7);
    CSA c0 ({8'b0,ab0},{7'b0,ab1,1'b0},{6'b0,ab2,2'b0},s0,c0);
    CSA c1 ({8'b0,ab3},{7'b0,ab4,1'b0},{6'b0,ab5,2'b0},s1,c1);
    CSA c2 (s0,{c0[14:0],1'b0},{s1[12:0],3'b0},s2,c2);
    CSA c3 (c1,{6'b0,ab6,2'b0},{5'b0,ab7,3'b0},s3,c3);
    CSA c4 (s2,{c2[14:0],1'b0},{s3[11:0],4'b0},s4,c4);
    CSA c5 (s4,{c4[14:0],1'b0},{c3[10:0],5'b0},s5,c5);
    CPA c6 (s5,{c5[14:0],1'b0},z);

endmodule // wallace8x8


module prods(a,b,ab0,ab1,ab2,ab3,ab4,ab5,ab6,ab7);
    input [7:0] a,b;
    output [7:0] ab0,ab1,ab2,ab3,ab4,ab5,ab6,ab7;

    assign 	 ab0 = a & {8 {b[0]}};
    assign 	 ab1 = a & {8 {b[1]}};
    assign 	 ab2 = a & {8 {b[2]}};
    assign 	 ab3 = a & {8 {b[3]}};
    assign 	 ab4 = a & {8 {b[4]}};
    assign 	 ab5 = a & {8 {b[5]}};
    assign 	 ab6 = a & {8 {b[6]}};
    assign 	 ab7 = a & {8 {b[7]}};

endmodule // prods


module CSA (o0,o1,o2,s,c);
    input [15:0] o0,o1,o2;
    output [15:0] s,c;

    assign s = o0 ^ o1 ^ o2;
    assign c = o0 & o1 | o0 & o2 | o1 & o2;

endmodule // CSA


module CPA (o0,o1,z);
    input [15:0] o0,o1;
    output [15:0] z;

    assign 	  z = {5'b0,o0} + {o1,5'b0};

endmodule // CPA
