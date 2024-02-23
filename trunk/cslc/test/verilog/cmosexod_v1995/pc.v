/*  PC.V
**
**  This core adheres to GNU Public Licence
**  Jeung Joon Lee  ***  www.cmosexod.com
**  joon.lee@quantum.com
**
**	JJL 12/12/98	
**  updated 3/16/2000
**
**  Highest module for the 8 bit general purpose microprocessor
**  Two submodules are declerared here, popcorn.v and sequencer.v
**  The role and functions of these modules are as following:
**		PC.V		wrapper, and clock generator.  Provides to the submodules
**					sys_clk and phase_1_clk
**		POPCORN.V	The 8 bit datapath.  Contains the ALU, register file,
**					the program counter, stack pointer and all of the muxes.
**		SEQUENCER.V	The sequencer state machine.  BAsed on the fetched opcode,
**					generates all of the sequence of control signals to
**					fetch more operands or finish executing the opcode. 
**
*/

`include "inc.h"

module pc(	sys_clk,
			sys_rst,
			addx_bus,
			data_bus,
			code_cs_l,
			code_rd_l,
			code_wr_l,
			sram_cs_l,
			slow_clk,
			port

`ifdef show_debug_pins
			,
			w_opl,
			w_pc,
			w_oplo,
			state,
			w_acc,
			w_ax,
			w_bx,
			w_p,			
			w_ophi,			
			w_flag,
			phase_1_clk,
			slow_clk4, 
			reg_flag,
			tst_bus,
			reg_acc,
			reg_ax,
			reg_bx,
			reg_p,
			reg_opl
`endif

);


parameter N=6;  


input         	sys_clk;
input 			sys_rst;
inout  [7:0]	data_bus;
inout  [7:0]	port;
//input  [1:0] 		tst_bus_sel;
output [11:0]	addx_bus;
//output [7:0] 		tst_bus;
output        		code_cs_l, code_rd_l, code_wr_l, sram_cs_l;
output        		slow_clk;

`ifdef show_debug_pins
// DEBUG SIGNALS
output			w_opl;
output			w_pc;
output			w_oplo;
output [3:0]    state;
output			w_acc;
output			w_ax;
output			w_bx;
output			w_p;	
output			w_ophi;			
output			w_flag;
output			phase_1_clk;
output			slow_clk4;
output	[2:0]	reg_flag;
output			tst_bus;
output	[7:0]	reg_acc;
output	[7:0]	reg_ax;
output	[7:0]	reg_bx;
output	[7:0]	reg_p;
output	[7:0]	reg_opl;
`endif

wire          		w_acc,w_ax,w_bx,w_p,w_flag;
wire          		pc_mux,w_pc,w_oplo,w_ophi,w_opl;
wire          		slow_clk4;
wire   [2:0]  		bbus_mux;
wire   [3:0]  		alu_func;
wire   [2:0]  		reg_flag;
wire   [7:0]    	port;
reg    [1:0]  		state_slow_clk4;
reg 		  		phase_1_clk;
wire          		xx,slow_clk;
wire   [5:0]  		state;
wire   [7:0]    	b_bus,c_bus;
wire   [11:0]	d_bus;
wire   [7:0]	    tst_bus;
wire				sp_mux, w_sp;
wire   [1:0] 		addx_mux;
wire				data_bus_wr;
wire				sram_cs_l, code_wr_l;
wire				flag_mux;
wire	[7:0]		reg_acc;
wire	[7:0]		reg_ax;
wire	[7:0]		reg_bx;
wire	[7:0]		reg_p;
wire	[7:0]		reg_opl;
//wire   [7:0]	port_in;
//wire				port_bus_ena;

// define test bus
/*
always @(tst_bus_sel or reg_opl or c_bus or b_bus or d_bus)
	case (tst_bus_sel)
		2'b00: tst_bus <= reg_opl;
		//2'b01: tst_bus <= b_bus;
		default: tst_bus <= b_bus;
		//2'b10: tst_bus <= c_bus;
		//default: tst_bus <= c_bus;
		//2'b11: tst_bus <= d_bus;
	endcase
*/
//assign tst_bus=tst_bus_sel[0] ? b_bus : c_bus;
assign tst_bus=c_bus;


`ifdef use_clock_divider
//
//  CLOCK DIVIDER
//
//
// N=5 sets for 1Mhz operation
// N=7 sets for 250Khz op.  good for slow speed debug
reg    [N-1:0]		clk;
always @(posedge sys_clk or negedge sys_rst)
	if (~sys_rst) clk <=0;
	else 		  clk <= clk + 1;
assign slow_clk = clk[N-1];
assign slow_clk4 = ~clk[N-3];
`else
reg [1:0] clk;
always @(posedge sys_clk or negedge sys_rst)
  if (~sys_rst) clk <= 2'b00;
  else clk <= clk + 1;
assign slow_clk  = clk[1];
assign slow_clk4 = sys_clk;
`endif

/* define phase_1 clock
**            |                                |
**            | ___     ___     ___     ___    | ___     ___    
** slow_clk*4 |/   \___/   \___/   \___/   \___|/   \___/   \___
**            | _______         _______        | _______
** slow_clk*2 |/       \_______/       \_______|/       \_______
**            | _______________                | _______________
** slow_clk   |/               \_______________|/        
**            |________                 _______|_
** phase_1    |        \_______________/       |
**            |                                |
*/
always @(posedge slow_clk4 or negedge sys_rst)
	if (~sys_rst) begin
		state_slow_clk4<=2'b00;
		phase_1_clk<=1'b1;
	end
	else case (state_slow_clk4)
		2'b00: begin state_slow_clk4<=2'b01; phase_1_clk<=1'b1; end
		2'b01: begin state_slow_clk4<=2'b11; phase_1_clk<=1'b1; end
		2'b11: begin state_slow_clk4<=2'b10; phase_1_clk<=1'b0; end
		2'b10: begin state_slow_clk4<=2'b00; phase_1_clk<=1'b0; end
	endcase
	
// instantiate the datapath
popcorn POPCORN(	.sys_clk(slow_clk),
					.sys_rst(sys_rst),
					.w_acc(w_acc),
					.w_ax(w_ax),
					.w_bx(w_bx),
					.w_p(w_p),
					.w_flag(w_flag),
					.bbus_mux(bbus_mux),
					.alu_func(alu_func),
					.pc_mux(pc_mux),
					.sp_mux(sp_mux),
					.flag_mux(flag_mux),
					.addx_mux(addx_mux),
					.w_pc(w_pc),
					.w_sp(w_sp),
					.w_oplo(w_oplo),
					.w_ophi(w_ophi),
					.w_opl(w_opl),
					.data_bus(data_bus),
					.port(port),
//					.port_in(port_in),
					.addx_bus(addx_bus),
					.reg_opl(reg_opl),
					.reg_flag(reg_flag),
					.b_bus(b_bus),
					.c_bus(c_bus),
					.d_bus(d_bus),
					.data_bus_wr(data_bus_wr),
					.code_wr_l(code_wr_l),
					.reg_acc(reg_acc),
					.reg_ax(reg_ax),
					.reg_bx(reg_bx),
					.reg_p(reg_p)
	              );

// instantiate the sequencer
sequencer SEQ  (	.sys_clk(slow_clk),
					.phase_1_clk(phase_1_clk),
					.sys_rst(sys_rst),
					.w_acc(w_acc),
					.w_ax(w_ax),
					.w_bx(w_bx),
					.w_p(w_p),
					.w_flag(w_flag),
					.bbus_mux(bbus_mux),
					.alu_func(alu_func),
					.pc_mux(pc_mux),
					.addx_mux(addx_mux),
					.sp_mux(sp_mux),
					.flag_mux(flag_mux),
					.w_pc(w_pc),
					.w_sp(w_sp),
					.w_oplo(w_oplo),
					.w_ophi(w_ophi),
					.w_opl(w_opl),
					.reg_opl(reg_opl),
					.code_cs_l(code_cs_l),
					.code_rd_l(code_rd_l),
					.code_wr_l(code_wr_l),
					.sram_cs_l(sram_cs_l),
					.reg_flag(reg_flag),
					.data_bus_wr(data_bus_wr),
					.next_state(state)
 	             );



endmodule



/*
**  Note on pin assignment:
**  o use pin file : "finalpin.pin"
**  o use global clock Y0 for 66Mhz source
**  o use global reset for reset.
**  o use N=6.  This requires 64Mhz to give internal clock speed of 1Mhz.
**
**  2/12/99
**  o Fixed the LDM ACC,xx bug.  ALU was not being set for c_bus = b_bus.
**    Call this 'popcorn - final'
**
**  2/11/99
**  o Uncovered and fixed 2 bugs relating the IO PORT: 
**    1.The signals 'reg_port_gate' which controls the gate of the port
**      output buffer has the wrong polarity.  This was causing the port
**      to drive the port IO pin only when it was being read.
**    2.The state of the bbus_mux[2:0] during LDACC/STADD was set to unknown.
**      This was causing the reg_port_gate to be deasserted during LDACC PORT
**      or STACC PORT instructions for 1 cycle, causing glitches in the IO port
**      pin
**      
**	1/8/99
**	o Succesfully ran a timer program which toggles all bits of the 
**	  port register at 2mS interval (period=4mS).  The program uses
**	  an instrunctions timed 2mS delay subroutine.	
**
**	1/7/99 
**	o Somewhat final version.  The test bus (TST[7:0]) has been dropped
**	  and PORT[7:0] been used.  All instructions works at least at 2 Mhz.
**	  Call this 'popcorn -v5'
**
**	1/5/99
**	o Droppped the automatic pushing and popping of the flags when CALL/RET
**    are executed, (could not fit).  So reduced the size of REG_OPHI down 
**	  to 4 from 8 bits.  Instead the pushing of the flag is now done with
**	  LDACC flag
**	  LDM flag, #addx
**	  PUSH flag 
**	  POP flag
**    instructions.  The flag register still is muxed from ALU and c_bus.
**    Thanks Lord.
**	  All that remains now is implementation of interrupt support.
**	
**  1/3/99
**	o Removed DX and CX register from the register file, to free-up
**	  the b_mux.  The freed b_bus mux inputs are used by the PC (hi and low).
**    This allows PC to be pushed into the stack as well as CALL and RET 
**    and push flag instructions
**
**	1/1/99
**	o Removed 7 level-deep hardware stack - it was obvious that this is not
**    a very robust way of having a stack.  It limits the CALL/RET depth.
**	  However my initial rational for not implementing the SP was that I
**    did not wanted to have a SRAM for stack.  SRAM automatically implies
**    an extenal IC (since on FPGA you could not provide the required 
**    amount of space).  
**  o Added another addressing mode: direct mode, and 2 instructions: LDM and
**	  STM (load mem, store mem).  This brings the modes
**	  to: register direct, immediate and direct.
**    Why not, I had decided to have exnal SRAM, so let's make use of it
**
**	12/28/98
**	o Added 7-level deep hardware LIFO to implement pushacc/popacc
**    instructions
**	o Implemented pushacc and popacc instructions in the sequencer.v
**
**  12/27/98
**	o Fixed a number of bugs, including CMPACC (reg direct) and ALU ops (reg
**	  direct) being decoded as same.
**
**	12/26/98
**	o Shortenend the PC to 12 bits from 16, to reduce design size. 
**  o REduced the datapath width to 8 from 16, to reduce design size.
**
**  Lots of previous history not accounted for.  Started to work on POPCORN
**  about 12/12/98
*/
