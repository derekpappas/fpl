// Title         : 32-Bit Register with Enable and Synchronous Reset
// Project       : ECE 313 - Computer Organization
//-----------------------------------------------------------------------------
// File          : reg32en2.v
// Author        : John Nestor  <nestorj@lafayette.edu>
// Organization  : Lafayette College
// 
// Created       : October 2002
// Last modified : 7 January 2005
//-----------------------------------------------------------------------------
// Description :
//   Simple 32-bit register with load enable and synchronous reset used in the
//   implementations of the MIPS processor subset described in Ch. 5-6 of "
//   Computer Organization and Design, 3rd ed." by David Patterson & John Hennessey,
//   Morgan Kaufmann, 2004 (COD3e).  
//
//-----------------------------------------------------------------------------

module reg32en (clk, reset, enable, d_in, d_out);
    input       	clk, reset, enable;
    input	[31:0]	d_in;
    output 	[31:0] 	d_out;
    reg 	[31:0]	 d_out;
   
    always @(posedge clk)
    begin
        if (reset) d_out <= 0;
        else if (enable) d_out <= d_in;
    end

endmodule
	
