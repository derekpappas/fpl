/* Example of Implementing Registers 

* FF_EXAMPLE.V 

* May 2001 

*/ 


module ff_example (RESET, CLOCK, ENABLE, D_IN, 

              A_Q_OUT, B_Q_OUT, C_Q_OUT, D_Q_OUT); 


input RESET, CLOCK, ENABLE; 

input [7:0] D_IN; 

output [7:0] A_Q_OUT; 

output [7:0] B_Q_OUT; 

output [7:0] C_Q_OUT; 

output [7:0] D_Q_OUT; 


reg [7:0] A_Q_OUT; 

reg [7:0] B_Q_OUT; 

reg [7:0] C_Q_OUT; 

reg [7:0] D_Q_OUT; 


// D flip-flop 

always @(posedge CLOCK) 

begin 

A_Q_OUT <= D_IN; 

end 


// Flip-flop with asynchronous reset 

always @(posedge RESET or posedge CLOCK) 

begin 

if (RESET) 

B_Q_OUT <= 8'b00000000; 

else 

B_Q_OUT <= D_IN; 

end 


// Flip-flop with asynchronous set 

always @(posedge RESET or posedge CLOCK) 

begin 

if (RESET) 

C_Q_OUT <= 8'b11111111; 

else 

C_Q_OUT <= D_IN; 

end 


//Flip-flop with asynchronous reset & clock enable always 

always@(posedge RESET or posedge CLOCK) 

begin 

if (RESET) 

D_Q_OUT <= 8'b00000000; 

else if (ENABLE) 

D_Q_OUT <= D_IN; 

end 


endmodule 

