module stage1(ir2,pc2,pcout,ir1,z4,mp1,clk,clr,pause1,pause2,nop2);

/*********************************************************************

        This module is for stage1 of the processor.
        The following are the modules which are instantiated.
        
        1. selIR2mux --> To select IR2 input
        2. pcmux     --> To select Program counter input
        3. pc2mux    --> To select PC2 input
        4. inc4      --> Module to increment PC by 4
        5. d_reg     --> Registers to latch values for stage 2 at clock.

**********************************************************************/

	output [31:0] ir2,pc2,pcout;
	input [31:0] ir1;
	input  [31:0] z4;
	input mp1,clk,clr;

	input pause1,pause2,nop2;
	wire [31:0] pcin,pc2_in;
	wire [31:0] inc4out,ir1_mux,nop2_out;
	wire or_nop2_pause1,sel1;
	
	
	or #3 (or_nop2_pause1,pause1,nop2);
	and #3 (sel1,mp1,or_nop2_pause1);
	
	
	
	// paras are sel0,sel1,out,in0-3
	mux4 #(32,6) selIR2mux(nop2,pause2,ir1_mux,ir1, nop2_out, ir2,ir2);
	mux4 #(32,6) pcmux(mp1,sel1,pcin,z4,inc4out,pcout,pcout);
	mux2 #(32,6) pc2mux(pause2,pc2_in,inc4out,pc2);	
	inc4 incr(inc4out,pcout);
	d_reg #(32,8) pc(clk,pcout,pcin,clr);
	d_reg #(32,8) pc2reg(clk,pc2,pc2_in,clr);
	d_reg #(32,8) ir2reg(clk,ir2,ir1_mux,clr);
	d_reg #(32,8) nop2reg(clk,nop2_out,0,clr);

endmodule