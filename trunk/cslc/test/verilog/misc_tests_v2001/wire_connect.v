module Top;
   wire  q0, q1, q2, q3, q4;
   wire [4:0] q;
   assign q={q4, q3, q2, q1, q0};
   send send0(.q(q[4:0]));
   mq mq0(.q0(q0));
   mw mw1(.q1(q1));
   me me2(.q2(q2));
   mr mr3(.q3(q3));
   mt mt4(.q4(q4));
endmodule
module Send(q);
   output [4:0] q ;
endmodule
module mq(q0);
   input q0;
endmodule   
module mw(q1);
    input q1;
endmodule
module me(q2);
    input q2;
endmodule
module mr(q3);
    input q3;
endmodule
module mt(q4);
    input q4;
endmodule
