module one_hot (CLOCK, RESET, A, B, C, D, E, 
              SINGLE, MULTI, CONTIG); 
 
input   CLOCK, RESET; 
input   A, B, C, D, E; 
output  SINGLE, MULTI, CONTIG; 
 
reg SINGLE, MULTI, CONTIG; 
 
// Declare the symbolic names for states 
parameter [6:0] 
    S1 = 7'b0000001,   
    S2 = 7'b0000010, 
    S3 = 7'b0000100, 
    S4 = 7'b0001000, 
    S5 = 7'b0010000, 
    S6 = 7'b0100000, 
    S7 = 7'b1000000; 
 
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
