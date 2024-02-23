     /////////////////////////////////////////////////
    // MUX_TBUF16.V Version 1.0                    //
   // Xilinx HDL Synthesis Design Guide           //
  // 16x1 multiplexer implemented in tri-states  //
 // September 1997                              //
/////////////////////////////////////////////////

module mux_tbuf16 (SEL, SIG, A, B, C, D, E, F,
                   G, H, I, J, K, L, M, N, O, P);

    input        A, B, C, D, E, F, G, H;
    input        I, J, K, L, M, N, O, P;
    input [15:0] SEL;
    output       SIG;
 
    reg          SIG;

    always @ (SEL or A) 
        begin
        if (SEL[0]==1'b0) 
            SIG=A;
        else
            SIG=1'bz;
        end

     always @ (SEL or B) 
         begin
         if (SEL[1]==1'b0)
             SIG=B;
         else
             SIG=1'bz;
         end

     always @ (SEL or C) 
         begin
         if (SEL[2]==1'b0)
             SIG=C;
         else 
             SIG=1'bz;
         end

     always @ (SEL or D) 
         begin
         if (SEL[3]==1'b0)
              SIG=D;
         else
              SIG=1'bz;
         end

     always @ (SEL or E) 
         begin
         if (SEL[4]==1'b0)
              SIG=E;
         else
              SIG=1'bz;
         end

     always @ (SEL or F) 
         begin
         if (SEL[5]==1'b0)
              SIG=F;
         else
              SIG=1'bz;
         end

     always @ (SEL or G) 
         begin
         if (SEL[6]==1'b0)
              SIG=G;
         else
              SIG=1'bz;
         end

     always @ (SEL or H) 
         begin
         if (SEL[7]==1'b0)
              SIG=H;
         else
              SIG=1'bz;
         end

     always @ (SEL or I) 
         begin
         if (SEL[8]==1'b0)
              SIG=I;
         else
              SIG=1'bz;
         end

     always @ (SEL or J) begin
         if (SEL[9]==1'b0)
              SIG=J;
         else
              SIG=1'bz;
         end

     always @ (SEL or K) 
         begin
         if (SEL[10]==1'b0)
              SIG=K;
         else
              SIG=1'bz;
         end

     always @ (SEL or L) 
         begin
         if (SEL[11]==1'b0)
              SIG=L;
         else
              SIG=1'bz;
         end

     always @ (SEL or M) 
         begin
         if (SEL[12]==1'b0)
              SIG=M;
         else
              SIG=1'bz;
         end

     always @ (SEL or N) 
         begin
         if (SEL[13]==1'b0)
              SIG=N;
         else
              SIG=1'bz;
         end

     always @ (SEL or O) 
         begin
         if (SEL[14]==1'b0)
              SIG=O;
         else
              SIG=1'bz;
         end

     always @ (SEL or P) 
         begin
         if (SEL[15]==1'b0)
              SIG=P;
         else
              SIG=1'bz;
         end

endmodule
