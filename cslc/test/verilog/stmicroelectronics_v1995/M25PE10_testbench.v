/*=========================================================

Testbench for M25PE10 SPI Bus Flash Memory

=========================================================*/

`include "M25PE10_macro.v"

//=========================================================
module M25PE10_TB;

//---------------------------------------------------------
wire c,d,q,s,tsl,reset,vcc,vss;

//---------------------------------------------------------
//Memory Array Initial
//---------------------------------------------------------
initial begin
  $display("%t: NOTE: Load Memory with Initial Content.",$realtime);
  $readmemh("M25PE10_initial.txt",U_M25PE10.memory);
  $display("%t: NOTE: Load Memory Successfully.\n",$realtime);
end

//---------------------------------------------------------
//Memory Model Instance
//---------------------------------------------------------
M25PE10_MEMORY U_M25PE10(.C(c),.D(d),.Q(q),.S(s),.TSL(tsl),.RESET(reset),.VCC(vcc),.VSS(vss));

//---------------------------------------------------------
//Memory Stimuli Instance
//---------------------------------------------------------
M25PE10_DRIVER D_M25PE10(.C(c),.D(d),.Q(q),.S(s),.TSL(tsl),.RESET(reset),.VCC(vcc),.VSS(vss));

endmodule