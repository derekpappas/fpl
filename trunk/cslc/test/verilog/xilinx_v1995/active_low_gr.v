         ////////////////////////////////////////////////////
        // ACTIVE_LOW_GR.V Version 1.0                    //
       // Xilinx HDL Synthesis Design Guide              //
      // The signal RESET is inverted before being      //
     // connected to the GR pin of the STARTUP block   //
    // The inverter will be absorbed by STARTUP in M1 //
   // Inverter is instantiated to avoid being mapped //
  // into a LUT by Synopsys                         //
 // September 1997                                 //
////////////////////////////////////////////////////

module active_low_gr ( CLOCK, RESET, UPCNT, DNCNT);

   input        CLOCK, RESET;
   output [3:0] UPCNT;
   output [3:0] DNCNT;

   wire       RESET_NOT;
   reg  [3:0] UPCNT;
   reg  [3:0] DNCNT;

   INV U1 (.O(RESET_NOT), .I(RESET));

   STARTUP U2 (.GR(RESET_NOT));

   always @ (posedge CLOCK or posedge RESET_NOT) 
   begin
      if (RESET_NOT) 
      begin
         UPCNT = 4'b0000;
         DNCNT = 4'b1111;
      end 
      else 
      begin
         UPCNT = UPCNT + 1'b1;
         DNCNT = DNCNT - 1'b1;
      end
   end

endmodule
