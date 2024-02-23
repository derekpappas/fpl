// Copyright (C) 1991-2002 Altera Corporation
// Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
// support information,  device programming or simulation file,  and any other
// associated  documentation or information  provided by  Altera  or a partner
// under  Altera's   Megafunction   Partnership   Program  may  be  used  only
// to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
// other  use  of such  megafunction  design,  netlist,  support  information,
// device programming or simulation file,  or any other  related documentation
// or information  is prohibited  for  any  other purpose,  including, but not
// limited to  modification,  reverse engineering,  de-compiling, or use  with
// any other  silicon devices,  unless such use is  explicitly  licensed under
// a separate agreement with  Altera  or a megafunction partner.  Title to the
// intellectual property,  including patents,  copyrights,  trademarks,  trade
// secrets,  or maskworks,  embodied in any such megafunction design, netlist,
// support  information,  device programming or simulation file,  or any other
// related documentation or information provided by  Altera  or a megafunction
// partner, remains with Altera, the megafunction partner, or their respective
// licensors. No other licenses, including any licenses needed under any third
// party's intellectual property, are provided herein.

module magnitude(
	clk,
	clken,
	aclr,
	vectorX,
	vectorY,
	magnitude
);

input	clk;
input   clken;
input   aclr;
input	[8:0] vectorX;
input	[8:0] vectorY;
output	[9:0] magnitude;


parameter IN_PREC = 20;
parameter OUT_PREC = 10;
parameter PIPELINE = "YES";


wire [19:0] squares_w;
wire [19:0] squares;
wire [9:0] magnitude_w;
reg [19:0] squares_pipe;
reg [9:0] magnitude_pipe;



square_number	b2v_inst(.clock0(clk),.dataa_0(vectorX),.dataa_1(vectorY),.datab_0(vectorX),.datab_1(vectorY),.result(squares_w[18:0]));
defparam b2v_inst.PIPELINE = PIPELINE;


root_pipeline_wrapper	b2v_inst2(.clk(clk),.clken(clken),.aclr(aclr),.rad(squares_pipe),.root(magnitude_w));
defparam	b2v_inst2.PREC = OUT_PREC;
defparam	b2v_inst2.WIDTH = IN_PREC;
defparam    b2v_inst2.PIPELINE = PIPELINE;


assign	squares_w[19] = 0;
assign	squares[19:0] = squares_w[19:0];
assign  magnitude = magnitude_pipe;

always @ (posedge clk or posedge aclr) 
begin
   if (aclr)
	  begin
         squares_pipe = 0;
	     magnitude_pipe = 0;
	  end
   else if (clken)
      begin
         squares_pipe = squares;
         magnitude_pipe = magnitude_w;
      end
   end
endmodule
