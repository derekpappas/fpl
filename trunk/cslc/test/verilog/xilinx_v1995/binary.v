module binary (CLOCK, RESET, A, B, C, D, E, SINGLE, MULTI, CONTIG);


input CLOCK, RESET; 

input A, B, C, D, E; 

output SINGLE, MULTI, CONTIG; 


reg SINGLE, MULTI, CONTIG; 

// Declare the symbolic names for states 

parameter [2:0] 

    S1 = 3'b001, 

    S2 = 3'b010, 

    S3 = 3'b011, 

    S4 = 3'b100, 

    S5 = 3'b101, 

    S6 = 3'b110, 

    S7 = 3'b111; 


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

              MULTI = 1'b0; 

              CONTIG = 1'b0; 

              SINGLE = 1'b0; 

            if (A && ~B && C) 

              NS = S2; 

            else if (A && B && ~C) 

              NS = S4; 

            else 

              NS = S1; 

            end 

            S2 : 

            begin 

              MULTI = 1'b1; 

              CONTIG = 1'b0; 

              SINGLE = 1'b0; 

            if (!D) 

                NS = S3; 

            else 

                NS = S4; 

            end 

            S3 : 

            begin 

              MULTI = 1'b0; 

              CONTIG = 1'b1; 

              SINGLE = 1'b0; 

              if (A || D) 

                  NS = S4; 

              else 

                NS = S3; 

              end 


            S4 : 

            begin 

              MULTI = 1'b1; 

              CONTIG = 1'b1; 

              SINGLE = 1'b0; 

              if (A && B && ~C) 

                  NS = S5; 

              else 

                  NS = S4; 

              end 

            S5 : 

            begin 

              MULTI = 1'b1; 

              CONTIG = 1'b0; 

              SINGLE = 1'b0; 

              NS = S6; 

              end 

            S6 : 

            begin 

              MULTI = 1'b0; 

              CONTIG = 1'b1; 

              SINGLE = 1'b1; 

              if (!E) 

                  NS = S7; 

              else 

                  NS = S6; 

              end 

              S7 : 

              begin 

                MULTI = 1'b0; 

                CONTIG = 1'b1; 

                SINGLE = 1'b0; 

                if (E) 

                    NS = S1; 

                else 

                    NS = S7; 

              end 

        endcase 

    end 

endmodule 
