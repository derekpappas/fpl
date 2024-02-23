
`include "prog_inc.h"

module prog (
				sys_clk,
				sys_rst_l,

				// to/from CONFIG ROM
				rom_cs_l,
				rom_rd_l,
				rom_addx,
				rom_data,

				// to/from FPGA
				nConfig,
				data0,
				nStatus,
				Conf_Done,
				Init_Done,
				dclk

				,
				// debug
				s_state,
				load_shiftDataH,
				shift_shiftDataH,
				slow_clk

			);

input			sys_clk;
input			sys_rst_l;

// to/from CONFIG ROM
output			rom_cs_l;
output			rom_rd_l;
output	[`AN-1:0]rom_addx; 
input	[7:0]	rom_data;

// to/from FPGA
output			nConfig;
input			nStatus;
output			data0;
output			dclk;
input			Conf_Done;
input			Init_Done;

output	[3:0]	s_state;
output			load_shiftDataH;
output			shift_shiftDataH;
output			slow_clk;

parameter	s_load1stbyte = 4'h0,
			s_assertConfig = 4'h1,
			s_waitStatLow = 4'h2,
			s_deassertConfig = 4'h3,
			s_waitStatHigh = 4'h4,
			s_loadByte    = 4'h5,
			s_shift = 4'h6,
			s_confDone = 4'h7,
			s_initDone = 4'h8,
            CFG_delay = 4'h9;

parameter LO = 1'b0,
		  HI = 1'b1,
		  X = 1'bx,
		  Z = 1'bz;

reg		[3:0]	s_state, next_state;
reg				rom_csIn_l;
reg				rom_rdIn_l;
reg		[`AN-1:0]rom_addxIn;  // 32KByte maximum
reg				dclk_ena;
reg		[7:0]	shiftData;
reg				load_shiftDataH;
reg				inc_rom_addxH;
reg				nConfigIn, nConfig;
reg				shift_shiftDataH;
reg		[4:0]	shiftCntr;
reg				outEnaH;
reg		[`CD-1:0]clk_div;
reg             rstDlyH;
reg		[2:0]	DlyCtr;

wire			slow_clk;
wire 			shiftTOH;
wire			data0;
wire			rom_cs_l;
wire			rom_rd_l;
wire	[`AN-1:0]rom_addx;


assign data0 = outEnaH ? shiftData[0] : Z;

// The serial data clock is gated
assign dclk = outEnaH ? (~slow_clk & dclk_ena) : Z;
assign rom_cs_l = outEnaH ? rom_csIn_l : Z;
assign rom_rd_l = outEnaH ? rom_rdIn_l : Z;
assign rom_addx = outEnaH ? rom_addxIn : {`AN{1'bz}};

always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) clk_div <= 0;
  else clk_div <= clk_div + 1;
assign slow_clk = clk_div[`CD-1];

// register nConfigIn so there is no glitch
always @(posedge slow_clk or negedge sys_rst_l)
  if (~sys_rst_l) nConfig <= HI;
  else nConfig <= nConfigIn;


// shift register
always @(posedge slow_clk or negedge sys_rst_l)
  if (~sys_rst_l) begin 
		shiftData <= 0;
		shiftCntr <= 0;
  end 
  else
	 if (load_shiftDataH) begin 
		shiftData <= rom_data;
		shiftCntr <= 0;
     end else 
		if (shift_shiftDataH) begin  // shift down
			shiftData[7] <= 1'b0;
			shiftData[6:0] <= shiftData[7:1];
			shiftCntr <= shiftCntr + 1;
	    end
	 else begin
		shiftData <= shiftData;
		shiftCntr <= shiftCntr;
	 end

assign shiftTOH = (shiftCntr == 4'h7);


// Address Pointer
always @(posedge slow_clk or negedge sys_rst_l)
  if (~sys_rst_l) rom_addxIn <= 0;
  else if (inc_rom_addxH) rom_addxIn <= rom_addxIn + 1;

// next state assignment
always @(posedge slow_clk or negedge sys_rst_l)
  if (~sys_rst_l) s_state <= s_load1stbyte;
  else s_state <= next_state;


// This is a 3bit counter used to generate
// a delay of 6uS.  
// "slow_clk" is at maximum of 1uS 
// (in prog_inc.h, set CD appropriately)
// so at most, 8counts will suffice to
// generate 6uS of delay
always @(posedge slow_clk or negedge sys_rst_l)
  if (~sys_rst_l) DlyCtr <= 0;
  else if (rstDlyH) DlyCtr <= 0;
  else DlyCtr <= DlyCtr + 1; 

always @(s_state or Conf_Done or Init_Done)
begin

	rom_csIn_l = HI;
	rom_rdIn_l = HI;
    nConfigIn = HI;
    dclk_ena = LO;
	load_shiftDataH = LO;
	shift_shiftDataH = LO;
    inc_rom_addxH = LO;
	nConfigIn = HI;
	outEnaH = HI;
    rstDlyH = LO;

	case (s_state)
		s_load1stbyte: begin
			rom_csIn_l = LO;
			rom_rdIn_l = LO;
			load_shiftDataH = HI;
			inc_rom_addxH = HI;
			next_state = s_assertConfig;
		end

		s_assertConfig: begin
		    nConfigIn = LO;  // assert nConfig
    	    next_state = s_waitStatLow;
		end

        // wait for nStatus to drop
	    s_waitStatLow: begin
			if (nStatus) begin 
			    nConfigIn = LO;  // assert nConfig
				next_state = s_waitStatLow;
			end else begin 
                next_state = CFG_delay;
                rstDlyH    = HI;
            end
        end

        // hold CONFIG low for minimum of 6uS
        CFG_delay: begin
          if (DlyCtr==3'b111) next_state = s_waitStatHigh;
           else begin 
               next_state = CFG_delay;
               nConfigIn = LO;  // assert nConfig
           end
        end        

		s_waitStatHigh: begin
			if (nStatus) next_state = s_shift;
			else next_state = s_waitStatHigh;
		end

		s_shift: begin
			dclk_ena = HI;
			if (shiftTOH) begin
				next_state = s_loadByte;
				load_shiftDataH = HI;			
				rom_csIn_l = LO;
				rom_rdIn_l = LO;	
    		end else begin
				shift_shiftDataH = HI;
				next_state = s_shift;
			end			
		end

		s_loadByte: begin
			if (Conf_Done) begin
				next_state = s_confDone;
			end else begin
				next_state = s_shift;
				inc_rom_addxH = HI;
			end
		end

		s_confDone: begin
			dclk_ena = HI;
			if(Init_Done) begin
				next_state = s_initDone;
			end else begin
				next_state = s_confDone;
			end
		end

		s_initDone: begin
			next_state = s_initDone;
			outEnaH = LO;
		end

		default: begin
			rom_csIn_l = X;
			rom_rdIn_l = X;
		    nConfigIn = X;
		    dclk_ena = X;
			load_shiftDataH = X;
			shift_shiftDataH = X;
		    inc_rom_addxH = X;
			nConfigIn = X;
			outEnaH = X;
			next_state = 4'hx;
            rstDlyH = X;
		end

	endcase
end



endmodule
