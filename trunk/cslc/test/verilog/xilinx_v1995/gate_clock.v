///////////////////////////////////////// 
// GATE_CLOCK.V Version 1.1                                           // 
// Gated Clock Example                                           // 
// Better implementation to use clock                                          // 
// enables than gating the clock                                           // 
// May 2001                                           // 
///////////////////////////////////////// 
 
module gate_clock(IN1, IN2, DATA, CLK,LOAD,OUT1); 
input       IN1 ; 
input       IN2 ; 
input       DATA ; 
input       CLK ; 
input       LOAD ; 
output      OUT1 ; 
reg         OUT1 ; 
 
wire GATECLK ; 
 
assign GATECLK = (IN1 & IN2 & CLK); 
 
always @(posedge GATECLK) 
begin 
   if (LOAD == 1'b1) 
      OUT1 = DATA; 
end 
 
endmodule 
