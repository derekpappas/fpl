       ///////////////////////////////////////////////////////
      // GATE_REDUCE.V Version 1.0                         //
     // Xilinx HDL Synthesis Design Guide                 //
    // Ilustrates gate reduction by the use of Synopsys  //
   // Designware compnents. This is the top level with  //
  // 2 Instantiated 'xilinx_dw' modules                //
 // December 1997                                     //
///////////////////////////////////////////////////////
 
module gate_reduce
	   (A_CHECK, B_CHECK, 
	    RESET, CLOCK, CLKEN, 
 	    A_TICK, B_TICK,
	    ST_A, ST_B);

input A_CHECK, B_CHECK;
input RESET, CLOCK, CLKEN;
input A_TICK, B_TICK;
output ST_A, ST_B;

   xilinx_dw I_0 (.CHECK(A_CHECK), .RST(RESET), .CLK(CLOCK), .CLK_EN(CLKEN),
                 .TICK(A_TICK), .ST(ST_A));
   xilinx_dw I_1 (.CHECK(B_CHECK), .RST(RESET), .CLK(CLOCK), .CLK_EN(CLKEN),
                 .TICK(B_TICK), .ST(ST_B));

endmodule 
