/*
** MYDIV8
**
** Unsigned integer divider of type
**     	Ain / Bin ==> 8bit / 8bit
**
** Output is 
** 	Quotient: 	8 bit
**	remainder:	8 bit
*/

// DEFINES

`define		HI		1'b1
`define		LO		1'b0

// ------- define the bewlow if the inputs are not stable during the
// ------- 
//`define		latch_needed	


module mydiv8(
		sys_rst_l,
		sys_clk,
		ina,
		inb,
		quo,
		rem,
		ready,
		start,

		// debug
		state_div,
		temp_a,
		sub_out,
		bin_scaled
				
		 );


input		sys_rst_l;	// global system reset, active low
input		sys_clk;	// global system clock
input	[7:0]	ina;		// dividend
input	[7:0]	inb;		// divisor
input		start;		// start , synchronous , active high
output	[7:0]	quo;		// Quotient
output	[7:0]	rem;		// remainder
output		ready;		// ready, synchronous, active high.

//debug
output	[7:0]	temp_a;
output	[7:0]	bin_scaled;
output	[8:0]	sub_out;
output	[3:0]	state_div;


reg	[3:0]	state_div;
reg		ready;
reg	[7:0]	quo;
`ifdef latch_needed
reg	[7:0]	bin_latch;
`else
wire	[7:0]	bin_latch;
`endif
reg	[15:0]	bin_scaled;
reg	[7:0]	temp_a;
wire	[8:0]	sub_out;
wire		cy, sign;
wire		bin_scaled_overflow;


// state machine declaration
parameter	s_idle		=	4'h0;
parameter	s_div128	=	4'h1;
parameter	s_div64		=	4'h2;
parameter	s_div32		=	4'h3;
parameter	s_div16		=	4'h4;
parameter	s_div8		=	4'h5;
parameter	s_div4		=	4'h6;
parameter	s_div2		=	4'h7;
parameter	s_div1		=	4'h8;



// the ramainder is the last value of temp_a
assign rem = temp_a;

`ifdef latch_needed
// bin latch
always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l)
    bin_latch <= 8'h00;
  else if (start)
    bin_latch <= inb;
`else
assign bin_latch = inb;
`endif     


/*
**  8 CYCLE STATE MACHINE
**
*/
always @(posedge sys_clk or negedge sys_rst_l)
 // active low asynch reset
 if (~sys_rst_l) begin
    state_div <= s_idle;
    ready     <= `LO;
    quo	      <= 8'h00;
    temp_a    <= 8'h00;
 end 

 // SWITCH CASE
 else case (state_div)
    s_idle:
	if (start==`HI) begin 		// If told to start division..
            temp_a      <= ina;		// load 'temp_a' with INA (dividend)
	    state_div 	<= s_div128;
	    ready 	<= `HI;		// not ready..
        end

    s_div128: begin
        state_div	<= s_div64;	
	if (sign==`LO && bin_scaled_overflow==`LO)  begin  // if temp_a - bin_scaled is positive AND		
	  quo[7]  <= `HI;				   // bin_scaled did not overflow..
	  temp_a  <= sub_out[7:0];			   // then, update: temp_a=temp_a-bin_scaled
        end 
        else quo[7] <= `LO;				   // ELSE, quotione is 0
    end

    s_div64: begin
        state_div	<= s_div32;
	if (sign==`LO && bin_scaled_overflow==`LO) begin   // ditto
	  quo[6]  <= `HI;
          temp_a  <= sub_out[7:0];
        end      
        else quo[6] <= `LO;		
    end

    s_div32: begin
        state_div	<= s_div16;
	if (sign==`LO && bin_scaled_overflow==`LO) begin
          quo[5]  <= `HI;
          temp_a  <= sub_out[7:0];
        end
        else quo[5] <= `LO;		
    end

    s_div16: begin
        state_div  <= s_div8;
	if (sign==`LO && bin_scaled_overflow==`LO) begin
	   quo[4]  <= `HI;
           temp_a  <= sub_out[7:0];
        end
        else quo[4] <= `LO;		
    end

    s_div8: begin
        state_div  <= s_div4;
	if (sign==`LO && bin_scaled_overflow==`LO) begin
           quo[3]  <= `HI;
           temp_a  <= sub_out[7:0];
        end
        else quo[3] <= `LO;		

    end

    s_div4: begin
        state_div  <= s_div2;
	if (sign==`LO && bin_scaled_overflow==`LO) begin
           quo[2]  <= `HI;
           temp_a  <= sub_out[7:0];
        end
        else quo[2] <= `LO;		
    end

    s_div2: begin
        state_div  <= s_div1;
	if (sign==`LO && bin_scaled_overflow==`LO) begin
           quo[1]  <= `HI;
           temp_a  <= sub_out[7:0];
        end
        else quo[1] <= `LO;		
    end

    s_div1: begin
        state_div  <= s_idle;
	ready	   <= `LO;
	if (sign==`LO && bin_scaled_overflow==`LO ) begin
           quo[0]  <= `HI;
           temp_a  <= sub_out[7:0];
        end
        else quo[0] <= `LO;    			
    end

 endcase


/*
** Binary Multiplier for BIN
** does:
**	 bin_scaled = bin * 2^I
**
**	 where I is 7 to 0
**
*  Note that bin_scaled is 16 bits wide, even though bin in is 8,
** to preserve "oveflow" conditions. 
**
*/
always @(state_div or bin_latch)
 case (state_div)
    s_idle,
    s_div128:
	bin_scaled <= (bin_latch << 7);
    s_div64:
	bin_scaled <= (bin_latch << 6);
    s_div32:
	bin_scaled <= (bin_latch << 5);
    s_div16:
	bin_scaled <= (bin_latch << 4);
    s_div8:
 	bin_scaled <= (bin_latch << 3);
    s_div4:
	bin_scaled <= (bin_latch << 2);
    s_div2:
	bin_scaled <= (bin_latch << 1);
    s_div1:
	bin_scaled <= (bin_latch << 0);
    default:
    bin_scaled <= 8'hxx;
 endcase
assign bin_scaled_overflow = | bin_scaled[15:8];	// bin_scaled_overflow if any one bit
							// is high in upper byte


// Subtracter
assign sub_out = temp_a - bin_scaled;
assign sign = sub_out[8];		// a 1 here means, that 
					// the result of the subtraction is
					// negative

endmodule

