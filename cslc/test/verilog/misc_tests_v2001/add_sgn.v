module add_signal();
    wire [15:0]stim_vec;
    wire [3:0] sgn1, sgn2;
    wire [7:0] sgn3;
    
    unit unit_a(sgn1, sg2, sgn3);
    //add sihnals to the vector
    assign stim_vec={sgn1, sgn2, sgn3};
endmodule