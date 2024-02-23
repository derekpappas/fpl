module enum (CLOCK, RESET, A, B, C, D, E, 
            SINGLE, MULTI, CONTIG); 
 
input  CLOCK, RESET; 
input  A, B, C, D, E; 
output SINGLE, MULTI, CONTIG; 
 
reg    SINGLE, MULTI, CONTIG; 
 
// Declare the symbolic names for states 
parameter [2:0] 
    S1 = 3'b000, 
    S2 = 3'b001, 
    S3 = 3'b010, 
    S4 = 3'b011, 
     S5 = 3'b100, 
    S6 = 3'b101, 
    S7 = 3'b110; 
 
// Declare current state and next state variables 
reg [2:0] CS; 
reg [2:0] NS; 
 
// state_vector CS 
 
always @ (posedge CLOCK or posedge RESET) 
begin 
    if (RESET == 1'b1) 
             CS = S1; 
     else 
         CS = NS; 
end 
 
always @ (CS or A or B or C or D or D or E) 
begin 
case (CS) 
     S1 : 
     begin 
     MULTI  = 1'b0; 
     CONTIG = 1'b0; 
     SINGLE = 1'b0; 
     if (A && ~B && C)  
         NS = S2; 
     else if (A && B && ~C) 
         NS = S4; 
     else 
         NS = S1; 
     end 
endcase
end
endmodule
