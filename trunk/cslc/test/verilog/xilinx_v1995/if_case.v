     ////////////////////////////////////////
    // IF_CASE.V Version 1.0              //
   // Xilinx HDL Synthesis Design Guide  //
  // Nested If vs. Case Design Example  //
 // August 1997                        //
////////////////////////////////////////

module if_case (ADDR_A, ADDR_B, ADDR_C, ADDR_D, RESET, CLK, DEC_Q);

    input  [1:0]  ADDR_A ;
    input  [1:0]  ADDR_B ;
    input  [1:0]  ADDR_C ;
    input  [1:0]  ADDR_D ;
    input         RESET, CLK ;
    output [5:0]  DEC_Q ;

    wire   [7:0]  ADDR_ALL ;
    reg    [5:0]  DEC_Q ;

    // Concatenate all address lines //
    assign ADDR_ALL = {ADDR_A, ADDR_B, ADDR_C, ADDR_D} ;

    // Use 'case' instead of 'nested_if' for efficient gate netlist //
    always @ (posedge CLK)
        begin
        if (RESET == 1'b1)
            begin
                casex (ADDR_ALL)
                    8'b00011011: begin
                                 DEC_Q[5:4] <= 2'b00;  
                                 DEC_Q[3:2] <= ADDR_A + 1;
                                 DEC_Q[1:0] <= ADDR_B + 1'b1;
                                 end
                    8'b000110xx: begin
                                 DEC_Q[5:4] <= ADDR_D + 1'b1;
                                 DEC_Q[3:2] <= ADDR_A + 1'b1;
                                 DEC_Q[1:0] <= ADDR_B + 1'b1;
                                 end
                    8'b0001xxxx: begin
                                 DEC_Q[5:4] <= ADDR_D;
                                 DEC_Q[3:2] <= ADDR_A + 1'b1;
                                 DEC_Q[1:0] <= ADDR_B + 1'b1;
                                 end
                    8'b00xxxxxx: begin
                                 DEC_Q[5:4] <= ADDR_D;
                                 DEC_Q[3:2] <= 2'b01;
                                 DEC_Q[1:0] <= 2'b00;
                                 end
                    default:     begin
                                 DEC_Q[5:4] <= ADDR_D;
                                 DEC_Q[3:2] <= ADDR_A;
                                 DEC_Q[1:0] <= ADDR_B + 1'b1;
                                 end
                endcase
            end
        else
            DEC_Q <= 6'b000000;
        end

endmodule
