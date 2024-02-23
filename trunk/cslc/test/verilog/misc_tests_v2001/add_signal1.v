module block1(en,i0,i1,i2,i3,sgn1,sgn2,sgn3,data_out);
    input en, i0,i1,i2,i3;
    output [1:0] sgn1, sgn2;
    output sgn3; 
    output [3:0] data_out;
    reg [3:0] data_out;
    wire i0,i1,i2,i3,en,del,valid,d0,d1,sgn3;
    wire [1:0] sgn1, sgn2;
    wire [3:0] d_out;
    wire state;
    delay delay1(.en(en),.del(del));
    cd cd1(.en(en),.i0(i0),.i1(i1),.i2(i2),.i3(i3),.d0(d0),.d1(d1));
    ctrl ctrl1(.del(del),.state(state),.valid(valid));
    box box1(.valid(valid),.d0(d0),.d1(d1),.state(state),.sgn1(sgn1),.sgn2(sgn2),.sgn3(sgn3),.data_out(d_out));
endmodule
module delay(en,del);
    input en;
    output del;   
endmodule
module cd(en,i0,i1,i2,i3,d0,d1);
    input en,i0,i1,i2,i3;
    output d0,d1;
endmodule
module ctrl(del,state,valid);
    input del,state;
    output valid;
endmodule
module box(valid,d0,d1,state,sgn1,sgn2,sgn3,data_out);
    input valid,d0,d1;
    output [1:0] sgn1,sgn2;
    output sgn3,state;
    output[3:0] data_out;
endmodule