/* define a name for this configuration */
//config cfg4

   /* specify where to find top level modules */
//   design rtlLib.top   

   /* set the default search order for finding
      instantiated modules */
//   default liblist rtlLib gateLib;

  /* explicitly specify which library to use
      for the following module instance */
//  instance test.dut.a2 liblist gateLib; 
//endconfig 

/* location of RTL models (current directory) */
//library rtlLib "./*.v";  
/* Location of synthesized models */
//library gateLib "./synth_out/*.v";




module Nbit_adder (co, sum, a, b, ci);

parameter SIZE = 4; 
output [SIZE-1:0] sum; 
output co; 
input [SIZE-1:0] a, b; 
input ci; 
wire [SIZE:0] c; 

genvar i;   
assign c[0] = ci;

assign co = c[SIZE];  

generate
 for(i=0; i<SIZE; i=i+1)
  begin:addbit
   wire n1,n2,n3; //internal nets
   xor g1 (n1 ,a[i] ,b[i]);
   xor g2 (sum[i] ,n1 ,c[i]);
   and g3 (n2 , a[i] ,b[i]);
   and g4 (n3 , n1 ,c[i]); 
   or g5 (c[i+1] ,n2 ,n3);
  end 
endgenerate 

endmodule 



module Nbit_adder2 (co, sum, a, b, ci);

parameter SIZE = 4;
output [SIZE-1:0] sum;
output co;
input [SIZE-1:0] a, b;
input ci;
wire [SIZE:0] c; 

genvar i;   
assign c[0] = ci;

assign co = c[SIZE];  

generate
 for(i=0; i<SIZE; i=i+1)
  begin:addbit
   wire n1,n2,n3; //internal nets
   xor g1 (n1 ,a[i] ,b[i]);
   xor g2 (sum[i] ,n1 ,c[i]); 
   and g3 (n2 , a[i] ,b[i]);
   and g4 (n3 , n1 ,c[i]); 
   or g5 (c[i+1] ,n2 ,n3);
  end 
endgenerate

endmodule 
