//
//	File Name: K7N161845A.v
//	Version  : Rev 0.4
//	NOV  30 2001
//
//	Description: ( 16Mb X18 NtSRAM ) 
//
//	Bwa_n	--> Control Dq 8 : 0
//	Bwb_n	--> Control Dq 17: 9
//


`timescale 1ns / 100ps


`ifdef hc25
        `define         tCYC            4.0             // Cycle Time
        `define         tCD             2.6             // Clock Acess Time
        `define         tOE             2.6             // Output Enable to Data Valid
        `define         tLZC            1.5             // Clock High to Output Low-Z
        `define         tOH             1.5             // Output Hold from Clock High
        `define         tLZOE           0               // Output Enable Low to Output Low-Z
        `define         tHZOE           2.6             // Output Enable High to Output High-Z
        `define         tHZC            2.6             // Clock High to Output High-Z
        `define         tCH             1.7             // Clock High Pulse Width
        `define         tCL             1.7             // Clock Low Pulse Width
        `define         tAS             1.2             // Address Setup to Clock High
        `define         tCES            1.2             // CKE_B Setup to Clock High
        `define         tDS             1.2             // Data Setup to Clock High
        `define         tWS             1.2             // Write Setup to Clock High
        `define         tADVS           1.2             // Address Advance Setup to Clock High
        `define         tCSS            1.2             // Chip Select Setup to Clock High
        `define         tAH             0.3             // Address Hold from Clock High
        `define         tCEH            0.3             // CKE_B Hold from Clock High
        `define         tDH             0.3             // Data Hold from Clock High
        `define         tWH             0.3             // Write Hold from clock High
        `define         tADVH           0.3             // Address Advance Hold from Clock High
        `define         tCSH            0.3             // Chip SElect Hold from Clock High
        `define         tPDS            8               // ZZ High to Power Down
        `define         tPUS            8               // ZZ Low to Power Up
`endif

`ifdef hc22
        `define         tCYC            4.4             // Cycle Time
        `define         tCD             2.8             // Clock Acess Time
        `define         tOE             2.8             // Output Enable to Data Valid
        `define         tLZC            1.5             // Clock High to Output Low-Z
        `define         tOH             1.5             // Output Hold from Clock High
        `define         tLZOE           0               // Output Enable Low to Output Low-Z
        `define         tHZOE           2.8             // Output Enable High to Output High-Z
        `define         tHZC            2.8             // Clock High to Output High-Z
        `define         tCH             2.0             // Clock High Pulse Width
        `define         tCL             2.0             // Clock Low Pulse Width
        `define         tAS             1.4             // Address Setup to Clock High
        `define         tCES            1.4             // CKE_B Setup to Clock High
        `define         tDS             1.4             // Data Setup to Clock High
        `define         tWS             1.4             // Write Setup to Clock High
        `define         tADVS           1.4             // Address Advance Setup to Clock High
        `define         tCSS            1.4             // Chip Select Setup to Clock High
        `define         tAH             0.4             // Address Hold from Clock High
        `define         tCEH            0.4             // CKE_B Hold from Clock High
        `define         tDH             0.4             // Data Hold from Clock High
        `define         tWH             0.4             // Write Hold from clock High
        `define         tADVH           0.4             // Address Advance Hold from Clock High
        `define         tCSH            0.4             // Chip SElect Hold from Clock High
        `define         tPDS            8.8             // ZZ High to Power Down
        `define         tPUS            8.8             // ZZ Low to Power Up
`endif


`ifdef hc20
        `define         tCYC            5.0             // Cycle Time
        `define         tCD             3.2             // Clock Acess Time
        `define         tOE             3.2             // Output Enable to Data Valid
        `define         tLZC            1.5             // Clock High to Output Low-Z
        `define         tOH             1.5             // Output Hold from Clock High
        `define         tLZOE           0               // Output Enable Low to Output Low-Z
        `define         tHZOE           3.0             // Output Enable High to Output High-Z
        `define         tHZC            3.0             // Clock High to Output High-Z
        `define         tCH             2.0             // Clock High Pulse Width
        `define         tCL             2.0             // Clock Low Pulse Width
        `define         tAS             1.4             // Address Setup to Clock High
        `define         tCES            1.4             // CKE_B Setup to Clock High
        `define         tDS             1.4             // Data Setup to Clock High
        `define         tWS             1.4             // Write Setup to Clock High
        `define         tADVS           1.4             // Address Advance Setup to Clock High
        `define         tCSS            1.4             // Chip Select Setup to Clock High
        `define         tAH             0.4             // Address Hold from Clock High
        `define         tCEH            0.4             // CKE_B Hold from Clock High
        `define         tDH             0.4             // Data Hold from Clock High
        `define         tWH             0.4             // Write Hold from clock High
        `define         tADVH           0.4             // Address Advance Hold from Clock High
        `define         tCSH            0.4             // Chip SElect Hold from Clock High
        `define         tPDS            10              // ZZ High to Power Down
        `define         tPUS            10              // ZZ Low to Power Up
`endif


`ifdef hc16
	`define		tCYC		6.0		// Cycle Time
	`define		tCD		3.5		// Clock Acess Time 
	`define		tOE		3.5		// Output Enable to Data Valid
	`define		tLZC		1.5		// Clock High to Output Low-Z
	`define		tOH		1.5		// Output Hold from Clock High
	`define		tLZOE		0		// Output Enable Low to Output Low-Z
	`define		tHZOE		3.0		// Output Enable High to Output High-Z
	`define		tHZC		3.0		// Clock High to Output High-Z
	`define		tCH		2.2		// Clock High Pulse Width
	`define		tCL		2.2		// Clock Low Pulse Width
	`define		tAS		1.5		// Address Setup to Clock High
	`define		tCES		1.5		// CKE_B Setup to Clock High
	`define		tDS		1.5		// Data Setup to Clock High
	`define		tWS		1.5		// Write Setup to Clock High
	`define		tADVS		1.5		// Address Advance Setup to Clock High
	`define		tCSS		1.5		// Chip Select Setup to Clock High
	`define		tAH		0.5		// Address Hold from Clock High
	`define		tCEH		0.5		// CKE_B Hold from Clock High
	`define		tDH		0.5		// Data Hold from Clock High
	`define		tWH		0.5		// Write Hold from clock High
	`define		tADVH		0.5		// Address Advance Hold from Clock High
	`define		tCSH		0.5		// Chip SElect Hold from Clock High
	`define		tPDS		12		// ZZ High to Power Down
	`define		tPUS		12		// ZZ Low to Power Up 
`endif


`ifdef hc13
	`define		tCYC		7.5		// Cycle Time
	`define		tCD		4.2		// Clock Acess Time 
	`define		tOE		4.2		// Output Enable to Data Valid
	`define		tLZC		1.5		// Clock High to Output Low-Z
	`define		tOH		1.5		// Output Hold from Clock High
	`define		tLZOE		0		// Output Enable Low to Output Low-Z
	`define		tHZOE		3.5		// Output Enable High to Output High-Z
	`define		tHZC		3.5		// Clock High to Output High-Z
	`define		tCH		3.0		// Clock High Pulse Width
	`define		tCL		3.0		// Clock Low Pulse Width
	`define		tAS		1.5		// Address Setup to Clock High
	`define		tCES		1.5		// CKE_B Setup to Clock High
	`define		tDS		1.5		// Data Setup to Clock High
	`define		tWS		1.5		// Write Setup to Clock High
	`define		tADVS		1.5		// Address Advance Setup to Clock High
	`define		tCSS		1.5		// Chip Select Setup to Clock High
	`define		tAH		0.5		// Address Hold from Clock High
	`define		tCEH		0.5		// CKE_B Hold from Clock High
	`define		tDH		0.5		// Data Hold from Clock High
	`define		tWH		0.5		// Write Hold from clock High
	`define		tADVH		0.5		// Address Advance Hold from Clock High
	`define		tCSH		0.5		// Chip SElect Hold from Clock High
	`define		tPDS		15		// ZZ High to Power Down
	`define		tPUS		15		// ZZ Low to Power Up 
`endif

     `define     addr_bits  20   // Address is 18 bits + 2bit(Burst count)
     `define     data_bits  18   //  18 I/O bits
     `define     pipe_state 18   //  18 pipeline state number
     `define     VDD     1       // TRUE  ==  VDD == VDDQ == 1
     `define     VDDQ    1       // TRUE  ==  VDD == VDDQ == 1
     `define     VSS     0       // FAULE ==  VSS == VSSQ == 1
     `define     VSSQ    0       // FAULE ==  VSS == VSSQ == 1


module K7N161845A ( Dq, Addr, CLK, CKEb, 
	   	  Bwa_n, Bwb_n,
	   	  WEb, ADV, OEb,                  
	   	  CS1b, CS2, CS2b, LBOb, ZZ ); 

parameter mem_sizes = 1024*1024 - 1 ;                         //  1M

inout   [(`data_bits - 1) : 0] Dq;                            // Data I/O
input   [(`addr_bits - 1) : 0] Addr;                          // Address

input   CLK;                                                  // Clock
input   ADV;                                                  // Address Advance
input   CKEb;                                                  // Slow Down Mode
input   WEb;                                                  // Read(="H")/Write(="L")

input   Bwa_n;                                                // Byte Write Enable A
input   Bwb_n;                                                // Byte Write Enable B

input   CS1b;                                                  // Chip Enable
input   CS2;                                                   // Chip Enable
input   CS2b;                                                   // Chip Enable
input   OEb;                                                   // Chip Enable
input   ZZ;                                                   // Chip Enable
input   LBOb;                                                   // Chip Enable

wire  [(`data_bits - 1) : 0] Dq;                         // Data I/O  inout is connected by wire
wire  [(`data_bits - 1) : 0] DQ;                         // Data I/O  inout is connected by wire
reg  [(`data_bits - 1) : 0] read_temp;                       // Data I/O  inout is connected by wire

reg     K;	    					      // clk
reg     ck ;	    					      // clk
reg     ckb ;	    					      // clkb
reg     [`data_bits -1 : 0] mem [ 0 : mem_sizes ];              // common IO = 18 , 1M

reg     ckeb;    					      // Chip select signal
reg     cs1b;    					      // Chip select signal
reg     cs2;    					      // Chip select signal
reg     cs2b;    					      // Chip select signal

reg     adv;    					      // ADV 
reg     now_adv;    					      // ADV 
reg     past_adv;    					      // ADV 
reg     last_adv;    					      // ADV 
reg     last1_adv;    					      // ADV 
reg     we_b;    					      // H(READ), L(WRITE)

reg     oeb;    					      // out enable bar
reg     out_con;    					      // echo clk2b
reg     output_con;    					      // echo clk2b

reg     [(`addr_bits - 1) : 0] addr_buf;                      // Addr Register
reg     [(`data_bits - 1) : 0] data_buf;                      // Data Register
reg     [(`data_bits - 1) : 0] dout;                          // Dq Register

reg     [(`addr_bits - 1) : 0] last1_add;                      // Addr @ before 2 cycle
reg     [(`addr_bits - 1) : 0] last_add;                      // Addr @ before 2 cycle
reg     [(`addr_bits - 1) : 0] past_add;                      // Addr @ before 1 cycle
reg     [(`addr_bits - 1) : 0] now_add;                       // Addr @ present cycle

reg     [(`data_bits - 1) : 0] tmp_data;                      // Data @ temp data Register

reg     last1_state;    	       		              // LAST STATE before 2 cycle@ Read or Write
reg     last_state;    	        		              // LAST STATE @ Read or Write
reg     past_state;    	        		              // PAST STATE @ Read or Write
reg     now_state; 		     	               	      // NOW STATE @ Read or Write

reg     past_deselect ;	        		              // PAST deselect
reg     now_deselect ;   	  	               	      // NOW  deselect
reg     deselect ;	   	  	               	      // deselct STATE
reg     past_deslct ;	        		              // PAST deselect
reg     now_deslct ;   	  	               	      // NOW  deselect
reg     deslct ;	   	  	               	      // deselct STATE

reg     zz;	    					      // Chip select signal

reg     lbob;	    					      // Chip select signal

reg     bwa_n;          	                              // Syn Byte Write Enable A
reg     bwb_n;                  	                      // Syn Byte Write Enable B

reg     now_bwa_n;          	                              // Syn Byte Write Enable A
reg     now_bwb_n;                  	                      // Syn Byte Write Enable B

reg     past_bwa_n;          	                              // Syn Byte Write Enable A
reg     past_bwb_n;                  	                      // Syn Byte Write Enable B

reg     single_w;                  	                      // Single Write Enable
reg     single_r;                  	                      // Single Read  Enable 

reg     [(`addr_bits - 3) : 0] rburst_add;                      // Addr Register
reg     [(`addr_bits - 3) : 0] wburst_add;                      // Addr Register
reg     n ; 			                     // Addr Register
reg     [1 : 0] bcnt;                                         // 4 Burst Counter(1 ~ 4)
                                                          
real    past_pos_CLK ;
real    last_pos_CLK ;
real    current_time ;
integer t ;		                                      
reg Dq_flag ;		                                  
integer sleep ; 			                     // Addr Register

//==============================================================================================//

///////////////////////////////////
// 	Initialize Variables     //
///////////////////////////////////

initial 
begin
	Dq_flag = 0 ; 
	single_w= 0 ; 
	single_r= 0 ; 
	t = 0      ;
	zz= 0      ;
	dout     = {`data_bits{1'bz}}  ;
	data_buf = {`data_bits{1'bz}}  ;
	read_temp = {`data_bits{1'bz}}  ;
        bcnt     = 2'b0   ; 
        ck = 1'b0 ;
        ckb = 1'b1 ;
        out_con = 1'b0 ;
        we_b = 1'bx ;

	bwa_n = 1    ;
       	bwb_n = 1    ;

	now_bwa_n = 1    ;
       	now_bwb_n = 1    ;

	past_bwa_n = 1    ;
       	past_bwb_n = 1    ;

	addr_buf = {`addr_bits{1'bz}};                      // Addr Register
	last_add = {`addr_bits{1'bz}};                      // Addr @ before 2 cycle
	past_add = {`addr_bits{1'bz}};                      // Addr @ before 1 cycle
	now_add  = {`addr_bits{1'bz}};                       // Addr @ present cycle

	tmp_data  = {`data_bits{1'bz}};                      // Data @ temp data Register
end

assign Dq = out_con ? read_temp : {`data_bits{1'bz}};


always @(posedge CLK )
	begin
		ckeb = CKEb ;

		if(CKEb == 1)
		  begin
			K = 0 ;
		  end
		else
		  begin
			K  = K & ~zz ;
		  end
	end

always @(negedge CLK )
	begin
		if(ckeb == 1)
		  begin
			K = 0 ;
		  end
		else
		  begin
			K  = K & ~zz ;
		  end
	end

always @(posedge ZZ)
	begin
		zz <= #`tPDS ZZ;
		out_con  <= #`tPDS 1'b0 ;
		dout <= #`tPDS {`data_bits{1'bz}} ;
		read_temp <= #`tPDS dout ;
	end

always @(negedge ZZ)
	begin
		zz <= #`tPUS ZZ;
	end

always @(posedge OEb)
	begin
		out_con  <= #`tHZOE 1'b0 ;
		dout <= #`tHZOE {`data_bits{1'bz}} ;
		read_temp <= #`tHZOE dout ;
	end

always @(negedge OEb)
	begin
//		read_temp <= #`tOE dout ;
		out_con  <= #`tOE 1'b1 ;
	end


//////////////////////
//  Main Function   //
//////////////////////

always @(posedge zz  )
	begin
		bwa_n = 1'bz  ;
        	bwb_n = 1'bz  ;
                adv   = 1'bz  ;
                we_b  = 1'bz  ;
                lbob  = 1'bz  ;
                cs1b  = 1'bz  ;
                cs2   = 1'bz  ;
                cs2b  = 1'bz  ;
		addr_buf  = {`addr_bits{1'bz}}  ;
		data_buf  = {`data_bits{1'bz}}  ;
		past_bwa_n = 1'bz ; 
		now_bwa_n = 1'bz ; 
       	        bwa_n = 1'bz ;
		past_bwb_n = 1'bz ; 
		now_bwb_n = 1'bz ; 
       	        bwb_n = 1'bz ;
		last1_state =  1'bz   ;             // adv  @ last cycle
		last_state =  1'bz    ;              // adv  @ last cycle
       	        past_state = 1'bz     ;               // adv  @ past cycle
       	        now_state  =  1'bz    ;               // adv  @ present cycle
		last1_adv =  1'bz     ;             // adv  @ last cycle
		last_adv =  1'bz      ;              // adv  @ last cycle
       	        past_adv = 1'bz      ;               // adv  @ past cycle
       	        now_adv   =  1'bz     ;               // adv  @ present cycle
		last1_add = {`addr_bits{1'bz}}  ;
		last_add = {`addr_bits{1'bz}}  ;
		past_add = {`addr_bits{1'bz}}  ;
		now_add = {`addr_bits{1'bz}}  ;
       	       	past_deslct = 0 ;    // deselect @ past cycle
	        now_deslct  = 0 ;
		deslct = 0 ;         // deselect @ present cycle
       	       	past_deselect = 0 ;    // deselect @ past cycle
	        now_deselect  = 0 ;
		t = 0 ;         // deselect @ present cycle
		n = 0 ;         // deselect @ present cycle
		single_w = 0 ;         // deselect @ present cycle
		single_r = 0 ;         // deselect @ present cycle
		dout  = {`data_bits{1'bz}}  ;
		read_temp = {`data_bits{1'bz}}  ;
        	bcnt     = 2'bzz  ; 
		tmp_data = {`data_bits{1'bz}}  ;
		rburst_add = {(`data_bits-2){1'bz}}  ;
		wburst_add = {(`data_bits-2){1'bz}}  ;
	end

always @(negedge zz  )
	begin
		bwa_n = 1'bz  ;
        	bwb_n = 1'bz  ;
                adv   = 1'bz  ;
                we_b  = 1'bz  ;
                lbob  = 1'bz  ;
                cs1b  = 1'bz  ;
                cs2   = 1'bz  ;
                cs2b  = 1'bz  ;
		addr_buf  = {`addr_bits{1'bz}}  ;
		data_buf  = {`data_bits{1'bz}}  ;
		past_bwa_n = 1'bz ; 
		now_bwa_n = 1'bz ; 
       	        bwa_n = 1'bz ;
		past_bwb_n = 1'bz ; 
		now_bwb_n = 1'bz ; 
       	        bwb_n = 1'bz ;
		last1_state =  1'bz  ;             // adv  @ last cycle
		last_state =  1'bz   ;              // adv  @ last cycle
       	        past_state = 1'bz    ;               // adv  @ past cycle
       	        now_state  =  1'bz   ;               // adv  @ present cycle
		last1_adv =  1'bz    ;             // adv  @ last cycle
		last_adv =  1'bz     ;              // adv  @ last cycle
       	        past_adv = 1'bz      ;               // adv  @ past cycle
       	        now_adv   =  1'bz    ;               // adv  @ present cycle
		last1_add = {`addr_bits{1'bz}}  ;
		last_add = {`addr_bits{1'bz}}  ;
		past_add = {`addr_bits{1'bz}}  ;
		now_add = {`addr_bits{1'bz}}  ;
       	       	past_deslct = 0 ;    // deselect @ past cycle
	        now_deslct  = 0 ;
		deslct = 0 ;         // deselect @ present cycle
       	       	past_deselect = 0 ;    // deselect @ past cycle
	        now_deselect  = 0 ;
		t = 0 ;         // deselect @ present cycle
		n = 0 ;         // deselect @ present cycle
		single_w = 0 ;         // deselect @ present cycle
		single_r = 0 ;         // deselect @ present cycle
		dout  = {`data_bits{1'bz}}  ;
		read_temp = {`data_bits{1'bz}}  ;
        	bcnt     = 2'bzz  ; 
		tmp_data = {`data_bits{1'bz}}  ;
		rburst_add = {(`data_bits-2){1'bz}}  ;
		wburst_add = {(`data_bits-2){1'bz}}  ;
	end


always @(negedge K )
	begin
	   if(zz == 0)
		begin
		past_bwa_n = now_bwa_n;
		now_bwa_n = bwa_n;

		past_bwb_n = now_bwb_n;
		now_bwb_n = bwb_n;

		last1_adv = last_adv;             // adv  @ last cycle
		last_adv = past_adv;              // adv  @ last cycle
                past_adv = now_adv;               // adv  @ past cycle
                now_adv   = adv;                  // adv  @ present cycle

		last1_add = last_add;             // Addr @ last cycle
		last_add = past_add;              // Addr @ last cycle
                past_add = now_add;               // Addr @ past cycle
                now_add  = addr_buf;              // Addr @ present cycle

                past_deslct = now_deslct ;    // deselect @ past cycle
                now_deslct  = deslct;         // deselect @ present cycle

                past_deselect = now_deselect ;    // deselect @ past cycle
                now_deselect  = deselect;         // deselect @ present cycle

                last_state = past_state ;         // State Register
                past_state = now_state ;          // State Register
                now_state  = we_b   ;             // State Register
		end

	end


always @(posedge K) 
	begin
		if((CS1b==1)||(CS2==0)||(CS2b==1))
	    		deselect = 1 ;
		else
	    		deselect = 0 ;
	end

always @(posedge K) 
	begin
		if((ADV == 0)&&(now_deselect==1))
		  begin
	    		deslct = 1 ;
		  end
		else if((deslct==1)&&(ADV==1))
		  begin
	    		deslct = 1 ;
		  end
		else
	    		deslct = 0 ;
	end


always @(posedge K) 
	begin
	   if(zz == 0)
		begin
		// Write Registry and Data Coherency Control Logic

		bwa_n = Bwa_n;
        	bwb_n = Bwb_n;
                adv   = ADV ;
                we_b  = WEb ;
                lbob  = LBOb ;
                cs1b  = CS1b ;
                cs2   = CS2  ;
                cs2b  = CS2b ;
		addr_buf  = Addr ;               // Address fetch at Addr Register
		data_buf  = Dq   ;               // Address fetch at Addr Register
		end


                ///////////////////
		//  Write Logic  //
                ///////////////////


if((zz==0)&&( past_adv==0 )&&(past_state==0)&&(past_deselect==0))   // Single Write
                begin
                    single_w= 1 ;
                    single_r= 0 ;
                    out_con = 0 ;
                    t =  0 ;
                    bcnt =   past_add[1:0] ;    // A1, A0 is used burst count start address
                    n = bcnt[0] ;               // LBOB control register
                    wburst_add =  past_add >> 2 ;   // value of A1, A0 is "00"


                        if ( past_bwa_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 2) - 1) : 0] = Dq[((`data_bits / 2) - 1) : 0];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                        if ( past_bwb_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[(`data_bits - 1) : (`data_bits / 2 )] = Dq[(`data_bits  - 1) : (`data_bits / 2 )];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                                read_temp = {`data_bits{1'bz}} ;
//                                out_con = 1 ;
                    end


                //////////////////////////
		//   Write Burst Logic  //
                //////////////////////////
        	if((zz==0)&&(single_w==1)&&( past_adv==1 )&&(past_deselect==0))  // Write Burst
	                 begin
				out_con =0 ;

			if ((n==1)&&(LBOb==1))
                	 	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
			else
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue


			if ( past_bwa_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[((`data_bits / 2) - 1) : 0] = Dq[((`data_bits / 2) - 1) : 0];
                                        mem[{wburst_add,bcnt}] = tmp_data ;

                                end

                        if ( past_bwb_n== 1'b0 )
                                begin
                                        tmp_data = mem[{wburst_add,bcnt}] ;
                                        tmp_data[(`data_bits - 1) : (`data_bits / 2 )] = Dq[(`data_bits - 1) : (`data_bits / 2)];
                                        mem[{wburst_add,bcnt}] = tmp_data ;
                                end

                                read_temp = {`data_bits{1'bz}} ;
//				out_con =1 ;
        	         end
/////////////////////   Write Logic END   //////////////////////

                //////////////////
		//  Read Logic  //
                //////////////////

        	if((zz==0)&&(now_adv==0)&&(now_state==1)&&(now_deselect==0)) //Single Read
	                 begin
				single_r = 1 ;
				single_w = 0 ;
				t =0 ;
				bcnt = now_add[1:0] ;    // A1, A0 is used burst count start address
                    		n = bcnt[0] ;               // LBOB control register
                                rburst_add = now_add >> 2 ;   // value of A1, A0 is "00"
                	 	dout = mem[{rburst_add, bcnt}] ;

			  if(OEb==0)
				begin
				 //out_con  <= #`tCD OEb ? 1'b0 : 1'b1 ;
				 out_con  <= #`tCD OEb ? 1'b0 : 1'b1 ;
				end

				 //read_temp <= #`tCD OEb ? `data_bits'bz : dout ;
				 read_temp <= #`tCD dout ;
				 output_con  <= #`tCD  1'b1 ;
                         end

        	if((zz==0)&&(single_r==1)&&( now_adv==1 )&&(now_deselect==0))   // Read Burst
	                 begin


			if ((n==1)&&(LBOb==1))
			  begin
                	 	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
			  end
			else
			  begin
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue
			  end


                	 	dout = mem[{rburst_add, bcnt}] ;

			  if(OEb==0)
				begin
				 //out_con  <= #`tCD OEb ? 1'b0 : 1'b1 ;
				 out_con  <= #`tCD 1'b1 ;
				end

				 //read_temp <= #`tCD OEb ? `data_bits'bz : dout ;
				 read_temp <= #`tCD dout ;
				 output_con  <= #`tCD  1'b1 ;
        	         end

    	end




always @(posedge K)
	begin
		if((ckeb==0)&&((output_con == 1)))
		  begin
			dout <= #(`tOH   ) {`data_bits{1'bz}} ;
			read_temp <= #(`tOH   ) {`data_bits{1'bz}} ;
			//read_temp <= #(`tOH ) dout  ;
			out_con <=  #(`tOH ) 1'b0 ;
			output_con <=  #(`tOH ) 1'b0 ;
		  end
	end


always @(posedge K)
	begin
				past_pos_CLK = last_pos_CLK ;
				last_pos_CLK = $realtime ;
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
			if((last_pos_CLK + `tCYC - current_time) < `tDS -0.001) 
				begin
        	                       	$display("Warning: tDS violation at %t ns", $time);
				end
		end
	end

always @(negedge Dq_flag)
	begin
	        current_time = $realtime ;

	if(past_state  == 0)
		begin
			if((current_time - last_pos_CLK) < `tDH - 0.001)
				begin
                                  	$display("Warning: tDH violation at %t ns", $time);
				end
		end


	end



/////////////////////////////
//// 	Timing Check     ////
/////////////////////////////
    specify
        specparam   t_KC  = `tCYC,     				// Clock Cycle Time
                    t_KH  = `tCH,   				// Clock High Time
                    t_KL  = `tCL,				// Clock Low Time
                    t_AS  = `tAS,  				// Address Setup Time
                    t_AH  = `tAH,                            	// Address Hold Time
                    t_DS  = `tDS, 				// Data-In Setup Time
                    t_DH  = `tDH,                               // Data-In Hold Time
                    t_advS  = `tADVS,				// ADV Setup Time
                    t_advH  = `tADVH,                        	// ADV Hold Time
                    t_WS  = `tWS,				// Write or Byte Write Signal Setup Time
                    t_WH  = `tWH,                            	// Write or Byte Write Signal Hold Time
                    t_ES1  = `tCSS,				// Chip enable Signal Setup Time
                    t_EH1  = `tCSH,                            	// Chip enable Signal Hold Time
                    t_ES2  = `tCSS,				// Chip enable Signal Setup Time
                    t_EH2  = `tCSH,                            	// Chip enable Signal Hold Time
                    t_CKES  = `tCES,				// Clock enable Signal Setup Time
                    t_CKEH  = `tCEH;                          	// Clock enable Signal Hold Time

        $width      ( posedge CLK, t_KH );                    	// Check Ck Width
        $width      ( negedge CLK, t_KL );
        $period     ( posedge CLK, t_KC );                    	// Check Ck Period
        $setuphold  ( posedge CLK, ADV,   t_advS, t_advH );    	// Check ADV Setup/Hold Time
        $setuphold  ( posedge CLK, WEb,   t_WS, t_WH );     	// Check RW#  Setup/Hold Time
        $setuphold  ( posedge CLK, Bwa_n, t_WS, t_WH );     	// Check BWa# Setup/Hold Time
        $setuphold  ( posedge CLK, Bwb_n, t_WS, t_WH );    	// Check BWb# Setup/Hold Time
        $setuphold  ( posedge CLK, Addr,  t_AS, t_AH );    	// Check Addr Setup/Hold Time
        $setuphold  ( posedge CLK, CKEb,  t_CKES, t_CKEH );    	// Check CKEb Setup/Hold Time
        $setuphold  ( posedge CLK, CS1b,  t_ES1, t_EH1 );    	// Check CSb  Setup/Hold Time
        $setuphold  ( posedge CLK, CS2b,  t_ES2, t_EH2 );    	// Check CSb  Setup/Hold Time
        $setuphold  ( posedge CLK, CS2,   t_ES2, t_EH2 );    	// Check CSb  Setup/Hold Time

    endspecify

endmodule
