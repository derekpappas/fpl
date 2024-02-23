      ///////////////////////////////////////////////////
     // PRESET_5K.V Version 1.0                       //
    // Example of 5k FF with Async. Preset           //
   // implemented with inverter on input and output //
  // of FF because FFs have only async. resets     //
 // November 1997                                 // 
///////////////////////////////////////////////////

module preset_5k (CLK, DATA, PRESET, Q);

input  CLK, DATA, PRESET;
output Q;

reg    Q;

    always @ (posedge CLK or posedge PRESET)
    begin: SET_FLOP
        if (PRESET)
   	  Q <= 1;
        else
          Q <= DATA;
    end 

endmodule
