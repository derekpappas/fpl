module chip(sig_m);
output [11:0] sig_m;
wire [11:6] sig_u1=1;
wire [5:2] sig_u2=1;
wire [1:0] sig_u3=1;
wire [11:0] sig_m_in;
u1 u10(.sig_u1(sig_u1));
u2 u20(.sig_u2(sig_u2));
u3 u30(.sig_u3(sig_u3));
ug ug0(.sig_m_in(sig_m_in),.sig_m(sig_m));
assign sig_m = {sig_u1,sig_u3,sig_u2};
endmodule
module u1(sig_u1);
output [11:6] sig_u1;
endmodule
module u2(sig_u2);
output [5:2] sig_u2;
endmodule
module u3(sig_u3);
output [1:0] sig_u3;
endmodule
module ug(sig_m_in,sig_m);
input [11:0] sig_m_in;
output [11:0] sig_m;
endmodule