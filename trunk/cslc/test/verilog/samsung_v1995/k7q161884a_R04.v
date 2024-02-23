/****************************************************************************************
*
*  SAMSUNG 16Mb QDR1-b4 SRAM Verilog Behavioral model
*
*  Description :  K7Q161884A (1M x 18 QDR-b4 SRAM)
*
*  File Name   :  k7q161884a.v
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
*                 - Read and write cannot be active simultaneously
*                 - BW_N# can be altered for any portion of the BURST WRITE operation
*                   provided that the setup and hold requirements are satisfied.
*                 - The address is concatenated with 2 additional internal LSB to facilitate
*                   burst operation.
*
*        Copyright(c) SAMSUNG ELECTRONICS Co,. 2001
*        All rights reserved
*
*   Revision History :
*
*   Rev  Author          Phone            Date        Changes
*   ---  --------------  --------------   ----------  -------------------------------------
*   0.0  Seungmin Lee   (82) 31-209-3823  08/24/2001
*   0.1  Seungmin Lee   (82) 31-209-3823  10/04/2001  correct inproperly burst counter initialization!!
*   0.2  Seungmin Lee   (82) 31-209-3823  11/28/2001  correct the wrong word
*   0.3  Seungmin Lee   (82) 31-209-3823  12/22/2001  correct the part of command fetch, when the skew between K and K_N occur 
*   0.4  Seungmin Lee   (82) 31-209-3823  01/07/2002  Add the effect of tCHQX
*
****************************************************************************************/

//Define time scale $ accuracy  

`timescale 1ns / 1ps

`ifdef fc20
        `define         tKHKH           5.0
        `define         tKHKL           2.0
        `define         tKLKH           2.0
        `define         tAVKH           0.6
        `define         tIVKH           0.6
        `define         tDVKH           0.6
        `define         tKHAX           0.6
        `define         tKHIX           0.6
        `define         tKHDX           0.6
        `define         tKHCH           0.0
        `define         tCHQV           2.2
        `define         tCHQX           1.0
        `define         tCHQZ           2.2
        `define         tCHQX1          1.0
        `define         out_clock_fix   0
`endif

`ifdef fc16
        `define         tKHKH           6.0
        `define         tKHKL           2.4 
        `define         tKLKH           2.4 
        `define         tAVKH           0.7
        `define         tIVKH           0.7
        `define         tDVKH           0.7
        `define         tKHAX           0.7
        `define         tKHIX           0.7
        `define         tKHDX           0.7
        `define         tKHCH           0.0
        `define         tCHQV           2.5
        `define         tCHQX           1.2
        `define         tCHQZ           2.5
        `define         tCHQX1          1.2 
        `define         out_clock_fix   0                     
`endif

`ifdef fc13 
        `define         tKHKH           7.5
        `define         tKHKL           3.0
        `define         tKLKH           3.0
        `define         tAVKH           0.8
        `define         tIVKH           0.8
        `define         tDVKH           0.8
        `define         tKHAX           0.8
        `define         tKHIX           0.8
        `define         tKHDX           0.8
        `define         tKHCH           0.0
        `define         tCHQV           3.0
        `define         tCHQX           1.2
        `define         tCHQZ           3.0
        `define         tCHQX1          1.2 
        `define         out_clock_fix   0                     
`endif

`ifdef fc10
        `define         tKHKH           10.0
        `define         tKHKL           3.5 
        `define         tKLKH           3.5 
        `define         tAVKH           1.0
        `define         tIVKH           1.0
        `define         tDVKH           1.0
        `define         tKHAX           1.0
        `define         tKHIX           1.0
        `define         tKHDX           1.0
        `define         tKHCH           0.0
        `define         tCHQV           3.0
        `define         tCHQX           1.2
        `define         tCHQZ           3.0
        `define         tCHQX1          1.2 
        `define         out_clock_fix   0                     
`endif

`ifdef fc20_ocf
        `define         tKHKH           5.0
        `define         tKHKL           2.0
        `define         tKLKH           2.0
        `define         tAVKH           0.6
        `define         tIVKH           0.6
        `define         tDVKH           0.6
        `define         tKHAX           0.6
        `define         tKHIX           0.6
        `define         tKHDX           0.6
        `define         tKHCH           0.0
        `define         tCHQV           2.2
        `define         tCHQX           1.0
        `define         tCHQZ           2.2
        `define         tCHQX1          1.0
        `define         out_clock_fix   1
`endif

`ifdef fc16_ocf
	`define		tKHKH		6.0   
	`define		tKHKL		2.4   
	`define		tKLKH		2.4   
	`define		tAVKH		0.7   
	`define		tIVKH		0.7   
	`define		tDVKH		0.7   
	`define		tKHAX		0.7   
	`define		tKHIX		0.7   
	`define		tKHDX		0.7   
	`define		tKHCH		0.0
        `define         tCHQV           2.5
        `define         tCHQX           1.2
        `define         tCHQZ           2.5
        `define         tCHQX1          1.2 
        `define         out_clock_fix   1                     
`endif

`ifdef fc13_ocf
	`define		tKHKH		7.5   
	`define		tKHKL		3.0   
	`define		tKLKH		3.0   
	`define		tAVKH		0.8   
	`define		tIVKH		0.8   
	`define		tDVKH		0.8   
	`define		tKHAX		0.8   
	`define		tKHIX		0.8   
	`define		tKHDX		0.8   
	`define		tKHCH		0.0
	`define		tCHQV		3.0   
        `define         tCHQX           1.2
        `define         tCHQZ           3.0
        `define         tCHQX1          1.2 
        `define         out_clock_fix   1                     
`endif

`ifdef fc10_ocf
	`define		tKHKH		10.0   
	`define		tKHKL		3.5   
	`define		tKLKH		3.5   
	`define		tAVKH		1.0   
	`define		tIVKH		1.0   
	`define		tDVKH		1.0   
	`define		tKHAX		1.0   
	`define		tKHIX		1.0   
	`define		tKHDX		1.0   
	`define		tKHCH		0.0
	`define		tCHQV		3.0   
        `define         tCHQX           1.2
        `define         tCHQZ           3.0
        `define         tCHQX1          1.2 
        `define         out_clock_fix   1                     
`endif

////////////////////////////////////////////////////////////////////////////////
//////////////////       Main module       ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

module k7q161884a (D, Q, SA, R_N, W_N, BW_N, K, K_N, C, C_N);

    	// Constant Parameters
    	parameter                   addr_bits =      18;    // This is external address
    	parameter                   data_bits =      18;
    	parameter                   mem_sizes =      1048575;

    	parameter                   qdelay    =     `tCHQV; // tCHQX1 to tCHQV
  
    	parameter                   aor_r     =      0;    // Read Address order
    	parameter                   aor_w     =      0;    // Write Address order
    	parameter                   dor_r     =      2;    // Read data order
    	parameter                   dor_w     =      2;    // Write data order
    	parameter                   bu_n      =      4;    // Burst number
    	parameter                   bn        =      2;    // Byte Write Bit
    
    	// Port Declarations
    	input   [data_bits - 1 : 0] D;
    	output  [data_bits - 1 : 0] Q;
    	input   [addr_bits - 1 : 0] SA;
    	input                       R_N;
    	input                       W_N;
    	input          [bn - 1 : 0] BW_N;
    	input                       K, K_N;
    	input                       C, C_N;

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
	reg			    int_K;

    	wire ocf = `out_clock_fix;
    
    	integer                     id;                    
    	integer                     rcount [0 : dor_r + bu_n ];
    	integer                     wcount [0 : dor_w + bu_n ];

    	// Initial Conditions
    	initial begin
        	OUT_REG = {data_bits{1'bz}};
        	OUT_BUF = {data_bits{1'bz}};
		BU_W_CNT = 0;
		BU_R_CNT = 0;
    	end 
    
    	always @ (posedge K) begin
		int_K = 1'b1;
	end

    	always @ (posedge K_N) begin
		int_K = 1'b0;
	end

    	always @ (posedge int_K or negedge int_K) begin
   
   	$display("%m : at time %t :==================================================================================================", $time);  

////////////////////////////////////////////////////////////////////////////////
//////////////////       Write function    ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
      
      	// Write  Address, BW, Data, command pipelining
      	for ( id = dor_w - aor_w ; id > 0 ; id = id - 1) begin
          	AD_W_PI[id]= AD_W_PI[id-1]; 
      	end
      
      	for (id = dor_w + bu_n  ; id > 0 ; id = id - 1) begin
          	wcount[id]= wcount[id-1];
      	end
      
      	wcount[0]= 0; 
     
      	AD_W_PI[0] = {addr_bits{1'bx}}; 
      
      	// Read address, command pipelining
      	for ( id = dor_r - aor_r  ; id > 0 ; id = id - 1 ) begin
        	AD_R_PI[id]= AD_R_PI[id-1];
      	end

      	for ( id = dor_r + bu_n ; id > 0 ; id = id - 1 ) begin
          	rcount[id]= rcount[id-1];
      	end

      	rcount[0]= 0;

      	AD_R_PI[0]= {addr_bits{1'bx}};

      	// Read or Write command fetch  
      	if ( R_N === 1'b0 && int_K === 1'b1) begin
         	if ( rcount[2] != 1 ) begin 
            		rcount[0]= 1;
            		$display("%m : at time %t : Read command is fetched!!", $time);
         	end
      	end
      	else if ( W_N === 1'b0 && R_N !== 1'b0 && int_K === 1'b1) begin
         	if ( wcount[2] != 1 ) begin
            		wcount[0]= 1;
            		$display("%m : at time %t : Write command is fetched!!", $time);
         	end 
      	end

      	// Write address fetch 
      	if (wcount[aor_w] == 1) begin
         	AD_W_PI[0]= SA;
         	$display ("%m : at time %t : Write address fetch!! : fetched address = %h", $time, AD_W_PI[0]); 
      	end
         
       	// Data input 
       	for (id = 0 ; id< bu_n ; id=id+1) begin   
         	if ( wcount[dor_w + id] == 1 ) begin
            		if (id == 0) begin
               			AD_W_REG = AD_W_PI[dor_w - aor_w];  
			end
            		IN_REG_TM = SMEM[{AD_W_REG, BU_W_CNT}]; 
            		DATA_TM = D;

             		// Byte write
             		if ( BW_N[0] === 1'b0 ) begin
                		IN_REG_TM[((data_bits/2)-1) : 0 ]= DATA_TM[((data_bits/2)-1) : 0];
             		end

             		if ( BW_N[1] === 1'b0 ) begin
                		IN_REG_TM[(data_bits-1) : (data_bits/2)]= DATA_TM[(data_bits-1) : (data_bits/2)];
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
          	AD_R_PI[0]= SA;
          	$display("%m : at time %t : Read Address fetch!! : fetched address = %h", $time, AD_R_PI[0]);
       	end
           
       	// Data read start
       	for (id = 0 ; id < bu_n ; id = id + 1) begin      
         	if ( rcount[dor_r + id] == 1 ) begin

       			if ( id == 0 ) begin
          			AD_R_REG = AD_R_PI[dor_r - aor_r];
       			end

            		OUT_REG = SMEM[{AD_R_REG,BU_R_CNT}];

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

            	// No operation - Read 
            	if( (rcount[dor_r + bu_n] == 0) && (rcount[2] == 1) ) begin
              		$display("%m : at time %t : (ocf=1) N-R", $time);
              		OUT_BUF <= #`tCHQX1 {data_bits{1'bz}};
              		OUT_BUF <= #`tCHQV OUT_REG;
            	end

            	// Read - Read
            	else if((rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 1)) begin
              		$display("%m : at time %t : (ocf=1) R-R", $time);
              		OUT_BUF <= #`tCHQX {data_bits{1'bz}};
              		OUT_BUF <= #`tCHQV OUT_REG;
            	end

            	// Continue
            	else if( (rcount[dor_r + 1] == 1) || (rcount[dor_r + 2] == 1) || (rcount[dor_r + 3] == 1)) begin
              		$display("%m : at time %t : (ocf=1) continue ", $time);
              		OUT_BUF <= #`tCHQX {data_bits{1'bz}};
              		OUT_BUF <= #`tCHQV OUT_REG;
            	end

            	// Read - No operation
            	else if( (rcount[6] == 1) && (rcount[2] == 0) ) begin
              		$display("%m : at time %t : (ocf=1) R-N", $time);
              		OUT_BUF <= #`tCHQX {data_bits{1'bz}};
              		OUT_BUF <= #`tCHQZ {data_bits{1'bz}};
            	end
       	end
    	end 
  
    	// Data out in case Output clock(C and C_N) is not fixed 
    	always @ (posedge C or posedge C_N) begin

      	if (ocf == 0) begin

		#0;
                // No operation - Read
                if( (rcount[dor_r + bu_n] == 0) && (rcount[dor_r] == 1) ) begin
                        $display("%m : at time %t : (ocf=0) N-R", $time);
              		OUT_BUF <= #`tCHQX1 {data_bits{1'bz}};
                        OUT_BUF <= #`tCHQV OUT_REG;
                end

                // Read - Read
                else if((rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 1)) begin
                        $display("%m : at time %t : (ocf=0) R-R", $time);
              		OUT_BUF <= #`tCHQX {data_bits{1'bz}};
                        OUT_BUF <= #`tCHQV OUT_REG;
                end

                // Continue
                else if( (rcount[dor_r + 1] == 1) || (rcount[dor_r + 2] == 1) || (rcount[dor_r + 3] == 1)) begin
                        $display("%m : at time %t : (ocf=0) continue", $time);
              		OUT_BUF <= #`tCHQX {data_bits{1'bz}};
                        OUT_BUF <= #`tCHQV OUT_REG;
                end

                // Read - No operation
                else if( (rcount[dor_r + bu_n] == 1) && (rcount[dor_r] == 0) ) begin
                        $display("%m : at time %t : (ocf=0) R-N", $time);
              		OUT_BUF <= #`tCHQX {data_bits{1'bz}};
                        OUT_BUF <= #`tCHQZ {data_bits{1'bz}};
                end

      	end
    	end

    	assign Q = OUT_BUF;
  
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
