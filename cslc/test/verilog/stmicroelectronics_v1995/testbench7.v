// Author: Hugues CREUSY
// FEBRUARY 2004
// Verilog model
// project: M25P32 50 MHz,
// release: 1.0


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
   defparam memory.mem_access.initfile = "initmemory.txt"; // modification introduced on 14/11/02
                                                                                              // to override initialization different from FFh
   
   m25p32 memory (.c(clock), .data_in(data), .s(select), .w(w), .hold(hold), .data_out(out)); 
   m25p32_driver tester (.clk(clock), .din(data), .cs_valid(select), .hard_protect(w), .hold(hold)); 
   
endmodule
