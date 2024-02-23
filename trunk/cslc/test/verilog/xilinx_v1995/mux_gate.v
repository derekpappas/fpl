/* MUX_GATE.V  
* May 2001 */ 

 
module mux_gate (A,B,C,D,E,SEL,SIG); 
 
input A,B,C,D,E; 
input [2:0] SEL; 
output SIG; 
reg SIG; 
 
    always @ (A or B or C or D or SEL) 
    case (SEL) 
        3'b000: 
          SIG=A; 
        3'b001: 
          SIG=B; 
        3'b010: 
          SIG=C; 
        3'b011: 
          SIG=D; 
        3'b100: 
          SIG=E; 
default: SIG=A; 
    endcase 
endmodule 
