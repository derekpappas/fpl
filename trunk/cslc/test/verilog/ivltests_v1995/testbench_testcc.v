module testbench_setcc;

// This is the top most file. The testcc module will be instantiated within
// this file.

wire [3:0] brcode;
wire c,z,n,v,result,clk;


// Instantiate the design under verification
testcc test_condition(brcode,c,z,n,v,result);

// This file drives the inputs of the DUV
// data_generator datagen(brcode,c,z,n,v,clk);
random_data_generator datagen(brcode,c,z,n,v,clk);

 
// This module acts as an checker comparing DUV o/p with predicted output
checker check(brcode,c,z,n,v,result,clk);

// Instantiate Oscillator
oscillator osc(clk,clk_n);

endmodule
