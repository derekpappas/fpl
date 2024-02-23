
/*=================================================================================
 * Verilog HDL Behavioral Modeling
 * 8M DDR SYNC SRAM : K7D161874B (1M x 18)  <<<
 *
 * Copyright(c) Samsung Electronics, 2001
 * All rights reseved.
 *=================================================================================
 * Revision No. : 0.0      ( Feb. 08, 2001)                                      
 * Revision No. : 0.1      ( Feb. 15, 2001)   ; read to write back to back controlled by gb
 *=================================================================================
 */

`timescale    1ns / 10ps
 
`ifdef hc33
    `define     tKHKH   3.0     // Min - Cycle time
    `define     tKHKL   1.3     // Min - Clock high pulse width
    `define     tKLKH   1.3     // Min - Clock low pulse width
    `define     tKXCE   1.8     // Max - Clock to Echo Clock
    `define     tCEQV   0.1     // Max - Echo Clock to Output Valid
    `define     tCEQX  -0.3    // Min - Echo Clock to Output Hold
    `define     tCEHZ   0.1     // Max - Echo Clock to Output High-Z
 
    `define     tGLQX   0.5     // Min - G# Low to Output Low-Z
    `define     tGHQZ   2.1     // Max - G# High to Output High-Z
    `define     tGLQV   2.1     // Max - G# Low to Output Valid
    `define     tGHQX   0.5     // Min - G# High to Output Hold

    `define     tAVKH   0.4     // Min - Address setup Time
    `define     tBVKH   0.4     // Min - Burst Control Setup Time
    `define     tDVKH   0.4    // Min - Data setup Time
    `define     tKHAX   0.4     // Min - Address hold Time
    `define     tKHBX   0.4     // Min - Burst Control Hold Time
    `define     tKHDX   0.4    // Min - Data hold Time

    `define     itPDS   2       // ZZ high to power down
    `define     itPUS   2       // ZZ low to power up


`endif
 
`ifdef hc30
    `define     tKHKH   3.3     // Min - Cycle time
    `define     tKHKL   1.5     // Min - Clock high pulse width
    `define     tKLKH   1.5     // Min - Clock low pulse width
    `define     tKXCE   1.9     // Max - Clock to Echo Clock
    `define     tCEQV   0.1     // Max - Echo Clock to Output Valid
    `define     tCEQX  -0.3    // Min - Echo Clock to Output Hold
    `define     tCEHZ   0.1     // Max - Echo Clock to Output High-Z
 
    `define     tGLQX   0.5     // Min - G# Low to Output Low-Z
    `define     tGHQZ   2.3     // Max - G# High to Output High-Z
    `define     tGLQV   2.3     // Max - G# Low to Output Valid
    `define     tGHQX   0.5     // Min - G# High to Output Hold
 
    `define     tAVKH   0.4     // Min - Address setup Time
    `define     tBVKH   0.4     // Min - Burst Control Setup Time
    `define     tDVKH   0.4    // Min - Data setup Time
    `define     tKHAX   0.4     // Min - Address hold Time
    `define     tKHBX   0.4     // Min - Burst Control Hold Time
    `define     tKHDX   0.4    // Min - Data hold Time

    `define     itPDS   2       // ZZ high to power down
    `define     itPUS   2       // ZZ low to power up
`endif

`ifdef hc25
    `define     tKHKH   4.0     // Min - Cycle time
    `define     tKHKL   1.7     // Min - Clock high pulse width
    `define     tKLKH   1.7     // Min - Clock low pulse width
    `define     tKXCE   2.0     // Max - Clock to Echo Clock
    `define     tCEQV   0.1     // Max - Echo Clock to Output Valid
    `define     tCEQX  -0.4     // Min - Echo Clock to Output Hold
    `define     tCEHZ   0.1     // Max - Echo Clock to Output High-Z
 
    `define     tGLQX   0.5     // Min - G# Low to Output Low-Z
    `define     tGHQZ   2.5     // Max - G# High to Output High-Z
    `define     tGLQV   2.5     // Max - G# Low to Output Valid
    `define     tGHQX   0.5     // Min - G# High to Output Hold
 
    `define     tAVKH   0.5     // Min - Address setup Time
    `define     tBVKH   0.5     // Min - Burst Control Setup Time
    `define     tDVKH   0.5     // Min - Data setup Time
    `define     tKHAX   0.5     // Min - Address hold Time
    `define     tKHBX   0.5     // Min - Burst Control Hold Time
    `define     tKHDX   0.5     // Min - Data hold Time

    `define     itPDS   2       // ZZ high to power down
    `define     itPUS   2       // ZZ low to power up
`endif

`ifdef hc16
    `define     tKHKH   6.0     // Min - Cycle time
    `define     tKHKL   2.4     // Min - Clock high pulse width
    `define     tKLKH   2.4     // Min - Clock low pulse width
    `define     tKXCE   2.2     // Max - Clock to Echo Clock
    `define     tCEQV   0.3     // Max - Echo Clock to Output Valid
    `define     tCEQX  -0.6     // Min - Echo Clock to Output Hold
    `define     tCEHZ   0.2     // Max - Echo Clock to Output High-Z
 
    `define     tGLQX   0.5     // Min - G# Low to Output Low-Z
    `define     tGHQZ   3.3     // Max - G# High to Output High-Z
    `define     tGLQV   3.3     // Max - G# Low to Output Valid
    `define     tGHQX   0.5     // Min - G# High to Output Hold
 
    `define     tAVKH   0.7     // Min - Address setup Time
    `define     tBVKH   0.7     // Min - Burst Control Setup Time
    `define     tDVKH   0.7     // Min - Data setup Time
    `define     tKHAX   0.7     // Min - Address hold Time
    `define     tKHBX   0.7     // Min - Burst Control Hold Time
    `define     tKHDX   0.7     // Min - Data hold Time

    `define     itPDS   2       // ZZ high to power down
    `define     itPUS   2       // ZZ low to power up
`endif
 
    `define TRUE        1
    `define FALSE       0
    `define nByte       4                        //<<<
    `define DQ_WIDTH    18      // data bits     //<<<
    `define nAddr       20      // address bits  //<<<
    `define byte        9
    `define page_size   256                      //<<<
    `define num_pages   1024

module k7d161874b(a, B1, B2, B3, clk, gb, lbob, dq, cq ,cqb );
    inout	[`DQ_WIDTH-1:0] dq;
    input   	[`nAddr-1:0] a;
    input 	B1, B2, B3, clk ; 
    input	gb,  lbob ;
    output	cq, cqb ;

    ////`protect

    parameter tPDS = `itPDS*`tKHKH;		
    parameter tPUS = `itPUS*`tKHKH;	
    
    real	CUR_TIME;

    `define symbol	8
    `define IDLE        0
    `define SLEEP       1
    `define HALF_SLEEP  2
    `define WAKEN       3

    `define BBRC_D        4	// DDR Begin Burst Read Cycle
    `define BBRC_S        5	// SDR Begin Burst Read Cycle
    `define CBRC_D        6	// DDR Continue Burst Read Cycle
    `define CBRC_S        7	// SDR Continue Burst Read Cycle
    `define BBWC_D        8	// DDR Begin Burst Write Cycle
    `define BBWC_S        9	// SDR Begin Burst Write Cycle
    `define CBWC_D        10	// DDR Continue Burst Write Cycle (a)
    `define CBWC_S        11	// SDR Continue Burst Write Cycle (b)

    `define SDR           1	// SDR
    `define DDR           2	// DDR 

    `define LBURST      0	// Linear Burst Sequence
    `define IBURST      1	// Interleaved Burst Sequence
    `define BLENGTH     4       // Burst Length

    `define z_data      `DQ_WIDTH'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
    `define x_data      `DQ_WIDTH'bxxxxxxxxxxxxxxxxxxzzzzzzzzzzzzzzzzzz

    parameter	page = `page_size * `num_pages;
    parameter	delay = 0.000;
    parameter	delay_c = 0.005;
    parameter	delay1= 0.005;

    reg 	[`DQ_WIDTH-1:0] mem_w [0:page-1];  // 128K x 36 Memory Array 
    reg 	[`DQ_WIDTH-1:0] mem_x [0:page-1];  // 128K x 36 Memory Array 
    reg 	[`DQ_WIDTH-1:0] dqo0;
    reg 	[`DQ_WIDTH-1:0] dqo0w;
    reg 	[`DQ_WIDTH-1:0] dqo0x;
    reg 	[`DQ_WIDTH-1:0] dqo1;
    reg 	[`DQ_WIDTH-1:0] dqo2;
    reg 	[`DQ_WIDTH-1:0] dqo3;
    reg 	[`DQ_WIDTH-1:0] dqo4;
    reg 	[`DQ_WIDTH-1:0] dq1;
    wire 	[`DQ_WIDTH-1:0] dq;
    reg 	[`DQ_WIDTH-1:0] cur_din1h;
    reg 	[`DQ_WIDTH-1:0] cur_din1l;
    reg 	[`DQ_WIDTH-1:0] cur_din1w;
    reg 	[`DQ_WIDTH-1:0] cur_din1x;

    reg		addr_decode;
    reg		[3:0] MODE;
    reg		[1:0] OUT_MODE;
    reg		[3:0] MODE_SD;
    reg		[3:0] MODE_P1;
    reg		[3:0] MODE_P2;
    reg		[3:0] MODE_DQ;
    reg		[1:0] dqo_flag;       //  integer := 0;   -- IDLE=0, WRITE=1, READ=2
    reg		[1:0] dqo_flag_old;   //  integer := 0;   -- IDLE=0, WRITE=1, READ=2
    reg		[1:0] dqo_flag_old2;  //  integer := 0;   -- IDLE=0, WRITE=1, READ=2
    reg		dqo_g;               //  integer := 0;   -- READ=1, Others=0
    reg		dqo_g_flag;          //  integer := 0;   -- READ=1, Others=0
    reg		dqo1_flag;            //  integer := 0;   -- READ=1, Others=0
    reg		init_finished;
    reg		zz;     

    reg		clk_d1;
    reg		clk_d2;
    reg		clk_d3;
    reg		clk_cq;
    reg		clk_cqb;
    reg		Cclk;
    reg		Czz;
    reg		Cdqo_flag;
    reg		Cdqo_g;

    reg 	time_check;	
    reg		[2:0] cmd;

    reg		[`nAddr-1:0] cur_ad;
    reg		[`nAddr-1:0] cnt_ad;
    reg		[`nAddr-1:0] cnt_ad_p1;
    reg		[`nAddr-1:0] cnt_ad_p2;
    reg		[`nAddr-1:0] cur_ad_w;
    reg		[`nAddr-1:0] cur_ad_x;
    reg		[`nAddr-1:0] cur_ad_w_p1;
    reg		[`nAddr-1:0] cur_ad_w_p2;
    reg		[`nAddr-1:0] cur_ad_x_p1;
    reg		[`nAddr-1:0] cur_ad_x_p2;
    reg		[`nAddr-1:0] init_ad;
    integer	add_mode;
    reg	        [35:0] sleep_count;

    real	B1_last_event;
    real	B2_last_event;
    real	B3_last_event;
    real	a_last_event;
    real	dq_last_event;
    real	clk_last_event;
    integer	k;

   /*******************************************
    ***  Timing  Violation  Check  Routine  ***
    *******************************************/

    initial
    begin
	zz = 0;
	B1_last_event = -50;
	B2_last_event = -50;
	B3_last_event = -50;
	a_last_event = -50;
	dq_last_event = -50;
	clk_last_event = -50;
	
	dqo0 = `z_data;
	dqo0w = `z_data;
	dqo0x = `z_data;
	dqo1 = `x_data;
	dqo2 = `z_data;
	dqo3 = `z_data;
	dqo4 = `z_data;
	dqo_flag = 0;
	dqo_flag_old = 0;
	dqo_flag_old2 = 0;
	sleep_count = 0;
	
	init_finished = `TRUE;
	time_check = `TRUE;
    	#1 Cclk = `FALSE; 
	Czz = `FALSE;
	Cdqo_flag = `FALSE;
	Cdqo_g = `FALSE;
	MODE = `IDLE;
	MODE_P1 = `IDLE;
	MODE_P2 = `IDLE;
	MODE_DQ = 0;
    end

    always @(B1)
    begin
	if(B1 == 0)
	    B1_last_event = $realtime;
    end

    always @(B2)
    begin
	if(B2 == 0)
	    B2_last_event = $realtime;
    end

    always @(B3)
    begin
	if(B3 == 0)
	    B3_last_event = $realtime;
    end

    always @(a)
	    a_last_event = $realtime;

    always @(clk)
	    clk_last_event = $realtime;

    always @(dq)
	    dq_last_event = $realtime;

    always @(clk)
    begin: clk_check
	real	last_rising; 
	real	last_falling; 

	if(init_finished) begin
	    last_rising = -50;
	    last_falling = -50;
	end

	else
	    wait(init_finished);

	if(!time_check)
	    wait(time_check);

	CUR_TIME = $realtime;

	if (CUR_TIME > 0) begin
	    if(clk == 1) begin
		if(CUR_TIME - last_rising < `tKLKH)
		    $display("Warning: tKLKH violation at %d", $time);
		if(CUR_TIME - last_rising < `tKHKH)
		    $display("Warning: tKHKH violation at %d", $time);
		if(CUR_TIME - B1_last_event < `tBVKH)
		    $display("Warning: tBVKH violation of B1 at %d", $time);
		if(CUR_TIME - B2_last_event < `tBVKH)
		    $display("Warning: tBVKH violation of B2 at %d", $time);
		if(CUR_TIME - B3_last_event < `tBVKH)
		    $display("Warning: tBVKH violation of B3 at %d", $time);
		if(CUR_TIME - a_last_event < `tAVKH)
		    $display("Warning: tAVKH violation at %d", $time);
		if( dqo_flag_old == 1  && CUR_TIME - dq_last_event < `tDVKH)
		    $display("Warning: tDVKH violation at %d", $time);
		last_rising = CUR_TIME;
	    end
	    else if(clk == 0) begin
		if(CUR_TIME - last_rising < `tKHKL)
		    $display("Warning: tKHKL violation at %d", $time);
		last_falling = CUR_TIME;
	    end
	    else
		$display("Unknown value at clk"); 
	end
	else begin
	    if(clk == 1)
		last_rising = CUR_TIME;
	    else if (clk == 0)
		last_falling = CUR_TIME; 
	end
    end

    always @(B1)
    begin: B1_check
	real	last_rising; 
	real	last_falling; 

	if(init_finished) begin
	    last_rising = -50;
	    last_falling = -50;
	end

   	else
	    wait(init_finished);

	if(!time_check)
	    wait(time_check);

	CUR_TIME = $realtime;

	if (CUR_TIME > 0) begin
	    if(CUR_TIME - clk_last_event < `tKHBX && clk == 1)
	        $display("Warning: tKHBX violation of B1 at %d", $time);
  	end
    end

    always @(B2)
    begin: B2_check
	real	last_rising; 
	real	last_falling; 

	if(init_finished) begin
	    last_rising = -50;
	    last_falling = -50;
	end

   	else
	    wait(init_finished);

	if(!time_check)
	    wait(time_check);

	CUR_TIME = $realtime;

	if (CUR_TIME > 0) begin
	    if(CUR_TIME - clk_last_event < `tKHBX && clk == 1)
		$display("Warning: tKHBX violation of B2 at %d", $time);
  	end
    end

    always @(B3)
    begin: B3_check
	real	last_rising; 
	real	last_falling; 

	if(init_finished) begin
	    last_rising = -50;
	    last_falling = -50;
	end

   	else
	    wait(init_finished);

	if(!time_check)
	    wait(time_check);

	CUR_TIME = $realtime;

	if (CUR_TIME > 0) begin
	    if(CUR_TIME - clk_last_event < `tKHBX && clk == 1)
		$display("Warning: tKHBX violation of B3 at %d", $time);
  	end
    end

    always @(a)
    begin: a_check
	real	last_rising; 
	real	last_falling; 

	if(init_finished) begin
	    last_rising = -50;
	    last_falling = -50;
	end

	else
	    wait(init_finished);

	if(!time_check)
	    wait(time_check);

	CUR_TIME = $realtime;

	if (CUR_TIME > 0) begin
	    if(addr_decode == `TRUE) begin
		if(CUR_TIME - clk_last_event < `tKHAX && clk == 1)
		    $display("Warning: tKHAX violation at %d", $time);
	    end
  	end
    end


    always @(dq)
    begin: dq_check
	real	last_rising; 
	real	last_falling; 

	if(init_finished) begin
	    last_rising = -50;
	    last_falling = -50;
	end

	else
	    wait(init_finished);

	if(!time_check)
	    wait(time_check);

	CUR_TIME = $realtime;

	if (CUR_TIME > 0) begin
	    if( dqo_flag_old == 1 && CUR_TIME - clk_last_event < `tKHDX && clk == 1)
	        $display("Warning: tKHDX violation at %d", $time);
  	end
    end

    /*********************************
     ***  Main  Function  Routine  ***
     *********************************/
//     assign dq = dqo3 ;
     assign dq = dqo4 ;
     assign cq = clk_cq ;
     assign cqb = clk_cqb ;

//*******************************************************************************************
    always @(OUT_MODE or dqo3)
    begin
        if(OUT_MODE == 0)
            dqo4 = `z_data;
 
        else if (OUT_MODE == 1 ) begin
                if (dqo3 === `z_data)
                        dqo4 = `z_data;
                else
                        dqo4 = `x_data;
        end

        else if (OUT_MODE == 2)
            dqo4 = dqo3;
    end  
 
    always @(gb)
    begin
        if(gb == 1)
		#(`tGHQZ)        OUT_MODE = 0;
 
        else begin
		#(`tGLQX)	 OUT_MODE = 1;
		#(`tGLQV-`tGLQX) OUT_MODE = 2;
        end
    end


    always @(dqo_g_flag or dqo2)
    begin
	if(MODE_DQ == 2) begin
               #(`tGLQX)        dqo3 = `x_data;
               #(`tGLQV-`tGLQX) dqo3 = dqo2;
	  end
	else if(MODE_DQ == 3) dqo3 = `z_data;
	else if(MODE_DQ == 6) begin
               #(`tGHQX)        dqo3 = `x_data;
               #(`tGHQZ-`tGHQX) dqo3 = `z_data;
	  end
	else   dqo3 = dqo2;	
    end

    always @( clk )
    begin  
      clk_d1 = #delay_c clk; 
    end

    always @( clk_d1 )
    begin  
      clk_d2 = #delay_c clk_d1; 
    end

    always @( clk_d2 )
    begin  
      clk_d3 = #delay_c clk_d2; 
    end

//*******************************************************************************************

    always @(posedge clk)                                       
    begin                         
       if (dqo_flag_old == 1 )    begin
          cur_din1h = dq;
       end                            
          if ( cnt_ad_p1[0]==`FALSE ) cur_din1w =  cur_din1h;
          if ( cnt_ad_p1[0]==`TRUE  ) cur_din1x =  cur_din1h;
    end                            

    always @(negedge clk)                                       
    begin                         
       if ( MODE_SD == `DDR) begin
            #`tKHKH
             if ( dqo_flag_old == 1) cur_din1l = dq;
       end                            
       if ( cnt_ad_p1[0]==`FALSE && (MODE_P1 == `BBWC_D || MODE_P1 == `CBWC_D) ) 
             cur_din1x =  cur_din1l;
       if ( cnt_ad_p1[0]==`TRUE  && (MODE_P1 == `BBWC_D || MODE_P1 == `CBWC_D) ) 
             cur_din1w =  cur_din1l;
    end                            

    always @( clk_d2 ) 
    begin                         

      if ( dqo_flag_old == 1 ) begin
        mem_w[cur_ad_w_p1] = cur_din1w;
	mem_x[cur_ad_x_p1] = cur_din1x;
	dqo0w =  mem_w[cur_ad_w_p1];
	dqo0x =  mem_x[cur_ad_x_p1];
      end
      if ( dqo_flag_old == 2 ) begin
	dqo0w =  mem_w[cur_ad_w_p1];
	dqo0x =  mem_x[cur_ad_x_p1];
      end
    end

    always @(posedge clk_d2)                                       
    begin                         
    
       if ( dqo_flag_old == 2   )    begin
            if ( cnt_ad_p1[0]==`FALSE ) dqo0 =  dqo0w;
            if ( cnt_ad_p1[0]==`TRUE  ) dqo0 =  dqo0x;
       end                            
    end                            

    always @(negedge clk_d2)                                       
    begin                         
       if ((dqo_flag_old == 2 ) && ( MODE_SD == `DDR ))    begin
            if ( cnt_ad_p1[0]==`FALSE ) dqo0 =  dqo0x;
            if ( cnt_ad_p1[0]==`TRUE  ) dqo0 =  dqo0w;
       end                            
    end                            

    always @( clk_d3)                                       
    begin                         

      dqo1 =  #1.0 dqo0 ;

    end

//*******************************************************************************************

 
    initial
    begin
	for(k=0; k<page; k=k+1) begin 
	    mem_w[k] = `x_data;
	    mem_x[k] = `x_data;
        end
    end

    always @(clk or zz)
    begin: fm_main
	integer	i;

	if(clk == 1 || Czz == `TRUE) begin
	    if(zz == 1) begin                                  // Power Down
 		dqo0 =  `z_data;    /*** Addition ***/
	        if(MODE != `SLEEP && Czz == `TRUE) begin
		    Czz = `FALSE;
		    $display("Entering Sleep Mode at ");
		    MODE = `SLEEP;
		    sleep_count = 0;
		     dqo_flag_old = dqo_flag;
		    #tPDS dqo_flag = 0;
	        end
	        else if (MODE == `SLEEP && Cclk == `TRUE && clk == 1) begin
		    Cclk = `FALSE;
		    sleep_count = sleep_count + 1;
		    if(sleep_count == 1) begin 
		         dqo_flag_old = dqo_flag;
		        #(`tKXCE + `tCEHZ) dqo_flag = 1;
		        #1 dqo_flag = 0;
		    end
	        end
	    end
	    else if (zz == 0) begin                              // Power Up

	         MODE_P2=  MODE_P1;
	       	 MODE_P1=  MODE;


		 cnt_ad_p2=  cnt_ad_p1;
		 cnt_ad_p1=  cnt_ad;

		 cur_ad_w_p2=  cur_ad_w_p1; 
		 cur_ad_w_p1=  cur_ad_w;   

		 cur_ad_x_p2=  cur_ad_x_p1;
		 cur_ad_x_p1=  cur_ad_x;  

	        if(MODE == `SLEEP && Czz == `TRUE) begin
		    $display("after tPUS, Entering Waken Up State at ");
   		    MODE = `HALF_SLEEP;
		    #`tKHKH MODE = `WAKEN;
		    dqo_flag_old = dqo_flag;
		    dqo_flag = 0;
 		    dqo0 =  `z_data;    /*** Addition ***/
	        end
	        else if (MODE != `HALF_SLEEP) begin
		    cmd = {B1, B2, B3 };
		    if((B1 ==1  &&  B2 == 0))  begin
		        MODE = `IDLE;
		         dqo_flag_old = dqo_flag;
  		        dqo_flag = 0;
//     		        dqo0 = `z_data;    /***     Addition ***/
		    end
		    else if((B1 ==0  && B2 == 1 ))  begin
		        MODE = `BBRC_S; 
		        if(B3 == 0) MODE = `BBRC_D; 
		        dqo_flag_old = dqo_flag;
      	                dqo_flag = 2;
		        cur_ad = a;
		        cnt_ad = cur_ad;
		        init_ad = a;
		        if(lbob == 0) begin
		        	add_mode = `LBURST;
                            	if (cur_ad[0] == 0 ) begin
		               		cur_ad_w = cur_ad;
		            		if(MODE == `BBRC_D) begin
       			       			addrcnt;
		               			cur_ad_x = cur_ad;
		            		end
		            	end
	                    	else begin
		              	 	cur_ad_x = cur_ad;
		            		if(MODE == `BBRC_D) begin
			        		addrcnt;
		               			cur_ad_w = cur_ad;
		            		end
		               end
		        end
		        else if(lbob == 1) begin
			    add_mode = `IBURST;
                            if (cur_ad[0] == 0 ) begin
		               cur_ad_w = cur_ad;
		              if(MODE == `BBRC_D) begin 
			       addrcnt;
			       cur_ad_x = cur_ad;
		              end
		            end
	                    else begin
		               cur_ad_x = cur_ad;
		              if(MODE == `BBRC_D) begin 
			       addrcnt;
			       cur_ad_w = cur_ad;
		              end
		            end
		        end

		        else begin
			    $display("Illegal address mode (LBOB Pin Floating) at ");
			    dqo0 = `x_data;
			    MODE = `IDLE;
		            dqo_flag_old = dqo_flag;
  		            dqo_flag = 0;
			end

		    end 
		    else if((B1 == 0  && B2 == 0 ))  begin
		        MODE = `BBWC_S;
		        if(B3 == 0) MODE = `BBWC_D; 
		        dqo_flag_old = dqo_flag;
  		        dqo_flag = 1;
		        cur_ad = a;
		        cnt_ad = cur_ad;
		        init_ad = cur_ad;
		        dqo0 = `z_data;
		        if(lbob == 0) begin
			    add_mode = `LBURST;
                            if (cur_ad[0] == 0 ) begin
		               cur_ad_w = cur_ad;
		               if(MODE == `BBWC_D) begin
       			         addrcnt;
		              	 cur_ad_x = cur_ad;
		               end
		            end
	                    else begin
		               cur_ad_x = cur_ad;
		               if(MODE == `BBWC_D) begin
			       addrcnt;
		               cur_ad_w = cur_ad;
		               end
		            end

		        end
		        else if(lbob == 1) begin
		            add_mode = `IBURST; 
                            if (cur_ad[0] == 0 ) begin
		               cur_ad_w = cur_ad;
		              if(MODE == `BBWC_D) begin 
       			       addrcnt;
			       cur_ad_x = cur_ad;
	            	       end

		            end
	                    else begin
		               cur_ad_x = cur_ad;
		              if(MODE == `BBWC_D) begin 
			       addrcnt;
			       cur_ad_w = cur_ad;
	            	       end

		            end
		        end
		        else
		            $display("Illegal address mode (LBOB Pin Floating) at ");

		    end
		    else if((B1 ==1  && B2 == 1) && ( dqo_flag == 2 ))  begin
		        if(MODE==`BBRC_S || MODE==`CBRC_S ) MODE = `CBRC_S;
		        if(MODE==`BBRC_D || MODE==`CBRC_D ) MODE = `CBRC_D;

		        dqo_flag_old = dqo_flag;
      	                dqo_flag = 2;
                            if (lbob == 0 ) begin
       			       	addrcnt;
		                cnt_ad = cur_ad;
                            	if (cur_ad[0] == 0 ) begin
		               		cur_ad_w = cur_ad;
                            		if (MODE == `CBRC_D ) begin
       			       			addrcnt;
		               			cur_ad_x = cur_ad;
		            		end
		            	end
	                    	else begin
		               		cur_ad_x = cur_ad;
                            		if (MODE == `CBRC_D ) begin
       			       			addrcnt;
		               			cur_ad_w = cur_ad;
		            		end
		            	end
		            end

                            else if (lbob == 1 ) begin
       			       	addrcnt;
		                cnt_ad = cur_ad;
                            	if (cur_ad[0] == 0 ) begin
		               		cur_ad_w = cur_ad;
                            		if (MODE == `CBRC_D ) begin 
       			       		addrcnt;
					cur_ad_x = cur_ad;
		            		end
		            	end
	                    	else begin
		               		cur_ad_x = cur_ad;
                            		if (MODE == `CBRC_D ) begin  
       			       		addrcnt;
					cur_ad_w = cur_ad;
		            		end
		            	end
		            end
	            end
		    else if((B1 ==1  && B2 == 1) && dqo_flag == 1)  begin
		            if(MODE==`BBWC_S || MODE==`CBWC_S ) MODE = `CBWC_S;
		            if(MODE==`BBWC_D || MODE==`CBWC_D ) MODE = `CBWC_D;

		            dqo_flag_old = dqo_flag;
      	                    dqo_flag = 1;
		       	    dqo0 =  `z_data;
                            	if (lbob == 0 ) begin
       			       		addrcnt;
		                        cnt_ad = cur_ad;
                            		if (cur_ad[0] == 0 ) begin
		               			cur_ad_w = cur_ad;
                            			if (MODE == `CBWC_D ) begin
       			       				addrcnt;
		               				cur_ad_x = cur_ad;
		            			end
		            		end
	                    		else begin
		               			cur_ad_x = cur_ad;
                            			if (MODE == `CBWC_D ) begin
       			       				addrcnt;
		               				cur_ad_w = cur_ad;
		            			end
		            		end
		            	end

                          	else if (lbob == 1 ) begin
       			       		addrcnt;
		                        cnt_ad = cur_ad;
                            		if (cur_ad[0] == 0 ) begin
		               			cur_ad_w = cur_ad;
                            			if (MODE == `CBWC_D ) begin 
       			       			addrcnt;
						cur_ad_x = cur_ad;
		            			end
		            		end
	                    		else begin
		               			cur_ad_x = cur_ad;
                            			if (MODE == `CBWC_D ) begin  
       			       			addrcnt;
						cur_ad_w = cur_ad;
		            			end
		            		end
		            	end
		    		else    dqo_flag_old = dqo_flag;
	        end
            end
        end
    end
    end

    always @(clk) begin
	Cclk = `TRUE;
        #1 Cclk = `FALSE;
    end  

    always @(zz) 
	Czz = `TRUE;

    always @(dqo_flag) 
	Cdqo_flag = `TRUE;


    always @(dqo_flag_old or gb) 
    begin
        if(( dqo_flag_old == 2  ) && gb == 0 )     
	      dqo_g = 1;

        else  dqo_g = 0;
    end

    always @(dqo_flag_old ) 
    begin
        #0.5 dqo_flag_old2 = dqo_flag_old; 
    end

    always @(dqo_g)
    begin
        dqo_g_flag = `TRUE;
    	#0.1 dqo_g_flag = `FALSE;
    end
	
    always @(dqo_g_flag )  begin
       if (dqo_g_flag == `TRUE) begin
            if ( dqo_g ==1 && dqo_flag_old == 0 )  
             begin
                MODE_DQ = 0;     
	     end
            else if (dqo_g ==1 && (dqo_flag_old2 == 0 || dqo_flag_old2 ==1 ) )  
             begin  
	        MODE_DQ = 1;
             end
            else if ( dqo_g ==1 && dqo_flag_old == 2 && dqo_flag ==2 ) 
             begin
	        MODE_DQ = 2;
             end
            else if ( dqo_g == 0 && ( dqo_flag_old == 0 ))         
	     begin
    	       MODE_DQ = 5;
	     end
            else if (dqo_g == 0 && dqo_flag_old ==2 && dqo_flag == 2)
	     begin
	       MODE_DQ = 6;
	     end
        end
     end

     always @(dqo1) begin
        dqo1_flag = `TRUE;
        #0.1 dqo1_flag = `FALSE;
     end


     always @(clk)
     begin
       if ( (MODE == `BBWC_D || MODE == `CBWC_D) || (MODE == `BBRC_D || MODE == `CBRC_D) ) 
            MODE_SD = `DDR ;
       if ( (MODE == `BBWC_S || MODE == `CBWC_S) || (MODE == `BBRC_S || MODE == `CBRC_S) ) 
            MODE_SD = `SDR ;
     end


     always @(clk)
     begin
       if ( dqo_g_flag == `FALSE) begin
//        if ( dqo_g == 1 && ( dqo_flag_old == 2)) begin
          if ( dqo_g == 1 && (dqo_flag_old == 1 || dqo_flag_old == 2))
  	     MODE_DQ = 7;
          else if ( dqo_flag_old == 2 )  MODE_DQ = 3;
          else MODE_DQ = 8;
       end
     end  
//****************************************************************************************************

    always @(posedge clk_d3)
    begin
      if ( MODE_DQ == 1 ) begin
           #(`tKXCE +`tCEQX) dqo2 = `x_data;
           #(`tCEQX*(-1)+ `tCEQV)    dqo2 = dqo1;
           if ( MODE_SD == `DDR ) dqo2 = #(`tKHKH/2 - `tCEQV + `tCEQX) `x_data;
           if ( MODE_SD == `SDR ) dqo2 = #(`tKHKH - `tCEQV + `tCEQX) `x_data;  
      end
    /*  if ( MODE_DQ == 5 ) begin
           #(`tCEQV)    dqo2 = dqo1;
           if ( MODE_SD == `DDR ) dqo2 = #(`tKHKH/2 - `tCEQV + `tCEQX) `x_data;
           #(`tCEQX*(-1)+ `tCEHZ)    dqo2 = `z_data;
      end */
    end

    always @(posedge clk_cq)
    begin
      if ( MODE_DQ == 5 ) begin
           #`tCEHZ    dqo2 = `z_data;
      end
    end

    always @(negedge clk_cq)
    begin
      if ( MODE_DQ == 5 ) begin
           #(`tCEQV)    dqo2 = dqo1;
           if ( MODE_SD == `DDR ) dqo2 = #(`tKHKH/2 - `tCEQV + `tCEQX) `x_data;
           if ( MODE_SD == `SDR ) dqo2 = #(`tKHKH/2 - `tCEQV + `tCEQX) `x_data;
           #(`tCEQX*(-1)+ `tCEHZ)    dqo2 = `z_data;
      end
    end

    always @( clk_cq)
    begin 

      if ( clk_cq == 1 && MODE_SD == `SDR ) begin
           if ( MODE_DQ == 0 )
                dqo2 = `z_data;

//         if ( MODE_DQ == 6 ) 
//                  #`tGHQZ dqo2 = `z_data;

           if ( MODE_DQ == 7 || MODE_DQ == 6 || MODE_DQ == 3 || MODE_DQ == 2 ) begin
                   dqo2 = #`tCEQV  dqo1;
//                if ( MODE_SD == `DDR )
//                 dqo2 = #(`tKHKH/2 - `tCEQV + `tCEQX) `x_data;
//                if ( MODE_SD == `SDR )
                   dqo2 = #(`tKHKH - `tCEQV + `tCEQX) `x_data;  

           end
//         if ( MODE_DQ == 8 ) 
//               #(`tCEHZ) dqo2 = `z_data;
//               dqo2 = `z_data;

      end

      if ( MODE_SD == `DDR ) begin
           if ( MODE_DQ == 0 )
                dqo2 = `z_data;

//         if ( MODE_DQ == 6 ) 
//                  #`tGHQZ dqo2 = `z_data;

           if ( MODE_DQ == 7 || MODE_DQ == 6 || MODE_DQ == 3 || MODE_DQ == 2 ) begin
                   dqo2 = #`tCEQV  dqo1;
//                if ( MODE_SD == `DDR )
                   dqo2 = #(`tKHKH/2 - `tCEQV + `tCEQX) `x_data;
//                if ( MODE_SD == `SDR )
//                 dqo2 = #(`tKHKH - `tCEQV + `tCEQX) `x_data;  

           end
//         if ( MODE_DQ == 8 ) 
//               #(`tCEHZ) dqo2 = `z_data;
//               dqo2 = `z_data;

      end

    end

    always @(posedge clk_d3)
    begin
      clk_cq = #`tKXCE clk_d3;
      clk_cqb = ~clk_cq;
    end
    always @(negedge clk_d3)
    begin
      clk_cq = #`tKXCE clk_d3;
      clk_cqb = ~clk_cq;
    end
//***********************************************************************************************

    task addrcnt;
	reg		[`nAddr-1:0] tmp1, tmp2;
    begin
        tmp1 = cur_ad % `BLENGTH;
	tmp2 = cur_ad - tmp1;
	if(add_mode == `LBURST) begin 
	    cur_ad = (tmp1 + 1) % `BLENGTH;
	    cur_ad = cur_ad + tmp2;
	end
	else begin
	    if((init_ad % 2) == 0) begin
		cur_ad = (tmp1 + 1) % `BLENGTH;
		cur_ad = cur_ad + tmp2;
	    end
	    else begin
		cur_ad = (tmp1 - 1) % `BLENGTH;
		cur_ad = cur_ad + tmp2;
	    end
	end
    end
    endtask

    //`endprotect
endmodule
