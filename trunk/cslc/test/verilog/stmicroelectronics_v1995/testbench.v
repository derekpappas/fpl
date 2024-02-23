// Author: Hugues CREUSY
// January 2004
// Verilog model
// project: M25P05A 25 MHz,
// release: 2.1



// These Verilog HDL models are provided "as is" without warranty
// of any kind, included but not limited to, implied warranty
// of merchantability and fitness for a particular purpose.


`timescale 1ns/1ns

module testbench();

   wire clock; 
   wire data; 
   wire w; 
   wire hold; 
   wire out; 
   wire select; 
   defparam memory.mem_access.initfile = "initmemory.txt"; 
   
   m25p05a        memory (.c(clock), .data_in(data), .s(select), .w(w), .hold(hold), .data_out(out)); 
   m25p05a_driver tester (.clk(clock), .din(data), .cs_valid(select), .hard_protect(w), .hold(hold)); 
   
endmodule
