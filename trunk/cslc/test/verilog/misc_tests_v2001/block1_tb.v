module block1_tb  ; 
 
  reg    i3   ; 
  wire  [3:0]  data_out   ; 
  wire  [1:0]  sgn1   ; 
  reg    i0   ; 
  wire  [1:0]  sgn2   ; 
  reg    i1   ; 
  wire    sgn3   ; 
  reg    i2   ; 
  reg    en   ; 
  block1  
   DUT  ( 
       .i3 (i3 ) ,
      .data_out (data_out ) ,
      .sgn1 (sgn1 ) ,
      .i0 (i0 ) ,
      .sgn2 (sgn2 ) ,
      .i1 (i1 ) ,
      .sgn3 (sgn3 ) ,
      .i2 (i2 ) ,
      .en (en ) ); 

endmodule

