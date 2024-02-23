module testbench_mem;

// This is the top most file. The mem_mod module will be instantiated within
// this file. 
parameter width = 32;

wire [width-1:0] data_out,data_in,address;
wire write;


// Instantiate the Design Under Verification (DUV)
mem_mod memory(data_out,data_in,address,write,,,,1'b1);

// This file drives the inputs of the DUV
rnd_data_generator datagen(data_in,address,write,clk);

// This module acts as an checker comparing DUV o/p with predicted output
checker check(data_out,data_in,address,write);

// Instantiate Oscillator
oscillator osc(clk,clk_n);

endmodule