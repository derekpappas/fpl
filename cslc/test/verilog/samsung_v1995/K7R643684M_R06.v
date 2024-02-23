/****************************************************************************************
* 
*  SAMSUNG K7R643684M QDRII-b4 SRAM Verilog Behavioral model
*  
*  Description :  K7R643684M (2MM x 36 QDRII-4B SRAM)
*
*  File Name   :  K7R643684M_R06.v 
*  Version     :  0.6 
*  Date        :  Setemver 30, 2004
*
*  Simulator   :  Velilog-XL (CADENCE)
*
*  Author      :  Seungmin Lee 
*  Email       :  smlee5253@samsung.co.kr
*  Phone       :  (82) 31-209-3823 
*  Company     :  SAMSUNG ELECTRONICS Co,. LTD.
*
*        Copyright(c) SAMSUNG ELECTRONICS Co,. 2001 
*        All rights reserved
*  
*  Note        :  - Set simulator resolution to "ps" timescale
*                 - IEEE 1149.1 Serial Boundary Scan (JTAG) is not implemented
*                 - Read and write cannot be active simultaneously
*                 - BW_N# can be altered for any portion of the BURST WRITE operation
*                   provided that the setup and hold requirements are satisfied.
*                 - The address is concatenated with 2 additional internal LSB to facilitate
*                   burst operation.
*                 - DLL(Delay-Locked Loops) is used for maximum output data valid window.
*                 - When you compile, you must determine mode (whether "single clock mode" or not, whether "DLL OFF" or not)
* 
*                   * refer to readme filea
* 
*        Copyright(c) SAMSUNG ELECTRONICS Co,. 2001
*        All rights reserved
*
*   Revision History :
*
*   Rev  Author          Phone            Date        Changes
*   ---  --------------  --------------   ----------  -------------------------------------
*   0.0  Seungmin Lee   (82) 31-209-3823  09/21/2001
*   0.1  Seungmin Lee   (82) 31-209-3823  10/04/2001
*   0.2  Seungmin Lee   (82) 31-209-3823  10/31/2001
*   0.3  Seungmin Lee   (82) 31-209-3823  11/16/2001  when the skew occur between K and K_N, the problem of CQ, CQ_N is fixed
*						      Correct the problem in the DLL OFF 
*   0.4  Seungmin Lee   (82) 31-209-3823  12/22/2001  Correct the error of command fectch when the skew occur between K and K_N, 
*   0.5  Seungmin Lee   (82) 31-209-3823  01/07/2002  Add the effect of tCHQX
*   0.6  Seungmin Lee   (82) 31-209-3823  04/23/2002  Modify command fetch
*
****************************************************************************************/

//Define time scale $ accuracy  

`timescale 1ns / 1ps

`ifdef fc30
        `define         tKHKH           3.30    // Min clock cycle time
        `define         tKHKH_M         4.20    // Max clock cycle time
        `define         tKHKL           1.32    // Min clock high time
        `define         tKLKH           1.32    // Min clock low time
        `define         tAVKH           0.40    // Min address valid to K, K_b rising edge
        `define         tIVKH           0.40    // Min control input valid to K, K_b rising edge
        `define         tDVKH           0.30    // Min Data-in valid to K, K_b rising edge
        `define         tKHAX           0.40    // Min K rising edge to address hold
        `define         tKHIX           0.40    // Min K rising edge to control input hold
        `define         tKHDX           0.30    // Min K rising edge to data-in hold
        `define         tKHCH           0.00    // Min clock to data clock
        `define         tCHQV           0.45    // Max C, C_b high to output valid
        `define         tCHQX          -0.45    // Min C, C_b high to output hold
        `define         tCHQZ           0.45    // Max C high to output high-z
        `define         tCHQX1         -0.45    // Min C high to output low-z
        `define         tCHCQV          0.45    // Max CQ, CQ_b echo clock valid
        `define         tCHCQX         -0.45    // Min CQ, CQ_b echo clock hold
        `define         tKCVAR          0.20    // Max clock phase jitter (K, K_b, C, C_b)
        `define         out_clock_fix   0       // not single clock mode, if out_clock_fix = 1, single clock mode!!
`endif

`ifdef fc25
        `define         tKHKH           4.0     // Min clock cycle time
        `define         tKHKH_M         5.0     // Max clock cycle time
        `define         tKHKL           1.6     // Min clock high time
        `define         tKLKH           1.6     // Min clock low time
        `define         tAVKH           0.5     // Min address valid to K, K_b rising edge
        `define         tIVKH           0.5     // Min control input valid to K, K_b rising edge
        `define         tDVKH           0.5     // Min Data-in valid to K, K_b rising edge
        `define         tKHAX           0.5     // Min K rising edge to address hold
        `define         tKHIX           0.5     // Min K rising edge to control input hold
        `define         tKHDX           0.5     // Min K rising edge to data-in hold
        `define         tKHCH           0.0     // Min clock to data clock
        `define         tCHQV           0.35    // Max C, C_b high to output valid
        `define         tCHQX           -0.35   // Min C, C_b high to output hold
        `define         tCHQZ           0.35    // Max C high to output high-z
        `define         tCHQX1          -0.35   // Min C high to output low-z
        `define         tCHCQV          0.33    // Max CQ, CQ_b echo clock valid
        `define         tCHCQX          -0.33   // Min CQ, CQ_b echo clock hold
        `define         tKCVAR          0.1    // Max clock phase jitter (K, K_b, C, C_b)
        `define         out_clock_fix   0       // not single clock mode, if out_clock_fix = 1, single clock mode!!
`endif

`ifdef fc20
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
        `define         out_clock_fix   0    
`endif

`ifdef fc16
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
        `define         out_clock_fix   0
`endif

`ifdef fc13
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
        `define         out_clock_fix   0
`endif

// In case C and C_b tied to high, QDR speed option is fc25_ocf, fc20_ocf, fc16_ocf & fc13_ocf

`ifdef fc30_ocf
        `define         tKHKH           3.30    // Min clock cycle time
        `define         tKHKH_M         4.20    // Max clock cycle time
        `define         tKHKL           1.32    // Min clock high time
        `define         tKLKH           1.32    // Min clock low time
        `define         tAVKH           0.40    // Min address valid to K, K_b rising edge
        `define         tIVKH           0.40    // Min control input valid to K, K_b rising edge
        `define         tDVKH           0.30    // Min Data-in valid to K, K_b rising edge
        `define         tKHAX           0.40    // Min K rising edge to address hold
        `define         tKHIX           0.40    // Min K rising edge to control input hold
        `define         tKHDX           0.30    // Min K rising edge to data-in hold
        `define         tKHCH           0.00    // Min clock to data clock
        `define         tCHQV           0.45    // Max C, C_b high to output valid
        `define         tCHQX          -0.45    // Min C, C_b high to output hold
        `define         tCHQZ           0.45    // Max C high to output high-z
        `define         tCHQX1         -0.45    // Min C high to output low-z
        `define         tCHCQV          0.45    // Max CQ, CQ_b echo clock valid
        `define         tCHCQX         -0.45    // Min CQ, CQ_b echo clock hold
        `define         tKCVAR          0.20    // Max clock phase jitter (K, K_b, C, C_b)
        `define         out_clock_fix   1       // not single clock mode, if out_clock_fix = 1, single clock mode!!
`endif

`ifdef fc25_ocf
        `define         tKHKH           4.0     // Min clock cycle time
        `define         tKHKH_M         5.0     // Max clock cycle time
        `define         tKHKL           1.6     // Min clock high time
        `define         tKLKH           1.6     // Min clock low time
        `define         tAVKH           0.5     // Min address valid to K, K_b rising edge
        `define         tIVKH           0.5     // Min control input valid to K, K_b rising edge
        `define         tDVKH           0.5     // Min Data-in valid to K, K_b rising edge
        `define         tKHAX           0.5     // Min K rising edge to address hold
        `define         tKHIX           0.5     // Min K rising edge to control input hold
        `define         tKHDX           0.5     // Min K rising edge to data-in hold
        `define         tKHCH           0.0     // Min clock to data clock
        `define         tCHQV           0.35    // Max C, C_b high to output valid
        `define         tCHQX           -0.35   // Min C, C_b high to output hold
        `define         tCHQZ           0.35    // Max C high to output high-z
        `define         tCHQX1          -0.35   // Min C high to output low-z
        `define         tCHCQV          0.33    // Max CQ, CQ_b echo clock valid
        `define         tCHCQX          -0.33   // Min CQ, CQ_b echo clock hold
        `define         tKCVAR          0.1    // Max clock phase jitter (K, K_b, C, C_b)
        `define         out_clock_fix   1       // not single clock mode, if out_clock_fix = 1, single clock mode!!
`endif

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

module K7R643684M (D, Q, SA, R_N, W_N, BW_N, K, K_N, C, C_N, CQ, CQ_N, DOFF_N);

        parameter       addr_bits = 19;
        parameter       data_bits = 36;
        parameter       mem_sizes = 2097152 - 1 ;                                //  1M


    	// Constant Parameters
    	parameter                   qdelay    =     `tCHQV; // tCHQX1 to tCHQV
  
    	parameter                   aor_r     =      0;    // Read Address order
    	parameter                   aor_w     =      0;    // Write Address order
    	parameter                   dor_r     =      2;    // Read data order
    	parameter                   dor_w     =      2;    // Write data order
    	parameter                   bu_n       =     4;    // Burst number
    
    	// Port Declarations
    	input   [data_bits - 1 : 0] D;
    	output  [data_bits - 1 : 0] Q;
    	input   [addr_bits - 1 : 0] SA;
    	input                       R_N;
    	input                       W_N;
    	input               [3 : 0] BW_N;
    	input                       K, K_N;
    	input                       C, C_N;
    	output			CQ, CQ_N;
    	input 			DOFF_N;

    	// Memory Array
    	reg     [data_bits - 1 : 0] SMEM [0 : mem_sizes];

    	// Declare internal Variables
    	reg     [data_bits - 1 : 0] IN_REG_TM;
    	reg     [data_bits - 1 : 0] IN_REG[0 : bu_n-1];
    	reg     [data_bits - 1 : 0] OUT_REG;
    	reg     [data_bits - 1 : 0] OUT_BUF;

    	reg     [addr_bits - 1 : 0] AD_R_REG;
    	reg     [addr_bits - 1 : 0] AD_W_REG;
    	reg     [addr_bits - 1 : 0] AD_W_PI [0 : dor_w-aor_w];
    	reg     [addr_bits - 1 : 0] AD_R_PI [0 : dor_r-aor_r];
    
    	reg     [data_bits - 1 : 0] DATA_PI [0 : bu_n-1];
    	reg     [data_bits - 1 : 0] DATA_TM;
    	reg     [1:0]               BU_R_CNT;
    	reg     [1:0]               BU_W_CNT;
    	reg                         eclk;
    	reg                         eclk_b;
    	reg                         int_K;
  
    	wire ocf = `out_clock_fix;
    
    	integer                     id;                    
    	integer                     flag;                    
    	integer                     rcount [0 : dor_r + bu_n ];
    	integer                     wcount [0 : dor_w + bu_n ];

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

		BU_W_CNT = 0;
		BU_R_CNT = 0;

		flag = 0;
    	end

 
    	always @ (posedge K) begin
		if (flag == 0) begin
			eclk = ~K;
			eclk_b = ~K_N;
			flag = 1;
		end
	end

	// Check the maximum tKHKH and the phase jitter violation of the clock(K, K_N, C, C_N)
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
             			$display("%m : at time %t : Warning!! KHKH is over limited value", $realtime);
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

        		if (zflag_c == 1) begin
          			zmax_c = cur_time_c - pre_time_c;
          			zmin_c = cur_time_c - pre_time_c;
          			zflag_c = zflag_c + 1;
        		end
        		else if (zflag_c == 2) begin
          			if (cur_time_c - pre_time_c > `tKHKH_M) begin
            				$display("%m : at time %t : Warning!! CHCH is over limited value", $realtime);
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
	
	// Generate internal clock ( when K is high ->  high : when K_N is high -> low) 
    	always @ (posedge K) begin
		int_K = 1'b1;
		epulse = t2 - t1;
		t1 = $realtime;
	end

    	always @ (posedge K_N) begin
		int_K = 1'b0;
		epulse = t1 - t2;
		t2 = $realtime;
	end

	// Main function
  	always @ (posedge int_K or negedge int_K) begin
   
   	$display("%m : at time %t :==================================================================================================", $time);  

////////////////////////////////////////////////////////////////////////////////
//////////////////       Write function    ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
      
      	// Write  Address, NW, Data, command pipelining
      	for ( id = 0 ; id < ( dor_w - aor_w ) ; id= id + 1) begin
          	AD_W_PI[id]= AD_W_PI[id+1]; 
      	end
      
      	for (id = dor_w + bu_n  ; id > 0 ; id = id - 1) begin
          	wcount[id]= wcount[id-1];
      	end
      
      	wcount[0]= 0; 
     
      	AD_W_PI[(dor_w - aor_w)] = {addr_bits{1'bx}}; 
      
      	// Read address, command pipelining
      	for ( id= 0 ; id < dor_r-aor_r ; id = id + 1 ) begin
        	AD_R_PI[id]= AD_R_PI[id+1];
      	end

      	for ( id = dor_r + bu_n ; id > 0 ; id = id - 1 ) begin
          	rcount[id]= rcount[id-1];
      	end

      	AD_R_PI[dor_r-aor_r]= {addr_bits{1'bx}};
      	rcount[0]= 0;

      	// Read or Write command fetch  
      	if ( R_N === 1'b0 && int_K === 1'b1 && rcount[2] != 1) begin
            		rcount[0]= 1;
            		$display("%m : at time %t : Read command is fetched!!", $time);
      	end
      	else if ( W_N === 1'b0 && int_K === 1'b1 && wcount[2] != 1) begin
            		wcount[0]= 1;
            		$display("%m : at time %t : Write command is fetched!!", $time);
      	end

      	// Write address fetch 
      	if (wcount[aor_w] == 1) begin
         	AD_W_PI[dor_w - aor_w]= SA;
         	$display ("%m : at time %t : Write address fetch!! : fetched address = %h", $time, AD_W_PI[dor_w - aor_w ]); 
      	end
         
       	// Data input 
       	for (id = 0 ; id< bu_n ; id=id+1) begin   
         	if ( wcount[dor_w + id] == 1 ) begin

            		if (id == 0) begin 
               			AD_W_REG = AD_W_PI[0];  
			end

            		IN_REG_TM= SMEM[{AD_W_REG, BU_W_CNT}]; 
            		DATA_TM = D;

             		// Byte write
             		if ( BW_N[0] === 1'b0 ) begin
                		IN_REG_TM[((data_bits/4)-1) : 0 ]= DATA_TM[((data_bits/4)-1) : 0];
             		end

             		if ( BW_N[1] === 1'b0 ) begin
                		IN_REG_TM[(data_bits/2-1) : (data_bits/4)]= DATA_TM[(data_bits/2-1) : (data_bits/4)];
             		end

             		if ( BW_N[2] === 1'b0 ) begin
                		IN_REG_TM[(data_bits*3/4-1) : (data_bits/2)]= DATA_TM[(data_bits*3/4-1) : (data_bits/2)];
             		end

             		if ( BW_N[3] === 1'b0 ) begin
                		IN_REG_TM[(data_bits-1) : (data_bits*3/4)]= DATA_TM[(data_bits-1) : (data_bits*3/4)];
             		end

             		SMEM[{AD_W_REG,BU_W_CNT}] = IN_REG_TM;
             
             		$display ("%m : at time %t : Memory Write!! : address = %h data = %h", $time, {AD_W_REG,BU_W_CNT}, IN_REG_TM); 

             		if (id == bu_n -1) begin
                		BU_W_CNT = 0;
             		end
             		else begin
                		BU_W_CNT = BU_W_CNT + 1;
             		end   
         	end
       	end 


////////////////////////////////////////////////////////////////////////////////
//////////////////       Read function     ////////////////////////////////////
////////////////////////////////////////////////////////////////////////////// 
    
       	// Read address fetch 
       	if ( rcount[aor_r] == 1 ) begin
          	AD_R_PI[dor_r-aor_r]= SA;
          	$display("%m : at time %t : Read Address fetch!! : fetched address = %h", $time, AD_R_PI[dor_r-aor_r]);
       	end
           
       	// Data read start
       	if ( rcount[dor_r] == 1 ) begin
          	AD_R_REG= AD_R_PI[0];
       	end

       	for (id = 0 ; id < bu_n ; id = id + 1) begin      
         	if ( rcount[dor_r + id] == 1 ) begin
            		OUT_REG= SMEM[{AD_R_REG,BU_R_CNT}];
            		$display ("%m : at time %t : Memory Read : address = %h data = %h", $time, {AD_R_REG,BU_R_CNT}, OUT_REG);
            		if (id == bu_n -1) begin
                		BU_R_CNT = 0;
             		end
             		else begin
                		BU_R_CNT = BU_R_CNT + 1;
             		end
        	end
       	end

       	// Data out in case output clock(C and C__N) is all 'H' fixed

       	if (ocf == 1) begin

         	// No operation - Read ( previous - current )
         	if ( (rcount[dor_r + bu_n] == 0) && (rcount[dor_r] == 1) ) begin
            		$display("%m : at time %t : N-R (ocf = 1)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX1) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

         	// Read - Read
         	else if( ((rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 1)) || (rcount[dor_r+2] == 1) ) begin
            		$display("%m : at time %t : R-R (ocf = 1)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

         	// Continue
         	else if( (rcount[dor_r+1] == 1) || (rcount[dor_r+3] == 1)) begin
            		$display("%m : at time %t : R-R (ocf = 1)", $realtime);
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

         	// No operation - Read
         	if ( (rcount[dor_r + bu_n] == 0) && (rcount[dor_r] == 1) ) begin
            		$display("%m : at time %t : N-R (ocf = 0)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX1) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

         	// ( Read - Read ) 
         	else if( ((rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 1)) || (rcount[dor_r+2] == 1) ) begin
            		$display("%m : at time %t : R-R (ocf = 0)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

		// continue
         	else if( (rcount[dor_r+1] == 1) || (rcount[dor_r+3] == 1)) begin
            		$display("%m : at time %t : R-R (ocf = 0)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQV) OUT_REG;
         	end

         	// Read - No operation
         	else if( (rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 0) ) begin
            		$display("%m : at time %t : R-N (ocf = 0)", $realtime);
            		OUT_BUF <= #(epulse + `tCHQX) {data_bits{1'bz}};
            		OUT_BUF <= #(epulse + `tCHQZ) {data_bits{1'bz}};
         	end
       	end
    	end

	// Generate CQ and CQ_N
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
        	$setuphold(posedge K,   BW_N, IVKH, KHIX);
        	$setuphold(posedge K_N, BW_N, IVKH, KHIX);
    	endspecify

endmodule
