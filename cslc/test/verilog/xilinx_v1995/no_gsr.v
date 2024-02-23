/* NO_GSR Example 
 * The signal RESET initializes all registers 
 * December 2001 */ 
 
module no_gsr ( CLOCK, RESET, UPCNT, DNCNT); 
 
input CLOCK, RESET; 
output [3:0] UPCNT; 
output [3:0] DNCNT; 
 
reg [3:0] UPCNT; 
reg [3:0] DNCNT;
 
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
