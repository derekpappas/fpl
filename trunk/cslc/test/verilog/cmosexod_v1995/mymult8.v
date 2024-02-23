/*
** MYMULT8.v
**
** 8x8 unsigned integer sequential multiplier.
** The data is available on the 9th rising edge after when
** the 'start' is recognized, with 'ready_l' becoming low.
**
**
*/


`define 	LO	1'b0
`define 	HI	1'b1
`define		IDLE	1'b0
`define		WAIT	1'b1


module mymult8(
		sys_rst_l,
		sys_clk,
		ina,
		inb,
		start,
		ready_l,
		out
		
 );


input		sys_rst_l;	// asynch active low reset
input		sys_clk;	// system clock
input	[7:0]	ina, inb;	// multiplicand, multiplier
input		start;		// actitive high start, sychronous to sys_clk
output		ready_l;	// active low, ready signal
output	[15:0]	out;		


// Memory elements
reg	[15:0]  out;
reg	[7:0]	ina_latched;
reg	[15:0]  inb_latched;
reg	[2:0]	mult_counter;
reg		state_mult;
reg		ena_mult;
reg		ready_l;


// Loadable shift register
always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) begin
    ina_latched <= 8'h00;
    inb_latched <= 16'h0000;
  end
  else if (start) begin
    ina_latched <= ina;
    inb_latched <= {8'h00,inb};
  end
  else begin
    ina_latched <= ina_latched >> 1;
    inb_latched <= inb_latched << 1;
  end 

// Multiplier counter
always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l)
     mult_counter <= 3'h0;
  else if (ena_mult)
     mult_counter <= mult_counter + 1;
         

// MULTIPLIER STATE MACHINE
// toggle between two states:
//   idle:  waiting for start 
//   wait:  waiting for mult counter to be 7
always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) begin
     state_mult <= `LO;
     ena_mult   <= `LO;
     ready_l     <= `LO;
  end 
  else case (state_mult)
     `IDLE: begin
	if (start) begin
           ena_mult   <= `HI;	                     
           state_mult <= `WAIT;
           ready_l     <= `HI;
        end
      end

     `WAIT: begin
        if (mult_counter==3'b111) begin
           ena_mult   <= `LO;
 	   state_mult <= `IDLE;
           ready_l    <= `LO;
        end           
      end
  endcase


// 
always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l)
    out <= 16'h0000;
  else if (start)
    out <= 16'h0000;
  else if (state_mult==`WAIT)
    out <= out + ( ina_latched[0] ? inb_latched : 16'h0000 );
    

endmodule

