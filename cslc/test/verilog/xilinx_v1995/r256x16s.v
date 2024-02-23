module r256x16s ( 
      addr, 
      di, 
      clk, 
      we, 
      en, 
      rst, 
      do); //synthesis syn_black_box 
input [7:0] addr; 
input [15:0] di; 
input clk; 
input we; 
input en; 
input rst; 
output [15:0] do; 
endmodule 
module top (addrp, dip, clkp, wep, enp, rstp, dop); 
input [7:0] addrp; 
input [15:0] dip; 
input clkp; 
input wep; 
input enp; 
input rstp; 
output [15:0] dop; 
r256x16s U0( 
        .addr(addrp), 
        .di(dip), 
        .clk(clkp), 
        .we(wep), 
        .en(enp), 
        .rst(rstp), 
        .do(dop)); 
endmodule 
