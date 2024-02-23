//-----------------------------------------------------------------------------
// Title         : 4-1 multiplexer
// Project       : ECE 313 - Computer Organization
//-----------------------------------------------------------------------------
// File          : mux4.v
// Author        : John Nestor  <nestorj@lafayette.edu>
// Organization  : Lafayette College
// 
// Created       : October 2002
// Last modified : 7 January 2005
//-----------------------------------------------------------------------------
// Description :
//   Parameterized 4-1 mux  used in the implementations of the MIPS processor
//   subset described in Ch. 5-6 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//-----------------------------------------------------------------------------

module mux4(s, d0, d1, d2, d3, y);
    parameter bitwidth=32;
    input  [1:0]          s;
    input  [bitwidth-1:0] d0, d1, d2, d3;
    output [bitwidth-1:0] y;
    reg    [bitwidth-1:0] y;

    always @(d0 or d1 or d2 or d3 or s) 
        case ( s)
           2'd0 : y = d0;
	    2'd1 : y = d1;
	    2'd2 : y = d2;
           2'd3 : y = d3;
           default : y = {bitwidth{1'bx}};
       endcase
endmodule
