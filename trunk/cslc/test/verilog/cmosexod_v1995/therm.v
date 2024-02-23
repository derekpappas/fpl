/*
**  THERM.v
**
**  "Single" chip Digital Thermometer.
**  This digital thermometer makes use of the LM75 (or compatible)
**  thermal-sensors.  
**
**  Target devices which it fits:
**	One  Lattice ispLSI3256 CPLD
**
**
**  Brief Theory of Operation
**
*/



module therm(
		// IIC related
		iic_sclk,	// IIC serial clock
		iic_sdat,	// IIC bidirectional data	


		// CLOCK DIVIDER
		raw_sys_clk,	// input to the internal clk divider 
		slow_clk,	// output of the clock divider

		// system related
		sys_rst_l,	// main system reset, active low
		fahren,
	
		// display related
		disp_latch_one,	 // active low, ones digit latch enable
		disp_latch_ten,	 // active low, tens digit latch enable
		disp_latch_hund, // active low, hundres digit latch enable
		disp_data,	 // 4 bit diaplay data
		dp_l,
		sel_f,		
		sel_c

		// debug
//		sp_ready,	// active high, serial port ready
//		div_rem,
//		div_quo

		 );


`define		N   		4	// defines the delay time gap
`define		M   		10	// clock prescaler
`define		_K_FAHREN	8'd230	// (9/5) * 128
parameter	HI = 1'b1;
parameter	LO = 1'b0;

// ---- Main Controller State Machine  State Definition 
// (un-encoded, since the speed requirement is not here)
parameter	s_idle			=	4'h0;
parameter	s_readiic		=	4'h1;
parameter	s_divide_tens		=	4'h2;
parameter	s_divide_tens_wait	=	4'h3;
parameter	s_display_ten		=	4'h4;
parameter	s_divide_ones		=	4'h5;
parameter	s_divide_ones_wait	=	4'h6;
parameter	s_display_one		=	4'h7;
parameter	s_convert_2_fahren	=	4'h8;
parameter	s_convert_2_fahren_wait	=	4'h9;
parameter	s_divide_hund		=	4'ha;
parameter	s_divide_hund_wait	=	4'hb;
parameter	s_display_hund		=	4'hc;
parameter	s_display_fraction	=	4'hd;


// IIC related
output		iic_sclk;
inout		iic_sdat;
// Clock divider
input		raw_sys_clk;
output		slow_clk;
// System Related
input		sys_rst_l;
//input		sys_clk;
input		fahren;		
// display related
output		disp_latch_one;
output		disp_latch_ten;
output		disp_latch_hund;
output	[3:0]	disp_data;
output		dp_l;			// decimal point, active low
output		sel_f;			// active low Fahren
output		sel_c;			// active celcius
// debug
//output		sp_ready;
//output	[7:0]	div_rem;
//output	[7:0]	div_quo;


// clockgen related
wire		sys_clk_b;
wire		sys_clk;
// IIC related
wire	[8:0]	temp_data;
wire	[5:0]	state_iic;
wire		sp_ready;
wire		cntr_rst_l;
// Divder related
wire		divide_ready;
reg	[7:0]	div_inb;
wire	[7:0]	div_rem;
wire	[7:0]	div_quo;
// Multiplier related
wire		multip_ready;
wire	[15:0]	mult_out;

reg	[3:0]	state_controller;
reg		read_temp;
reg		ena_delay_cntr;
reg		disp_latch_one,disp_latch_ten, disp_latch_hund;
reg	[3:0]	disp_data;
reg		divide_ena;
reg		multip_ena;
reg	[7:0]	div_ina;

reg	[`N-1:0]	delay_cntr;
reg	[`M-1:0]	clk_scaler;

/*
// Instantiate the clock generator module
clockgen CLOCKGEN (
		.sys_rst_l(sys_rst_l),
		.sys_clk(sys_clk_b),
		.ena(2'b11)
	);
*/

// Instantiate the IIC module
IIC iic	( 
		// system connections
		.sys_rst_l(sys_rst_l),
		.sys_clk(sys_clk),

		// IIC related 
		.iic_sclk(iic_sclk),
		.iic_sdat(iic_sdat),
		.read_temp(read_temp),
		.sp_ready(sp_ready),
		.temp_data(temp_data),				

		// debug
		.state_iic(state_iic)
	);

// Instantiate the 8 bit unsigned integer divider
mydiv8 DIVIDER(
		.sys_rst_l(sys_rst_l),
		.sys_clk(sys_clk),
		.ina(div_ina),
		.inb(div_inb),
		.quo(div_quo),
		.rem(div_rem),
		.ready(divide_ready),
		.start(divide_ena)
				
	 );

// Instantiate the 8 bit unsigned multiplier multiplier
mymult8 MULTIPLIER (
		.sys_rst_l(sys_rst_l),
		.sys_clk(sys_clk),
		.ina(temp_data[8:1]),
		.inb(`_K_FAHREN),
		.start(multip_ena),
		.ready_l(multip_ready),
		.out(mult_out)		
	);



// Clock prescaler
assign sys_clk = clk_scaler[`M-1];
always @(posedge raw_sys_clk or negedge sys_rst_l)
  if (~sys_rst_l)
     clk_scaler <= `M'h0000;
  else
     clk_scaler <= clk_scaler + 1;


// This is the delay timer counter
// Active high "ena_delay_cntr" enables the counter to 
// Count up
assign cntr_rst_l = ena_delay_cntr & sys_rst_l;
always @(posedge sys_clk or negedge cntr_rst_l)
  if (~cntr_rst_l)
     delay_cntr <= `N'h000000;
  else if (ena_delay_cntr)
     delay_cntr <= delay_cntr + 1;



/*
**
**  State Machine 
**
**
**
**
*/
always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) begin
     state_controller <= s_idle;
     ena_delay_cntr <= LO;
     read_temp <= LO;
     disp_latch_one  <= HI;
     disp_latch_ten  <= HI;
     disp_latch_hund <= HI;
     divide_ena	     <= LO;
     multip_ena	     <= LO;
     div_ina	     <= 8'h00;
  end
  else case (state_controller)

     s_idle: begin
           ena_delay_cntr <= HI;
           disp_latch_hund<= HI; 
           disp_latch_ten <= HI;
	   disp_latch_one <= HI;
           if (delay_cntr[`N-1] == HI) begin
              state_controller <= s_readiic;
              ena_delay_cntr <= LO;
	      read_temp <= HI;		// "turn on" IIC S.P. to read a packet
           end
     end

     s_readiic: begin
          read_temp <= LO;		// "turn off" IIC serial port
	  if (sp_ready == HI) begin
             if (fahren)  begin
                 state_controller <= s_convert_2_fahren;
                 multip_ena <= HI;	// enable the multiplier
             end 
             else begin
                 state_controller <= s_divide_tens;
 	         divide_ena <= HI;			//enable the divider
	         div_ina    <= temp_data[8:1];	//load dividend, skip fraction bit
	     end
          end
     end


     s_convert_2_fahren:  begin
          multip_ena       <= LO;		//turn off multip_ena
	  state_controller <= s_convert_2_fahren_wait;
     end
          
     s_convert_2_fahren_wait: begin
          if (multip_ready==LO) begin
	    state_controller <= s_divide_hund;
            divide_ena  <= HI;			    // enable divider
	    div_ina     <= mult_out[14:7] + 8'd32;  // F = C*240/128 + 32
          end
     end

     s_divide_hund: begin
          state_controller <= s_divide_hund_wait;
          divide_ena       <= LO;	// turn off divide
     end

     s_divide_hund_wait: begin
          if (divide_ready==LO)
            state_controller <= s_display_hund;
     end
         
     s_display_hund: begin
          if (fahren)
             disp_latch_hund  <= LO;
          state_controller <= s_divide_tens;
          divide_ena       <= HI; 	// enable divider for TENS digit
	  div_ina	   <= div_rem;	// load dividend
     end

     s_divide_tens: begin
          disp_latch_hund  <= HI;
	  state_controller <= s_divide_tens_wait;
     end

     s_divide_tens_wait: begin
         divide_ena  <= LO;		// turn off divider
         if (divide_ready==LO) begin
 	   state_controller <= s_display_ten;
         end
     end

     s_display_ten: begin
          state_controller <= s_divide_ones;
          if (fahren)
              disp_latch_ten   <= LO;
          else
              disp_latch_hund  <= LO;
          divide_ena <= HI;		// enable divider
          div_ina    <= div_rem;	// load dividend
     end

     s_divide_ones: begin
          disp_latch_ten  <= HI;
          disp_latch_hund <= HI;
	  state_controller <= s_divide_ones_wait;
     end

     s_divide_ones_wait: begin
          divide_ena <= LO;
         if (divide_ready==LO)
 	   state_controller <= s_display_one;
     end

     s_display_one: begin
          if (fahren) begin
              disp_latch_one   <= LO;
              state_controller <= s_idle;
          end
          else begin
              disp_latch_ten   <= LO;
              state_controller <= s_display_fraction;
          end
     end 

     s_display_fraction: begin
          state_controller <= s_idle;
          disp_latch_ten   <= HI;
          disp_latch_one   <= LO;
     end

  endcase



/*
**  This mux, sets the correct divider
**  to the 8 bit divider, 100, 10 or 1
**
*/
always @(state_controller   or fahren)
  case (state_controller)

     // during the hundreds digit
     s_readiic,
     s_convert_2_fahren_wait,
     s_divide_hund,
     s_divide_hund_wait:
        div_inb = 8'd100;

     // during the tens digit
     s_display_hund,
     s_divide_tens,
     s_divide_tens_wait:
        div_inb = 8'd10;

     // during the ones digit
     s_display_ten,
     s_divide_ones,
     s_divide_ones_wait:
        div_inb = 8'h01;

    
     default:
        div_inb = 4'hx;
  endcase


always @(state_controller or temp_data[0] or div_quo[3:0])
  case (state_controller)
    s_idle:
      if (~fahren)
         if (temp_data[0])
            disp_data = 4'h5;
         else
            disp_data = 4'h0;    
      else
         disp_data = div_quo[3:0];
    default:
       disp_data = div_quo[3:0];    
  endcase
   

assign dp_l      = fahren;

assign sel_f	 = ~fahren;
assign sel_c     = fahren;


endmodule

