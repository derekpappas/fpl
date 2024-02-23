module types(w1, w2, w3, w5, w6, wa1, wa2, wa3, wa5, wa6,
wo1, wo2, wo3, wo5, wo6, s01, s02, s03, s05, s06, s11, s12,
s13, s15, s16, t1, t2, t3, t5, t6, ta1, ta2, ta3, ta5,
ta6, to1, to2, to3, to5, to6, t01, t02, t03, t05,
t06, t11, t12, t13, t15, t16, r1, r2, r3, r5, r6);

parameter a=1?2:3;

integer a_int=10;

//input wire
  input wire w1; 
  input wire [0:7] w2;
  input wire [8:2] w3; 
  input wire signed [0:2]w5; 
  input wire signed [2:0]w6;
//input wand
  input wand wa1; 
  input wand [0:7] wa2;
  wand [7:0] wa_4[0:15] [0:10] ;
  input wand [8:2] wa3; 
  input wand signed [0:2]wa5; 
  input wand signed [2:0]wa6;
//input wor
  input wor wo1; 
  input wor [0:7] wo2;
  input wor [8:2] wo3; 
  input wor signed [0:2]wo5; 
  input wor signed [2:0]wo6;
//input supply0
  input supply0 s01; 
  input supply0 [0:7] s02;
  input supply0 [8:2] s03; 
  input supply0 signed [0:2]s05; 
  input supply0 signed [2:0]s06;
//input suply1
  input supply1 s11; 
  input supply1 [0:7] s12;
  input supply1 [8:2] s13; 
  input supply1 signed [0:2]s15; 
  input supply1 signed [2:0]s16;
//input tri
  input tri t1; 
  input tri [0:7] t2;
  input tri [8:2] t3; 
  input tri signed [0:2]t5; 
  input tri signed [2:0]t6;
//input triand
  input triand ta1; 
  input triand [0:7] ta2;
  input triand [8:2] ta3; 
  input triand signed [0:2]ta5; 
  input triand signed [2:0]ta6;
//input trior
  input trior to1; 
  input trior [0:7] to2;
  input trior [8:2] to3; 
  input trior signed [0:2]to5; 
  input trior signed [2:0]to6;
//input tri0
  input tri0 t01; 
  input tri0 [0:7] t02;
  input tri0 [8:2] t03; 
  input tri0 signed [0:2]t05; 
  input tri0 signed [2:0]t06;
//input tri1
  input tri1 t11; 
  input tri1 [0:7] t12;
  input tri1 [8:2] t13; 
  input tri1 signed [0:2]t15; 
  input tri1 signed [2:0]t16;
//output reg
  output reg r1;
  output reg [0:7]r2;
  output reg [8:2]r3;
  output reg signed r5;
  output reg signed [2:0]r6;
endmodule