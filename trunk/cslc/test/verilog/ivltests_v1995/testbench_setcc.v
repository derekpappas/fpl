module testbench_setcc;

// This is the top most file. The setcc module will be instantiated within
// this file.
parameter width = 32;
wire [width-1:0] op1,op2;
wire [width:0] result;

wire add,sub,cmp; 

// Instantiate the design under verification
setcc set_condition(op1,op2,result,add,sub,cmp,c,z,n,v);

// This file drives the inputs of the DUV
// data_generator datagen(op1,op2,result,add,sub,cmp,clk);
random_data_generator datagen(op1,op2,result,add,sub,cmp,clk);

 
// This module acts as an checker comparing DUV o/p with predicted output
checker check(op1,op2,result,add,sub,cmp,c,z,n,v,clk);

// Instantiate Oscillator
oscillator osc(clk,clk_n);

endmodule