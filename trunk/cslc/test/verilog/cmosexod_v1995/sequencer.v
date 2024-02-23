/*
**  SEQUENCER
**
**  This core adheres to GNU Public Licence
**  Jeung Joon Lee  ***  www.cmosexod.com
**  joon.lee@quantum.com
**
**	JJL 12/12/98	
**  updated 3/16/2000
**
**
**  This is the sequencer for the POPCORN 8bit microprocessor.
**  Controls all of the control signals.
**
**  This sequencer controls these following signals of the datapath "popcorn"
**
**
**
*/
module sequencer   (sys_clk,
					phase_1_clk,
					sys_rst,
					w_acc,
					w_ax,
					w_bx,
					w_p,
					w_flag,					
					bbus_mux,
					alu_func,
					pc_mux,
					addx_mux,
					sp_mux,
					flag_mux,
					w_sp,
					w_pc,
					w_oplo,
					w_ophi,
					w_opl,
					reg_opl,
					code_cs_l,
					code_rd_l,
					sram_cs_l,
					code_wr_l,
					reg_flag,
					data_bus_wr,
					next_state
 	             );

input        		sys_clk,sys_rst,phase_1_clk;
input  [7:0]    	reg_opl;
input  [2:0] 		reg_flag;
output       		w_acc,w_ax,w_bx,w_p,w_flag,pc_mux,w_pc;
output       		w_opl,w_oplo,w_ophi,code_cs_l,code_rd_l;
output [3:0] 		alu_func;
output [2:0] 		bbus_mux;
output [3:0] 		next_state;
output [1:0]		addx_mux;
output				sp_mux, w_sp, sram_cs_l, code_wr_l, data_bus_wr;
output				flag_mux;

reg    [5:0] 		next_state;
reg          		code_cs_l,code_rd_l_gate;
reg		     		w_opl_gate,w_acc_gate,w_ax_gate,w_bx_gate;
reg					w_p_gate,w_flag_gate,pc_mux;
reg		     		w_oplo_gate,w_ophi_gate,w_pc_gate;
reg    [3:0] 		alu_func;
reg    [2:0] 		bbus_mux;
reg          		dummy;
reg	   [1:0]        addx_mux;
reg					w_sp_gate, sp_mux, sram_cs_l, code_wr_l_gate,data_bus_wr;
reg					flag_mux;

parameter state_s0  =6'b000001;
parameter state_s1  =6'b000010;
parameter state_s2  =6'b000100;
parameter state_s3  =6'b001000;
parameter state_s4	=6'b010000;
parameter state_s5  =6'b100000;

assign w_acc = w_acc_gate;
assign w_ax  = w_ax_gate;
assign w_bx  = w_bx_gate;
assign w_p   = w_p_gate;
assign w_flag= w_flag_gate;
assign w_pc  = w_pc_gate;
assign w_sp  = w_sp_gate;
assign w_oplo= w_oplo_gate | phase_1_clk;		// asynchronous reg
assign w_ophi= w_ophi_gate | phase_1_clk;		// asynchronous reg
assign w_opl = w_opl_gate  | phase_1_clk; 		// asynchronous reg
assign code_rd_l = code_rd_l_gate | phase_1_clk;	// code rom rd
assign code_wr_l = code_wr_l_gate | phase_1_clk;

/*
** Behavioral description of the Sequencer State machine
**
** synchronous state machine, transitions on the rising edge of sys_clk
*/
always @(posedge sys_clk or negedge sys_rst) begin
	if (~sys_rst) begin   // rst
		code_cs_l 		<= 1'b1;
		code_rd_l_gate 	<= 1'b1;
		code_wr_l_gate  <= 1'b1;
		sram_cs_l		<= 1'b1;
		alu_func  		<= 4'b0000;
		w_acc_gate     	<= 1'b1;
		w_ax_gate      	<= 1'b1;
		w_bx_gate	   	<= 1'b1;
		w_p_gate       	<= 1'b1;
		w_flag_gate    	<= 1'b1;
		w_opl_gate     	<= 1'b1;
		w_oplo_gate    	<= 1'b1;
		w_ophi_gate    	<= 1'b1;
		bbus_mux       	<= 2'b00;				
		addx_mux		<= 2'b01;
		pc_mux         	<= 1'b1;
		sp_mux			<= 1'b1;
		flag_mux		<= 1'b1;
		w_pc_gate      	<= 1'b1;
		w_sp_gate		<= 1'b1;
		data_bus_wr		<= 1'b1;
//		port_bus_ena	<= 1'b0;
		next_state     	<= state_s0;
	end	
	else case(next_state)
		/*
		** FETCH OPCODE STATE. (at beginning of s1 opcode is latched into reg_opl)
		*/
		state_s0: begin     // *****2
				code_cs_l      <= 1'b0;	// enable code cs
                code_rd_l_gate <= 1'b0;	// enable code rd
				code_wr_l_gate <= 1'b1;
				sram_cs_l	   <= 1'b1;
				alu_func       <= 4'bx;
				w_acc_gate     <= 1'b1;
				w_ax_gate      <= 1'b1;
				w_bx_gate	   <= 1'b1;
				w_p_gate       <= 1'b1;
				w_flag_gate    <= 1'b1;
				w_opl_gate     <= 1'b0;	// latch opl at s1
				w_oplo_gate    <= 1'b1;
                w_ophi_gate    <= 1'b1;
				bbus_mux       <= 2'b00;				
				addx_mux	   <= 2'b01;
				pc_mux         <= 1'b1;
				sp_mux		   <= 1'b1;
				flag_mux	   <= 1'b1;
				w_pc_gate      <= 1'b1;
				w_sp_gate	   <= 1'b1;
				data_bus_wr	   <= 1'b1;
				//port_bus_ena	<= 1'b0;
				next_state     <= state_s1;
		end
		/*
		** REGISTER DIRECT INSTRUCTIONS 1 byte, 2 cycle instructions
		** these are: stacc, ldacc, and alu ops
		*/
		state_s1: begin	// ******** 2	

                begin
				    code_cs_l           <= 1'b1;  // disable cs and rd from code ram
				    code_rd_l_gate      <= 1'b1;
				    w_opl_gate          <= 1'b1;  // disable opcode latch gate		
                end

				// ALU opcode - register direct
				if((reg_opl[7:6]==2'b00)&&(reg_opl[2:0]!=3'b111)) begin
					alu_func       <= reg_opl[6:3];
					w_acc_gate     <= 1'b0;  // latch acc with result on s0
					w_flag_gate    <= 1'b0;	// latch reg result on s0			
					bbus_mux       <= reg_opl[2:0];									
					w_pc_gate      <= 1'b0;  // increment pc on s0
					next_state     <= state_s0;					
				end
				// CMPACC opcode - register direct
				else if((reg_opl[7:3]==5'b01000)&&(reg_opl[2:0]!=3'b111)) begin
					alu_func       <= 4'b0001;  // alu subtract
					w_flag_gate    <= 1'b0;	// latch reg result on s0
					bbus_mux       <= reg_opl[2:0];				
					w_pc_gate      <= 1'b0;  // increment pc on s0
					next_state     <= state_s0;					
				end				
				// LDACC - register direct
				else if ((reg_opl[7:3]==5'b10001)&&(reg_opl[2:0]!=3'b111)) begin
					alu_func       <= 4'b1000;  // alu=select b bus
					w_acc_gate     <= 1'b0;     // latch acc on s0
					bbus_mux       <= reg_opl[2:0];				
					w_pc_gate      <= 1'b0;  // increment pc on s0
					next_state     <= state_s0;								
				end
				// STACC - register direct
				else if ((reg_opl[7:3]==5'b10010)&&(reg_opl[2:0]!=3'b111)) begin
					alu_func       <= 4'b1001;  // alu=select a bus
					case (reg_opl[2:0])    // latch approp dest reg on s0					
						3'b001: w_ax_gate      <= 1'b0;
						3'b010: w_bx_gate	   <= 1'b0;
						3'b100: begin
									w_flag_gate	<= 1'b0;
									flag_mux	<= 1'b0;
								end
						3'b101: w_p_gate       <= 1'b0;
						default: dummy         <= 1'b0;  // do nothing
					endcase					
					bbus_mux       <= 3'b001;  // anything but 3'b101 (port)
					w_pc_gate      <= 1'b0;  // increment pc in s0
					next_state	   <= state_s0;								
				end
				// PUSH , write out to [SP] and decrement SP
				// push does this:   [SP] <- reg,  SP=SP-1
				else if(reg_opl[7:3]==5'b01110) begin		
					if (reg_opl[2:0]==3'b000) begin
						alu_func   <= 4'b1001;  // select c_bus=acc
					end else begin
						alu_func   <= 4'b1000;  // select c_bus=b_bus
					end
					bbus_mux       <= reg_opl[2:0];	
					sp_mux		   <= 1'b1;		// sp = sp -1
					w_sp_gate	   <= 1'b0;		// allow sp to decrement
					addx_mux	   <= 2'b10;	// select sp as addx source			
					sram_cs_l      <= 1'b0;		// select sram
					code_wr_l_gate <= 1'b0;		// and write
					data_bus_wr		<= 1'b0;	// drive data bus with c_bus							
					w_pc_gate      <= 1'b0;  	// increment pc on s0
					next_state     <= state_s0;					
				end
				// POP, RET part I, increment SP
				// pop does this:  
				//		SP=SP+1
				//		reg_ophi <- [SP]
				//		SP=SP+1
				//		reg_oplo <- [SP]
				else if (reg_opl[7:3]==5'b01111 | reg_opl[7:0]==8'b11011110) begin					
					alu_func	   <= 4'b1000;	// c_bus = b_bus
					bbus_mux	   <= 3'b110;	// b_bus = d_bus
					sp_mux		   <= 1'b0;		// sp = sp + 1
					w_sp_gate	   <= 1'b0;		// allow sp to increment
					next_state     <= state_s2;					
				end

				// Immediate mode, so need to go and fetch one or two operands.
				// setup the PC so it increments to 1 and cs and rd gates
				// are asserted
				else begin
					alu_func       <= 4'b1000;
					w_acc_gate     <= 1'b1;
					w_ax_gate      <= 1'b1;
					w_bx_gate	   <= 1'b1;
					w_p_gate       <= 1'b1;
					w_oplo_gate    <= 1'b1;					
					bbus_mux       <= 3'b110;   // show d_bus on c_bus 				
					pc_mux         <= 1'b1;
					w_pc_gate      <= 1'b0;  	// increment pc on s2
					next_state     <= state_s2;									
				end
		end
		
		/*
		** IMMEDIATE INSTRUCTIONS.  2 bytes, 3 cycle insruction
		** these are:  ldi, alu ops.
		*/
		state_s2: begin
				// LDI - load immediate 8 bit value to register 
				if ((reg_opl[7:6]==2'b10)&&(reg_opl[2:0]==3'b111)) begin
						alu_func  <= 4'b1000;
						case (reg_opl[5:3])  // latch the dest reg on s0
							3'b000: w_acc_gate  <= 1'b0;
							3'b001: w_ax_gate   <= 1'b0;
							3'b010: w_bx_gate	<= 1'b0;
							3'b101: w_p_gate    <= 1'b0;
							default: dummy      <= 1'b0;  //do nothing
						endcase						
						bbus_mux    <= 3'b110;				
						w_pc_gate   <= 1'b0;  // increment pc on s0
				        code_cs_l      <= 1'b0;    // allow -cs and -rd to code ram
				        code_rd_l_gate <= 1'b0;	  	
         				w_oplo_gate    <= 1'b0;    // assert oplo gate
						next_state  <= state_s0;						
				end
				// ALU op - immediate
				else if ((reg_opl[7:6]==2'b00)&&(reg_opl[2:0]==3'b111)) begin
						alu_func    <= reg_opl[6:3]; // get alu oprerationg from instruction
						w_acc_gate  <= 1'b0;  // latch acc on s0
						w_flag_gate <= 1'b0;  // update flag on s0												
						bbus_mux    <= 3'b110;				
						w_pc_gate   <= 1'b0;  // increment pc on s0
				        code_cs_l      <= 1'b0;    // allow -cs and -rd to code ram
				        code_rd_l_gate <= 1'b0;	  	
         				w_oplo_gate    <= 1'b0;    // assert oplo gate
						next_state  <= state_s0;						
				end
				// CMPACC op - immediate
				else if ((reg_opl[7:3]==5'b01000)&&(reg_opl[2:0]==3'b111)) begin
						alu_func    <= 4'b001; // alu to subtract
						w_flag_gate <= 1'b0;  // update flag on s0												
						bbus_mux    <= 3'b110; // bbus select d_bus				
						w_pc_gate   <= 1'b0;  // increment pc on s0
				        code_cs_l      <= 1'b0;    // allow -cs and -rd to code ram
         				code_rd_l_gate <= 1'b0;	  	
         				w_oplo_gate    <= 1'b0;    // assert oplo gate
						next_state  <= state_s0;						
				end 
				// POP, part II, load data from [SP]
				else if (reg_opl[7:3]==5'b01111) begin		
					code_cs_l	   <= 1'b1;		// don't read from code ram			
					alu_func	   <= 4'b1000;	// c_bus = b_bus
					bbus_mux	   <= 3'b110;	// b_bus = d_bus
					w_sp_gate	   <= 1'b1;		// disallow sp to change
					addx_mux	   <= 2'b10;	// select sp as addx source			
					sram_cs_l	   <= 1'b0;		// select sram
					code_rd_l_gate <= 1'b0;		// and read
					w_oplo_gate    <= 1'b0;		// and latch it into reg_oplo
					case (reg_opl[2:0])
						3'b000: w_acc_gate	<= 1'b0;
						3'b001: w_ax_gate	<= 1'b0;
						3'b010: w_bx_gate   <= 1'b0;
						3'b100: begin
									w_flag_gate	<= 1'b0;
									flag_mux	<= 1'b0;
								end
						default: w_p_gate	<= 1'b0;
					endcase
					w_pc_gate      <= 1'b0;  	// increment pc on s0
					next_state     <= state_s0;					
				end		
				// RET, part II, load hi byte of saved PC
				else if (reg_opl[7:0]==8'b11011110) begin
					code_cs_l	   <= 1'b1;		// don't read from code ram			
					alu_func	   <= 4'b1000;	// c_bus = b_bus
					bbus_mux	   <= 3'b110;	// b_bus = d_bus
					sp_mux		   <= 1'b0;		// increment SP
					w_sp_gate	   <= 1'b0;		// allow sp to change
					addx_mux	   <= 2'b10;	// select sp as addx source			
					sram_cs_l	   <= 1'b0;		// select sram
					code_rd_l_gate <= 1'b0;		// and read
					w_ophi_gate    <= 1'b0;		// and latch it into reg_ophi
     				code_rd_l_gate <= 1'b0;	  	
     				w_oplo_gate    <= 1'b0;    // assert oplo gate
					next_state	   <= state_s3;
				end
				// these are the 3 byte branching instructions. so go and fetch the high
				// byte operand
				else begin
					code_cs_l      <= 1'b0;    // allow -cs and -rd to code ram
					code_rd_l_gate <= 1'b0;	  	
					alu_func       <= 4'b1000;
					w_acc_gate     <= 1'b1;
					w_ax_gate      <= 1'b1;
					w_bx_gate	   <= 1'b1;
					w_p_gate       <= 1'b1;														
					bbus_mux       <= 3'b110;				
					pc_mux         <= 1'b1;
					w_pc_gate      <= 1'b0;  // increment pc on s3
    				w_oplo_gate    <= 1'b0;    // assert oplo gate
					next_state <= state_s3;
				end
		end				
		
		/*
		** BRANCHING INSTRUCTIONS,  3 bytes, 4 cycles
		*/
		state_s3: begin
//				w_ophi_gate   <= 1'b0;  // latch-in high byte operand
//				w_oplo_gate   <= 1'b1;  // deassert oplo gate
				// Branching operations - immediate
				if((reg_opl[7]==1'b1)&&(reg_opl[2:0]==3'b000)) begin
						alu_func    <= 4'b1000;  // for debug, c_bus=b_bus
						bbus_mux    <= 3'b110;	// for debug c_bus=d_bus			
						case(reg_opl[6:3])
							4'b0011: if(reg_flag[0]==1'b1) // JE
										pc_mux<=0; 		   	
									 else pc_mux<=1;
							4'b0100: if(reg_flag[0]==1'b0) // JNE
										pc_mux<=0; 
									 else pc_mux<=1;
							4'b0101: if(reg_flag[1]==1'b1) // JP
										pc_mux<=0; 
									 else pc_mux<=1;
							4'b0110: if(reg_flag[1]==1'b0) // JN
										pc_mux<=0; 
									 else pc_mux<=1;
							4'b0111: if(reg_flag[2]==1'b1) // JC
										pc_mux<=0; 
									 else pc_mux<=1;
							4'b1000: if(reg_flag[2]==1'b0) // JNC
										pc_mux<=0; 
									 else pc_mux<=1;
							4'b1001: pc_mux<=0;			   // JMP unconditional 
							default: pc_mux<=pc_mux;
						endcase
						w_pc_gate   <= 1'b0;	// increment pc on s0
						w_ophi_gate   <= 1'b0;  // latch-in high byte operand
						w_oplo_gate   <= 1'b1;  // deassert oplo gate
						next_state  <= state_s0;														
				end 
				// RET, part III, load lo byte of saved PC
				else if (reg_opl[7:0]==8'b11011110) begin
					code_cs_l	   <= 1'b1;		// don't read from code ram			
					alu_func	   <= 4'b1000;	// c_bus = b_bus
					bbus_mux	   <= 3'b100;	// b_bus = reg_pc hi
					sp_mux		   <= 1'b1;		// increment SP
					w_sp_gate	   <= 1'b1;		// disallow sp to change
					addx_mux	   <= 2'b10;	// select sp as addx source			
					sram_cs_l	   <= 1'b0;		// select sram
					code_rd_l_gate <= 1'b0;		// and read
					w_ophi_gate    <= 1'b1;		
					w_oplo_gate	   <= 1'b0;		// and latch it into reg_oplo
					pc_mux	       <= 1'b0;			
					w_pc_gate	   <= 1'b0;		// PC = d_bus	
					w_flag_gate    <= 1'b0;		// restore flag									
					next_state	   <= state_s0;
				end
				// CALL, part I. Allow the PC to be incremented so, that
				// the PC that is pushed onto the stack is pointing to 
				// the instruction after the call
				// what CALL does:
				//		[SP]    <- PC low byte
				//      SP=SP-1
				//		[SP]	<- PC high 4 bits
				//  	SP=SP-1 
				else if (reg_opl[7:0]==8'b11010110) begin
					w_pc_gate	<= 1'b0;
					w_ophi_gate   <= 1'b0;  // latch-in high byte operand
					w_oplo_gate   <= 1'b1;  // deassert oplo gate
					next_state  <= state_s4;
				end
				// Must be direct addresing instruction 
				else begin
					next_state	<= state_s4;
					w_ophi_gate   <= 1'b0;  // latch-in high byte operand
					w_oplo_gate   <= 1'b1;  // deassert oplo gate
					w_pc_gate  	<= 1'b1;      // deassert PC gate.
				end			
		end

		/*
		** DIRECT INSTRUCTIONS,  3 byte, 5 cycles
		*/
		state_s4: begin

				begin
					code_cs_l      <= 1'b1;    
					w_ophi_gate    <= 1'b1;  // latch-in high byte operand
				end

				// LMD and STM instructions
				if ((reg_opl[7:4]==5'b0110)&&(reg_opl[2:0]!=3'b111)) begin
						sram_cs_l 		<= 1'b0;	// select the sram
						addx_mux		<= 2'b00;	// select the sram address	
						w_pc_gate		<= 1'b0;	// increment pc on s0
						pc_mux			<= 1'b1;									
					    alu_func  <= 4'b1000;  // else c_bus = b_bus
						bbus_mux		<= 3'b110; // select d_bus by default
						// if it is STM
						if (reg_opl[3]==1'b1) begin	
							// while in STM, select c_bus=a_bus only if it's STM acc,xx
						    if (reg_opl[2:0]==3'b000)  begin
							   alu_func  <= 4'b1001;  // if DDD=acc c_bus=acc
 							end
							bbus_mux		<= reg_opl[2:0]; // select the approp reg
							code_wr_l_gate	<= 1'b0;
							data_bus_wr		<= 1'b0;	// drive data bus with c_bus							
						end
						// if it is LDM
						else begin
							code_rd_l_gate	<= 1'b0; 
							w_oplo_gate		<= 1'b0;   // latchin oplo with sram data on s4
            				code_rd_l_gate <= 1'b1;	  	
							case (reg_opl[2:0])    // latch approp dest reg on s0					
								3'b001: w_ax_gate      <= 1'b0;
								3'b010: w_bx_gate	   <= 1'b0;
								3'b101: w_p_gate       <= 1'b0;
								3'b100: begin
										w_flag_gate	<= 1'b0;
										flag_mux	<= 1'b0;
										end
								default: w_acc_gate    <= 1'b0;  // else, must be acc
							endcase
						end
						next_state <= state_s0;
				end // LMD if
				// CALL, 3 bytes, 6 cycles
				else if (reg_opl[7:0]==8'b11010110) begin
         				code_rd_l_gate <= 1'b1;	  	
						alu_func   	   <= 4'b1000;  // select c_bus=b_bus
						bbus_mux       <= 3'b011;	// select reg_pc low	
						sp_mux		   <= 1'b1;		// sp = sp - 1 on s5
						w_sp_gate	   <= 1'b0;		// allow sp to decrement
						addx_mux	   <= 2'b10;	// select sp as addx source			
						sram_cs_l      <= 1'b0;		// select sram
						code_wr_l_gate <= 1'b0;		// and write
						data_bus_wr	   <= 1'b0;	    // drive data bus with c_bus							
						w_pc_gate      <= 1'b1;  	// 
						next_state     <= state_s5;											
				end // call				
		end	// state_s4

		/*
		** CALL,  3 byte, 6 cycles
		** save to [SP], [SP-1] PC+1 not PC
		*/
		state_s5: begin
				if (reg_opl[7:0]==8'b11010110) begin
						alu_func   	   <= 4'b1000;  // select c_bus=b_bus
						bbus_mux       <= 3'b100;	// select reg_pc hi
						sp_mux		   <= 1'b1;		// sp = sp - 1 on s0
						w_sp_gate	   <= 1'b0;		// allow sp to decrement
						addx_mux	   <= 2'b10;	// select sp as addx source			
						sram_cs_l      <= 1'b0;		// select sram
						code_wr_l_gate <= 1'b0;		// and write
						data_bus_wr	   <= 1'b0;	    // drive data bus with c_bus							
						pc_mux		   <= 1'b0;		// PC = d_bus						
						w_pc_gate      <= 1'b0;  	// allow pc to be changed
						next_state     <= state_s0;
				end
		end // state_s5

	endcase  //state machine

end


endmodule
