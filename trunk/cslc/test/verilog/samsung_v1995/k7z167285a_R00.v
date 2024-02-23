//
//	File Name: K7Z167285A.v
//	Version  : Rev 0.3
//	July 27 2001
//
//	Description: ( 16Mb Double Late Write Sigma SRAM ) 
//
//	Bwa_n	--> Control Dq 8 : 0
//	Bwb_n	--> Control Dq 17: 9
//	Bwc_n	--> Control Dq 26:18
//	Bwd_n	--> Control Dq 35:27
//	Bwe_n	--> Control Dq 44:36
//	Bwf_n	--> Control Dq 53:45
//	Bwg_n	--> Control Dq 62:54
//	Bwh_n	--> Control Dq 71:63
//


`timescale 1ns / 100ps

`ifdef hc30
     `define     tKHKH   3.3     // Min - Cycle time
     `define     tKHKL   1.3     // Min - Clock high pulse width
     `define     tKLKH   1.3     // Min - Clock low pulse width
     `define     tKHCH   1.7     // Max - Clock High to Echo Clock High
     `define     tKLCL   1.9     // Max - Clock Low to Echo Clock Low
     `define     tCHQV   0.4     // Max - Echo Clock to Output Valid
     `define     tCHQX  -0.4     // Min - Echo Clock to Output Hold
     `define     tCHQX1 -0.4     // Max - Echo Clock to Output High-Z
     `define     tKHCX1  0.5     // Min - Clock High to Output Low-Z
     `define     tKHCZ   1.7     // Max - Clock High to Output High-Z
     `define     tKHQV   1.8     // Max - Clock High to Output Valid
     `define     tKHQZ   1.8     // Max - Clock High to Output High-Z
     `define     tKHQX   0.5     // Min - Output Hold from Clock High
     `define     tKHQX1  0.5     // Min - Clock High to Output Low-Z
     `define     tAVKH   0.7     // Min - Address setup Time
     `define     tEVKH   0.7     // Min - Chip Enable Setup to Clock High
     `define     tWVKH   0.7     // Min - Write Setup to Clock High
     `define     tDVKH   0.7     // Min - Data setup to Clock High
     `define     tadvVKH 0.7     // Min - Address ADV hold from Clock High
     `define     tKHAX   0.4     // Min - Address hold Time
     `define     tKHEX   0.4     // Min - Chip Enable Hold from Clock High
     `define     tKHWX   0.4     // Min - Write(WEb, BW_X) hold from Clock High
     `define     tKHDX   0.4     // Min - Data hold from Clock High
     `define     tKHadvX 0.4     // Min - Address ADV hold from Clock High


`endif

`ifdef hc27
     `define     tKHKH   3.6     // Min - Cycle time
     `define     tKHKL   1.4     // Min - Clock high pulse width
     `define     tKLKH   1.4     // Min - Clock low pulse width
     `define     tKHCH   1.9     // Max - Clock High to Echo Clock High
     `define     tKLCL   2.0     // Max - Clock Low to Echo Clock Low
     `define     tCHQV   0.4     // Max - Echo Clock to Output Valid
     `define     tCHQX  -0.4     // Min - Echo Clock to Output Hold
     `define     tCHQX1 -0.4     // Max - Echo Clock to Output High-Z
     `define     tKHCX1  0.5     // Min - Clock High to Output Low-Z
     `define     tKHCZ   1.9     // Max - Clock High to Output High-Z
     `define     tKHQV   2.0     // Max - Clock High to Output Valid
     `define     tKHQZ   2.0     // Max - Clock High to Output High-Z
     `define     tKHQX   0.5     // Min - Output Hold from Clock High
     `define     tKHQX1  0.5     // Min - Clock High to Output Low-Z
     `define     tAVKH   0.7     // Min - Address setup Time
     `define     tEVKH   0.7     // Min - Chip Enable Setup to Clock High
     `define     tWVKH   0.7     // Min - Write Setup to Clock High
     `define     tDVKH   0.7     // Min - Data setup to Clock High
     `define     tadvVKH 0.7     // Min - Address ADV setup from Clock High
     `define     tKHAX   0.4     // Min - Address Hold from
     `define     tKHEX   0.4     // Min - Chip Enable Hold from Clock High
     `define     tKHWX   0.4     // Min - Write(WEb, BW_X) hold from Clock High
     `define     tKHDX   0.4     // Min - Data hold from Clock High
     `define     tKHadvX 0.4     // Min - Address ADV hold from Clock High


`endif

`ifdef hc25
     `define     tKHKH   4.0     // Min - Cycle time
     `define     tKHKL   1.5     // Min - Clock high pulse width
     `define     tKLKH   1.5     // Min - Clock low pulse width
     `define     tKHCH   2.0     // Max - Clock High to Echo Clock High
     `define     tKLCL   2.3     // Max - Clock Low to Echo Clock Low
     `define     tCHQV   0.5     // Max - Echo Clock to Output Valid
     `define     tCHQX  -0.4     // Min - Echo Clock to Output Hold
     `define     tCHQX1 -0.4     // Max - Echo Clock to Output High-Z
     `define     tKHCX1  0.5     // Min - Clock High to Output Low-Z
     `define     tKHCZ   2.0     // Max - Clock High to Output High-Z
     `define     tKHQV   2.1     // Max - Clock High to Output Valid
     `define     tKHQZ   2.1     // Max - Clock High to Output High-Z
     `define     tKHQX   0.5     // Min - Output Hold from Clock High
     `define     tKHQX1  0.5     // Min - Clock High to Output Low-Z
     `define     tAVKH   0.8     // Min - Address setup Time
     `define     tEVKH   0.8     // Min - Chip Enable Setup to Clock High
     `define     tWVKH   0.8     // Min - Write Setup to Clock High
     `define     tDVKH   0.8     // Min - Data setup to Clock High
     `define     tadvVKH 0.8     // Min - Address ADV hold from Clock High
     `define     tKHAX   0.5     // Min - Address hold Time
     `define     tKHEX   0.5     // Min - Chip Enable Hold from Clock High
     `define     tKHWX   0.5     // Min - Write(WEb, BW_X) hold from Clock High
     `define     tKHDX   0.4     // Min - Data hold from Clock High
     `define     tKHadvX 0.5     // Min - Address ADV hold from Clock High

`endif

`ifdef hc30_sd

     `define     tKHKH   3.3     // Min - Cycle time
     `define     tKHKL   1.3     // Min - Clock high pulse width
     `define     tKLKH   1.3     // Min - Clock low pulse width
     `define     tKHCH   2.6     // Max - Clock High to Echo Clock High
     `define     tKLCL   2.8     // Max - Clock Low to Echo Clock Low
     `define     tCHQV   0.4     // Max - Echo Clock to Output Valid
     `define     tCHQX  -0.4     // Min - Echo Clock to Output Hold
     `define     tCHQX1 -0.4     // Max - Echo Clock to Output High-Z
     `define     tKHCX1  1.4     // Min - Clock High to Output Low-Z
     `define     tKHCZ   2.6     // Max - Clock High to Output High-Z
     `define     tKHQV   2.7     // Max - Clock High to Output Valid
     `define     tKHQZ   2.7     // Max - Clock High to Output High-Z
     `define     tKHQX   1.4     // Min - Output Hold from Clock High
     `define     tKHQX1  1.4     // Min - Clock High to Output Low-Z
     `define     tAVKH   0.7     // Min - Address setup Time
     `define     tEVKH   0.7     // Min - Chip Enable Setup to Clock High
     `define     tWVKH   0.7     // Min - Write Setup to Clock High
     `define     tDVKH   0.7     // Min - Data setup to Clock High
     `define     tadvVKH 0.7     // Min - Address ADV hold from Clock High
     `define     tKHAX   0.4     // Min - Address hold Time
     `define     tKHEX   0.4     // Min - Chip Enable Hold from Clock High
     `define     tKHWX   0.4     // Min - Write(WEb, BW_X) hold from Clock High
     `define     tKHDX   0.4     // Min - Data hold from Clock High
     `define     tKHadvX 0.4     // Min - Address ADV hold from Clock High


`endif

`ifdef hc27_sd
     `define     tKHKH   3.6     // Min - Cycle time
     `define     tKHKL   1.4     // Min - Clock high pulse width
     `define     tKLKH   1.4     // Min - Clock low pulse width
     `define     tKHCH   2.8     // Max - Clock High to Echo Clock High
     `define     tKLCL   2.9     // Max - Clock Low to Echo Clock Low
     `define     tCHQV   0.4     // Max - Echo Clock to Output Valid
     `define     tCHQX  -0.4     // Min - Echo Clock to Output Hold
     `define     tCHQX1 -0.4     // Max - Echo Clock to Output High-Z
     `define     tKHCX1  1.4     // Min - Clock High to Output Low-Z
     `define     tKHCZ   2.8     // Max - Clock High to Output High-Z
     `define     tKHQV   2.9     // Max - Clock High to Output Valid
     `define     tKHQZ   2.9     // Max - Clock High to Output High-Z
     `define     tKHQX   1.4     // Min - Output Hold from Clock High
     `define     tKHQX1  1.4     // Min - Clock High to Output Low-Z
     `define     tAVKH   0.7     // Min - Address setup Time
     `define     tEVKH   0.7     // Min - Chip Enable Setup to Clock High
     `define     tWVKH   0.7     // Min - Write Setup to Clock High
     `define     tDVKH   0.7     // Min - Data setup to Clock High
     `define     tadvVKH 0.7     // Min - Address ADV setup from Clock High
     `define     tKHAX   0.4     // Min - Address Hold from
     `define     tKHEX   0.4     // Min - Chip Enable Hold from Clock High
     `define     tKHWX   0.4     // Min - Write(WEb, BW_X) hold from Clock High
     `define     tKHDX   0.4     // Min - Data hold from Clock High
     `define     tKHadvX 0.4     // Min - Address ADV hold from Clock High


`endif

`ifdef hc25_sd
     `define     tKHKH   4.0     // Min - Cycle time
     `define     tKHKL   1.5     // Min - Clock high pulse width
     `define     tKLKH   1.5     // Min - Clock low pulse width
     `define     tKHCH   2.9     // Max - Clock High to Echo Clock High
     `define     tKLCL   3.2     // Max - Clock Low to Echo Clock Low
     `define     tCHQV   0.5     // Max - Echo Clock to Output Valid
     `define     tCHQX  -0.4     // Min - Echo Clock to Output Hold
     `define     tCHQX1 -0.4     // Max - Echo Clock to Output High-Z
     `define     tKHCX1  1.4     // Min - Clock High to Output Low-Z
     `define     tKHCZ   2.9     // Max - Clock High to Output High-Z
     `define     tKHQV   3.0     // Max - Clock High to Output Valid
     `define     tKHQZ   3.0     // Max - Clock High to Output High-Z
     `define     tKHQX   1.4     // Min - Output Hold from Clock High
     `define     tKHQX1  1.4     // Min - Clock High to Output Low-Z
     `define     tAVKH   0.8     // Min - Address setup Time
     `define     tEVKH   0.8     // Min - Chip Enable Setup to Clock High
     `define     tWVKH   0.8     // Min - Write Setup to Clock High
     `define     tDVKH   0.8     // Min - Data setup to Clock High
     `define     tadvVKH 0.8     // Min - Address ADV hold from Clock High
     `define     tKHAX   0.5     // Min - Address hold Time
     `define     tKHEX   0.5     // Min - Chip Enable Hold from Clock High
     `define     tKHWX   0.5     // Min - Write(WEb, BW_X) hold from Clock High
     `define     tKHDX   0.4     // Min - Data hold from Clock High
     `define     tKHadvX 0.5     // Min - Address ADV hold from Clock High

`endif

     `define     addr_bits  18   // Address is 16 bits + 2bit(Burst count)
     `define     data_bits  72   //  72 I/O bits
     `define     VDD     1       // TRUE  ==  VDD == VDDQ == 1
     `define     VDDQ    1       // TRUE  ==  VDD == VDDQ == 1
     `define     VSS     0       // FAULE ==  VSS == VSSQ == 1
     `define     VSSQ    0       // FAULE ==  VSS == VSSQ == 1


module K7Z167285A ( Dq, Addr, CLK, 
	   	  Bwa_n, Bwb_n, Bwc_n, Bwd_n, Bwe_n, Bwf_n, Bwg_n, Bwh_n,
	   	  WEb, ADV, SDb,                  
	   	  EP2, EP3, E1b, E2, E3, 
                  CQ1, CQ1b, CQ2, CQ2b );

parameter mem_sizes = 262143;                                 //  256 K

inout   [(`data_bits - 1) : 0] Dq;                            // Data I/O
input   [(`addr_bits - 1) : 0] Addr;                          // Address

input   CLK;                                                  // Clock
input   ADV;                                                  // Address Advance
input   SDb;                                                  // Slow Down Mode
input   WEb;                                                  // Read(="H")/Write(="L")

input   Bwa_n;                                                // Byte Write Enable A
input   Bwb_n;                                                // Byte Write Enable B
input   Bwc_n;                                                // Byte Write Enable C
input   Bwd_n;                                                // Byte Write Enable D
input   Bwe_n;                                                // Byte Write Enable E
input   Bwf_n;                                                // Byte Write Enable F
input   Bwg_n;                                                // Byte Write Enable G
input   Bwh_n;                                                // Byte Write Enable H

input   E1b;                                                  // Chip Enable
input   E2;                                                   // Chip Enable
input   E3;                                                   // Chip Enable
input   EP2;                                                  // Chip Enable
input   EP3;                                                  // Chip Enable

wire  [(`data_bits - 1) : 0] Dq;                         // Data I/O  inout is connected by wire
wire  [(`data_bits - 1) : 0] DQ;                         // Data I/O  inout is connected by wire
reg  [(`data_bits - 1) : 0] read_temp;                       // Data I/O  inout is connected by wire

output  CQ1 ;              				      // output clock
output  CQ2 ;              				      // output clock
output  CQ1b;              				      // output clock bar
output  CQ2b;              				      // output clock bar

reg     ck ;	    					      // clk
reg     ckb ;	    					      // clkb
reg     [`data_bits -1 : 0] mem [ 0 : mem_sizes ];              // common IO = 72 , 256K

reg     adv;    					      // ADV 
reg     now_adv;    					      // ADV 
reg     past_adv;    					      // ADV 
reg     last_adv;    					      // ADV 
reg     last1_adv;    					      // ADV 
reg     sd_b;    					      // Slow Down control
reg     sd_b_n;    					      // Slow Down control
reg     we_b;    					      // H(READ), L(WRITE)

reg     cq1;    					      // echo clk1
reg     cq1b;    					      // echo clk1b
reg     cq2;    					      // echo clk2
reg     cq2b;    					      // echo clk2b
reg     out_con;    					      // echo clk2b

reg     [(`addr_bits - 1) : 0] addr_buf;                      // Addr Register
reg     [(`data_bits - 1) : 0] data_buf;                      // Data Register
reg     [(`data_bits - 1) : 0] dout;                          // Dq Register

reg     [(`addr_bits - 1) : 0] last1_add;                      // Addr @ before 2 cycle
reg     [(`addr_bits - 1) : 0] last_add;                      // Addr @ before 2 cycle
reg     [(`addr_bits - 1) : 0] past_add;                      // Addr @ before 1 cycle
reg     [(`addr_bits - 1) : 0] now_add;                       // Addr @ present cycle
reg     [(`addr_bits - 1) : 0] addr_tmp;                      // Addr @ present cycle

reg     [(`data_bits - 1) : 0] last1_data;                     // Data @ before 2 cycle
reg     [(`data_bits - 1) : 0] last_data;                     // Data @ before 2 cycle
reg     [(`data_bits - 1) : 0] past_data;                     // Data @ past cycle
reg     [(`data_bits - 1) : 0] now_data;                      // Data @ present cycle
reg     [(`data_bits - 1) : 0] tmp_data;                      // Data @ temp data Register

reg     burst_state[4:0];    	      		              // PAST STATE before 3 cycle@ Read or Write
reg     last2_state;    	      		              // PAST STATE before 3 cycle@ Read or Write
reg     last1_state;    	       		              // LAST STATE before 2 cycle@ Read or Write
reg     last_state;    	        		              // LAST STATE @ Read or Write
reg     past_state;    	        		              // PAST STATE @ Read or Write
reg     now_state; 		     	               	      // NOW STATE @ Read or Write

reg     bwa_n;          	                              // Syn Byte Write Enable A
reg     bwb_n;                  	                      // Syn Byte Write Enable B
reg     bwc_n;                          	              // Syn Byte Write Enable C
reg     bwd_n;	                                	      // Syn Byte Write Enable D
reg     bwe_n; 	  	                                      // Syn Byte Write Enable E
reg     bwf_n;		                                      // Syn Byte Write Enable F
reg     bwg_n;  	                                      // Syn Byte Write Enable G
reg     bwh_n;           	                              // Syn Byte Write Enable H

reg     now_bwa_n;          	                              // Syn Byte Write Enable A
reg     now_bwb_n;                  	                      // Syn Byte Write Enable B
reg     now_bwc_n;                          	              // Syn Byte Write Enable C
reg     now_bwd_n;	                                	      // Syn Byte Write Enable D
reg     now_bwe_n; 	  	                                      // Syn Byte Write Enable E
reg     now_bwf_n;		                                      // Syn Byte Write Enable F
reg     now_bwg_n;  	                                      // Syn Byte Write Enable G
reg     now_bwh_n;           	                              // Syn Byte Write Enable H

reg     past_bwa_n;          	                              // Syn Byte Write Enable A
reg     past_bwb_n;                  	                      // Syn Byte Write Enable B
reg     past_bwc_n;                          	              // Syn Byte Write Enable C
reg     past_bwd_n;	                                	      // Syn Byte Write Enable D
reg     past_bwe_n; 	  	                                      // Syn Byte Write Enable E
reg     past_bwf_n;		                                      // Syn Byte Write Enable F
reg     past_bwg_n;  	                                      // Syn Byte Write Enable G
reg     past_bwh_n;           	                              // Syn Byte Write Enable H

reg     [(`addr_bits - 3) : 0] rburst_add;                      // Addr Register
reg     [(`addr_bits - 3) : 0] wburst_add;                      // Addr Register
reg     [1 : 0] bcnt;                                         // 4 Burst Counter(1 ~ 4)
reg     deselect;					      // deselect
reg     now_deselect    ;	                              // chip select
reg     past_deselect   ;	                              // chip select
reg     last_deselect   ;	                              // chip select
reg     last1_deselect  ;	                              // chip select
reg     last2_deselect  ;	                              // chip select
                                                          
reg     ep2;		                                      // control bit with e2
reg     ep2_n;		                                      // control bit with e2
reg     ep3;		                                      // control bit with e3
reg     ep3_n;		                                      // control bit with e3
reg     E  ;		                                      // control bit(Bank select)
reg     e ;		                                      // chip select
reg     e1b ;		                                      // chip select
reg     now_e1b ;	                                      // chip select
reg     past_e1b ;	                                      // chip select
reg     last_e1b ;	                                      // chip select
reg     last1_e1b ;	                                      // chip select
reg     e2 ;		                                      // control bit with ep2
reg     e3 ;		                                      // control bit with ep3
reg     e2_n ;		                                      // control bit with ep2
reg     e3_n ;		                                      // control bit with ep3
reg    	Dq_flag ;
real    last_pos_CLK ;
real    current_time ;
reg     W_flag     ;
integer t ;		                                      // control bit with ep3


//==============================================================================================//

///////////////////////////////////
// 	Initialize Variables     //
///////////////////////////////////

initial 
begin
	t = 0      ;
	Dq_flag = 0      ;
	W_flag = 0      ;
	dout     = {`data_bits{1'bz}}  ;
	data_buf = {`data_bits{1'bz}}  ;
	addr_tmp = `addr_bits'b111111111111111100  ;
	read_temp = {`data_bits{1'bz}}  ;
        rburst_add= 2'b0   ; 
        wburst_add= 2'b0   ; 
        bcnt     = 2'b0   ; 
	deselect = 1'b0   ;
	now_deselect = 1'bz   ;
	past_deselect = 1'bz   ;
	last_deselect = 1'bz   ;
	last1_deselect = 1'bz   ;
	last2_deselect = 1'bz   ;
        ck = 1'b0 ;
        ckb = 1'b1 ;
        out_con = 1'b0 ;

	bwa_n = 1    ;
       	bwb_n = 1    ;
       	bwc_n = 1    ;
       	bwd_n = 1    ;
	bwe_n = 1    ;
       	bwf_n = 1    ;
       	bwg_n = 1    ;
       	bwh_n = 1    ;

	now_bwa_n = 1    ;
       	now_bwb_n = 1    ;
       	now_bwc_n = 1    ;
       	now_bwd_n = 1    ;
	now_bwe_n = 1    ;
       	now_bwf_n = 1    ;
       	now_bwg_n = 1    ;
       	now_bwh_n = 1    ;

	past_bwa_n = 1    ;
       	past_bwb_n = 1    ;
       	past_bwc_n = 1    ;
       	past_bwd_n = 1    ;
	past_bwe_n = 1    ;
       	past_bwf_n = 1    ;
       	past_bwg_n = 1    ;
       	past_bwh_n = 1    ;

	last1_e1b = 1'bz ;
	last_e1b = 1'bz  ;
        past_e1b = 1'bz  ;  
        now_e1b  = 1'bz  ;
        e1b =   1'bz   ;


	addr_buf = {`addr_bits{1'bz}};                      // Addr Register
	last_add = {`addr_bits{1'bz}};                      // Addr @ before 2 cycle
	past_add = {`addr_bits{1'bz}};                      // Addr @ before 1 cycle
	now_add  = {`addr_bits{1'bz}};                       // Addr @ present cycle

	last_data  = {`data_bits{1'bz}};                     // Data @ before 2 cycle
	past_data  = {`data_bits{1'bz}};                     // Data @ past cycle
	now_data  = {`data_bits{1'bz}};                      // Data @ present cycle
	tmp_data  = {`data_bits{1'bz}};                      // Data @ temp data Register
end


always @(posedge CLK)
    begin
	cq1 = #`tKHCH CLK;			// CLK -> Echo clk
	cq1b = ~cq1;			// CQ2 enable
	ck = #0.03  CLK;			// CLK -> Echo clk
    end

always @(negedge CLK)
    begin
	cq1 = #`tKHCH CLK ;			// CQ1 enable
	cq1b = ~cq1;			// CQ2 enable
	ck =  #0.03 CLK;			// CLK -> Echo clk
    end


assign CQ1  = E ? cq1 : 1'bz ;			// CQ1 enable
assign CQ2  = E ? cq1  : 1'bz;			// CQ2 enable
assign CQ1b = E ? cq1b  : 1'bz;			// CQ1b enable
assign CQ2b = E ? cq1b : 1'bz ;			// CQ2b enable

assign Dq = out_con ? read_temp : {`data_bits{1'bz}};




////////////////////////////////////////////////
/////// state tran. control signal   ///////////
///////      Echo clock control      ///////////
////////////////////////////////////////////////
always @(posedge ck ) // or negedge CLK)  // if error, make E_temp register
	begin
                if((e2 == ep2)&&(e3==ep3))              // Chip enable 'E' decision
                   begin
                       E = 1 ;                          // T == 1
 	           end
                else
                   begin 
		       E = 0 ;                          // F == 0
		   end
	end

///////////////////////////////////////////////////////////////////////////
//////   Deselect   ////    control signal sequence [ /E1, E, ADV, /WE ]
///////////////////////////////////////////////////////////////////////////
always @(negedge CLK )
	begin
        	if((e1b==1)&&(E==1)&&(adv==0))
                  begin
                   deselect = 1;		
                  end

        	if((E==0)&&(adv==0)&&(deselect==1))
                  begin
                   deselect = 1;		
                  end
        	else if((adv==1)&&(deselect==1))
                  begin
                   deselect =  1;
                  end
                else if((e1b==0)&&(E==1)&&(adv==0))// &&((we_b ==1)||(we_b==0)))
                  begin
                   deselect =  0;				// Deselect(=Hold) is RESET
                  end
	end
//////////////////////
//  Main Function   //
//////////////////////

always @(posedge ck or negedge ck )
	begin
		last2_deselect = last1_deselect;   // deselect @ last cycle
		last1_deselect = last_deselect;   // deselect @ last cycle
		last_deselect = past_deselect;    // deselect @ last cycle
                past_deselect = now_deselect;     // deselect @ past cycle
                now_deselect   = deselect;        // deselect @ present cycle
	end

always @(negedge CLK)
	begin
		past_bwa_n = now_bwa_n;
		now_bwa_n = bwa_n;

		past_bwb_n = now_bwb_n;
		now_bwb_n = bwb_n;

		past_bwc_n = now_bwc_n;
		now_bwc_n = bwc_n;

		past_bwd_n = now_bwd_n;
		now_bwd_n = bwd_n;

		past_bwe_n = now_bwe_n;
		now_bwe_n = bwe_n;

		past_bwf_n = now_bwf_n;
		now_bwf_n = bwf_n;

		past_bwg_n = now_bwg_n;
		now_bwg_n = bwg_n;

		past_bwh_n = now_bwh_n;
		now_bwh_n = bwh_n;


		last1_e1b = last_e1b;             // e1b  @ last cycle
		last_e1b = past_e1b;              // e1b  @ last cycle
                past_e1b = now_e1b;               // e1b  @ past cycle
                now_e1b   = e1b;                  // e1b  @ present cycle

		last1_adv = last_adv;             // adv  @ last cycle
		last_adv = past_adv;              // adv  @ last cycle
                past_adv = now_adv;               // adv  @ past cycle
                now_adv   = adv;                  // adv  @ present cycle

		last1_add = last_add;             // Addr @ last cycle
		last_add = past_add;              // Addr @ last cycle
                past_add = now_add;               // Addr @ past cycle
                now_add   = addr_buf;             // Addr @ present cycle

                last1_data = last_data;           // data @ last cycle
                last_data = past_data;            // data @ last cycle
                past_data = now_data;             // data @ past cycle
                now_data  = data_buf;             // data @ present cycle

                last2_state = last1_state ;       // State Register
                burst_state[4] = last1_state ;       // State Register

                last1_state = last_state ;        // State Register
                burst_state[3] = last_state ;       // State Register

                last_state = past_state ;         // State Register
                burst_state[2] = past_state ;       // State Register

                past_state = now_state ;          // State Register
                burst_state[1] = now_state ;       // State Register

                now_state  = we_b   ;             // State Register
                burst_state[0] = we_b ;       // State Register

                e = E ;
                e2_n = e2 ;
                e3_n = e3 ;
                ep2_n = ep2 ;
                ep3_n = ep3 ;
                sd_b_n = sd_b;
	end


always @(posedge CLK) 
	begin
		// Write Registry and Data Coherency Control Logic

		bwa_n = Bwa_n;
        	bwb_n = Bwb_n;
        	bwc_n = Bwc_n;
        	bwd_n = Bwd_n;
		bwe_n = Bwe_n;
        	bwf_n = Bwf_n;
        	bwg_n = Bwg_n;
        	bwh_n = Bwh_n;

                adv   = ADV ;
                sd_b  = SDb ;
                we_b  = WEb ;
                e1b   = E1b ;
                e2    = E2  ;
                e3    = E3  ;
                ep2   = EP2 ;
                ep3   = EP3 ;
		addr_buf  = Addr ;               // Address fetch at Addr Register
		data_buf  = Dq   ;               // Address fetch at Addr Register


                ///////////////////
		//  Write Logic  //
                ///////////////////


if((past_e1b==0)&&(E==1)&&( past_adv==0 )&&(past_state==0))   // Single Write
                         begin

                                out_con = 0 ;
                                t =  0 ;
                                W_flag  =  1 ;
                                bcnt =  past_add[1:0] ;    // A1, A0 is used burst count start address
                                wburst_add =  past_add >> 2 ;   // value of A1, A0 is "00"

                        if ( past_bwa_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8) - 1) : 0] = Dq[((`data_bits / 8) - 1) : 0];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwb_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 4) - 1) : (`data_bits / 8 )] = Dq[((`data_bits / 4) - 1) : (`data_bits / 8 )];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwc_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*3 - 1) : (`data_bits / 4 )] = Dq[((`data_bits / 8)*3 - 1) : (`data_bits / 4 )];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwd_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*4 - 1) : (`data_bits / 8 )*3] = Dq[((`data_bits / 8)*4 - 1) : (`data_bits / 8 )*3];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwe_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*5 - 1) : (`data_bits / 8 )*4] = Dq[((`data_bits / 8)*5 - 1) : (`data_bits / 8 )*4];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwf_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*6 - 1) : (`data_bits / 8 )*5] = Dq[((`data_bits / 8)*6 - 1) : (`data_bits / 8 )*5];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwg_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*7 - 1) : (`data_bits / 8 )*6] = Dq[((`data_bits / 8)*7 - 1) : (`data_bits / 8 )*6];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwh_n== 1'b0   )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*8 - 1) : (`data_bits / 8 )*7] = Dq[((`data_bits / 8)*8 - 1) : (`data_bits / 8 )*7];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end
                                read_temp = {`data_bits{1'bz}} ;
                                t = 2               ;         //   Burst or Continue
                                out_con = 1 ;
                         end


/////////////////   WRITE  BURST LOGIC    /////////////////////


        	if(( past_adv==1 )&&(e==1)&&(burst_state[t]==0))   // Write Burst
	                 begin
                                W_flag = 1 ;
				out_con =0 ;
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue

			if ( past_bwa_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8) - 1) : 0] = Dq[((`data_bits / 8) - 1) : 0];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwb_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 4) - 1) : (`data_bits / 8 )] = Dq[((`data_bits / 4) - 1) : (`data_bits / 8)];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwc_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*3 - 1) : (`data_bits / 4 )] = Dq[((`data_bits / 8)*3 - 1) : (`data_bits/4)];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwd_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*4 - 1) : (`data_bits / 8 )*3] = Dq[((`data_bits / 8)*4 - 1) : (`data_bits / 8 )*3];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwe_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*5 - 1) : (`data_bits / 8 )*4] = Dq[((`data_bits / 8)*5 - 1) :(`data_bits / 8 )*4];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwf_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*6 - 1) : (`data_bits / 8 )*5] = Dq[((`data_bits / 8)*6 - 1) : (`data_bits / 8 )*5];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwg_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*7 - 1) : (`data_bits / 8 )*6] = Dq[((`data_bits / 8)*7 - 1) :  (`data_bits / 8 )*6];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwh_n== 1'b0   )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*8 - 1) : (`data_bits / 8 )*7] = Dq[((`data_bits / 8)*8 - 1) :  (`data_bits / 8 )*7];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwg_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*7 - 1) : (`data_bits / 8 )*6] = Dq[((`data_bits / 8)*7 - 1) : (`data_bits / 8 )*6];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwh_n== 1'b0   )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 8)*8 - 1) : (`data_bits / 8 )*7] = Dq[((`data_bits / 8)*8 - 1) : (`data_bits / 8 )*7];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end


//////////////////////////////////////////////////////////////////////////////////////////////////////
//	                 	mem[{wburst_add,bcnt}] = Dq ;
                	 	t = t + 1		    ; 	      //   Burst or Continue
                              if(deselect==1)
				begin
                                	$display(" Deselect can not active in Burst operation");
				end
                                read_temp = {`data_bits{1'bz}} ;
				out_con =1 ;
        	         end

                //////////////////
		//  Read Logic  //
                //////////////////

        	if((deselect==0)&&(now_e1b==0)&&(E==1)&&(now_adv==0)&&(now_state==1)) //Single Read
	                 begin
				t =0 ;
				bcnt = now_add[1:0] ;    // A1, A0 is used burst count start address
                                rburst_add = now_add >> 2 ;   // value of A1, A0 is "00"
                	 	dout = #0.03 mem[{rburst_add, bcnt}] ;

				out_con  <= #(`tKHQV + `tKHKH*0  ) 1'b1 ;
				read_temp <= #(`tKHQV + `tKHKH*0 ) dout ;
				dout <= #(`tKHQX + `tKHKH*1 ) {`data_bits{1'bz}} ;
				read_temp <= #(`tKHQX + `tKHKH*1 ) dout  ;
				out_con <=  #(`tKHQX + `tKHKH*1  ) 1'b0 ;
				t =1 ;
                         end

        	if(( now_adv==1 )&&(e==1)&&(burst_state[t]==1))   // Read Burst
	                 begin
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue
                                W_flag = 0 ;
                	 	dout = mem[{rburst_add, bcnt}] ;
				out_con  <= #(`tKHQV+`tKHKH*0 ) 1'b1 ;
				read_temp <= #(`tKHQV+`tKHKH*0) dout ;
				dout <= #(`tKHQX + `tKHKH*1) {`data_bits{1'bz}} ;
				read_temp <= #(`tKHQX + `tKHKH*1) dout  ;
				out_con <=  #(`tKHQX + `tKHKH*1 ) 1'b0 ;
                              if(deselect==1)
				begin
                                	$display(" Deselect can not active in Burst operation");
				end
                	 	t = t + 1		    ; 	      //   Burst or Continue
        	         end

    	end

always @(posedge CLK)
	begin
		last_pos_CLK <= $realtime ;
	end


always @(Dq)
        begin
                if(Dq >= 0)
                        Dq_flag = 1 ;
                else
                        Dq_flag = 0 ;
        end

always @(posedge Dq_flag)
        begin
                current_time = $realtime ;
        if(past_state  == 0)
                begin
                    if((last_pos_CLK + `tKHKH) - current_time < `tDVKH - 0.001)
                       begin
                          $display("Warning: tDVKH violation at %d ns", $time);
                       end
                end
        end

always @(negedge Dq_flag)
        begin
                current_time = $realtime ;

        if(past_state  == 0)
                begin
                    if((current_time - last_pos_CLK) < `tKHDX - 0.001)
                       begin
                          $display("Warning: tKHDX violation at %d ns", $time);
                       end
                end


        end


/////////////////////////////
//// 	Timing Check     ////
/////////////////////////////
    specify
        specparam   t_KC  = `tKHKH,     			// Clock Cycle Time
                    t_KH  = `tKHKL,   				// Clock High Time
                    t_KL  = `tKLKH,				// Clock Low Time
                    t_AS  = `tAVKH,  				// Address Setup Time
                    t_AH  = `tKHAX,                            	// Address Hold Time
                    t_DS  = `tDVKH, 				// Data-In Setup Time
                    t_DH  = `tKHDX,                             // Data-In Hold Time
                    t_advS  = `tadvVKH,				// ADV Setup Time
                    t_advH  = `tKHadvX,                        	// ADV Hold Time
                    t_WS  = `tWVKH,				// Write or Byte Write Signal Setup Time
                    t_WH  = `tKHWX,                            	// Write or Byte Write Signal Hold Time
                    t_ES  = `tEVKH,				// Chip enable Signal Setup Time
                    t_EH  = `tKHEX,                            	// Chip enable Signal Hold Time
                    t_CQS  = `tKHCH,                            	// Chip enable Signal Hold Time
                    t_CQH  = `tKLCL;                           	// Chip enable Signal Hold Time

        $width      ( posedge CLK, t_KH );                    	// Check Ck Width
        $width      ( negedge CLK, t_KL );
        $period     ( posedge CLK, t_KC );                    	// Check Ck Period
        $setuphold  ( posedge CLK, ADV,   t_advS, t_advH );    	// Check ADV Setup/Hold Time
        $setuphold  ( posedge CLK, WEb,   t_WS, t_WH );     	// Check RW  Setup/Hold Time
        $setuphold  ( posedge CLK, Bwa_n, t_WS, t_WH );     	// Check BWa Setup/Hold Time
        $setuphold  ( posedge CLK, Bwb_n, t_WS, t_WH );    	// Check BWb Setup/Hold Time
        $setuphold  ( posedge CLK, Bwc_n, t_WS, t_WH );		// Check BWc Setup/Hold Time
        $setuphold  ( posedge CLK, Bwd_n, t_WS, t_WH );    	// Check BWd Setup/Hold Time
        $setuphold  ( posedge CLK, Bwe_n, t_WS, t_WH );     	// Check BWe Setup/Hold Time
        $setuphold  ( posedge CLK, Bwf_n, t_WS, t_WH );    	// Check BWf Setup/Hold Time
        $setuphold  ( posedge CLK, Bwg_n, t_WS, t_WH );		// Check BWg Setup/Hold Time
        $setuphold  ( posedge CLK, Bwh_n, t_WS, t_WH );    	// Check BWh Setup/Hold Time
        $setuphold  ( posedge CLK, Addr,  t_AS, t_AH );    	// Check Addr Setup/Hold Time
        $setuphold  ( posedge CLK, E1b,   t_ES, t_EH );     	// Check Chip enable Setup/Hold Time
        $setuphold  ( posedge CLK, E2,    t_ES, t_EH );     	// Check Chip enable Setup/Hold Time
        $setuphold  ( posedge CLK, E3,    t_ES, t_EH );     	// Check Chip enable Setup/Hold Time

    endspecify

endmodule
