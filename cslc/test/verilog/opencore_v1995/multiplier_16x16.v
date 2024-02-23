// created by verisplt.awk

/* 
   run this program using vb multiplexer_generator.v

2-to-1
    $fdisplay (generated_multiplexer,"mux_%d mux%d (.a({a[%d],a[%d]}),.sel(sel),.y(y[%d]));",max_words,i,i+max_bits*1,i+max_bits*0,i);

2-to-1 inverting
    $fdisplay (generated_multiplexer,"muxi_%d mux%d (.a({a[%d],a[%d]}),.sel(sel),.seli(seli),.yi(yi[%d]));",max_words,i,i+max_bits*1,i+max_bits*0,i);

4-to-1 inverting
    $fdisplay (generated_multiplexer,"muxi_%d mux%d (.a({a[%d],a[%d],a[%d],a[%d]}),.sel(sel),.seli(seli),.yi(yi[%d]));",max_words,i,i+max_bits*3,i+max_bits*2,i+max_bits*1,i+max_bits*0,i);

64-to-1
    $fdisplay (generated_multiplexer,"mux_%d mux%d (.a({a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d]}),.sel(sel),.y(y[%d]));",max_words,i,i+max_bits*63,i+max_bits*62,i+max_bits*61,i+max_bits*60,i+max_bits*59,i+max_bits*58,i+max_bits*57,i+max_bits*56,i+max_bits*55,i+max_bits*54,i+max_bits*53,i+max_bits*52,i+max_bits*51,i+max_bits*50,i+max_bits*49,i+max_bits*48,i+max_bits*47,i+max_bits*46,i+max_bits*45,i+max_bits*44,i+max_bits*43,i+max_bits*42,i+max_bits*41,i+max_bits*40,i+max_bits*39,i+max_bits*38,i+max_bits*37,i+max_bits*36,i+max_bits*35,i+max_bits*34,i+max_bits*33,i+max_bits*32,i+max_bits*31,i+max_bits*30,i+max_bits*29,i+max_bits*28,i+max_bits*27,i+max_bits*26,i+max_bits*25,i+max_bits*24,i+max_bits*23,i+max_bits*22,i+max_bits*21,i+max_bits*20,i+max_bits*19,i+max_bits*18,i+max_bits*17,i+max_bits*16,i+max_bits*15,i+max_bits*14,i+max_bits*13,i+max_bits*12,i+max_bits*11,i+max_bits*10,i+max_bits*9,i+max_bits*8,i+max_bits*7,i+max_bits*6,i+max_bits*5,i+max_bits*4,i+max_bits*3,i+max_bits*2,i+max_bits*1,i+max_bits*0,i);

32-to-1
    $fdisplay (generated_multiplexer,"mux_%d mux%d (.a({a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d]}),.sel(sel),.y(y[%d]));",max_words,i,i+max_bits*31,i+max_bits*30,i+max_bits*29,i+max_bits*28,i+max_bits*27,i+max_bits*26,i+max_bits*25,i+max_bits*24,i+max_bits*23,i+max_bits*22,i+max_bits*21,i+max_bits*20,i+max_bits*19,i+max_bits*18,i+max_bits*17,i+max_bits*16,i+max_bits*15,i+max_bits*14,i+max_bits*13,i+max_bits*12,i+max_bits*11,i+max_bits*10,i+max_bits*9,i+max_bits*8,i+max_bits*7,i+max_bits*6,i+max_bits*5,i+max_bits*4,i+max_bits*3,i+max_bits*2,i+max_bits*1,i+max_bits*0,i);

16to-1
    $fdisplay (generated_multiplexer,"mux_%d mux%d (.a({a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d]}),.sel(sel),.y(y[%d]));",max_words,i,i+max_bits*15,i+max_bits*14,i+max_bits*13,i+max_bits*12,i+max_bits*11,i+max_bits*10,i+max_bits*9,i+max_bits*8,i+max_bits*7,i+max_bits*6,i+max_bits*5,i+max_bits*4,i+max_bits*3,i+max_bits*2,i+max_bits*1,i+max_bits*0,i);

8-to-1
    $fdisplay (generated_multiplexer,"mux_%d mux%d (.a({a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d],a[%d]}),.sel(sel),.y(y[%d]));",max_words,i,i+max_bits*7,i+max_bits*6,i+max_bits*5,i+max_bits*4,i+max_bits*3,i+max_bits*2,i+max_bits*1,i+max_bits*0,i);

4-to-1
    $fdisplay (generated_multiplexer,"mux_%d mux%d (.a({a[%d],a[%d],a[%d],a[%d]}),.sel(sel),.y(y[%d]));",max_words,i,i+max_bits*3,i+max_bits*2,i+max_bits*1,i+max_bits*0,i);
*/

		/* ------------------------------------ */
		/*					*/
		/*	      Macro  Library		*/
		/*					*/ 
		/*   	   VLSI Tecnologies Lab		*/
		/*					*/
		/*	    Advanced DSP Group		*/
		/*					*/
		/*		 --------		*/
		/*					*/
		/*	   Designer: Tim Pagden		*/
		/*					*/
		/*	      Date: Oct 1990		*/
		/*					*/ 
		/* ------------------------------------ */

module multiplier_16x16 (a,b,y);

input[15:0] a,b;
output[31:0] y;

wire lo;
wire[2:0] cntl_0,cntl_1,cntl_2,cntl_3;
wire[3:0] cntl_4;
wire[18:0] a0,a1,a2,a3,a5,a6;
wire[19:0] a4,a8;
wire[21:0] a7;

assign  lo = 0;

scaler_3_16 sc0 (.a(a),.cntl(cntl_0),.y(a0));
scaler_3_16 sc1 (.a(a),.cntl(cntl_1),.y(a1));
scaler_3_16 sc2 (.a(a),.cntl(cntl_2),.y(a2));
scaler_3_16 sc3 (.a(a),.cntl(cntl_3),.y(a3));
scaler_4_16 sc4 (.a(a),.cntl(cntl_4),.y(a4));
adder_19 add0 (.a({a0[18],a0[18],a0[18],a0[18:3]}),.b(a1),
	.c_in(lo),.y(a5));
adder_19 add1 (.a({a2[18],a2[18],a2[18],a2[18:3]}),.b(a3),
	.c_in(lo),.y(a6));
adder_22 add2 (.a({{6{a5[18]}},a5[18:3]}),
	.b({a6,a2[2:0]}),.c_in(lo),.y(a7));
adder_20 add3 (.a({{4{a7[21]}},a7[21:6]}),
	.b(a4),.c_in(lo),.y(a8));

assign  cntl_0 = b[2:0],
	cntl_1 = b[5:3],
	cntl_2 = b[8:6],
	cntl_3 = b[11:9],
	cntl_4 = b[15:12],
	y = {a8,a7[5:0],a5[2:0],a0[2:0]};

endmodule
