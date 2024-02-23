/**********************************************************
 *							  *
 *    Shell description for sdram behavioral model        *
 *							  *
 *   ( Simulation output DQ file generation routine )     *
 *							  *
 **********************************************************
 *                          Author : S. K. Cho            *
 *                          Revision date : 97.07.24      *
 **********************************************************
*/

`timescale    1ns / 100ps

module sdram_2mx32 (CLK, CKE, CSB, RASB, CASB, WEB, BADDR, ADDR, DQM, DQ);
input CLK;
input CKE;
input CSB;
input RASB;
input CASB;
input WEB;
input [1:0] BADDR;
input [10:0] ADDR;
input [3:0] DQM;
inout [31:0] DQ;



wire [3:0] opcode = {CSB, RASB, CASB, WEB};
wire [12:0] address = {BADDR, ADDR};

initial begin
$dumpvars(2);
$timeformat(-9, 1, " ns", 10);
end

integer dq_state, clocknum;
initial 
begin
  clocknum = 0;
  dq_state = $fopen("dq_state.list"); if(dq_state == 0) $finish;
end
  

always @(posedge CLK) begin
  if ($time > 15) begin
  case (opcode)
  4'b0000 : $fdisplay(dq_state,"%d (%t): MRS\t\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
  4'b0001 : $fdisplay(dq_state,"%d (%t): REFRESH\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
  4'b0010 : if (BADDR==2'b00) $fdisplay(dq_state,"%d (%t): PRECH(A)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b01) $fdisplay(dq_state,"%d (%t): PRECH(B)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b10) $fdisplay(dq_state,"%d (%t): PRECH(C)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b11) $fdisplay(dq_state,"%d (%t): PRECH(D)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (ADDR[10]==1'b1) $fdisplay(dq_state,"%d (%t): PRECH(ALL)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
  4'b0011 : if (BADDR==2'b00) $fdisplay(dq_state,"%d (%t): ACTIVE(A)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b01) $fdisplay(dq_state,"%d (%t): ACTIVE(B)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b10) $fdisplay(dq_state,"%d (%t): ACTIVE(C)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b11) $fdisplay(dq_state,"%d (%t): ACTIVE(D)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
  4'b0100 : if (BADDR==2'b00 && ~ADDR[10]) $fdisplay(dq_state,"%d (%t): WRITE(A)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b00 && ADDR[10]) $fdisplay(dq_state,"%d (%t): WRITE_AP(A)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b01 && ~ADDR[10]) $fdisplay(dq_state,"%d (%t): WRITE(B)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b01 && ADDR[10]) $fdisplay(dq_state,"%d (%t): WRITE_AP(B)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b10 && ~ADDR[10]) $fdisplay(dq_state,"%d (%t): WRITE(C)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b10 && ADDR[10]) $fdisplay(dq_state,"%d (%t): WRITE_AP(C)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b11 && ~ADDR[10]) $fdisplay(dq_state,"%d (%t): WRITE(D)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b11 && ADDR[10]) $fdisplay(dq_state,"%d (%t): WRITE_AP(D)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
  4'b0101 : if (BADDR==2'b00 && ~ADDR[10]) $fdisplay(dq_state,"%d (%t): READ(A)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b00 && ADDR[10]) $fdisplay(dq_state,"%d (%t): READ_AP(A)\t  %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b01 && ~ADDR[10]) $fdisplay(dq_state,"%d (%t): READ(B)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b01 && ADDR[10]) $fdisplay(dq_state,"%d (%t): READ_AP(B)\t  %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b10 && ~ADDR[10]) $fdisplay(dq_state,"%d (%t): READ(C)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b10 && ADDR[10]) $fdisplay(dq_state,"%d (%t): READ_AP(C)\t  %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b11 && ~ADDR[10]) $fdisplay(dq_state,"%d (%t): READ(D)\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
            else if (BADDR==2'b11 && ADDR[10]) $fdisplay(dq_state,"%d (%t): READ_AP(D)\t  %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
  4'b0110 : $fdisplay(dq_state,"%d (%t): BURSTOP\t %b      %b      %h (%b) ", clocknum, $realtime, address, DQM, DQ, DQ);
  default : $fdisplay(dq_state,"%d (%t):\t \t \t \t    %b      %h (%b) ", clocknum, $realtime, DQM, DQ, DQ);
  endcase
  end

 clocknum = clocknum + 1;
end


sdram i1(CLK, CSB, CKE, BADDR, ADDR, RASB, CASB, WEB, DQM, DQ);

endmodule

`include "./sdram.vp"
