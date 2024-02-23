/****************************************************************************************
* 
*  SAMSUNG 32Mb QDR2-b2 SRAM Verilog Behavioral model
*  
*  Description :  K7R320882M (4M x 8 QDR2-b2 SRAM)
*
*  File Name   :  k7r320882m.v 
*  Version     :  Rev0.4 
*  Date        :  Jan 7th, 2002
*
*  Simulator   :  Velilog-XL (CADENCE)
*
*  Author      :  Seungmin Lee 
*  Email       :  smlee5253@samsung.co.kr
*  Phone       :  (82) 31-209-3823 
*  Company     :  SAMSUNG ELECTRONICS Co,. LTD.
*
*  Note        :  - Set simulator resolution to "ps" timescale
*                 - IEEE 1149.1 Serial Boundary Scan (JTAG) is not implemented
*                 - Read and write can be active simultaneously
*                 - NW_N# can be altered for any portion of the BURST WRITE operation
*                   provided that the setup and hold requirements are satisfied. 
*                 - The address is concatenated with 1 additional internal LSB to facilitate
*                   burst operation.
*                 - DLL(Delay-Locked Loops) is used for maximum output data valid window.
*                 - When you compile, you must determine mode (whether "single clock mode" or not, whether "DLL OFF" or not) 
*
*                   * refer to readme file
*
*        Copyright(c) SAMSUNG ELECTRONICS Co,. 2001 
*        All rights reserved
*  
*   Revision History :
*
*   Rev  Author          Phone            Date        Changes
*   ---  --------------  --------------   ----------  --------------------------------------
*   0.0  Seungmin Lee   (82) 31-209-3823  09/22/2001  
*   0.1  Seungmin Lee   (82) 31-209-3823  10/31/2001  The problem of CQ, CQ_N is fixed
*   0.2  Seungmin Lee   (82) 31-209-3823  11/16/2001  when the skew occur between K and K_N, The problem of CQ, CQ_N is fixed
*						      Correct the problem in the DLL OFF
*   0.3  Seungmin Lee   (82) 31-209-3823  12/22/2001  Correct the part of command fetch, when the skew occur between K and K_N
*   0.4  Seungmin Lee   (82) 31-209-3823  01/07/2002  Add the effect of tCHQX
*
****************************************************************************************/

// Define time scale $ accuracy  
`timescale 1ns / 1ps

// QDR speed option (fc20, fc16, fc13)

`ifdef fc20
        `define         tKHKH           5.0     // Min clock cycle time
        `define         tKHKH_M         6.0     // Max clock cycle time
        `define         tKHKL           2.0     // Min clock high time
        `define         tKLKH           2.0     // Min clock low time
        `define         tAVKH           0.6     // Min address valid to K, K_b rising edge
        `define         tIVKH           0.6     // Min control input valid to K, K_b rising edge
        `define         tDVKH           0.6     // Min Data-in valid to K, K_b rising edge
        `define         tKHAX           0.6     // Min K rising edge to address hold
        `define         tKHIX           0.6     // Min K rising edge to control input hold
        `define         tKHDX           0.6     // Min K rising edge to data-in hold
        `define         tKHCH           0.0     // Min clock to data clock
        `define         tCHQV           0.38    // Max C, C_b high to output valid
        `define         tCHQX           -0.38   // Min C, C_b high to output hold
        `define         tCHQZ           0.38    // Max C high to output high-z
        `define         tCHQX1          -0.38   // Min C high to output low-z
        `define         tCHCQV          0.36    // Max CQ, CQ_b echo clock valid
        `define         tCHCQX          -0.36   // Min CQ, CQ_b echo clock hold
        `define         tKCVAR          0.13    // Max clock phase jitter (K, K_b, C, C_b)
        `define         out_clock_fix   0       // not single clock mode, if out_clock_fix = 1, single clock mode!!kkkkk
`endif

`ifdef fc16
	`define		tKHKH		6.0   
	`define		tKHKH_M		7.5   
	`define		tKHKL		2.4   
	`define		tKLKH		2.4   
	`define		tAVKH		0.7   
	`define		tIVKH		0.7   
	`define		tDVKH		0.7   
	`define		tKHAX		0.7   
	`define		tKHIX		0.7   
	`define		tKHDX		0.7   
	`define		tKHCH		0.0
        `define         tCHQV           0.4 
        `define         tCHQX           -0.4 
        `define         tCHQZ           0.4 
        `define         tCHQX1          -0.4 
        `define         tCHCQV          0.38  
        `define         tCHCQX          -0.38
        `define         tKCVAR          0.15 
        `define         out_clock_fix   0                     
`endif

`ifdef fc13
	`define		tKHKH		7.5   
	`define		tKHKH_M		8.0   
	`define		tKHKL		3.0   
	`define		tKLKH		3.0   
	`define		tAVKH		0.8   
	`define		tIVKH		0.8   
	`define		tDVKH		0.8   
	`define		tKHAX		0.8   
	`define		tKHIX		0.8   
	`define		tKHDX		0.8   
	`define		tKHCH		0.0
	`define		tCHQV		0.4   
        `define         tCHQX           -0.4 
        `define         tCHQZ           0.4 
        `define         tCHQX1          -0.4 
        `define         tCHCQV          0.38  
        `define         tCHCQX          -0.38
        `define         tKCVAR          0.19 
        `define         out_clock_fix   0                     
`endif

// In case C and C_b tied to high, QDR speed option is fc20_ocf, fc16_ocf & fc13_ocf
 
`ifdef fc20_ocf
        `define         tKHKH           5.0
        `define         tKHKH_M         6.0
        `define         tKHKL           2.0
        `define         tKLKH           2.0
        `define         tAVKH           0.6
        `define         tIVKH           0.6
        `define         tDVKH           0.6
        `define         tKHAX           0.6
        `define         tKHIX           0.6
        `define         tKHDX           0.6
        `define         tKHCH           0.0
        `define         tCHQV           0.38
        `define         tCHQX           -0.38
        `define         tCHQZ           0.38
        `define         tCHQX1          -0.38
        `define         tCHCQV          0.36  
        `define         tCHCQX          -0.36
        `define         tKCVAR          0.13 
        `define         out_clock_fix   1
`endif

`ifdef fc16_ocf
        `define         tKHKH           6.0
        `define         tKHKH_M         7.5 
        `define         tKHKL           2.4 
        `define         tKLKH           2.4 
        `define         tAVKH           0.7
        `define         tIVKH           0.7
        `define         tDVKH           0.7
        `define         tKHAX           0.7
        `define         tKHIX           0.7
        `define         tKHDX           0.7
        `define         tKHCH           0.0
        `define         tCHQV           0.4
        `define         tCHQX           -0.4
        `define         tCHQZ           0.4
        `define         tCHQX1          -0.4
        `define         tCHCQV          0.38  
        `define         tCHCQX          -0.38
        `define         tKCVAR          0.15 
        `define         out_clock_fix   1
`endif

`ifdef fc13_ocf
        `define         tKHKH           7.5
        `define         tKHKH_M         8.0 
        `define         tKHKL           3.0
        `define         tKLKH           3.0
        `define         tAVKH           0.8
        `define         tIVKH           0.8
        `define         tDVKH           0.8
        `define         tKHAX           0.8
        `define         tKHIX           0.8
        `define         tKHDX           0.8
        `define         tKHCH           0.0
        `define         tCHQV           0.4
        `define         tCHQX           -0.4
        `define         tCHQZ           0.4
        `define         tCHQX1          -0.4
        `define         tCHCQV          0.38  
        `define         tCHCQX          -0.38
        `define         tKCVAR          0.19 
        `define         out_clock_fix   1
`endif

////////////////////////////////////////////////////////////////////////////////
//////////////////       Main module       ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

module k7r320882m (D, Q, SA, R_N, W_N, NW_N, K, K_N, C, C_N, CQ, CQ_N, DOFF_N);

    	// Constant Parameters
    	parameter                   addr_bits =      21;    // This is external address
    	parameter                   data_bits =      8;
    	parameter                   mem_sizes =  4*1024*1024-1;

    	parameter                   qdelay    =     `tCHQV; // tCHQX1 to tCHQV
  
    	parameter                   aor_r     =      0;    // Read Address order
    	parameter                   aor_w     =      1;    // Write Address order
    	parameter                   dor_r     =      2;    // Read data order
    	parameter                   dor_w     =      0;    // Write data order
    	parameter                   bu_n      =      2;    // Burst number
    
    	// Port Declarations
    	input   [data_bits - 1 : 0] D;
    	output  [data_bits - 1 : 0] Q;
    	input   [addr_bits - 1 : 0] SA;
    	input                       R_N;
    	input                       W_N;
    	input               [1 : 0] NW_N;
    	input                       K, K_N;
    	input                       C, C_N;
    	output                      CQ, CQ_N;
    	input                       DOFF_N;  

    	// Memory Array
    	reg     [data_bits - 1 : 0] SMEM [0 : mem_sizes];

    	// Declare internal Variables
    	reg     [data_bits - 1 : 0] IN_REG;
    	reg     [data_bits - 1 : 0] OUT_REG;
    	reg     [data_bits - 1 : 0] OUT_BUF;
    	reg                         BW_0[0 : bu_n-1];
    	reg                         BW_1[0 : bu_n-1];

    	reg     [addr_bits - 1 : 0] AD_R_REG;
    	reg     [addr_bits - 1 : 0] AD_W_REG;
    	reg     [addr_bits - 1 : 0] AD_W_PI [0 : dor_r + 1 - aor_w];
    	reg     [addr_bits - 1 : 0] AD_R_PI [0 : dor_r-aor_r];
    
    	reg     [data_bits - 1 : 0] DATA_PI [0 : bu_n-1];
    	reg     [data_bits - 1 : 0] OUT_REG_PI1 [0 : (dor_r - aor_r)];
    	reg     [data_bits - 1 : 0] OUT_REG_PI2 [0 : (dor_r + 1 - aor_r)];

    	reg     [data_bits - 1 : 0] DATA_TM;
    	reg                         BU_W_CNT;
    	reg                         eclk;
    	reg                         eclk_b;

    	reg                         int_K;

    	wire ocf = `out_clock_fix;
    
    	integer                     id;                
    	integer                     flag;                
    	integer                     rcount [0 : dor_r + bu_n ];  
    	integer                     wcount [0 : dor_w + bu_n + 1]; 

    	// For check "clock phase zitter variation"
    	real                     cur_time;                        
    	real                     pre_time;
    	real                     cur_time_c;                           
    	real                     pre_time_c;
    	real                     zmax;   
    	real                     zmin;  
    	real                     zmax_c;
    	real                     zmin_c; 
    	real                     zflag;                       
    	real                     zflag_c;
    	real                     t1;
    	real                     t2;
    	real                     epulse;
	

    	// Initial Conditions
    	initial begin

        	OUT_REG = {data_bits{1'bz}};
        	OUT_BUF = {data_bits{1'bz}};

        	// For check "clock phase zitter variation"
        	pre_time =0;
        	pre_time_c = 0;
        	zmax = 0;
        	zmin = 0;
        	zmax_c = 0;
        	zmin_c = 0;
        	zflag = 0;
        	zflag_c = 0;
		flag = 0;
		t1 = 0;
		t2 = 0;
        
    	end 
   
    	always @ (posedge K) begin
		if (flag == 0) begin
			eclk = ~K;
			eclk_b = ~K_N;
			flag = 1;
		end
	end

    	always @ (posedge K) begin

        		// Check K clock phase zitter variation !!  
        		cur_time = $realtime;

        		if (zflag == 2) begin
          			zmax = cur_time - pre_time;
          			zmin = cur_time - pre_time;
          			zflag = zflag + 1;
        		end
        		else if (zflag == 3) begin
          			if (cur_time - pre_time > `tKHKH_M) begin
            				$display("%m : at time %t : Warning!! KHKH is over limited value ", $realtime);
          			end 
          			if (cur_time - pre_time > zmax) begin
            				zmax = cur_time - pre_time;
          			end
          			else if (cur_time - pre_time < zmin) begin
            				zmin = cur_time - pre_time;
          			end
        		end
			else begin
				zflag = zflag + 1;
			end

        		pre_time = $realtime;

        		if (zmax - zmin > `tKCVAR) begin
          			$display("%m : at time %t : Warning!! K clock phase jitter violation!!", $realtime);
        		end
    	end

    	always @ (posedge C) begin

        		// Check C clock phase zitter variation !!  
        		cur_time_c = $realtime;

        		if (zflag_c == 2) begin
          			zmax_c = cur_time_c - pre_time_c;
          			zmin_c = cur_time_c - pre_time_c;
          			zflag_c = zflag_c + 1;
        		end
        		else if (zflag_c == 3) begin
          			if (cur_time - pre_time > `tKHKH_M) begin
            				$display("%m : at time %t : Warning!! KHKH is over limited value ", $realtime);
          			end
          			if (cur_time_c - pre_time_c > zmax_c) begin
            				zmax_c = cur_time - pre_time;
          			end
          			else if (cur_time_c - pre_time_c < zmin_c) begin
            				zmin_c = cur_time_c - pre_time_c;
          			end
        		end
			else begin
	  			zflag_c = zflag_c + 1;
			end

        		pre_time_c = $realtime;

        		if (zmax_c - zmin_c > `tKCVAR) begin
          			$display("%m : at time %t : Warning!! C clock phase jitter violation!!", $realtime);
        		end
    	end 

    	always @ (posedge K) begin
		int_K = 1'b1;
		epulse = t2 -t1;
		t1 = $realtime;
		
	end

    	always @ (posedge K_N) begin
		int_K = 1'b0;
		epulse = t1 - t2;
		t2 = $realtime;
	end

    	always @ (posedge int_K or negedge int_K) begin

      	$display ("%m : at time %t :================================================================================", $realtime);    

////////////////////////////////////////////////////////////////////////////////
//////////////////       Write function    ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////  
  
      	// BW, Data, command pipelining
      	for (id = bu_n - 1  ; id > 0 ; id = id - 1) begin
          	BW_0[id]= BW_0[id-1];
          	BW_1[id]= BW_1[id-1];
          	DATA_PI[id]= DATA_PI[id-1];
      	end
      
      	for (id = dor_w + bu_n + 1 ; id > 0 ; id = id - 1) begin
          	wcount[id]= wcount[id-1];
      	end

      	for (id = dor_r + 1 - aor_w; id > 0 ; id = id - 1) begin
          	AD_W_PI[id]= AD_W_PI[id-1];
      	end
      
      	// Pipeline variable initializing 
      	wcount[0]= 0; 
     
      	BW_0[0] = 1'b1;
      	BW_1[0] = 1'b1;
      
      	DATA_PI[0] = {data_bits{1'bx}};
	AD_W_PI[0] = {addr_bits{1'bx}};

      	// Write command fetch : if write, wcount[0] = 1
      	if ( W_N === 1'b0 && int_K === 1'b1) begin
         	wcount[0]= 1;
         	$display("%m : at time %t : Write command fetch!!", $realtime);
      	end

      	// Data input start
      	for (id = 0 ; id < bu_n ; id = id+1) begin
         	if ( wcount[dor_w + id] == 1 ) begin

            		// Data, BW pipe
            		DATA_PI[0]= D;
            		$display("%m : at time %t : Write data fetch!! : fetched data = %h", $realtime, DATA_PI[0]);
            		BW_0[0]= NW_N[0];
            		BW_1[0]= NW_N[1];
         	end
      	end

       	// In the Last Burst, Registered data is written into memory   
       	if ( wcount[dor_w + bu_n -1] == 1) begin

          	AD_W_REG = SA;
          	AD_W_PI[0] = SA;
      	  	$display ("%m : at time %t : Write address fetch!! : fetched address = %h", $realtime, AD_W_REG);

          	BU_W_CNT= 1'b0;	
               
          	for (id = 0 ; id < bu_n ; id = id + 1) begin
             		IN_REG = SMEM[{AD_W_REG, BU_W_CNT}]; 
             		DATA_TM = DATA_PI[bu_n - 1 - id];
                 
             		// Byte write 
             		if ( BW_0[bu_n - 1 - id] === 1'b0 ) begin
                		IN_REG[((data_bits/2)-1) : 0 ]= DATA_TM[((data_bits/2)-1) : 0];
             		end
                
             		if ( BW_1[bu_n - 1 - id] === 1'b0 ) begin
                		IN_REG[(data_bits-1) : (data_bits/2)]= DATA_TM[(data_bits-1) : (data_bits/2)];
             		end

             		SMEM[{AD_W_REG,BU_W_CNT}] = IN_REG;
                   
             		$display ("%m : at time %t : Memory Write!! : address = %b data = %b", $realtime, {AD_W_REG,BU_W_CNT}, IN_REG); 
             		BU_W_CNT= BU_W_CNT + 1;
          	end
       	end


////////////////////////////////////////////////////////////////////////////////
//////////////////       Read function     ////////////////////////////////////
////////////////////////////////////////////////////////////////////////////// 

      	// Command, address, output data pipelining
      	for ( id = dor_r + bu_n ; id > 0 ; id = id - 1 ) begin
          	rcount[id]= rcount[id-1];
      	end
  
      	for ( id = dor_r - aor_r ; id > 0 ; id = id - 1 ) begin
          	AD_R_PI[id]= AD_R_PI[id-1];
      	end
  
      	for ( id = dor_r - aor_r ; id > 0 ; id = id - 1 ) begin
          	OUT_REG_PI1[id]= OUT_REG_PI1[id-1];
      	end
  
      	for ( id = dor_r + 1 - aor_r ; id > 0 ; id = id - 1 ) begin
          	OUT_REG_PI2[id]= OUT_REG_PI2[id-1];
      	end
  
      	// Pipelined variable initializing
      	rcount[0]= 0;
      	AD_R_PI[0] = {addr_bits{1'bx}};
      	OUT_REG_PI1[0] = {data_bits{1'bx}};
      	OUT_REG_PI2[0] = {data_bits{1'bx}};

      	// Read command fetch : if Read, rcount[0] = 1
      	if ( (R_N === 1'b0) && (int_K === 1'b1) ) begin
         	rcount[0]= 1;
         	$display("%m : at time %t : Read command fetch!!", $realtime);
      	end

      	// Read address, data fetch
      	if ( rcount[aor_r] == 1 ) begin
         	AD_R_PI[0] = SA;
         	OUT_REG_PI1[0]= SMEM[{SA,1'b0}];
         	OUT_REG_PI2[0]= SMEM[{SA,1'b1}];
         	$display("%m : at time %t : Read Address fetch!! : fetched address = %h", $realtime, AD_R_PI[0]);
      	end
  
      	// First Burst data out
      	if ( rcount[dor_r] == 1 ) begin
         	AD_R_REG= AD_R_PI[dor_r - aor_r];
  
         	// In case read and write, Bypass
         	if ((wcount[dor_r] == 1 ) && (AD_R_REG === AD_W_PI[dor_r - aor_w])) begin
            		OUT_REG_PI1[dor_r - aor_r] = SMEM[{AD_R_REG,1'b0}];
            		OUT_REG_PI2[dor_r - aor_r] = SMEM[{AD_R_REG,1'b1}];
         	end

         	OUT_REG = OUT_REG_PI1[dor_r - aor_r];

         	$display ("%m : at time %t : Memory Read : address = %h data1 = %h", $realtime, {AD_R_REG,1'b0}, OUT_REG);

      	end

      	// Second Burst data out
      	if ( rcount[dor_r + 1] == 1 ) begin
         	OUT_REG= OUT_REG_PI2[dor_r - aor_r + 1];

         	$display ("%m : at time %t : Memory Read : address = %h data2 = %h", $realtime, {AD_R_REG,1'b1}, OUT_REG);

      	end

      	// Data out in case Output clock(C and C_N) is all 'H' fixed
      	if (ocf == 1) begin

         	// No operation - Read ( previous - current ) 
         	if ( (rcount[dor_r + bu_n] == 0) && (rcount[dor_r] == 1) ) begin
            		$display("%m : at time %t : N-R (ocf = 1)", $realtime);
             		OUT_BUF <= #(epulse + `tCHQX1) {data_bits{1'bz}};
             		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

         	// Read - Read 
         	else if( ((rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 1)) ) begin
            		$display("%m : at time %t : R-R (ocf = 1)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end
         
         	// Burst Continue 
         	else if( (rcount[dor_r+1] == 1) ) begin
            		$display("%m : at time %t : Burst Continue ", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

         	// Read - No operation
         	else if( (rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 0) ) begin
            		$display("%m : at time %t : R-N (ocf = 1)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQZ) {data_bits{1'bz}};
         	end
      	end
    	end 
  
    	// Data out in case Output clock(C and C_N) is not fixed 
    	always @ (posedge C or posedge C_N) begin

      	if (ocf == 0) begin

		#0;
         	// No operation - Read
         	if ( (rcount[dor_r + bu_n] == 0) && (rcount[dor_r] == 1) ) begin
            		$display("%m : at time %t : N-R (ocf = 1)", $realtime);
             		OUT_BUF <= #(epulse + `tCHQX1) {data_bits{1'bz}};
             		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

         	// ( Read - Read )
         	else if( ((rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 1)) ) begin
            		$display("%m : at time %t : R-R (ocf = 1)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

         	// Burst Continue
         	else if( (rcount[dor_r+1] == 1) ) begin
            		$display("%m : at time %t : Burst Continue ", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

         	// Read - No operation
         	else if( (rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 0) ) begin
            		$display("%m : at time %t : R-N (ocf = 1)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQZ) {data_bits{1'bz}};

         	end
      	end
    	end

    	always @ (posedge K) begin
        	if (ocf == 1) begin
                	eclk <= #`tCHCQV 1'b1;
                	eclk_b <= #`tCHCQV 1'b0;
        	end
    	end

    	always @ (posedge K_N) begin
        	if (ocf == 1) begin
                	eclk <= #`tCHCQV 1'b0;
                	eclk_b <= #`tCHCQV 1'b1;
        	end
    	end

    	always @ (posedge C) begin
        	if (ocf == 0) begin
                	eclk <= #`tCHCQV 1'b1;
                	eclk_b <= #`tCHCQV 1'b0;
        	end
    	end

    	always @ (posedge C_N) begin
        	if (ocf == 0) begin
                	eclk <= #`tCHCQV 1'b0;
                	eclk_b <= #`tCHCQV 1'b1;
        	end
    	end

    	assign Q = OUT_BUF;
    	assign CQ = eclk;
    	assign CQ_N = eclk_b;
 
    	//Timing violation check!!   
    	specify
        	specparam
                KHKH =  `tKHKH,
                KHKL =  `tKHKL,
                KLKH =  `tKLKH,
                // Setup Time,
                AVKH =  `tAVKH,
                IVKH =  `tIVKH,
                DVKH =  `tDVKH,
                // Hold Times
                KHAX =  `tKHAX,
                KHIX =  `tKHIX,
                KHDX =  `tKHDX;
            
        	$width    (posedge K,         KHKL);
        	$width    (negedge K_N,       KLKH);
        	$width    (posedge C,         KHKL);
        	$width    (negedge C_N,       KLKH);
        	$period   (negedge K,         KHKH);
        	$period   (posedge K_N,       KHKH);
        	$period   (negedge C,         KHKH);
        	$period   (posedge C_N,       KHKH);
        	$setuphold(posedge K,     SA, AVKH, KHAX);
        	$setuphold(posedge K,    R_N, IVKH, KHIX);
        	$setuphold(posedge K,    W_N, IVKH, KHIX);
        	$setuphold(posedge K,   NW_N, IVKH, KHIX);
        	$setuphold(posedge K_N, NW_N, IVKH, KHIX);
    	endspecify

endmodule
