module unbonded_io (A, B, CLK, Q_OUT); 


input A, B, CLK; 

output Q_OUT; 


wire[3:0] U_Q; 

wire U_D; 


assign U_D = A & B; 

assign Q_OUT = U_Q[0]; 


    OFD_U U3 (.Q(U_Q[3]), .D(U_D), .C(CLK)); 

    IFDI_U U2 (.Q(U_Q[2]), .D(U_Q[3]), .C(CLK)); 


    OFDI_U U1 (.Q(U_Q[1]), .D(U_Q[2]), .C(CLK)); 


    IFD_U U0 (.Q(U_Q[0]), .D(U_Q[1]), .C(CLK)); 

endmodule 

