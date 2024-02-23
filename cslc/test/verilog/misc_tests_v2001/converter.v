module delay_line(clk,del_out,out_dll);
  input clk;
  output [31:0] del_out;
  output out_dll;
endmodule
module mux(mux_in,mux_sel,mux_out);
  input [31:0] mux_in;
  input [4:0] mux_sel;
  output mux_out;
endmodule
module delay_gen(in_gen,ctrl_gen,out_gen);
  input in_gen;
  input [6:0] ctrl_gen;
  output out_gen;
endmodule
module ff(d,clk,q);
  input d;
  input clk;
  output q;
endmodule
module converter(clk,ext_sgn,k_sgn,out_sgn);
  input clk,ext_sgn;
  input [11:0] k_sgn;
  output out_sgn;
  wire out_dll, out_mux, out_gen,sgn;
  wire [4:0] mux_sel;
  wire [6:0] ctrl_gen;
  wire [31:0] del_out;
  assign k_sgn = {mux_sel,ctrl_gen};
  mux mux(.mux_in(del_out), .mux_sel(mux_sel), .mux_out(mux_out));
  delay_gen del_gen(.in_gen(out_dll), .ctrl_gen(ctrl_gen), .out_gen(out_gen));
  ff ff0(.d(ext_sgn), .clk(out_mux), .q(sgn));
  ff ff1(.d(sgn), .clk(out_gen), .q(out_sgn));
endmodule

