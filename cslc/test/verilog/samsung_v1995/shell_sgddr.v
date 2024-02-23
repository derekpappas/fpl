`timescale    1ns / 10ps

module SGDDR_64M (CLK, CLKB, CSB, RASB, CASB, WEB, BA, ADDR, DQ, DQS, CKE, DM);
inout   [31:0]  DQ;
input   [1:0]   BA;
input   [10:0]  ADDR;
input           RASB,CASB,WEB;
input           CLK,CLKB,CKE,CSB;
input   [3:0]   DM;
inout           DQS;

reg DSF;

wire [4:0] opcode = {CSB, RASB, CASB, WEB, DSF};
wire [12:0] address = {BA, ADDR};

reg WBE,VBL,PRT,UPDN;

initial 
begin
  DSF = 0;
end

defparam i1.pwrup_check=0;

SGRAM_64M  i1 (CLK, CLKB, CKE, BA, ADDR, CSB, RASB, CASB, WEB, DM, DQ, DQS);
endmodule

`include "SGDDR_64M_rev03.vp"
