     /////////////////////////////////////
    // SET_AND_RESET.V Version 1.0     //
   // FF with Async. Set and Reset    //
  // Do not use this in FPGA Designs //
 // November 1997                   //
/////////////////////////////////////

module set_and_reset (CLK, DATA, PRESET, RESET, Q);

input CLK, DATA, PRESET, RESET;
output Q;

reg    Q;

    always @ (posedge CLK or posedge PRESET or posedge RESET)
    begin: SR_FLOP
        if (RESET)
            Q <= 0;
        else if (PRESET)
            Q <= 1;
        else
   	    Q <= DATA;
    end 

endmodule
