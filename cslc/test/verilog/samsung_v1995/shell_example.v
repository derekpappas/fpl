/*******************************************************************
 *							           *
 *        Shell description for sgddr behavioral model             *
 *							           *
 *   ( Simulation output DQ file generation routine for SGDDR)     *
 *							           *
 *******************************************************************
 *                          Author : S. K. Cho                     *
 *                          Author : Y. C. Bae                     *
 *                          Revision : K. H. Kim                   *
 *                          Revision date : 99.07.08               *
 *******************************************************************
*/

`timescale    1ns / 10ps

module SGDDR_128M(CLK, CLKB, CSB, RASB, CASB, WEB, BA, ADDR, DQ, DQS, CKE, DM);
inout   [31:0]  DQ;
input   [1:0]   BA;
input   [11:0]  ADDR;
input           RASB,CASB,WEB;
input           CLK,CLKB,CKE,CSB;
input   [3:0]   DM;
inout   [3:0]   DQS;  

////`protect

reg DSF;

wire [4:0] opcode = {CSB, RASB, CASB, WEB, DSF};
wire [13:0] address = {BA, ADDR};

reg WBE,VBL,PRT,UPDN;

initial
begin
  DSF = 0;
end


initial begin
$dumpvars();
$dumpfile("bm.dump"); 
$timeformat(-9, 3, " ns", 10);
end

integer dq_state, clocknum;
initial 
begin
  clocknum = 0;
  dq_state = $fopen("dq_state.list"); 
  if(dq_state == 0) $finish;
end
  
always @(posedge CLK or negedge CLK) begin
  if ($realtime > 35) begin
  #0.50  
  case (opcode)
 5'b00000 : $fdisplay(dq_state,"%d (%t): MRS\t\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b00001 : $fdisplay(dq_state,"%d (%t): SMRS\t\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b0001x : $fdisplay(dq_state,"%d (%t): REFRESH\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b00010 : $fdisplay(dq_state,"%d (%t): REFRESH\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b00011 : $fdisplay(dq_state,"%d (%t): REFRESH\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b0010x : if (BA==2'b00) $fdisplay(dq_state,"%d (%t): PRECH(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01) $fdisplay(dq_state,"%d (%t): PRECH(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10) $fdisplay(dq_state,"%d (%t): PRECH(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11) $fdisplay(dq_state,"%d (%t): PRECH(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (ADDR[8]==1'b1) $fdisplay(dq_state,"%d (%t): PRECH(ALL)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b00100 : if (BA==2'b00) $fdisplay(dq_state,"%d (%t): PRECH(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01) $fdisplay(dq_state,"%d (%t): PRECH(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10) $fdisplay(dq_state,"%d (%t): PRECH(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11) $fdisplay(dq_state,"%d (%t): PRECH(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (ADDR[8]==1'b1) $fdisplay(dq_state,"%d (%t): PRECH(ALL)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b00101 : if (BA==2'b00) $fdisplay(dq_state,"%d (%t): PRECH(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01) $fdisplay(dq_state,"%d (%t): PRECH(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10) $fdisplay(dq_state,"%d (%t): PRECH(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11) $fdisplay(dq_state,"%d (%t): PRECH(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (ADDR[8]==1'b1) $fdisplay(dq_state,"%d (%t): PRECH(ALL)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b0011x : if (BA==2'b00) $fdisplay(dq_state,"%d (%t): ACTIVE(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01) $fdisplay(dq_state,"%d (%t): ACTIVE(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10) $fdisplay(dq_state,"%d (%t): ACTIVE(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11) $fdisplay(dq_state,"%d (%t): ACTIVE(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b00110 : if (BA==2'b00) $fdisplay(dq_state,"%d (%t): ACTIVE(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01) $fdisplay(dq_state,"%d (%t): ACTIVE(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10) $fdisplay(dq_state,"%d (%t): ACTIVE(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11) $fdisplay(dq_state,"%d (%t): ACTIVE(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b00111 : if (BA==2'b00) $fdisplay(dq_state,"%d (%t): ACTIVE(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01) $fdisplay(dq_state,"%d (%t): ACTIVE(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10) $fdisplay(dq_state,"%d (%t): ACTIVE(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11) $fdisplay(dq_state,"%d (%t): ACTIVE(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b01000 : if (BA==2'b00 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): WRITE(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b00 && ADDR[8]) $fdisplay(dq_state,"%d (%t): WRITE_AP(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): WRITE(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ADDR[8]) $fdisplay(dq_state,"%d (%t): WRITE_AP(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): WRITE(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ADDR[8]) $fdisplay(dq_state,"%d (%t): WRITE_AP(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): WRITE(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ADDR[8]) $fdisplay(dq_state,"%d (%t): WRITE_AP(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b01001 : if (BA==2'b00 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): BLKWRITE(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b00 && ADDR[8]) $fdisplay(dq_state,"%d (%t): BLKWRITE_AP(A)\t %b     %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): BLKWRITE(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ADDR[8]) $fdisplay(dq_state,"%d (%t): BLKWRITE_AP(B)\t %b     %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): BLKWRITE(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ADDR[8]) $fdisplay(dq_state,"%d (%t): BLKWRITE_AP(C)\t %b     %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): BLKWRITE(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ADDR[8]) $fdisplay(dq_state,"%d (%t): BLKWRITE_AP(D)\t %b     %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b0101x : if (BA==2'b00 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b00 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b01010 : if (BA==2'b00 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b00 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b01011 : if (BA==2'b00 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b00 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(A)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b01 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(B)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b10 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(C)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ~ADDR[8]) $fdisplay(dq_state,"%d (%t): READ(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
           else if (BA==2'b11 && ADDR[8]) $fdisplay(dq_state,"%d (%t): READ_AP(D)\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b0110x : $fdisplay(dq_state,"%d (%t): BURSTOP\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b01100 : $fdisplay(dq_state,"%d (%t): BURSTOP\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 5'b01101 : $fdisplay(dq_state,"%d (%t): BURSTOP\t %b      %b  %b  %h (%b) ", clocknum, $realtime, address, DM, DQS, DQ, DQ);
 default : $fdisplay(dq_state,"%d (%t): \t \t \t \t    %b  %b  %h (%b) ", clocknum, $realtime, DM, DQS, DQ, DQ);
 endcase
  end

 clocknum = clocknum + 1;
end

defparam i1.pwrup_check=0;

SGRAM_128M i1 (CLK, CLKB, CKE, BA, ADDR, CSB, RASB, CASB, WEB, DM, DQ, DQS);
endmodule

`include "./SGDDR_4Mx32_BGA.vp"
