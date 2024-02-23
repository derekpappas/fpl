     ///////////////////////////////////////////
    // MUX_GATE16.V Version 1.0              //
   // Xilinx HDL Synthesis Design Guide     //
  // 16x1 multiplexer implemented in gates //
 // September 1997                        //
///////////////////////////////////////////

module mux_gate16 (SEL, SIG, A, B, C, D, E, F,
                 G, H, I, J, K, L, M, N, O, P);

    input       A, B, C, D, E, F, G, H;
    input       I, J, K, L, M, N, O, P;
    input [3:0] SEL;
    output      SIG;

    reg         SIG;

    always @ (A or B or C or D or E or F or G or H or 
              I or J or K or L or M or N or O or P or SEL) 

    case (SEL)
        4'b0000: 
            SIG=A;
        4'b0001: 
            SIG=B;
        4'b0010: 
            SIG=C;
        4'b0011: 
            SIG=D;
        4'b0100: 
            SIG=E;
        4'b0101: 
            SIG=F;
        4'b0110: 
            SIG=G;
        4'b0111: 
            SIG=H;
        4'b1000: 
            SIG=I;
        4'b1001: 
            SIG=J;
        4'b1010: 
            SIG=K;
        4'b1011: 
            SIG=L;
        4'b1100: 
            SIG=M;
        4'b1101: 
            SIG=N;
        4'b1110: 
            SIG=O;
        default: 
            SIG=P;
    endcase

endmodule
