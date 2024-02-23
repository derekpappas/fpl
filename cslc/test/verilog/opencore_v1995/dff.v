/******************************************************/   
/*   module dff                                       */   
/******************************************************/   
// D flip-flop   
// -------------


module dff(D,Q,Clock,Reset); // N.B. reset is active-low   
   output Q; 
   input D,Clock,Reset;   
   
   parameter CARDINALITY = 1; 
   reg [CARDINALITY-1:0] Q;   
   wire [CARDINALITY-1:0] D;   
   
     always @(posedge Clock) if (Reset!==0) #1 Q=D;   
     always begin wait (Reset==0); Q=0; wait (Reset==1); end    
endmodule