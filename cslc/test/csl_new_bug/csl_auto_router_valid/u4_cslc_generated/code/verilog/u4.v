`include "defines.v"

module u4(p11,
          p12,
          p13,
          p14,
          p15,
          p16,
          p21,
          p22,
          p23,
          p24,
          p25,
          p26,
          p31,
          p32,
          p33,
          p34,
          p35,
          p36);
// Location of source csl unit: file name = conn_units_multiple_levels.csl line number = 36
  input [2 - 1:0] p11;
  input [2 - 1:0] p12;
  input [2 - 1:0] p13;
  input [2 - 1:0] p14;
  input [2 - 1:0] p15;
  input [2 - 1:0] p16;
  input [2 - 1:0] p21;
  input [2 - 1:0] p22;
  input [2 - 1:0] p23;
  input [2 - 1:0] p24;
  input [2 - 1:0] p25;
  input [2 - 1:0] p26;
  input [2 - 1:0] p31;
  input [2 - 1:0] p32;
  input [2 - 1:0] p33;
  input [2 - 1:0] p34;
  input [2 - 1:0] p35;
  input [2 - 1:0] p36;
  u3 u31(.p1(p11),
         .p2(p12),
         .p3(p13),
         .p4(p14),
         .p5(p15),
         .p6(p16));
  u3 u32(.p1(p21),
         .p2(p22),
         .p3(p23),
         .p4(p24),
         .p5(p25),
         .p6(p26));
  u3 u33(.p1(p31),
         .p2(p32),
         .p3(p33),
         .p4(p34),
         .p5(p35),
         .p6(p36));
  `include "u4.logic.vh"
endmodule

