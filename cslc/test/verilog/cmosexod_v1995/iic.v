module IIC( 
		// system connections
		sys_rst_l,
		sys_clk,

		// IIC related 
		iic_sclk,
		iic_sdat,
		read_temp,
		sp_ready,
		temp_data,				

		// debug
		state_iic

 );

`define		HI	1'b1
`define		LOW	1'b0
`define		X	1'bx

// system connections
input		sys_rst_l;
input		sys_clk;

// IIC related
output		iic_sclk;
inout		iic_sdat;
output		sp_ready;	// active high serial port ready signal
input		read_temp;	// active high signal to start the serial port read
output	[8:0]	temp_data;

// debug
output	[4:0]	state_iic;


reg	[4:0]	state_iic;
reg	[8:0]	temp_data;
reg		sclk_ena_l;	// active low enable signal for SCLK.
reg		iic_sdat_ena;
reg		iic_sdat_out;
reg		sp_ready;	
reg		shift_reg_ena;	// enable the shift register to shift data in
wire		iic_sdat_in;

// speed here is not critical, so unencoded state
// machine should do.
parameter	s_iic_idle	= 5'h00;
parameter	s_iic_s		= 5'h01;
parameter	s_iic_a3	= 5'h02;
parameter	s_iic_a2	= 5'h03;
parameter	s_iic_a1	= 5'h04;
parameter	s_iic_a0	= 5'h05;
parameter	s_iic_ao2	= 5'h06;
parameter	s_iic_ao1	= 5'h07;
parameter	s_iic_ao0	= 5'h08;
parameter	s_iic_rw	= 5'h09;
parameter	s_iic_ack1	= 5'h0a;
parameter	s_iic_d7	= 5'h0b;
parameter	s_iic_d6	= 5'h0c;
parameter	s_iic_d5	= 5'h0d;
parameter	s_iic_d4	= 5'h0e;
parameter	s_iic_d3	= 5'h0f;
parameter	s_iic_d2	= 5'h10;
parameter	s_iic_d1	= 5'h11;
parameter	s_iic_d0	= 5'h12;
parameter	s_iic_ack2	= 5'h13;
parameter	s_iic_d7l	= 5'h14;
parameter	s_iic_d6l	= 5'h15;
parameter	s_iic_d5l	= 5'h16;
parameter	s_iic_d4l	= 5'h17;
parameter	s_iic_d3l	= 5'h18;
parameter	s_iic_d2l	= 5'h19;
parameter	s_iic_d1l	= 5'h1a;
parameter	s_iic_d0l	= 5'h1b;
parameter	s_iic_d00	= 5'h1c;
parameter	s_iic_ack3	= 5'h1d;
parameter	s_iic_p		= 5'h1e;
parameter	s_iic_p2	= 5'h1f;

assign iic_sclk = sys_clk | sclk_ena_l;

// IIC_SDAT bidirectional buffer
assign iic_sdat_in = iic_sdat;
assign iic_sdat = iic_sdat_ena ? iic_sdat_out : 1'bz;


// SCLK generator
always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l)
    sclk_ena_l <= `HI;
  else if (state_iic == s_iic_s ) 
    sclk_ena_l <= `LOW;
  else if (state_iic == s_iic_p2 ) 
    sclk_ena_l <= `HI;

// Temp data shift register
// Knowing that this IIC module only works with xx75 kind,
// there will be need to shift in only 9 bits of data
always @(posedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l)
    temp_data <= 9'h000;
  else if (shift_reg_ena) begin
    temp_data[8:1] <= temp_data[7:0];
    temp_data[0]   <= iic_sdat_in;
  end    
     

// State Machine to walk through the IIC process
// Clocks on the negative edge of sys_clk
// Moore type
always @(negedge sys_clk or negedge sys_rst_l)
  if (~sys_rst_l) begin
    state_iic     <= s_iic_idle;// initial state is s_iic_idle
    iic_sdat_out  <= `HI;
    iic_sdat_ena  <= `HI;	// driving SDAT by default
    sp_ready	  <= `HI;	// ready by default 
    shift_reg_ena <= `LOW;	// disble shift register
  end
  else case (state_iic)
     // idle state, wait for read_temp bit to start 
     s_iic_idle: begin	
     	  if (read_temp) begin
            state_iic    <= s_iic_s;
 	    iic_sdat_ena <= `HI;   // enable driving SDAT
 	    iic_sdat_out <= `LOW;  // start bit is low
	    sp_ready     <= `LOW;  // sp not ready 
          end
     end

     // start state: generate the SDAT falling with SCLK high condition
     s_iic_s:begin 
          state_iic    <= s_iic_a3;
          iic_sdat_out <= `HI;      // temp sensor IIC Addx[3]=1
     end

     s_iic_a3: begin
          state_iic    <= s_iic_a2;
	  iic_sdat_out <= `LOW;	    // temp sensor IIC Addx[2]=0
     end

     s_iic_a2: begin
          state_iic    <= s_iic_a1;
	  iic_sdat_out <= `LOW;     // temp sensor IIC Addx[1]=0
     end

     s_iic_a1: begin
          state_iic    <= s_iic_a0;
          iic_sdat_out <= `HI;	    // temp sensor IIC Addx[0]=1
     end
 
     s_iic_a0: begin
          state_iic    <= s_iic_ao2;
          iic_sdat_out <= `LOW;
     end

     s_iic_ao2: begin
          state_iic    <= s_iic_ao1;
          iic_sdat_out <= `LOW;
     end

     s_iic_ao1: begin
          state_iic    <= s_iic_ao0;
          iic_sdat_out <= `LOW;
     end

     s_iic_ao0: begin
          state_iic    <= s_iic_rw;
          iic_sdat_out <= `HI;	// READ = 1
     end

     s_iic_rw: begin
          state_iic    <= s_iic_ack1;
	  iic_sdat_ena <= `LOW;		// turn off SDAT driver
     end

     s_iic_ack1: begin
          state_iic     <= s_iic_d7;
          shift_reg_ena <= `HI;		// enable the receive shift reg
     end

     s_iic_d7: 
          state_iic    <= s_iic_d6;

     s_iic_d6: 
          state_iic    <= s_iic_d5;

     s_iic_d5: 
          state_iic    <= s_iic_d4;

     s_iic_d4: 
          state_iic    <= s_iic_d3;

     s_iic_d3: 
          state_iic    <= s_iic_d2;

     s_iic_d2: 
          state_iic    <= s_iic_d1;

     s_iic_d1: 
          state_iic    <= s_iic_d0;

     s_iic_d0: begin
          state_iic    <= s_iic_ack2;
	  shift_reg_ena <= `LOW;	// disable shifting data in during this bit
	  iic_sdat_out  <= `LOW;	// acknowledge to Temp Sensor I got the data
	  iic_sdat_ena  <= `HI;		// allow sending of SDAT
     end

     s_iic_ack2: begin
          state_iic     <= s_iic_d7l;
          shift_reg_ena <= `HI;
	  iic_sdat_ena  <= `LOW;
     end

     s_iic_d7l: begin
          state_iic     <= s_iic_d6l;
	  shift_reg_ena <= `LOW;
     end

     s_iic_d6l:  
          state_iic     <= s_iic_d5l;
	  
     s_iic_d5l: 
          state_iic     <= s_iic_d4l;
	  
     s_iic_d4l: 
          state_iic     <= s_iic_d3l;
	  
     s_iic_d3l: 
          state_iic     <= s_iic_d2l;
	  
     s_iic_d2l: 
          state_iic     <= s_iic_d1l;
	  
     s_iic_d1l: 
          state_iic     <= s_iic_d0l;
	  
     s_iic_d0l: 
          state_iic     <= s_iic_ack3;
	  
     s_iic_ack3: begin
          state_iic     <= s_iic_p;
	  iic_sdat_out  <= `HI;   	// NACK 
	  iic_sdat_ena  <= `HI;
     end	  

     s_iic_p: begin 
          state_iic     <= s_iic_p2;
          iic_sdat_out  <= `LOW;
          sp_ready      <= `HI;
     end

     s_iic_p2: begin
          state_iic     <= s_iic_idle;
          iic_sdat_out  <= `HI;
     end
     
  endcase
        



endmodule

