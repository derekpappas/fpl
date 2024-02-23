`timescale 1 ns /100 ps


/*******************************************************************************
*
 * Authors: Adrian Ellsworth & Dennis King
* ---------------------------------------
* Copyright January 1999
*
* Last Edited: March 24, 1999
*
******************************************************************************/


module micro (data_bus, address_bus, wr, rd, iom, sal, sce12, sce34, scue, scu, swr, sclr, sa, sd,
	 clk, reset, bus_select, disp_clk, intr, inta, p24_dir, p25_dir);

inout [15:0] data_bus;
output [15:0] address_bus;
output wr, rd, iom, inta, p24_dir, p25_dir;
output sal, sce12, sce34, scue, scu, swr, sclr;
output [1:0] sa;
output [6:0] sd;
input clk, reset, disp_clk;
input bus_select, intr;		//both controlled by external switches

// external connections
wire [15:0] data_bus, address_bus;
wire wr, rd, iom;
wire sce12, sce34, swr;
wire sal, scue, scu, sclr;
wire [1:0] sa;
wire [6:0] sd;
wire clk, reset, disp_clk;
wire bus_select, intr, inta;
wire p24_dir, p25_dir;

// internal connections;
wire ext_wr, ext_rd, ext_iom;
wire io_en, io_dir, tri_en;
wire alu_to_mem, addr_en;
wire ir_en, ir2_en;
wire [3:0] wr_addr, a_addr, b_addr; // Now use 4 bits r0-r15
wire wr_clk, sel_imm_rega;
wire [2:0] alu_control;
wire [4:0] alu_flags;
wire [15:0] rega, regb, ip, transfer_bus;
wire [15:0] imm, ir_bus, data_buf;
wire [15:0] alu_a, alu_out, ip_reset, alu_flags2;
wire io_dir1, sel_tri; 
wire regstore_reset, sel_fl_alu;
wire iflag;
wire signedflag;

assign p24_dir = 1;
assign p25_dir = 0;
assign io_dir1 = io_en & io_dir;
assign rd = (~io_dir1) & ext_rd & (~ext_wr);
assign sel_tri = alu_to_mem & (~(io_en & (~ io_dir)));
assign wr = ext_wr & (~ext_rd);
assign iom = ext_iom;
assign sal = 1;
assign scue = 0;
assign scu = 1;
assign sclr = 1;

	tranceiver		trans1(data_bus, data_buf, io_en, io_dir1),
				trans2(data_buf, ip, io_en, io_dir);
		
	latch			latch1(alu_out, address_bus[15:0], addr_en),
				latch2(ip, imm, ir_en),
				latch3(ip, ir_bus, ir2_en);

	tristate		tristate1(transfer_bus, ip, sel_tri);

	mux2x1			mux1(imm, rega, alu_a, sel_imm_rega);
			
	flagmuxer		flagmux1(alu_flags, alu_out, transfer_bus, sel_fl_alu, iflag);

	regstore		regstore1(ip, rega, regb, wr_addr, a_addr, b_addr, wr_clk, clk, regstore_reset, alu_flags2);

	alu			alu1(alu_a, regb, alu_out, alu_control, alu_flags, signedflag);

	display			display1(sal, sce12, sce34, scue, scu, swr, sclr, sa,
					sd, address_bus[15:0], data_buf, alu_out, imm, disp_clk, bus_select);

	control_unit 		control1(clk, reset, ir_bus, imm, sel_fl_alu, alu_flags2, ext_wr, ext_rd, ext_iom,
 			     		io_en, io_dir, alu_to_mem,  ir_en, ir2_en, wr_addr, a_addr, intr,
			     		b_addr, wr_clk, alu_control, addr_en, sel_imm_rega, regstore_reset, inta,
					iflag, signedflag);


endmodule



module alu(alu_a, alu_b, alu_out, alu_control, alu_flags, signedflag);

input [15:0] alu_a, alu_b;
input [2:0] alu_control;
input signedflag;
output [15:0] alu_out;
output [4:0] alu_flags;

wire [15:0] alu_a, alu_b;
wire [2:0] alu_control;
wire signedflag;
reg [15:0] alu_out;
reg [4:0] alu_flags;
reg [3:0] alu_temp;

always @(alu_control or alu_a or alu_b or signedflag)
begin
	case(alu_control)

			// Shift Operation - alu_out = alu_a << alu_b
		3'b000 : begin
			 // We are using a 6-bit shift operator value
			 // Bit [5] is the sign of the operator with values ranging 
			 // from +31 to -32
			 if (alu_b[5] == 1) // Signed - Shift to the Right >>
			 begin

				alu_out = (alu_a >> (~alu_b[4:0] + 5'h01));
				
				if (alu_a[~alu_b[4:0]] == 1) // Set the Carry Flag
					alu_flags[2] = 1;
				else	
					alu_flags[2] = 0;							
			 end
			 else	// Postive - Shift to the Left <<
			 begin		
				{alu_flags[2], alu_out} = (alu_a << alu_b[4:0]);
			 end

			 // If the u/s (unsigned/signed) flag is set then check
			 // for an overflow
			 if (signedflag == 1)
			 begin
				if ( (alu_out[15] == 0) && (alu_a[15] == 1) )
			 		alu_flags[3] = 1;
			 	else if ( (alu_out[15] == 1) && (alu_a[15] == 0) )
			 		alu_flags[3] = 1;
			 	else if (alu_out[15] == alu_a[15])
			 		alu_flags[3] = 0;
 			 end
			 else 
				alu_flags[3] = 0;	// Overflow Flag

			 if (alu_out == 0)
			 	alu_flags[0] = 1;	// Zero Flag
			 else
			 	alu_flags[0] = 0;
			 	
			 alu_flags[1] = alu_out[15]; 	// Negative Flag
			 alu_flags[4] = 0;		// Half Overflow Flag
			 end

			 // Addition Operation
		3'b001 : begin
			 // Carry Flag	
			 {alu_flags[2], alu_out} = (alu_a + alu_b);
			 
			 // Half Overflow flag
			 {alu_flags[4], alu_temp} = (alu_a[3:0] + alu_b[3:0]);
			 
 			 // Overflow flag
			 if ( (alu_a[15] == 0) && (alu_b[15] == 0) )
			 	alu_flags[3] = alu_out[15];
			 else if ( (alu_a[15] == 1) && (alu_b[15] == 1) )
			 	alu_flags[3] = !alu_out[15];
			 else
			 	alu_flags[3] = 0;
			 	
			 // Negative flag
			 alu_flags[1] = alu_out[15];
			 
			 // Zero flag
			 if (alu_out == 0)
			 	alu_flags[0] = 1;
			 else
			 	alu_flags[0] = 0;
			 end
			 
			 // Subraction Operation
		3'b010 : begin
			 // Carry Flag
			 {alu_flags[2], alu_out} = (alu_b - alu_a);
			 
			 // Half Overflow flag
			 {alu_flags[4], alu_temp} = (alu_b[3:0] - alu_a[3:0]);
			 	
			 // Overflow flag
			 if ( (alu_b[15] == 0) && (alu_a[15] == 1) )
			 	alu_flags[3] = alu_out[15];
			 else if ( (alu_b[15] == 1) && (alu_a[15] == 0) )
			 	alu_flags[3] = !alu_out[15];
			 else if (alu_b[15] == alu_a[15])
			 	alu_flags[3] = 0;
			 	
			 // Negative flag
			 alu_flags[1] = alu_out[15];
			 
			 // Zero flag
			 if (alu_out == 0)
			 	alu_flags[0] = 1;
			 else
			 	alu_flags[0] = 0;
			 end
			 
			 // AND operation
		3'b011 : begin
			 alu_out = alu_a & alu_b;
			 
			 // Negative flag
			 alu_flags[1] = alu_out[15];
			 
			 // Zero flag
			 if (alu_out == 0)
			 	alu_flags[0] = 1;
			 else
			 	alu_flags[0] = 0;

			 alu_flags[2] = 0;
			 alu_flags[3] = 0;
			 alu_flags[4] = 0; 
			 end
			 
			 // OR operation
		3'b100 : begin
			 alu_out = alu_a | alu_b;

			 // Negative flag
			 alu_flags[1] = alu_out[15];
			 
			 // Zero flag
			 if (alu_out == 0)
			  	alu_flags[0] = 1;
			 else
			  	alu_flags[0] = 0;
			  	
			 alu_flags[2] = 0;
			 alu_flags[3] = 0;
			 alu_flags[4] = 0;
			 end
			 
			 // XOR operation
		3'b101 : begin
			 alu_out = alu_a ^ alu_b;

			 // Negative flag
			 alu_flags[1] = alu_out[15];
			 
			 // Zero flag
			 if (alu_out == 0)
			 	alu_flags[0] = 1;
			 else
			 	alu_flags[0] = 0;

			 alu_flags[2] = 0;
			 alu_flags[3] = 0;
			 alu_flags[4] = 0;
			 end

			 // Increment Operation
		3'b110 : begin
			 {alu_flags[2], alu_out} = alu_a + 1;

			 // Half Overflow flag
			 {alu_flags[4], alu_out[7:0]} = alu_a[7:0] + 1;

			 // Overflow flag
			 if (alu_a[15] == 0)
			 	alu_flags[3] = alu_out[15];
			 else 
			 	alu_flags[3] = 0;
			 			 	
			 // Negative flag
			 alu_flags[1] = alu_out[15];
			 
			 // Zero flag
			 if (alu_out == 0)
			 	alu_flags[0] = 1;
			 else
			 	alu_flags[0] = 0;
			 end


			 // Feedthrough Operation
		3'b111 : begin
			 alu_out = alu_a;

			 // Negative flag
			 alu_flags[1] = alu_out[15];
			 
			 // Zero flag
			 if (alu_out == 0)
			 	alu_flags[0] = 1;
			 else
			 	alu_flags[0] = 0;

			 alu_flags[2] = 0;
			 alu_flags[3] = 0;
			 alu_flags[4] = 0;
			 end
	endcase
end
endmodule



module regstore(regwr, rega, regb, wr_addr, a_addr, b_addr, wr_clk, clk, regstore_reset, alu_flags2);

	output [15:0] rega, regb;
	output [15:0] alu_flags2;
	input [15:0] regwr;
	input [3:0] wr_addr, a_addr, b_addr; // now use 16 registers r0-r15
	input wr_clk, clk, regstore_reset;

	reg [15:0] rega, regb;
	reg [15:0] alu_flags2;
	wire [15:0] regwr;
	wire [3:0] wr_addr, a_addr, b_addr;  // now use 16 registers r0-r15
	wire wr_clk, clk, regstore_reset;

	reg [15:0] 	register0,  register1,  register2,  register3,  register4,  
		   	register5,  register6,  register7,  register8,  register9,  register10, 
		   	register11,  register12,  register13,  register14,  register15; 

		/*   	register16,  register17,  register18,  register19,  register20,  
		   	register21,  register22,  register23,  register24,  register25,  register26,
		   	register27,  register28,  register29,  register30,  register31; */

		
	always @(posedge wr_clk or posedge regstore_reset)
	begin
		if (regstore_reset)
			begin
			register15 = 16'h8000; //will be used to go to first instruction in set
			$display("Setting register15 to IP = %h", register15);
			register0 = 16'h0000;
			register1 = 16'h0000;
			register2 = 16'h0000;
			register3 = 16'h0000;
			register4 = 16'h0000;
			register5 = 16'h0000;
			register6 = 16'h0000;
			register7 = 16'h0000;
			register8 = 16'h0000;
			register9 = 16'h0000;
			register10 = 16'h0000;
			register11 = 16'h0000;
			register12 = 16'h0000;
			register13 = 16'h0000;
			register14 = 16'h0000;
		end
		else
			begin
			case (wr_addr)                
				5'd0 : register0 = regwr; 
				5'd1 : register1 = regwr;
				5'd2 : register2 = regwr;
				5'd3 : register3 = regwr;
				5'd4 : register4 = regwr;
				5'd5 : register5 = regwr;
				5'd6 : register6 = regwr;
				5'd7 : register7 = regwr;
				5'd8 : register8 = regwr; 
				5'd9 : register9 = regwr;
				5'd10 : register10 = regwr;
				5'd11 : register11 = regwr;
				5'd12 : register12 = regwr;
				5'd13 : register13 = regwr;
				5'd14 : register14 = regwr;
				5'd15 : register15 = regwr;

			/*	5'd16 : register16 = regwr; 
				5'd17 : register17 = regwr;
				5'd18 : register18 = regwr;
				5'd19 : register19 = regwr;
				5'd20 : register20 = regwr;
				5'd21 : register21 = regwr;
				5'd22 : register22 = regwr;
				5'd23 : register23 = regwr;
				5'd24 : register24 = regwr; 
				5'd25 : register25 = regwr;
				5'd26 : register26 = regwr;
				5'd27 : register27 = regwr;
				5'd28 : register28 = regwr;
				5'd29 : register29 = regwr;
				5'd30 : register30 = regwr;
				5'd31 : register31 = regwr;   */
			endcase

			//set the alu_flgs2 bus equal to the flag register at all times
			register14 = (register14 & 16'h003F);  //six flags including interrupt flag
			alu_flags2 = register14;

			end
	end 

 	// Cannot use a edge with a non-edge in an always
	always @(a_addr or register0 or register1 or register2 or register3 or register4 or register5 or register6 or 
		register7 or register8 or register9 or register10 or register11 or register12 or register13 or 
		register14 or register15) 
		/* or register16 or register17 or register18 or register19 or register20 or
		register21 or register22 or register23 or register24 or register25 or register26 or register27 or
		register28 or register29 or register30 or register31) */	
	begin
		case (a_addr)
				5'd0 : rega = register0;
				5'd1 : rega = register1;
				5'd2 : rega = register2;
				5'd3 : rega = register3;
				5'd4 : rega = register4;
				5'd5 : rega = register5;
				5'd6 : rega = register6;
				5'd7 : rega = register7;
				5'd8 : rega = register8;
				5'd9 : rega = register9;
				5'd10 : rega = register10;
				5'd11 : rega = register11;
				5'd12 : rega = register12;
				5'd13 : rega = register13;
				5'd14 : rega = register14;
				5'd15 : rega = register15;

			/*	5'd16 : rega = register16;
				5'd17 : rega = register17;
				5'd18 : rega = register18;
				5'd19 : rega = register19;
				5'd20 : rega = register20;
				5'd21 : rega = register21;
				5'd22 : rega = register22;
				5'd23 : rega = register23;
				5'd24 : rega = register24;
				5'd25 : rega = register25;
				5'd26 : rega = register26;
				5'd27 : rega = register27;
				5'd28 : rega = register28;
				5'd29 : rega = register29;
				5'd30 : rega = register30;
				5'd31 : rega = register31;  */
		endcase
	end

	always @(b_addr or register0 or register1 or register2 or register3 or register4 or register5 or register6 or 
		register7 or register8 or register9 or register10 or register11 or register12 or register13 or 
		register14 or register15)
		/* or register16 or register17 or register18 or register19 or register20 or
		register21 or register22 or register23 or register24 or register25 or register26 or register27 or
		register28 or register29 or register30 or register31) */
	begin
		case (b_addr)
				5'd0 : regb = register0;
				5'd1 : regb = register1;
				5'd2 : regb = register2;
				5'd3 : regb = register3;
				5'd4 : regb = register4;
				5'd5 : regb = register5;
				5'd6 : regb = register6;
				5'd7 : regb = register7;
				5'd8 : regb = register8;
				5'd9 : regb = register9;
				5'd10 : regb = register10;
				5'd11 : regb = register11;
				5'd12 : regb = register12;
				5'd13 : regb = register13;
				5'd14 : regb = register14;
				5'd15 : regb = register15;
				
			/*	5'd16 : regb = register16;
				5'd17 : regb = register17;
				5'd18 : regb = register18;
				5'd19 : regb = register19;
				5'd20 : regb = register20;
				5'd21 : regb = register21;
				5'd22 : regb = register22;
				5'd23 : regb = register23;
				5'd24 : regb = register24;
				5'd25 : regb = register25;
				5'd26 : regb = register26;
				5'd27 : regb = register27;
				5'd28 : regb = register28;
				5'd29 : regb = register29;
				5'd30 : regb = register30;
				5'd31 : regb = register31; */
		endcase
	end


endmodule


module tranceiver(port1, port2, io_en, io_dir);
// Enable is active high, direction is from port1 to port2 when io_dir = 0.

	inout [15:0] port1, port2;
 	input io_en, io_dir;
	wire [15:0] port1, port2;
	wire enable1, enable2;
	wire io_en, io_dir, notio_dir;

	not		not1(notio_dir, io_dir);

	and		and1(enable1, io_en, io_dir),
			and2(enable2, io_en, notio_dir);
  
	bufif1		buf10(port1[0], port2[0], enable1),  //This is 16 buffers for each direction of the tranciever
			buf11(port1[1], port2[1], enable1),  
			buf12(port1[2], port2[2], enable1),
			buf13(port1[3], port2[3], enable1),
			buf14(port1[4], port2[4], enable1),
			buf15(port1[5], port2[5], enable1),
			buf16(port1[6], port2[6], enable1),
			buf17(port1[7], port2[7], enable1),    //Direction from port1 to port2
			buf18(port1[8], port2[8], enable1),  
			buf19(port1[9], port2[9], enable1),  
			buf20(port1[10], port2[10], enable1),
			buf21(port1[11], port2[11], enable1),
			buf22(port1[12], port2[12], enable1),
			buf23(port1[13], port2[13], enable1),
			buf24(port1[14], port2[14], enable1),
			buf25(port1[15], port2[15], enable1),
			buf26(port2[0], port1[0], enable2),
			buf27(port2[1], port1[1], enable2),
			buf28(port2[2], port1[2], enable2),
			buf29(port2[3], port1[3], enable2),
			buf30(port2[4], port1[4], enable2),
			buf31(port2[5], port1[5], enable2),
			buf32(port2[6], port1[6], enable2),    //direction from port2 to port1   
			buf33(port2[7], port1[7], enable2),
			buf34(port2[8], port1[8], enable2),
			buf35(port2[9], port1[9], enable2),
			buf36(port2[10], port1[10], enable2),
			buf37(port2[11], port1[11], enable2),
			buf38(port2[12], port1[12], enable2),
			buf39(port2[13], port1[13], enable2),
			buf40(port2[14], port1[14], enable2),
			buf41(port2[15], port1[15], enable2);

endmodule


module mux2x1 (in0, in1, out, select);
// This module models a 16 bit 2 to 1 multiplexer

	input [15:0] in0, in1; 			//Two 16-bit inputs into the muxer
	output [15:0] out;                      //One 16-bit output
	input select;				//The Select line
        wire [15:0] in0, in1;	                //Was not here for compiliong version
	reg [15:0] out;				//Make the connections

	always @(select or in0 or in1)		//wait until triiger of select
	begin					//or ino , in1
		case (select)               //If select is toggled
			0 : out = in0;		//If Select == 0 then ouput in0
			1 : out = in1;		//if Select == 1 then output in1
		endcase
	end	

endmodule

module flagmuxer (in0, in1, out, select, iflag);
// This module models a 16 bit 2 to 1 multiplexer

	input [15:0] in1; 			//Two 16-bit inputs into the muxer
	input [4:0] in0;
	output [15:0] out;                      //One 16-bit output
	input select, iflag;			//The Select line
        wire [15:0] in1;
	wire [4:0] in0;	                //Was not here for compiliong version
	reg [15:0] out;				//Make the connections
	


	always @(select or in0 or in1 or iflag)		//wait until triiger of select
	begin					//or ino , in1
		case (select)               //If select is toggled
			0 : begin 
				out[4:0] = in0[4:0];		//If Select == 0 then ouput in0
				out[5] = iflag;
				out[15:6] = 10'b0000000000; 
			end

			1 : out = in1;		//if Select == 1 then output in1
		endcase
	end	

endmodule



module tristate(in, out, enable);

// 16 bit 3 state buffer.  enable is active high

	input [15:0] in;	         	//16-bit input
	output [15:0] out;     			//16-bit output
	input enable;          			//enable to drive the data through
	wire [15:0] in;           
	reg [15:0] out;        			//make the connections
	wire enable;

	always @(enable or in)    		//Whenever there is an enable or data has  
	begin                     		//arrived at the input 
		case (enable)
			1'b0 : out = 16'bz;   	//if enable is low the output is high impedence
			1'b1 : out = in;     	//if enable  is high then ouput = input
		endcase
	end

endmodule


module latch(in, out, enableh);
//This modules simulates a 16-bit latch

	input [15:0] in;			//16-bit input
	output [15:0] out;			//16-bit output	
	input enableh;				//enable for the latch
	wire [15:0] in;				//Make the connection
	reg [15:0] out;

	always @(posedge enableh)     		//Every possitive edge of the enableh going 
		out = in;			//high, set output = input

endmodule


module display(sal, sce12, sce34, scue, scu, swr, sclr, sa, sd, bus0, bus1,
		bus2, bus3, clk, bus_select);
//This module recieves data from various bus's in the micro and drives the 
//correct coverted one out to the display unit

	output sal, sce12, sce34, scue, scu, swr, sclr; //sal if for the blanking
	output [1:0] sa;				//scue, cursor select enable
	output [6:0] sd;				
	input [15:0] bus0, bus1, bus2, bus3;		//4 16-bit inputs into the mudule	
	input clk;
        input bus_select;
	reg sce12, swr;
	wire sal, scue, scu, sclr, sce34;
	reg [1:0] sa;					//Make connections
	wire [6:0] sd;
	wire [15:0] bus0, bus1, bus2, bus3;
	wire [15:0] word0, word1;
	wire clk;
	
	wire [2:0] select;
	wire [3:0] out;

	assign sal = 1;					//turning  of the blanking mode
	assign scue = 0;				//diabling cursor select enable
	assign scu = 1;					//
	assign sclr = 1;				//diabling the clr mode
	assign select[0] = sa[0];				
	assign select[1] = sa[1];
	assign select[2] = sce12;
	assign sce34 = ~sce12;

	disp_decoder	decoder1(out, sd);

	disp_mux	mux1(select,word1, word0, out);

	mux4_to_2       mux2(bus_select, bus0, bus1, bus2, bus3, word0, word1);



	always
	begin
		
		@(posedge clk)
		begin	
			sce12 = 1;			//Adress_bus display selected
			sa = 2'b00;			//choose digit on display
			swr = 0;			//
		end

		@(posedge clk)
			swr = 1;

		@(posedge clk)
		begin
			sa = 2'b01;
			swr = 0;
		end

		@(posedge clk)
			swr = 1;

		@(posedge clk)
		begin
			sa = 2'b10;
			swr = 0;
		end

		@(posedge clk)
			swr = 1;

		@(posedge clk)
		begin
			sa = 2'b11;
			swr = 0;
		end

		@(posedge clk)
			swr = 1;


		@(posedge clk)
		begin
			sce12 = 0;
			sa = 2'b00;
			swr = 0;
		end

		@(posedge clk)
			swr = 1;

		@(posedge clk)
		begin
			sa = 2'b01;
			swr = 0;
		end

		@(posedge clk)
			swr = 1;

		@(posedge clk)
		begin
			sa = 2'b10;
			swr = 0;
		end

		@(posedge clk)
			swr = 1;

		@(posedge clk)
		begin
			sa = 2'b11;
			swr = 0;
		end

		@(posedge clk)
			swr = 1; 

	end

endmodule

module disp_decoder(nibble, ascii);
//Takes a 4-bit nibble and converts it into ascii

	input [3:0]nibble;
	output [6:0]ascii;
	
	wire [3:0]nibble;
	reg [6:0]ascii;

	always @(nibble)
	begin
		case (nibble)
			4'h0 : ascii = 7'h30;
			4'h1 : ascii = 7'h31;
			4'h2 : ascii = 7'h32;
			4'h3 : ascii = 7'h33;
			4'h4 : ascii = 7'h34;
			4'h5 : ascii = 7'h35;
			4'h6 : ascii = 7'h36;
			4'h7 : ascii = 7'h37;
			4'h8 : ascii = 7'h38;
			4'h9 : ascii = 7'h39;
			4'ha : ascii = 7'h41;
			4'hb : ascii = 7'h42;
			4'hc : ascii = 7'h43;
			4'hd : ascii = 7'h44;
			4'he : ascii = 7'h45;
			4'hf : ascii = 7'h46;
			default: ascii = 7'h46;
		endcase
	end

endmodule

module disp_mux(select, word0, word1, out);
//This module chooses what 16-bit to choose

	input [2:0] select;
	input [15:0] word0, word1;
	output [3:0] out;

	wire [2:0] select;
	reg [3:0] out;

	always @(select or word0 or word1)
	begin
		case (select)
			3'b000 : out = word0[3:0];
			3'b001 : out = word0[7:4];
			3'b010 : out = word0[11:8];
			3'b011 : out = word0[15:12];
			3'b100 : out = word1[3:0];
			3'b101 : out = word1[7:4];
			3'b110 : out = word1[11:8];
			3'b111 : out = word1[15:12];
		endcase
	end

endmodule


module mux4_to_2 (bus_select, in0, in1, in2, in3, out0, out1);
// This module models a 16 bit 4 to 2 multiplexer

	input [15:0] in0, in1, in2, in3;	//4 16-bit inputs into the muxer
	output [15:0] out0, out1;               //One 16-bit output
	input bus_select;			//The Select line
        wire [15:0] in0, in1, in2, in3;         //Was not here for compiliong version
	reg [15:0] out0, out1;			//Make the connections
	wire bus_select;

	always @(bus_select or in0 or in1 or in2 or in3)		//wait until triiger of select
	begin					
		case (bus_select)           //If select is toggled
			
			0 : begin
				out0 = in0;	//If Select == 0 then ouput in0 and in1
				out1 = in1;	
			    end	
			1 : begin
				out0 = in2;	//if Select == 1 then output in2 and in3
				out1 = in3;
			    end	
		endcase
	end	

endmodule


/*******************************************************************************
* Module control_unit - This block of code will fetch, decode and execute
* 			instuctions.
*			
*	This module will generate all the appropiate control signals to do
* 	certain operations. It is a big state machine.
*
* ALU Flags (alu_flags[4:0])
* --------------------------
* alu_flags[0] Z - Zero
* alu_flags{1] N - Negative
* alu_flags[2] C - Carry
* alu_flags[3] V - Overflow
* alu_flags[4] HV - Half Overflow
*
* Aliases for Registers in the Regstore
* -------------------------------------
* FL = R28 (flags)
* RA = R29 (return address)
* SP = R30 (stack pointer)
* IP = R31 (instruction pointer)
*
* ALU Control Operation
* ---------------------
* 001 == A Plus B	101 == A ^ B
* 010 == A Minus B	 == B << A
* 011 == A & B		 == A Plus 1
* 100 == A | B		111 == A
*
*******************************************************************************/
module control_unit (clk, reset, ir_bus, imm_bus, sel_fl_alu, alu_flags2, ext_wr, ext_rd, ext_iom,
 		     io_en, io_dir, alu_to_mem, ir_en, ir2_en, wr_addr, a_addr, intr,
		     b_addr, wr_clk, alu_control, addr_en, sel_imm_rega, regstore_reset, inta,
		     iflag, signedflag);

// This module is for fetching, decoding and executing instructions for our RISC
// micro design.

input clk, reset, intr;
input [15:0] ir_bus, imm_bus;
input [15:0] alu_flags2;

output ext_wr;  // ext_wr = 1 for a RAM/EPROM write operation
output ext_rd;  // ext_rd = 1 for a RAM/EPROM read operation
output ext_iom; // ext_iom = 0 for a Memory operation, 1 for a I/O operation
output io_en;
output io_dir;
output alu_to_mem, sel_imm_rega;// sel_imm_rega = 0 to mux imm_bus else mux rega (in1) through 
output ir_en;   		// ir_en = 1 to hold the lower 16-bits of IR
output ir2_en;  		// ir2_en = 1 to hold the upper 16-bits of IR
output [3:0] wr_addr; 		// the address to write to in the Register Store Unit (r0 - r15)
output [3:0] a_addr;		// the address of the register to put out onto the A-Bus
output [3:0] b_addr;    	// the address of the register to put out onto the B-Bus
output wr_clk;			// (0 to a 1 transistion) clock to write value at ip into wr_addr
output [2:0] alu_control;	// 3-bit ALU operation
output addr_en;			// addr_en = 1 to latch alu_out[15:0] to address_bus[15:0] 
output regstore_reset; 	 	// Reset signal for register store unit to set register31 = 8000H
output sel_fl_alu;		// select the muxer for the desired output.  Flags or alu_out
output inta, iflag;		// Interrupt Acc. and interrupt flag
output signedflag;		// Signed Flag used for the ALU SHIFTu/sx instruction  

// External connections
wire clk, reset, intr;
wire [15:0] ir_bus, imm_bus;
wire [15:0] alu_flags2;
wire iflag;
assign iflag = alu_flags2[5];

reg regstore_reset, sel_fl_alu;
reg ext_wr, ext_rd, ext_iom, inta;
reg io_en, io_dir, sel_imm_rega;
reg alu_to_mem, ir_en, ir2_en;
reg [3:0] wr_addr, a_addr, b_addr;
reg wr_clk, addr_en, a_clk, b_clk;
reg [2:0] alu_control; 
reg signedflag;

// Internal connections, variables, regs, etc.
wire [31:0] instruction;  // This will hold the value of the full instruction
assign instruction = {ir_bus[15:0], imm_bus[15:0]};

integer condition; // condition = 1 for TRUE and condition = 0 for FALSE


	always
	begin    

/**********************************RESET OPERATION*********************************************/
	
		@(posedge clk)
		begin
			if (reset)
			begin
				// Re-initalize the appropiate control lines and registers 
				$display("entered control reset");
				ext_wr = 0;
				ext_rd = 0;		// Initialize all control lines for data transfers
				ext_iom = 0;
				io_en = 0;
				sel_fl_alu = 1;
				sel_imm_rega = 1;
				io_dir = 0;
				alu_to_mem = 0;
				inta = 0;
				regstore_reset = 1;     //reset the ip register	
				
				@(posedge clk)
				begin
					regstore_reset = 0;
				end
			end
		end
	
/**********************************FIRST OPERATION*********************************************/

		// Start the FETCH sequence in the Control Unit State Machine
		@(posedge clk)
		begin	
			$display("inside first clk");
			alu_to_mem = 0;	
			sel_imm_rega = 1;
			sel_fl_alu = 1;
			alu_control = 3'b111;	// alu_out = alu_b
			a_addr = 4'b1111;	// Select Register r31 (IP)
		end


		@(posedge clk)  // 4 clocks
		begin
			addr_en = 1;
		end
	
		@(posedge clk)
		begin
			addr_en = 0;
		end

/**********************************SECOND OPERATION******************************************/
		
		@(posedge clk)
		begin
			$display("inside 2nd clk");
			io_en = 1;	// Setup the transcievers to read in data from
			io_dir = 0;	// the data bus and put it on the imm_bus.
			ext_rd = 1;	// This will get the lower 16-bits of the
			// instruction.  (imm_bus) = ((IP))
		end

		@(posedge clk)   // 7 clocks
		begin
			ir_en = 1; 
		end
				
		@(posedge clk)
		begin
			ir_en = 0;
			io_en = 0;
		end

		@(posedge clk)
		begin
			ext_rd = 0;
		end

/**********************************THIRD OPERATION******************************************/

		@(posedge clk)
		begin
			$display("inside 3nd clk");
			io_en = 0;		// (r31) = (r31) + 1
			alu_to_mem = 1;
			sel_imm_rega = 1;
			sel_fl_alu = 1;
			alu_control = 3'b110; 	// B + 1
			wr_addr = 4'b1111;	// (IP) = (IP) + 1
			a_addr = 4'b1111;	// a_addr = r31
			// A high to a low transition will
			// write the data into r31.
		end


		@(posedge clk)
		begin
			wr_clk = 1; 
		end

		@(posedge clk)
		begin
			wr_clk = 0;
			alu_to_mem = 0;
		end

/*********************************FOURTH OPERATION******************************************/

		@(posedge clk)
		begin
			$display("inside 4nd clk");
			sel_imm_rega = 1;
			sel_fl_alu = 1;
			alu_control = 3'b111; 	// alu_out = alu_b
			a_addr = 4'b1111;	// r31
			// Put out the address of the next
			// instuction on the address bus
		end

		@(posedge clk)		// 14 clocks
		begin
			addr_en = 1; 
		end

		@(posedge clk)
		begin
			addr_en = 0; 
		end

/*******************************FIFTH OPERATION************************************************/

		@(posedge clk)
		begin
			$display("inside 5nd clk");
			io_en = 1;	// Setup the transcievers to read in data
			io_dir = 0;
			ext_rd = 1;	// This will get the upper 16-bits of the 
			// instruction
			// (ir_bus) = ((IP+1))
		end

		@(posedge clk)
		begin
			ir2_en = 1; 
		end

		@(posedge clk)
		begin
			ir2_en = 0;
			io_en = 0;
		end

		@(posedge clk)
		begin
			ext_rd = 0;
		end


/******************************SIXTH OPERATION**************************************************/

		@(posedge clk)	// 20 clocks
		begin	
			$display("inside 6nd clk");
						// (r31) = (r31) + 1
			alu_to_mem = 1;
			sel_imm_rega = 1;	// (IP) = (IP) + 1/ 
			sel_fl_alu = 1;
			alu_control = 3'b110; 	// B + 1
			wr_addr = 4'b1111;	//
			a_addr = 4'b1111;	//
				// Increment (IP) on a positive edge clock
				// Reset wr_clk to 0	
		end

		@(posedge clk)
		begin
			wr_clk = 1; 
		end

		@(posedge clk)
		begin
			wr_clk = 0;
			alu_to_mem = 0;
		end

/********************************DECODE INSTRUCTION************************************************/

		// We now have fetched our instruction and it will be stored in the
		// reg instruction[31:0] = {ir_bus[15:0], imm_bus[15:0]}
		/* ALU Flags (alu_flags[4:0])
		* --------------------------
		* alu_flags[0] Z - Zero
		* alu_flags[1] N - Negative
		* alu_flags[2] C - Carry
		* alu_flags[3] V - Overflow
		* alu_flags[4] HV - Half Overflow
		*/
		// We will now DECODE the instruction in the Control Unit State Machine
		@(posedge clk) // 23 clocks
		begin
			case ( instruction[31:27] ) // Figure out the Mnemonic
			
/*********************************** JMPcc, IJMPcc, DJMPcc ********************************************************/

				5'b10000,	 // DJMP  IP = Rb + RI
				5'b00100,	 // IJMP  IP = RB + disp16
				5'b00000 : begin // JMPcc IP = addr16

					$display("Inside the JMP instruction");					

					case ( instruction[26:22] ) // Look at cc (Condition)
					
						5'b00000 : condition = 1; // blank - Always
						5'b00001 : condition = 0; // NOP - Never
						5'b00010 : begin // Z - Z=1  Jump Zero
							if (alu_flags2[0] == 1)
								condition = 1; // TRUE
							else 
								condition = 0; // FALSE
							end
						5'b00011 : begin // NZ (Not Zero) - Z=0
							if (alu_flags2[0] == 0)
								condition = 1; // TRUE
							else 
								condition = 0; // FALSE
							end 
						5'b00100 : begin // N (Negative) - N=1
							if (alu_flags2[1] == 1)
								condition = 1;
							else
								condition = 0;
							end
						5'b00101 : begin // NN (Not Negative) - N=0
							if (alu_flags2[1] == 0)
								condition = 1;
							else
								condition = 0;
							end	
						5'b00110 : begin // C (Carry) - C=1
							if (alu_flags2[2] == 1) 
								condition = 1;
							else 
								condition = 0;
							end
						5'b00111 : begin // NC (No Carry) - C=0
							if (alu_flags2[2] == 0)
								condition = 1;
							else 
								condition = 0;
							end
						5'b01000 : begin // V (Overflow) - V=1
							if (alu_flags2[3] == 1)
								condition = 1;
							else
								condition = 0;
							end
						5'b01001 : begin // NV (No Overflow) - V=0
							if (alu_flags2[3] == 0)
								condition = 1;
							else
								condition = 0;
							end
						5'b01010 : begin // HV (Half Overflow) - HV=1
							if (alu_flags2[4] == 1)
								condition = 1;
							else
								condition = 0;
							end
						5'b01011 : begin // NHV (No Half Overflow) - HV=0
							if (alu_flags2[4] == 0)
								condition = 1;
							else 
								condition = 0;
							end
						5'b01100 : begin // GTE (Greater Then or Equal) - (V=0, N=0) or (V=1, N=1)
							if ( (alu_flags2[3] == 0 && alu_flags2[1] == 0) ||
							     (alu_flags2[3] == 1 && alu_flags2[1] == 1) )
								condition = 1;
							else
								condition = 0;
							end
						5'b01101 : begin // LT (Less Then) - (V=1, N=0) or (V=0, N=1)
							if ( (alu_flags2[3] == 1 && alu_flags2[1] == 0) ||
							     (alu_flags2[3] == 0 && alu_flags2[1] == 1) )
								condition = 1;
							else 
								condition = 0;
							end 
						5'b01110 : begin // GT (Greater Then) - (V=0, N=0, Z=0) or (V=1, N=1, Z=0)
							if ( (alu_flags2[3] == 0 && alu_flags2[1] == 0 && alu_flags2[0] == 0) ||
 							     (alu_flags2[3] == 1 && alu_flags2[1] == 1 && alu_flags2[0] == 0) )
								condition = 1;
							else
								condition = 0;
							end
						5'b01111 : begin // LTE (Less Then or Equal) - (V=1, N=0) or (V=0, N=1) or (Z=1)
							if ( (alu_flags2[3] == 1 && alu_flags2[1] == 0) ||
							     (alu_flags2[3] == 0 && alu_flags2[1] == 1) ||
							     (alu_flags2[0] == 1) ) 
								condition = 1;
							else
								condition = 0;
							end
						5'b10000 : begin // GTEU - (C=0) // Fixed
							if ( (alu_flags2[2] == 0) )
								condition = 1;
							else
								condition = 0;
							end
						5'b10001 : begin // LTU - (C=1) // Fixed
							if ( (alu_flags2[2] == 1) )
								condition = 1;
							else
								condition = 0;
							end
						5'b10010 : begin // GTU - (C=0, Z=0) // Fixed
							if ( (alu_flags2[2] == 0) && (alu_flags2[0] == 0) )
								condition = 1;
							else
								condition = 0;
							end
						5'b10011 : begin  // LTEU - (C=1, Z=0) or (C=0, Z=1) // Fixed
							if ( ((alu_flags2[2] == 1) && (alu_flags2[0] == 0)) ||
							     ((alu_flags2[2] == 0) && (alu_flags2[0] == 1)) )
								condition = 1;
							else
								condition = 0;
							end
					endcase	// End of cc

					// Now EXECUTE the JMP instruction

					if (condition == 1) // IP = addr16
					begin	
						$display("condition == true");

						@(posedge clk)
						begin
							if ( instruction[31:27] == 5'b00000 )  		// JMPcc
							begin
								$display("JMPcc");
								alu_control = 3'b111;			// (IP) = addr16
								sel_imm_rega = 0;			// Select IMM BUS
								sel_fl_alu = 1;
								alu_to_mem = 1;   
								wr_addr = 4'b1111;
							end

							else if( instruction[31:27] == 5'b00100 )	// DJMPcc
							begin
								$display("DJMPcc");
								b_addr = instruction[21:17];
								alu_control = 3'b001;			// (IP) = RB + DISP16
								sel_imm_rega = 0;			// Select IMM Bus
								sel_fl_alu = 1;
								alu_to_mem = 1;   
								wr_addr = 4'b1111;
							end

							else if( instruction[31:27] == 5'b10000 )	// IJMPcc
							begin
								$display("IJMPcc");
								b_addr = instruction[21:17];		// Select RB
								a_addr = instruction[15:11];		// Select RI
								sel_imm_rega = 1;			// Select Rega
								sel_fl_alu = 1;
								alu_control = 3'b001;			// Add operation
								alu_to_mem = 1;   			// Write new IP
								wr_addr = 4'b1111;
							end
						end
					
						@(posedge clk)
						begin
							wr_clk = 1;
						end
						
						@(posedge clk)
						begin
							wr_clk = 0;
						end
						
						@(posedge clk)
						begin
							alu_to_mem = 0;
						end
						
					end

					else // Do nothing
						$display("condition == false");
					
					end // End JMPcc
									
				

/*********************************** CALL, ICALL, DCALL ********************************************************/
								
				// CALL Instruction
				5'b00101,		// DCALL IP = RB + disp16
				5'b10001,		// ICALL IP = RB + RI
				5'b00001 : begin 	// Look at R? (Register Encoding)
							// RA (Return Address) = register?
							// RA = IP, IP = addr16

					$display("In the (D/I)CALL Instruction");
					$display("addr16 = %h", instruction[15:0]);
					$display("instuction[26:22] = %b ", instruction[26:22]);  
					$display("register = %d ", instruction[26:22]);					
					
					//*********Save the IP register in the RA register********	
					@(posedge clk) // 24 clocks
					begin
						io_en = 0;		//
						alu_to_mem = 1;		// RA = IP
						sel_imm_rega = 1;	//
						sel_fl_alu = 1;
						alu_control = 3'b111; 	//
						wr_addr = instruction[25:22]; // wr_addr = instruction[26:22] = RA
						a_addr = 4'b1111;
					end

					@(posedge clk)
					begin
						wr_clk = 1; 
					end

					@(posedge clk)
					begin
						wr_clk = 0;
						alu_to_mem = 0;		// Write in the value of IP into 
 									// register? (RA) so we can return later
					end	 

					//
					@(posedge clk)
					begin
						if ( instruction[31:27] == 5'b00001 )
						begin
							$display("CALL");
							alu_control = 3'b111;		// IP = addr16
							alu_to_mem = 1;		// 
							sel_imm_rega = 0;	// imm_bus == addr16
							sel_fl_alu = 1;
							wr_addr = 4'b1111;	// wr_addr = IP (r31)
						end

						else if( instruction[31:27] == 5'b00101 )
						begin
							$display("DCALL");
							b_addr = instruction[21:17];
							alu_control = 3'b001;			// (IP) = RB + DISP16
							sel_imm_rega = 0;			// Select IMM Bus
							sel_fl_alu = 1;
							alu_to_mem = 1;   
							wr_addr = 4'b1111;
						end
						
						else if( instruction[31:27] == 5'b10001 )
						begin
							$display("ICALL");
							b_addr = instruction[21:17];		// Select RB
							a_addr = instruction[15:11];		// Select RI
							sel_imm_rega = 1;			// Select Rega
							sel_fl_alu = 1;
							alu_control = 3'b001;			// Add operation
							alu_to_mem = 1;   			// Write new IP
							wr_addr = 4'b1111;
						end


					end

					@(posedge clk)
					begin
						wr_clk = 1; 
					end

					@(posedge clk)
					begin
						wr_clk = 0;		// Write in the new value of IP
						alu_to_mem = 0;		// into the regstore
					end

					end // End CALL
					


/*********************************** LOADm/p, ILOADm/p, DLOADm/p ********************************************************/

				// LOADm/p Instruction
				5'b00110,		// RC = (disp16 + RB)  DLOAD
				5'b10010,		// RC = (RB + RI)      ILOAD	
				5'b00010 : begin	// RC = (addr16)       LOAD	

					
					if (instruction[16] == 1)
						ext_iom = 1;   	// Perform I/O Operation
					else
						ext_iom = 0;	// Perform Memory Operation

					@(posedge clk)
					begin
						if( instruction[31:27] == 5'b00010 )
						begin
							sel_imm_rega = 0;	// Output addr16 onto the address_bus
							alu_control = 3'b111;   // A 
							$display("In the LOADm/p Instruction");
						end

						else if( instruction[31:27] == 5'b00110 )
						begin
							b_addr = instruction[21:17];
							alu_control = 3'b001;			// (IP) = RB + DISP16
							sel_imm_rega = 0;			// Select IMM Bus
							$display("In the DLOADm/p Instruction");
						end
						else if( instruction[31:27] == 5'b10010 )
						begin
							b_addr = instruction[21:17];		// Select RB
							a_addr = instruction[15:11];		// Select RI
							sel_imm_rega = 1;			// Select Rega
							alu_control = 3'b001;			// Add operation
							$display("In the ILOADm/p Instruction");
						end

					end

					$display("addr16 = %h", instruction[15:0]);
					$display("register = %d m/p = %b", instruction[26:22], instruction[16]);

					@(posedge clk)
					begin
						addr_en = 1; 
					end

					@(posedge clk)
					begin
						addr_en = 0; 
					end

					@(posedge clk)
					begin
						io_en = 1;		// RC = (addr16)
						io_dir = 0;		//
						ext_rd = 1;		// Setup the transcievers to read in data
						wr_addr =  instruction[25:22]; // wr_addr = RC = instruction[26:22]
					end

					@(posedge clk)
					begin
						wr_clk = 1; 
					end

					@(posedge clk)
					begin
						wr_clk = 0; 
					end


					@(posedge clk)
					begin
						ext_rd = 0;
						io_en = 0;
						ext_iom = 0;
					end
				

					end // End LOADm/p



/*********************************** STOREm/p, DSTOREm/p, ISTOREm/p ********************************************************/

				// STOREm/p Instruction
				5'b00111,			// (disp16 + RC) = RC  DSTOREm/p
				5'b10011,			// (RB + RI) = RC      ISTOREm/p
				5'b00011 : begin		// (addr16) = RC       STOREm/p
											
					if (instruction[16] == 1)
						ext_iom = 1;   	// Perform I/O Operation
					else
						ext_iom = 0;	// Perform Memory Operation

					@(posedge clk)
					begin
						
						if( instruction[31:27] == 5'b00011 )
						begin
							sel_imm_rega = 0;	// Output addr16 onto the address_bus
							alu_control = 3'b111;   // A 
							$display("In the STOREm/p Instruction");
						end

						else if( instruction[31:27] == 5'b00111 )
						begin
							b_addr = instruction[21:17];
							alu_control = 3'b001;			// (IP) = RB + DISP16
							sel_imm_rega = 0;			// Select IMM Bus
							$display("In the DSTOREm/p Instruction");
						end
						else if( instruction[31:27] == 5'b10011 )
						begin
							b_addr = instruction[21:17];		// Select RB
							a_addr = instruction[15:11];		// Select RI
							sel_imm_rega = 1;			// Select Rega
							alu_control = 3'b001;			// Add operation
							$display("In the ISTOREm/p Instruction");
						end

					end

					$display("addr16 = %h", instruction[15:0]);
					$display("register = %d m/p = %b", instruction[26:22], instruction[16]);					
					@(posedge clk)
					begin
						addr_en = 1; 
					end

					@(posedge clk)
					begin
						addr_en = 0; 
					end

					@(posedge clk)
					begin
						io_en = 1;			// (addr16) = RC
						io_dir = 1;			//
						sel_imm_rega = 1;		// Setup the transcievers to write out data
						alu_to_mem = 1;			//
						a_addr =  instruction[25:22]; 	// a_addr = RC = instruction[26:22]
						alu_control = 3'b111;		// A
					end

					@(posedge clk)
					begin
						ext_wr = 1; 
					end

					@(posedge clk)
					begin
						ext_wr = 0; 
					end


					@(posedge clk)
					begin
						io_en = 0;
						io_dir = 0;
						alu_to_mem = 0;
						ext_iom = 0;
					end

					end // End STOREm/p



/*********************************** ADDx, SUBx, ANDx, ORx, XORx ********************************************************/

				5'b11001,	// ADDx Instruction  RC = RB + RX
				5'b11010, 	// SUBx Instruction  RC = RB - RX
				5'b11011, 	// ANDx Instruction  RC = RB & RX
				5'b11100, 	// ORx Instruction   RC = RB | RX
				5'b11101 : 	// XORx Instruction  RC = RB ^ RX
					begin
				
					if ( instruction[31:27] == 5'b11001 )  		// ADDx
					begin
						$display("In the ADDx Instruction");
						alu_control = 3'b001;
					end
					else if( instruction[31:27] == 5'b11010 )	// SUBx
					begin
						$display("In the SUBx Instruction");
						alu_control = 3'b010;
					end
					else if( instruction[31:27] == 5'b11011 )	// ANDx
					begin
						$display("In the ANDx Instruction");
						alu_control = 3'b011;
					end
					else if( instruction[31:27] == 5'b11100 )	// ORx
					begin
						$display("In the ORx Instruction");
						alu_control = 3'b100;
					end
					else if( instruction[31:27] == 5'b11101 )	// XORx
					begin
						$display("In the XORx Instruction");
						alu_control = 3'b101;
					end

					$display("RC = %d RB = %d RX = %d x = %b", instruction[26:22], instruction[21:17],
							  instruction[15:11], instruction[16]);
					$display("alu_control = %b", alu_control);


					//*****Set up A and B inputs to the ALU for proper Flag result******
					@(posedge clk)
					begin
						io_en = 0;
						sel_imm_rega = 1;		//   
						a_addr = instruction[14:11];	// RB
						b_addr = instruction[20:17];	// RX
					end

					//*****Write the Flags into Register14 if user desired***************
					if (instruction[16] == 0)	//Make a copy of the flags
					begin
						$display("Operation affects the flags");

						@(posedge clk)
						begin
							alu_to_mem = 1;			
							sel_fl_alu = 0;
							wr_addr = 5'b1110;    //Write into flag register 14.
						end

						@(posedge clk)
						begin
							wr_clk = 1;
						end

						@(posedge clk)
						begin
							wr_clk = 0;
							alu_to_mem = 0;
						end

					end

					else
					begin
						$display("Operation has no affect on the flags");
					end


					//******Write the result into the correct Register*********************
					@(posedge clk)
					begin
						sel_fl_alu = 1;
						alu_to_mem = 1;
						wr_addr = instruction[25:22];	// RC

					end
				
					@(posedge clk)
					begin
						wr_clk = 1; 
					end

					@(posedge clk)
					begin
						wr_clk = 0;
						alu_to_mem = 0;
 					end

					$display("alu_flags2 = %b", alu_flags2);

					
					end // ADDx, SUBx, ANDx, ORx, XORx

			

/*********************************** ADDLx, SUBLx, ANDLx, ORLx, XORLx ********************************************************/

				5'b01001, 	// ADDLx Instruction  RC = RB + imm16
				5'b01010, 	// SUBLx Instruction  RC = RB - imm16
				5'b01011, 	// ANDLx Instruction  RC = RB & imm16
				5'b01100, 	// ORLx Instruction   RC = RB | imm16
				5'b01101 : 	// XORLx Instruction  RC = RB ^ imm16
					begin
			
					if ( instruction[31:27] == 5'b01001 )  		// ADDLx
					begin
						$display("In the ADDLx Instruction");
						alu_control = 3'b001;
					end
					else if( instruction[31:27] == 5'b01010 )	// SUBLx
					begin
						$display("In the SUBLx Instruction");
						alu_control = 3'b010;
					end
					else if( instruction[31:27] == 5'b01011 )	// ANDLx
					begin
						$display("In the ANDLx Instruction");
						alu_control = 3'b011;
					end
					else if( instruction[31:27] == 5'b01100 )	// ORLx
					begin
						$display("In the ORLx Instruction");
						alu_control = 3'b100;
					end
					else if( instruction[31:27] == 5'b01101 )	// XORLx
					begin
						$display("In the XORLx Instruction");
						alu_control = 3'b101;
					end

					$display("RC = %d RB = %d imm16 = %h x = %b", instruction[26:22], instruction[21:17],
							  instruction[15:0], instruction[16]);
					$display("alu_control = %b", alu_control);


					//*****Set up A and B inputs to the ALU for proper Flag result******
					@(posedge clk)
					begin
						io_en = 0;			// RC = RB function imm16
						sel_imm_rega = 0;		// 
						b_addr = instruction[20:17];	// RB
					end


					//*****Write the Flags into Register14 if user desired***************
					if (instruction[16] == 0)	//Save the value of the flags into R14
					begin
						
						@(posedge clk)
						begin
							alu_to_mem = 1;
							sel_fl_alu = 0;
							wr_addr = 5'b1110;    //Write into flag register 14.
						end

						@(posedge clk)
						begin
							wr_clk = 1;
						end

						@(posedge clk)
						begin
							wr_clk = 0;
							alu_to_mem = 0;
						end

					end

					else
					begin
						$display("Operation has no affect on the flags");  // Check with Diduch 
					end


					//******Write the result into the correct Register*********************
					@(posedge clk)
					begin
						sel_fl_alu = 1;
						alu_to_mem = 1;
						wr_addr = instruction[25:22];	// RC
					end

					@(posedge clk)
					begin
						wr_clk = 1; 
					end

					@(posedge clk)
					begin
						wr_clk = 0;
						alu_to_mem = 0;
 					end

				
					$display("alu_flags2 = %b", alu_flags2);
						
					end // ADDLx, SUBLx, ANDLx, ORLx, XORLx



/*********************************** SWAP ********************************************************/

				// SWAP Instruction
			/*	5'b10111 : begin	// RC = (RB+RI), (RB+RI) = RC or 1 

					$display("In the SWAP Instruction");
					$display("RC = %d RB = %d RI = %d",
						 instruction[26:22], instruction[21:17], instruction[15:11]);	
			
					@(posedge clk)	// 20 clocks
					begin	
						alu_to_mem = 1;			// R27 = RC
						sel_imm_rega = 1;		//  
						alu_control = 3'b111; 		// A
						wr_addr = 4'b1111;		//
						a_addr = instruction[25:22];	// 
					end

					@(posedge clk)
					begin
						wr_clk = 1; 	// Store the value of RC into register 27
					end

					@(posedge clk)
					begin
						wr_clk = 0;
						alu_to_mem = 0;
					end

					// -------------------------
					@(posedge clk)
					begin
						alu_to_mem = 0;			// RC = (RB + RX)
						sel_imm_rega = 1;		//  
						alu_control = 3'b001; 		// A + B
						a_addr = instruction[20:17];	// RB
						b_addr = instruction[14:11];	// RX 
					end

					@(posedge clk)
					begin
						addr_en = 1;  // Put (RB+RI) onto the address bus
					end

					@(posedge clk)
					begin
						addr_en = 0;
 					end

					// --------------------------
					@(posedge clk)
					begin
						io_en = 1; 	// Setup the transcievers to read in data from
						io_dir = 0;	// the data bus and put it on the imm_bus.
						ext_rd = 1;	// This will get the lower 16-bits of the
						wr_addr = instruction[25:22];	// RC 
					end

					@(posedge clk)
					begin
						wr_clk = 1; 	// Write (RB+RI) into RC
					end
				
					@(posedge clk)
					begin
						wr_clk = 0;
						io_en = 0;
					end

					@(posedge clk)
					begin
						ext_rd = 0;
					end
					
					// ----------------------------------
					@(posedge clk)
					begin
						io_en = 1;		// (RB+RI) = R27 = RC
						io_dir = 1;		//
						sel_imm_rega = 1;	// Setup the transcievers to write out data
						alu_to_mem = 1;		//
						a_addr =  4'b1111; 	// a_addr = RC = R27
						alu_control = 3'b111;	// A
					end

					@(posedge clk)
					begin
						ext_wr = 1; 
					end

					@(posedge clk)
					begin
						ext_wr = 0; 
					end

					@(posedge clk)
					begin
						io_en = 0;
						io_dir = 0;
						alu_to_mem = 0;
					end

					end // SWAP  */


/*********************************** SHIFTx ********************************************************/

				// SHIFTx Instruction
				5'b01000 : begin	// RC = RB << imm6 + RX 

					$display("In the SHIFTx Instruction");
					$display("RC = %d RB = %d RX = %d",
						 instruction[26:22], instruction[21:17], instruction[15:11]);
					$display("imm6 = %b  x = %b  u/s = %b",
						 instruction[5:0], instruction[16], instruction[10]);	

					if (instruction[10] == 1)
					begin
						$display("This is a signed Shift ALU operation");
						signedflag = 1;
					end
					else
					begin
						$display("This is an unsigned Shift ALU operation");
						signedflag = 0;
					end
					/* ------------- First add imm6 with RX   ------------------ */
					/*  only if imm6 != 0 */
					if (instruction[5:0] != 0)
					begin
						$display("Adding imm6 to RX");
						alu_control = 3'b001;

						//*****Set up A and B inputs to the ALU ******
						@(posedge clk)
						begin
							io_en = 0;			// RC = RX + imm6
							sel_imm_rega = 0;		// 
							sel_fl_alu = 1;
							alu_to_mem = 1;
							b_addr = instruction[14:11];	// RX
							wr_addr = instruction[25:22];	// RC
						end
						@(posedge clk)
						begin
							wr_clk = 1; 
						end
						@(posedge clk)
						begin
							wr_clk = 0;
							alu_to_mem = 0;
 						end
					end

					/* --------------  Next shift RB << im6+RX times ------------ */
							
					//*****Set up A and B inputs to the ALU for proper Flag result******
					@(posedge clk)
					begin
						io_en = 0;			// 
						sel_imm_rega = 1;		// 
						alu_control = 3'b000; 		// ALU Shift Operation
						a_addr = instruction[20:17];	// RB - value to be shifted
						if (instruction[5:0] == 0) // imm6 != 0
							b_addr = instruction[14:11];	// RX - number of times shifted
						else 
							b_addr = instruction[25:22];	// RC - number of times shifted
						
					end

					//*****Write the Flags into Register14 if user desired***************
					if (instruction[16] == 0)	//Save the value of the flags into R14
					begin
						$display("Operation affects the flags");
						@(posedge clk)
						begin
							alu_to_mem = 1;
							sel_fl_alu = 0;
							wr_addr = 5'b1110;    //Write into flag register 14.
						end

						@(posedge clk)
						begin
							wr_clk = 1;
						end

						@(posedge clk)
						begin
							wr_clk = 0;
							alu_to_mem = 0;
						end

					end
					else
					begin
						$display("Operation has no affect on the flags");
					end

					//******Write the result into the correct Register*********************
					@(posedge clk)
					begin
						sel_fl_alu = 1;
						alu_to_mem = 1;
						wr_addr = instruction[25:22];	// RC
					end

					@(posedge clk)
					begin
						wr_clk = 1; 
					end

					@(posedge clk)
					begin
						wr_clk = 0;
						alu_to_mem = 0;
 					end
				
					$display("alu_flags2 = %b", alu_flags2);

				end // SHIFTx


/*********************************** INT (SOFTWARE Interrupt)********************************************************/

				// INT Instruction
				5'b01110 : begin	// FL = FLAGS = R28, TF = 0, IF = 0, CALL N(NULL), RA
					$display("In the INT Instruction");
					$display("N16 = %h ", instruction[15:0]);	
					$display("FL = R28 = Flags = %b", alu_flags2);
					$display("TF =    IF =  ");					

					if (alu_flags2[5] == 1)  // if interrupt flag is set
					begin			// service interrupt
			
				      		//******save the IP pointer
						@(posedge clk) // 24 clocks
						begin
							$display("Servicing interrupt");
							io_en = 0;		//
							alu_to_mem = 1;		// RA = IP
							sel_imm_rega = 1;	//
							sel_fl_alu = 1;
							alu_control = 3'b111; 	//
							wr_addr = 4'b1101; 	// wr_addr = R13
							a_addr = 4'b1111;
						end

						@(posedge clk)
						begin
							wr_clk = 1; 
						end

						@(posedge clk)
						begin
							wr_clk = 0;
							alu_to_mem = 0;		// Write in the value of IP into 
 										// register? (RA) so we can return later
						end	 

				      		//*****Put the new IP in IP register for ISR
						@(posedge clk)
						begin
							alu_control = 3'b111;		// IP = addr16
							alu_to_mem = 1;		// 
							sel_imm_rega = 0;	// imm_bus == addr16
							sel_fl_alu = 1;
							wr_addr = 4'b1111;	// wr_addr = IP (r31)
						end

						@(posedge clk)
						begin
							wr_clk = 1; 
						end

						@(posedge clk)
						begin
							wr_clk = 0;		// Write in the new value of IP
							alu_to_mem = 0;		// into the regstore
						end
					end // if
					else
						$display("Not servicing interrupt since IF = 0 ");				
				end // INT

			endcase // End of instructions
			
	//**********************************In case of an HARDWARE Interrupt**************************************************/
	//*****************************This excutes at the end of each instruction********************************************/
			@(posedge clk)
			begin
				if (intr == 1 && alu_flags2[5] ==1)  // if external interrupt and interrupt flag is set
				begin				     // service interrupt
	
					$display("Inside Hardware Interrupt.  INTR has Occured");
					
					//******save the current IP pointer into register 13***************
					@(posedge clk) // 24 clocks
					begin
						io_en = 0;		//
						alu_to_mem = 1;		// RA = IP
						sel_imm_rega = 1;	//
						sel_fl_alu = 1;
						alu_control = 3'b111; 	//
						wr_addr = 4'b1101; 	// wr_addr = R13
						a_addr = 4'b1111;
					end

					@(posedge clk)
					begin
						wr_clk = 1; 
					end

					@(posedge clk)
					begin
						wr_clk = 0;
						alu_to_mem = 0;		// Write in the value of IP into 
 								// register? (RA) so we can return later
					end	 


					//************Put Address of ISR(from external port1(hex switches)) into IP register*
					@(posedge clk)
					begin
						inta = 1;
						ext_rd = 1;
						ext_iom = 1;
						io_en = 1;	
						io_dir = 0;		
						wr_addr =  4'b1111; // wr_addr = RC = instruction[26:22]
					end

					@(posedge clk)
					begin
						wr_clk = 1; 
					end

					@(posedge clk)
					begin
						wr_clk = 0; 
					end


					@(posedge clk)
					begin
						ext_rd = 0;
						io_en = 0;
						ext_iom = 0;
						inta = 0;
					end

				end//IF

				else if (intr == 1 && alu_flags2[5] == 0)  // if external interrupt and interrupt flag is set
				begin
					$display("No Interrupt will occur because IF = 0 ");
					$display("Ha Ha Ha Ha Ha ...............................");
				end	
		 
			end//Interrupts


		end//First posedge

	end //Always state machine


endmodule // control_unit

