/*
   General introduction to Verilog code

   Example of an inverting multiplexor done is several
   coding styles
*/

// behavioural-level description of an inverting multiplexor
module mux_beh (out, cnt, a, b);
   output out;
   input  cnt, a, b;
   reg      out;

   always @(cnt or a or b)
      if (cnt == 1) out = ~a;
      else out = ~b;

endmodule // mux_gate

// behavioural-level description of an inverting multiplexor
module mux_beh_2 (out, cnt, a, b);
   output out;
   input  cnt, a, b;

   assign out = (cnt == 1) ? ~a: ~b;

endmodule // mux_gate

// functional-level description of an inverting multiplexor
module mux_func (out, cnt, a, b);
   output out;
   input  cnt, a, b;

   assign out = ~((cnt & a) |(~cnt & b));

endmodule // mux_gate

// gate-level description of an inverting multiplexor
module mux_gate (out, cnt, a, b);
   output out;
   input  cnt, a, b;

   wire     cntBar;
   wire     aval, bval;

   not (cntBar, cnt);
   and (aval, cnt, a);
   and (bval, cntBar, b);
   nor (out, aval, bval);

endmodule // mux_gate

// NECESSARY TEST stimulus to verify designs
module stimulus;
   reg    a, b, c;
   wire   out1, out2, out3, out4;
   integer i;

   mux_beh_2 mod1 (out1, c, a, b);
   mux_beh   mod2 (out2, c, a, b);
   mux_func  mod3 (out3, c, a, b);
   mux_gate  mod4 (out4, c, a, b);

   initial begin
      for (i = 0; i < 8; i = i + 1) begin
      {a, b, c} = i[2:0];
      #10 $display ($time, " %b %b %b  -  %b %b %b %b",
                 a, b, c, out1, out2, out3, out4);
      end
      #10 $finish;
   end // initial begin

endmodule // stimulus


