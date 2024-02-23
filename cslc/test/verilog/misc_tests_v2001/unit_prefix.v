module block1(i0,i1,i2,d1_o0,d1_o1,d1_o2,d2_o0,d2_o1,d2_o2,d3_o0,d3_o1,d3_o2);
    input i0,i1,i2;
    output d1_o0,d1_o1,d1_o2,d2_o0,d2_o1,d2_o2,d3_o0,d3_o1,d3_o2;
    wire [2:0] in_signs;
    wire [2:0] out1_signs,out2_signs,out3_signs;
    wire [8:0] out_signs;
    assign in_signs = {i0,i1,i2};
    assign out1_signs = {d1_o0,d1_o1,d1_o2};
    assign out2_signs = {d2_o0,d2_o1,d2_o2};
    assign out3_signs = {d3_o0,d3_o1,d3_o2};
    assign out_signs = {out1_signs,out2_signs,out3_signs};
    wire vl1,vl12,vl23,vl3;
    box01 box1(i0,i1,i2,d1_o0,d1_o1,d1_o2,vl1,vl12);
    box02 box2(i0,i1,i2,d2_o0,d2_o1,d2_o2,vl12,vl23);
    box03 box3(i0,i1,i2,d3_o0,d3_o1,d3_o2,vl23,vl3);
endmodule
//change the name of the interfaces signals and instances
module box01(bk1_i0,bk1_i1,bk1_i2,bk1_d1_o0,bk1_d1_o1,bk1_d1_o2,bk1_vl1,b1_2_bk1_vl12);
    input bk1_i0,bk1_i1,bk1_i2,bk1_vl1;
    output bk1_d1_o0,bk1_d1_o1,bk1_d1_o2,b1_2_bk1_vl12;
    wire bk1_en;
    dy01 bk1_dy01(bk1_i0,bk1_i1,bk1_i2,bk1_d1_o0,bk1_d1_o1,bk1_d1_o2,bk1_en,bk1_vl1,b1_2_bk1_vl12);            
endmodule
//change only the name of the interfaces
module box02(bk1_i0,bk1_i1,bk1_i2,bx2_bk1_d2_o0,bk1_d2_o1,bx2_bk1_d2_o2,bk1_vl12,bk1_vl23);
    input bk1_i0,bk1_i1,bk1_i2,bk1_vl12;
    output bx2_bk1_d2_o0,bk1_d2_o1,bx2_bk1_d2_o2,bk1_vl23;
    wire en;
    wire i0,i1,i2,d2_o0,d2_o1,d2_o2,vl12,vl23;
    assign i0 = bk1_i0;
    assign i1 = bk1_i1;
    assign i2 = bk1_i2;
    assign bx2_d2_o0 = bx2_bk1_d2_o0;
    assign d2_o1 = bk1_d2_o1;
    assign bx2_d2_o2 = bx2_bk1_d2_o2;
    assign vl12 = bk1_vl12;
    assign vl23 = bk1_vl23;
    dy02 dy2(i0,i1,i2,bx2_d2_o0,d2_o1,bx2_d2_o2,en,vl12,vl23);
endmodule
//change only the name of the signals and instances
module box03(i0,i1,i2,d2_o0,d2_o1,d2_o2,vl23,vl3);
    input i0,i1,i2,vl23;
    output d2_o0,d2_o1,d2_o2,vl3;
    wire bk1_en,box2_3_bk1_vl23,bk1_vl3;
    wire bx3_bk1_i0,bk1_i1,bx3_bk1_i2,bk1_d2_o0,bk1_d2_o1,bk1_d2_o2;
    assign bx3_bk1_i0 = i0;
    assign bk1_i1=  i1;
    assign bx3_bk1_i2 = i2;
    assign bk1_d2_o0 = d2_o0;
    assign bk1_d2_o1 = d2_o1;
    assign bk1_d2_o2 = d2_o2;
    assign box2_3_bk1_vl23 = vl23;
    assign bk1_vl3 = vl3;
    dy03 bk1_dy3(bk1_i0,bk1_i1,bk1_i2,bk1_d2_o0,bk1_d2_o1,bk1_d2_o2,bk1_en,bk1_vl23,bk1_vl3);
endmodule
//the prefix affect this
module dy01(bk1_i0,bk1_i1,bk1_i2,bk1_d1_o0,bk1_d1_o1,bk1_d1_o2,bk1_en,bk1_vl1,b1_2_bk1_vl12);
    input bk1_i0,bk1_i1,bk1_i2,bk1_en,bk1_vl1;
    output bk1_d1_o0,bk1_d1_o1,bk1_d1_o2,b1_2_bk1_vl12;
endmodule
//the prefix affect this
module dy02(i0,i1,i2,bx2_d2_o0,d2_o1,bx2_d2_o2,en,vl12,vl23);
    input i0,i1,i2,en,vl12;
    output bx2_d2_o0,d2_o1,bx2_d2_o2,vl23;
endmodule
//the prefix affect this
module dy03(bk1_i0,bk1_i1,bk1_i2,bk1_d2_o0,bk1_d2_o1,bk1_d2_o2,bk1_en,bk1_vl23,bk1_vl3);
    input bk1_i0,bk1_i1,bk1_i2,bk1_en,bk1_vl23;
    output bk1_d2_o0,bk1_d2_o1,bk1_d2_o2,bk1_vl3;
endmodule