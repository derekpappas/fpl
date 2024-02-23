     ////////////////////////////////////////
    // NESTED_IF.V Version 1.0            //
   // Xilinx HDL Synthesis Design Guide  //
  // Nested If vs. Case Design Example  //
 // August 1997                        //
////////////////////////////////////////

module nested_if (ADDR_A, ADDR_B, ADDR_C, ADDR_D, RESET, CLK, DEC_Q);

    input  [1:0]  ADDR_A ;
    input  [1:0]  ADDR_B ;
    input  [1:0]  ADDR_C ;
    input  [1:0]  ADDR_D ;
    input         RESET, CLK ;
    output [5:0]  DEC_Q ;

    reg    [5:0]  DEC_Q ;

    //  Nested If Process  //
    always @ (posedge CLK)
        begin
        if (RESET == 1'b1)
            begin
            if (ADDR_A == 2'b00)
                begin
                DEC_Q[5:4] <= ADDR_D;
                DEC_Q[3:2] <= 2'b01;
                DEC_Q[1:0] <= 2'b00;
                if (ADDR_B == 2'b01)
                    begin
                    DEC_Q[3:2] <= ADDR_A + 1'b1;
                    DEC_Q[1:0] <= ADDR_B + 1'b1;
                    if (ADDR_C == 2'b10)
                        begin
                        DEC_Q[5:4] <= ADDR_D + 1'b1;
                        if (ADDR_D == 2'b11)
                            DEC_Q[5:4] <= 2'b00;
                        end
                    else
                        DEC_Q[5:4] <= ADDR_D;
                    end
                end
            else
                DEC_Q[5:4] <= ADDR_D;
                DEC_Q[3:2] <= ADDR_A;
                DEC_Q[1:0] <= ADDR_B + 1'b1;
            end
        else
            DEC_Q <= 6'b000000;
        end

endmodule
