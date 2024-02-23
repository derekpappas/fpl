/*
**  POPCORN
**
**  This core adheres to GNU Public Licence
**  Jeung Joon Lee  ***  www.cmosexod.com
**  joon.lee@quantum.com
**
**	JJL 12/12/98	
**  updated 3/16/2000
**
**  This is an 8 bit general purpose microprocessor.  The architecture
**  is that of a CISC type with accumulator-based operations.
**  The internal data-path is 8 bits, and the external bus is 8.
**  No support for muliply or other complex arithmetic operations are
**  supported (see ALU below).
**
**  Two addressing modes:  immediate and register-direct.f
**  23 instructions are supported
**
**  Instrutions lengths can be 1 or 2 or 3 bytes, which correcponds to
**  executions times of 2, 3 and 4 cycles.

**  to change the address width: from 12 bits to wider:
**  change:
**		AW to desired value (all 3 files)
**		REG_OPHI width definition
**
*/

module popcorn( sys_clk,	// system clock 1Mhz 
				sys_rst,	// system reset active low
				w_acc,		// accumulator write signal, active low
				w_ax,		// AX regster write signal, active low
				w_bx,		// BX "			"			"
				w_p,		// PORT "		"			"
				w_flag,		// FLAG "		"			"			
				bbus_mux,	// bbus mux selector
				alu_func,
				pc_mux,
				addx_mux,
				sp_mux,
				flag_mux,
				w_pc,
				w_sp,
				w_oplo,
				w_ophi,
				w_opl,
				data_bus,				
				addx_bus,
				port,
				reg_opl,
				reg_flag,

                c_bus,
				b_bus,
				d_bus,
				data_bus_wr,
				code_wr_l,
				reg_acc,
				reg_ax,
				reg_bx,
				reg_p
              );

input         		sys_clk,sys_rst,w_acc,w_ax,w_bx,w_p,w_flag;
input         		pc_mux,w_pc,w_oplo,w_ophi,w_opl;
input  [3:0]  		alu_func;
input  [2:0]  		bbus_mux;
input				data_bus_wr;
input				code_wr_l;
output [7:0]	    b_bus,c_bus;
output [11:0]       d_bus;
output [7:0]	    reg_opl;
output [2:0]  		reg_flag;
inout  [7:0]	data_bus;
inout  [7:0]	port;
output [11:0]	addx_bus;
input				sp_mux,w_sp;
input  [1:0]        addx_mux;
input				flag_mux;
output	[7:0]	reg_acc;
output	[7:0]	reg_ax;
output	[7:0]	reg_bx;
output	[7:0]	reg_p;

reg   [7:0] 	reg_ax,reg_bx,reg_acc;
reg   [11:0]		reg_pc, reg_sp;
reg   [7:0]  	reg_opl,reg_oplo,reg_p;
reg   [3:0]         reg_ophi;
reg          		carry,pos,zero,cout;
reg   [7:0] 	b_bus,c_bus;  
reg	  [11:0]		addx_bus;
//reg	  [7:0]		reg_port_dir;
wire  [2:0]  		reg_flag;
wire  [11:0]    	d_bus;
wire  [7:0]		data;
wire  [7:0] 	input_port;
wire				cs_reg_port_dir;
wire 				reg_port_gate;

/*
**  DATA BUS :: bi-directional
**  Output c_bus onto the pad at data_bus_wr == 0
*/
assign data 	= data_bus;		// input
assign data_bus = data_bus_wr ? 8'hzz : c_bus; //output

/*
** REGISTER FILE :: Synchronous to sys_clk 
** There are total of 6 registers 
** 	ACC accumulator 8 bit
**	AX  general purpose register 8 bit
**	BX  general purpose register 8 bit
**	P   I/O port register 4 bit 
*/
always @(posedge sys_clk or negedge sys_rst) 
  if (~sys_rst) 
    reg_p <= 8'h00;
  else if(~w_p)
	reg_p <= c_bus;

always @(posedge sys_clk or negedge sys_rst) 
  if (~sys_rst) 
    reg_ax <= 8'h00;
  else if(~w_ax)
	reg_ax <= c_bus;

always @(posedge sys_clk or negedge sys_rst) 
  if (~sys_rst) 
    reg_bx <= 8'h00;
  else if(~w_bx)
	reg_bx <= c_bus;

always @(posedge sys_clk or negedge sys_rst) 
  if (~sys_rst) 
    reg_acc <= 8'h00;
  else if(~w_acc)
	reg_acc <= c_bus;


/* OPL  :: Synchronous to W_OPL
** Opcode_Latch register 8 bit
** Latched by rising edge of W_OPL
*/
always @(posedge w_opl or negedge sys_rst)
	if(~sys_rst)
		reg_opl <= 8'h00;
	else 
		reg_opl <= data;

/*
** PC:: Synchronous to sys_clk 
** Program Counter 8 bit
**
** Input:   sys_clk : on rising edge, PC is update
**          w_pc    : 1=allow pc to change, 0=pc has its previous 
**                    value
**          pc_mux  : 1=on the rising edge of sys_clk pc=pc+1
**                    0=on the rising edge of sys_clk pc=d_bus
*/
always @(posedge sys_clk or negedge sys_rst)
	if (~sys_rst)
		reg_pc <= 12'h000;   // the reset value must be all 0's 
	else if (~w_pc & pc_mux)
		reg_pc <= reg_pc + 1;
	else if ( ~w_pc & ~pc_mux )
		reg_pc <= d_bus;
	else 
		reg_pc <= reg_pc;

/*
** SP :: Synchrnous to sys_clk
** Stack Pointer
*/
always @(posedge sys_clk or negedge sys_rst)
	if (~sys_rst)
		reg_sp <= 12'hFFF;		// default reset value of sp is 0xFFF
	else if (~w_sp & sp_mux)
		reg_sp <= reg_sp - 1;
	else if ( ~w_sp & ~sp_mux)
		reg_sp <= reg_sp + 1;

/*
** ADDX mux
*/  
always @(addx_mux or reg_pc or reg_sp or d_bus)
	case (addx_mux)
		2'b00: addx_bus <= d_bus;
		2'b01: addx_bus <= reg_pc;
		default: addx_bus <= reg_sp;
	endcase 

/*
** Arithmetic Logic Unit
** This ALU provides 9 funtions:
** 	0	c = a+b
**	1	c = a-b  (a+~b+1)
**	2	c = a&b
**	3	c = a|b
**	4	c = a^b
**	5	c = ~a
**	6	c = a >> 1
**	7	c = a << 1
**	8	c = b
**  else c = a
*/		
always @(reg_acc or b_bus or alu_func) begin
  case (alu_func)
  	4'b0000: {cout,c_bus} <= reg_acc+b_bus;
	4'b0001: {cout,c_bus} <= reg_acc-b_bus;	
	4'b0010: begin c_bus  <= reg_acc&b_bus; cout<=1'b0; end
	4'b0011: begin c_bus  <= reg_acc|b_bus; cout<=1'b0; end
	4'b0100: begin c_bus  <= reg_acc^b_bus; cout<=1'b0; end
	4'b0101: begin c_bus  <= ~reg_acc;	     cout<=1'b0; end 			
	4'b0110: begin c_bus  <= {1'b0,reg_acc[7:1]}; cout<=reg_acc[0]; end	
	4'b0111: begin c_bus  <= {reg_acc[6:0],1'b0}; cout<=reg_acc[7]; end		
	4'b1000: begin c_bus  <= b_bus; cout<=1'b0; end
    default: begin c_bus  <= reg_acc; cout<=1'b0; end						
  endcase  
end

// Define ALU flag register
always @(posedge sys_clk or negedge sys_rst)
	if (~sys_rst) begin
		pos  <= 1'b0;		
		zero <= 1'b0;
		carry <= 1'b0;
	end
	else if ((~w_flag) && (flag_mux==1'b1)) begin
		zero  <= ~( | c_bus );		// zero=1 iff all bits==0
		pos   <= ~(c_bus[7]);   // pos=1  iff msb=0
		carry <= cout;	            // carry , see alu above
	end
	else if ((~w_flag) && (flag_mux==1'b0)) begin
		zero  <= c_bus[5];			// zero=1 iff all bits==0
		pos   <= c_bus[6];			// pos=1  iff msb=0
		carry <= c_bus[7];			// carry , see alu above
	end

assign reg_flag = {carry,pos,zero};

/*
** Define B MUX 
*/
always @(reg_ax or reg_bx or reg_flag or reg_pc or d_bus or reg_p or bbus_mux or input_port)
	case (bbus_mux)		
		3'b001: b_bus <= reg_ax;
		3'b010: b_bus <= reg_bx;
		3'b011: b_bus <= reg_pc[7:0];
		3'b100: b_bus <= {reg_flag,1'b0,reg_pc[11:8]};
		3'b101: b_bus <= input_port;
		3'b110: b_bus <= d_bus[7:0];
		default: b_bus <=d_bus;
	endcase


/*
** Define d_bus
*/
assign d_bus={reg_ophi[3:0],reg_oplo};
always @(posedge w_oplo or negedge sys_rst)
  if (~sys_rst)
    reg_oplo <= 8'h00;  
  else 
    reg_oplo <= data;
always @(posedge w_ophi or negedge sys_rst)
  if (~sys_rst)
    reg_ophi <= 4'b0000;  
  else 
    reg_ophi <= data[3:0];


/*
** Define the PORT register :: Synchronous to sys_clk
*/
/*
assign port[0] = reg_port_dir[0] ? 1'bz : reg_p[0];
assign port[1] = reg_port_dir[1] ? 1'bz : reg_p[1];
assign port[2] = reg_port_dir[2] ? 1'bz : reg_p[2];
assign port[3] = reg_port_dir[3] ? 1'bz : reg_p[3];
assign port[4] = reg_port_dir[4] ? 1'bz : reg_p[4];
assign port[5] = reg_port_dir[5] ? 1'bz : reg_p[5];
assign port[6] = reg_port_dir[6] ? 1'bz : reg_p[6];
assign port[7] = reg_port_dir[7] ? 1'bz : reg_p[7];
*/

assign input_port 	= port;			
//assign port 		= reg_port_gate ? 8'hzz : reg_p;

bufif1(port[0], reg_p[0], reg_port_gate);
bufif1(port[1], reg_p[1], reg_port_gate);
bufif1(port[2], reg_p[2], reg_port_gate);
bufif1(port[3], reg_p[3], reg_port_gate);
bufif1(port[4], reg_p[4], reg_port_gate);
bufif1(port[5], reg_p[5], reg_port_gate);
bufif1(port[6], reg_p[6], reg_port_gate);
bufif1(port[7], reg_p[7], reg_port_gate);

assign reg_port_gate = (bbus_mux[2:0]==3'b101);

/*
assign cs_reg_port_dir = ( ~(addx_bus==12'hD00) | (~code_wr_l) );
always @(posedge cs_reg_port_dir or negedge sys_rst)
	if (~sys_rst)
		reg_port_dir <= 8'h00;
	else
		reg_port_dir <= c_bus;
*/		
endmodule

