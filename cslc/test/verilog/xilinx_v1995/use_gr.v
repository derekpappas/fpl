       ////////////////////////////////////////////////
      // USE_GR.V Version 1.0                       //
     // Xilinx HDL Synthesis Design Guide          //
    // The signal RESET initializes all registers //
   // Using the global reset resources since     //
  // STARTUP block instantiation was added      //
 // December 1997                              //
////////////////////////////////////////////////

module use_gr ( CLOCK, RESET, UPCNT, DNCNT);

input CLOCK, RESET;
output [3:0] UPCNT;
output [3:0] DNCNT;

reg [3:0] UPCNT;
reg [3:0] DNCNT;

STARTUP U1 (.GR(RESET));

always @ (posedge CLOCK or posedge RESET) begin
    if (RESET) begin
        UPCNT = 4'b0000;
        DNCNT = 4'b1111;
    end else begin
        UPCNT = UPCNT + 1'b1;
        DNCNT = DNCNT - 1'b1;
    end
end

endmodule
