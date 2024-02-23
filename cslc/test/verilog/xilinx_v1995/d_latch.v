/* Transparent High Latch 
 * D_LATCH.V 
 * May 2001 
*/ 
 
module d_latch (GATE, DATA, Q); 
 
input GATE; 
input DATA; 
output Q; 
 
reg Q; 
 
  
   always @ (GATE or DATA)  
   begin  
          if (GATE == 1'b1)  
              Q <= DATA;  
 
   end  // End Latch 
 
endmodule 
