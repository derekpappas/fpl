// Interleave, nor any of the other methods, give the arithmetic interleaving
// between "ic" and "tc" that is desirable for this example.

// Below is the .v file, and the desirable ordering file.  You can paramaterize
// the size of the example to n bits, by setting MSB to n-1 and MAX_NUM to 2^n -
// 1.  The files are for n=4.

/*============== Island Tunnel Controller Without Counters ==============*/

/* Enumerate type definition. This is an extension of Verilog allowed by VIS */
typedef enum {green, entering, red, exiting} ms_sort;
typedef enum {dispatch, iuse, muse, iclear, mclear} ts_sort;

`define MSB 3
`define MAX_NUM 15

/*============== Main module ==============*/

module main(clk,igl,irl,mgl,mrl,
	    );
input clk; //,  ie,ix,me,mx;
output igl,irl,mgl,mrl;

wire ie,ix,me,mx,igl,irl,mgl,mrl;
//wire igl,irl,mgl,mrl;
wire ic_plus,ic_minus,itc_plus,itc_minus,mtc_plus,mtc_minus;
wire [`MSB:0] tc,ic;

sensor sensor(clk, ie,ix,me,mx);
counter counter(clk,tc,ic,
		ic_plus,ic_minus,itc_plus,itc_minus,mtc_plus,mtc_minus);
island island(clk,ie,ix,igl,irl,ic_minus,itc_plus,itc_minus,iu,ir,ig,iy);
mainland mainland(clk,me,mx,mgl,mrl,ic,ic_plus,mtc_plus,mtc_minus,mu,mr,mg,my);
tunnel tunnel(clk,iu,ir,ig,iy,mu,mr,mg,my,tc,ic);

endmodule

/* Sensors. 
   For VIS, a variable in a CTL formula should not have primary 
   inputs as its supporting variables. So module Sensor simply 
   simulates the enviroment by modelling the inputs as state 
   variables in an enviroment state machine.
*/

module sensor(clk, ie,ix,me,mx);
input clk;
output ie,ix,me,mx;

wire rand_choice1,rand_choice2,rand_choice3,rand_choice4;
reg ie,ix,me,mx;

initial ie = 0;
initial ix = 0;
initial me = 0;
initial mx = 0;

assign rand_choice1 = $ND(0,1);
assign rand_choice2 = $ND(0,1);
assign rand_choice3 = $ND(0,1);
assign rand_choice4 = $ND(0,1);

always @(posedge clk) begin
    if (rand_choice1 == 0) 
        ie = 0;
    else 
	ie = 1;
    if (rand_choice2 == 0) 
        ix = 0;
    else 
	ix = 1;
    if (rand_choice3 == 0) 
        me = 0;
    else 
	me = 1;
    if (rand_choice4 == 0) 
        mx = 0;
    else 
	mx = 1;
end
endmodule

/*============================= Counters ============================*/

module counter(clk, tc,ic,
	       ic_plus,ic_minus,itc_plus,itc_minus,mtc_plus,mtc_minus);
input clk;
input ic_plus,ic_minus,itc_plus,itc_minus,mtc_plus,mtc_minus;
output tc,ic;

reg [`MSB:0] tc,ic;
wire ic_plus,ic_minus,itc_plus,itc_minus,mtc_plus,mtc_minus;

initial tc = 0;
initial ic = 0;

always @(posedge clk) begin
    if 	((ic_minus == 1) && (ic > 0)) ic = ic - 1;
    else if ((ic_plus == 1) && (ic < `MAX_NUM)) ic = ic + 1;
    else ic = ic;

/*
mtc+  mtc-  itc+  itc-     op
 0     0     0     0        =
 0     0     0     1       --
 0     0     1     0       ++
 0     0     1     1        X
 0     1     0     0       --
 0     1     0     1       --
 0     1     1     0        =
 0     1     1     1        X
 1     0     0     0       ++
 1     0     0     1        =
 1     0     1     0       ++
 1     0     1     1        X
 1     1     0     0        X
 1     1     0     1        X
 1     1     1     0        X
 1     1     1     1        X
*/

    if 	    ((itc_minus == 1) && (mtc_plus == 1))  tc = tc;
    else if ((mtc_minus == 1) && (itc_plus == 1))  tc = tc;
    else if ((itc_minus == 1) && (tc > 0))  tc = tc - 1;
    else if ((mtc_minus == 1) && (tc > 0))  tc = tc - 1;
    else if ((itc_plus == 1)  && (tc < `MAX_NUM)) tc = tc + 1;
    else if ((mtc_plus == 1)  && (tc < `MAX_NUM)) tc = tc + 1;
    else tc = tc;
end
endmodule


/*======================= Island Light Controller =======================*/

module island(clk,ie,ix,igl,irl,ic_minus,itc_plus,itc_minus,iu,ir,ig,iy);

input clk;
input ie,ix,ig,iy;
output igl,irl,ic_minus,itc_plus,itc_minus,iu,ir;

wire ie,ix,ig,iy,igl,irl,iu,ir;
wire ic_minus,itc_plus,itc_minus;

ms_sort reg is;

initial is = red;

always @(posedge clk) begin
	case (is)
	green:	if ((iy==0)&&(ie==0)) is = green;
		else if ((iy==0)&&(ie==1)) is = entering;
		else is = red;
	entering: if (ie==0) is = green;
		else is = entering;
	red: 	if ((ix==0)&&(ig==0)) is = red;
		else if ((ix==0)&&(ig==1)) is = green;
		else is = exiting;
	exiting: if (ix==0) is = red;
		else is = exiting;
	endcase
end

assign ir = ((is == red)&&(ie == 1)) ? 1 : 0;

assign iu = ((is == green) || (is == entering)) ? 1 : 0;

assign irl = ((is == red) || (is == exiting)) ? 1 : 0;

assign igl = ((is == green) || (is == entering)) ? 1 : 0;

assign itc_plus = ((is == green) && (iy == 0) && (ie == 1)) ? 1 : 0;

assign itc_minus = ((is == red) && (ix == 1)) ? 1 : 0;

assign ic_minus = ((is == green) && (iy == 0) && (ie == 1)) ? 1 : 0;

endmodule

/*======================= Mainland Light Controller =========================*/

module mainland(clk,me,mx,mgl,mrl,ic,ic_plus,mtc_plus,mtc_minus,mu,mr,mg,my);

input clk;
input [`MSB:0] ic;
input me,mx,mg,my;
output mgl,mrl,ic_plus,mtc_plus,mtc_minus,mu,mr;

wire [`MSB:0] ic;
wire me,mx,mg,my;
wire mgl,mrl,ic_plus,mtc_plus,mtc_minus,mu,mr;

ms_sort reg ms;

initial ms = red;

always @(posedge clk) begin
	case (ms)
	green:	if (ic >= `MAX_NUM) ms = red;
		else if ((my==0)&&(me==0)) ms = green;
		else if ((my==0)&&(me==1)) ms = entering;
		else ms = red;
	entering: if (me==0) ms = green;
		else ms = entering;
	red: 	if ((mx==0)&&(mg==0)) ms = red;
		else if ((mx==0)&&(mg==1)) ms = green;
		else ms = exiting;
	exiting: if (mx==0) ms = red;
		else ms = exiting;
	endcase
end

assign mr = ((ms == red)&&(me == 1)) ? 1 : 0;

assign mu = ((ms == green) || (ms == entering)) ? 1 : 0;

assign mrl = ((ms == red) || (ms == exiting)) ? 1 : 0;

assign mgl = ((ms == green) || (ms == entering)) ? 1 : 0;

assign mtc_plus =((ms == green) && (my == 0) && (me == 1) && (ic < `MAX_NUM)) ? 1 : 0;

assign mtc_minus = ((ms == red) && (mx == 1)) ? 1 : 0;

assign ic_plus = ((ms == green) && (my == 0) && (me == 1) && (ic < `MAX_NUM)) ? 1 : 0;

endmodule


/*======================= Tunnel Controller ===========================*/

module tunnel(clk,iu,ir,ig,iy,mu,mr,mg,my,tc,ic);

input clk;
input [`MSB:0] ic, tc;
input iu,ir,mu,mr;
output ig,iy,mg,my;

wire [`MSB:0] ic, tc;
wire iu,ir,mu,mr;
wire ig,iy,mg,my;

ts_sort reg ts;

initial ts = dispatch;

always @(posedge clk) begin
	case (ts)
	dispatch: if ((ir==0)&&(mr==0)) ts = dispatch;
		else if ((ir==0)&&(mr==1)&&(ic>=`MAX_NUM)) ts = dispatch;
		else if ((ir==0)&&(mr==1)&&(ic<`MAX_NUM)&&(iu==1)) ts = iuse;
		else if ((ir==0)&&(mr==1)&&(ic<`MAX_NUM)&&(iu==0)&&(tc!=0)) ts=iclear;
	      else if ((ir==0)&&(mr==1)&&(ic<`MAX_NUM)&&(iu==0)&&(tc==0)) ts=dispatch;
		else if ((ir==1)&&(mu==1)) ts=muse;
		else if ((ir==1)&&(mu==0)&&(tc!=0)) ts=mclear;
		else ts=dispatch;
	iuse:   if (iu==0) ts = iclear;
		else ts = iuse;
	muse:   if (mu==0) ts = mclear;
		else ts = muse;
	iclear: if (tc!=0) ts = iclear;
		else ts = dispatch;
	mclear: if (tc!=0) ts = mclear;
		else ts = dispatch;
	endcase
end

assign ig = (((ts==dispatch)&&(ir==1)&&(tc==0)&&(mu==0)) ||
	     ((ts==mclear)&&(tc==0))) ? 1 : 0;

assign iy = (ts == iuse) ? 1 : 0;

assign mg = (((ts==dispatch)&&(ir==0)&&(mr==1)&&(ic<`MAX_NUM)&&(tc==0)&&(iu==0)) ||
	     ((ts==iclear)&&(tc==0))) ? 1 : 0;

assign my = (ts == muse) ? 1 : 0;

endmodule
