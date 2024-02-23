/*
 * Copyright (c) 2001 Stephan Boettcher <stephan@nevis.columbia.edu>
 *
 *    This source code is free software; you can redistribute it
 *    and/or modify it in source code form under the terms of the GNU
 *    General Public License as published by the Free Software
 *    Foundation; either version 2 of the License, or (at your option)
 *    any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 */

// $Id: udp_lfsr.v,v 1.1 2001/10/27 23:38:29 sib4 Exp $

module test_lfsr;

   reg   cp;
   reg 	 in;
   wire  out;
   reg 	 reset;
   lfsr sr(cp, reset, in, out);
   
   reg 	 errors;
   initial errors = 0;
   integer i;
   
   initial
     begin
        in = 0;
	cp = 0;
	#2 reset = 1;
	#2 reset = 0;
	#1;
	for (i=0; i<512; i=i+1)
	  #5 cp = ~cp;

        in = 0;
	cp = 0;
	#2 reset = 1;
	#2 reset = 0;
	#1;
	for (i=0; i<512; i=i+1)
	  #5 cp <= ~cp;

	#5;
	if (errors == 0)
	  $display("PASSED");
	#10 $finish;
     end

   reg [7:0] here;
   reg [7:0] next;
   reg [7:0] old;
   reg [7:0] new;
   
   always @(reset)
     if (reset)
       begin
	  here = 1;
	  #1;
	  old = {out, sr.s};
	  if (old === here)
	    begin
	       $display("%b RESET", old);
	    end
	  else
	    begin
	       $display("%b RESET FAILED: expect %b", old, here);
	       errors = 1;
	    end
       end

   always
     begin
	@(posedge cp) old = {out, sr.s};
	next = {here[6:0], ^(here & sr.P) ^ in};
	@(negedge cp) new = {out, sr.s};
	if (old != here || new !== next)
	  begin
	     $display("%b->%b FAILED: expect %b->%b", old, new, here, next);
	     errors = 1;
	  end
	else
	  begin
	     $display("%b->%b", old, new);
	  end
	here = next;
     end

endmodule

module lfsr (clk, reset, in, out);

   parameter 	  P = 8'b 1101_1001;

   input 	  clk;
   input 	  reset;
   input 	  in;

   output 	  out;
   wire [6:0] 	  s;
   wire 	  i = ^{P & {out,s}} ^ in;	  
 	  
   jkff ff1 (s[0], clk, i,    ~i,    reset, 0);
   jkff ff2 (s[1], clk, s[0], ~s[0], 0, reset);
   jkff ff3 (s[2], clk, s[1], ~s[1], 0, reset);
   jkff ff4 (s[3], clk, s[2], ~s[2], 0, reset);

   jkff ff8 (out,  clk, s[6], ~s[6], 0, reset);
   jkff ff7 (s[6], clk, s[5], ~s[5], 0, reset);
   jkff ff6 (s[5], clk, s[4], ~s[4], 0, reset);
   jkff ff5 (s[4], clk, s[3], ~s[3], 0, reset);
   
endmodule

primitive jkff(q, cp, j, k, s, r);
   output q;
   input  cp, j, k, s, r;
   reg 	  q;
   table
   // (cp)  j  k  s   r  :  q  :  q  ;
        ?   ?  ? (? 0) 0  :  ?  :  -  ;
        ?   ?  ?  0 (? 0) :  ?  :  -  ;
        ?   *  ?  0   0  :  ?  :  -  ;
        ?   ?  *  0   0  :  ?  :  -  ;
        ?   ?  ?  1   0  :  ?  :  1  ;
        ?   ?  ?  0   1  :  ?  :  0  ;
        ?   ?  ?  x   0  :  1  :  1  ;
        ?   ?  ?  0   x  :  0  :  0  ;
      (? 0)  ?  ?  0   0  :  ?  :  -  ;
      (1 x)  ?  ?  0   0  :  ?  :  -  ;
      (? 1)  0  ?  0   0  :  0  :  0  ;
      (? 1)  ?  0  0   0  :  1  :  1  ;
      (0 x)  0  ?  0   0  :  0  :  0  ;
      (0 x)  ?  0  0   0  :  1  :  1  ;
      (0 1)  1  ?  0   0  :  0  :  1  ;
      (0 1)  ?  1  0   0  :  1  :  0  ;
      (0 1)  1  0  0   0  :  x  :  1  ;
      (0 1)  0  1  0   0  :  x  :  0  ;
   endtable
endprimitive
