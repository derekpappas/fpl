module cswitch_tb  ; 
 
  reg    sel00   ; 
  wire  [31:0]  out0   ; 
  reg    sel10   ; 
  reg    sel01   ; 
  reg    sel11   ; 
  reg  [31:0]  in0   ; 
  cswitch  
   DUT  ( 
       .sel00 (sel00 ) ,
      .out0 (out0 ) ,
      .sel10 (sel10 ) ,
      .sel01 (sel01 ) ,
      .sel11 (sel11 ) ,
      .in0 (in0 ) ); 

endmodule

