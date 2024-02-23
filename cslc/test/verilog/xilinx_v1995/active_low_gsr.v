module active_low_gsr ( CLOCK, RESET, UPCNT, DNCNT); 
 input        CLOCK, RESET; 
 output [3:0] UPCNT; 
 output [3:0] DNCNT; 
  
    wire       RESET_NOT; 
 reg  [3:0] UPCNT; 
 reg  [3:0] DNCNT; 
 
 INV U1 (.O(RESET_NOT), .I(RESET)); 
 
 STARTUP U2 (.GSR(RESET_NOT)); 
 
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
