//
//	File Name: K7D163671M.v
//	Version  : Rev 0.1
//	JAN  31 2002
//
//	Description: ( 16Mb X36  DDR SRAM ) 
//

`timescale 1ns / 100ps

`ifdef hc40
     `define     tKHKH   2.5     // Min - Cycle time
     `define     tKHKL   1.1     // Min - Clock high pulse width
     `define     tKLKH   1.1     // Min - Clock low pulse width
     `define     tCHCL   `tKHKL - 0.1    // Max - Clock High to Echo Clock High
     `define     tCLCH   `tKLKH - 0.1    // Max - Clock High to Echo Clock High
     `define     tKXCH   0.5     // Min - Echo to Clock High
     `define     tKXCL   0.5     // Min - Echo to Clock Low
     `define     tCHQV   0.1     // Max - Echo Clock to Output Valid 
     `define     tCLQV   0.1     // Max - Echo Clock to Output Valid 
     `define     tCHQX  -0.15    // Min - Echo Clock to Output Hold  
     `define     tCLQX  -0.15    // Min - Echo Clock to Output Hold  
     `define     tCHQZ   0.1     // Max - Echo Clock to Output High-Z
     `define     tCLQZ   0.1     // Max - Echo Clock to Output High-Z
     `define     tGLQX   0.5     // Min - G bar Low to Output Low-Z
     `define     tGHQZ   1.6     // Max - G bar Low to Output High-Z
     `define     tGHQX   1.6     // Max - G bar Low to Output High-Z
     `define     tGLQV   1.6     // Max - G bar Low to Output Valid 
     `define     tAVKH   0.4     // Min - Address setup Time
     `define     tKHAX   0.4     // Min - Address hold Time
     `define     tBVKH   0.4     // Min - Burst control setup Time
     `define     tKHBX   0.3     // Min - Burst control hold Time
     `define     tDVKH   0.25    // Min - Data setup to Clock High
     `define     tKHDX   0.25    // Min - Data Hold to Clock High
`endif

`ifdef hc33
     `define     tKHKH   3.0     // Min - Cycle time
     `define     tKHKL   1.3     // Min - Clock high pulse width
     `define     tKLKH   1.3     // Min - Clock low pulse width
     `define     tCHCL   `tKHKL - 0.1    // Max - Clock High to Echo Clock High
     `define     tCLCH   `tKLKH - 0.1    // Max - Clock High to Echo Clock High
     `define     tKXCH   0.5     // Min - Echo to Clock High
     `define     tKXCL   0.5     // Min - Echo to Clock Low
     `define     tCHQV   0.1     // Max - Echo Clock to Output Valid 
     `define     tCLQV   0.1     // Max - Echo Clock to Output Valid 
     `define     tCHQX  -0.25    // Min - Echo Clock to Output Hold  
     `define     tCLQX  -0.25    // Min - Echo Clock to Output Hold  
     `define     tCHQZ   0.1     // Max - Echo Clock to Output High-Z
     `define     tCLQZ   0.1     // Max - Echo Clock to Output High-Z
     `define     tGLQX   0.5     // Min - G bar Low to Output Low-Z
     `define     tGHQZ   1.7     // Max - G bar Low to Output High-Z
     `define     tGLQV   1.7     // Max - G bar Low to Output Valid 
     `define     tAVKH   0.4     // Min - Address setup Time
     `define     tKHAX   0.4     // Min - Address hold Time
     `define     tBVKH   0.4     // Min - Burst control setup Time
     `define     tKHBX   0.3     // Min - Burst control hold Time
     `define     tDVKH   0.25    // Min - Data setup to Clock High
     `define     tKHDX   0.25    // Min - Data Hold to Clock High
`endif

`ifdef hc30
     `define     tKHKH   3.3     // Min - Cycle time
     `define     tKHKL   1.5     // Min - Clock high pulse width
     `define     tKLKH   1.5     // Min - Clock low pulse width
     `define     tCHCL   `tKHKL - 0.2    // Max - Clock High to Echo Clock High
     `define     tCLCH   `tKLKH - 0.2    // Max - Clock High to Echo Clock High
     `define     tKXCH   0.5     // Min - Echo to Clock High
     `define     tKXCL   0.5     // Min - Echo to Clock Low
     `define     tCHQV   0.1     // Max - Echo Clock to Output Valid 
     `define     tCLQV   0.1     // Max - Echo Clock to Output Valid 
     `define     tCHQX  -0.30    // Min - Echo Clock to Output Hold  
     `define     tCLQX  -0.30    // Min - Echo Clock to Output Hold  
     `define     tCHQZ   0.1     // Max - Echo Clock to Output High-Z
     `define     tCLQZ   0.1     // Max - Echo Clock to Output High-Z
     `define     tGLQX   0.5     // Min - G bar Low to Output Low-Z
     `define     tGHQZ   1.9     // Max - G bar Low to Output High-Z
     `define     tGLQV   1.9     // Max - G bar Low to Output Valid 
     `define     tAVKH   0.4     // Min - Address setup Time
     `define     tKHAX   0.4     // Min - Address hold Time
     `define     tBVKH   0.4     // Min - Burst control setup Time
     `define     tKHBX   0.3     // Min - Burst control hold Time
     `define     tDVKH   0.30    // Min - Data setup to Clock High
     `define     tKHDX   0.30    // Min - Data Hold to Clock High
`endif

     `define     addr_bits  19   // Address is 17 bits + 2bit(Burst count)
     `define     data_bits  36   //  36 I/O bits
     `define     pipe_state 36   //  36 pipeline state number
     `define     VDD     1       // TRUE  ==  VDD == VDDQ == 1
     `define     VDDQ    1       // TRUE  ==  VDD == VDDQ == 1
     `define     VSS     0       // FAULE ==  VSS == VSSQ == 1
     `define     VSSQ    0       // FAULE ==  VSS == VSSQ == 1


module K7D163671M ( Dq, Addr, K, Kb, CQ, CQb,
	   	  B1, B2, B3,   
    	   	  LBOb, Gb ); 

parameter mem_sizes = 512*1024 - 1 ;                        // 512K

inout   [(`data_bits - 1) : 0] Dq;                          // Data I/O
input   [(`addr_bits - 1) : 0] Addr;                        // Address

input  K;                                                 // Clock
input  Kb;                                                // Clock bar

input   B1;                                                // control signal B1  
input   B2;                                                // control signal B2  
input   B3;                                                // control signal B3  

output  CQb ;                                                // Output clock
output  CQ ;                                                 // Output clock
input   Gb;                                                 // Output control
input   LBOb;                                               // Burst Mode control signal

reg     CLK;    					      // internal  CLK
wire [(`data_bits - 1) : 0] Dq;                               // Data I/O  inout is connected by wire
wire [(`data_bits - 1) : 0] DQ;                               // Data I/O  inout is connected by wire
reg  [(`data_bits - 1) : 0] read_temp;                       // Data I/O  inout is connected by wire

reg     [`data_bits -1 : 0] mem [ 0 : mem_sizes ];           // common IO = 36 , 512k

reg     out_con;    					      // echo clk2b
reg     Gb_flag;    					      // echo clk2b
reg     cq_reg;    					      // echo clk
reg     cqb_reg;    					      // echo clk2b

reg     [(`addr_bits - 1) : 0] addr_buf;                      // Addr Register
reg     [(`data_bits - 1) : 0] data_buf;                      // Data Register
reg     [(`data_bits - 1) : 0] dout;                          // Dq Register
reg     [(`data_bits - 1) : 0] dout_temp;                     // Dq Register TEMP

reg     [(`addr_bits - 1) : 0] last1_add;                      // Addr @ before 2 cycle
reg     [(`addr_bits - 1) : 0] last_add;                      // Addr @ before 2 cycle
reg     [(`addr_bits - 1) : 0] past_add;                      // Addr @ before 1 cycle
reg     [(`addr_bits - 1) : 0] now_add;                       // Addr @ present cycle

reg     tmp_data;                      // Data @ temp data Register
reg     pos_data;                      // Data @ temp data Register
reg     neg_data;                      // Data @ temp data Register

wire    gb;	    					      // Chip select signal

reg     lbob;	    					      // Chip select signal
reg     lbob_state[`pipe_state:0];	    		      // Chip select signal
reg     last1_lbob ;    	       		              // LAST STATE before 2 cycle@ Read or Write
reg     last_lbob ;    	        		              // LAST STATE @ Read or Write
reg     past_lbob ;    	        		              // PAST STATE @ Read or Write
reg     now_lbob ; 		     	               	      // NOW STATE @ Read or Write

reg     b1;          	                                      // B1 reg using internal operation 
reg     b2;          	                                      // B2 reg using internal operation 
reg     b3;          	                                      // B3 reg using internal operation 

reg     now_b1;          	                              // now B1 reg state 
reg     now_b2;          	                              // now B2 reg state 
reg     now_b3;          	                              // now B3 reg state 

reg     past_b1;          	                              // past B1 reg state 
reg     past_b2;          	                              // past B2 reg state 
reg     past_b3;          	                              // past B3 reg state 

reg     [(`addr_bits - 3) : 0] rburst_add;                      // Addr Register
reg     [(`addr_bits - 3) : 0] wburst_add;                      // Addr Register
reg     n ; 			                     // Addr Register
reg     [1 : 0] bcnt;                                    // 4 Burst Counter(1 ~ 4)
reg     Operation ;                                      // Operation mode registor
reg     single_R  ;                                      // Single Read Operation mode 
reg     single_W  ;                                      // Single Write Operation mode
reg     DDR_R  ;                                         // DDR Read Operation mode 
reg     DDR_W  ;                                         // DDR Write Operation mode
reg     SDR_R  ;                                         // DDR Read Operation mode 
reg     SDR_W  ;                                         // DDR Write Operation mode
reg     DDR_R_burst  ;                                         // DDR Read Operation mode 
reg     DDR_W_burst  ;                                         // DDR Write Operation mode
                                                          
real    pos_gb ;
real    neg_gb ;
real    current_time ;
integer t ;		                                      
reg Dq_flag ;		                                  


//==============================================================================================//

///////////////////////////////////
// 	Initialize Variables     //
///////////////////////////////////

initial 
begin
	//CLK = 1'b0      ;
	CLK = K      ;
	Dq_flag = 0 ; 
	t = 0      ;
	dout     = {`data_bits{1'bz}}  ;
	data_buf = {`data_bits{1'bz}}  ;
	read_temp = {`data_bits{1'bz}}  ;
        bcnt     = 2'b0   ; 
        out_con = 1'b0 ;
	single_R = 1'bz ;
	single_W = 1'bz ;

	b1 = 1'bz ;
	b2 = 1'bz ;
	b3 = 1'bz ;

	now_b1 = 1'bz ;
	now_b2 = 1'bz ;
	now_b3 = 1'bz ;

	past_b1 = 1'bz ;
	past_b2 = 1'bz ;
	past_b3 = 1'bz ;

	addr_buf = {`addr_bits{1'bz}};                      // Addr Register
	last_add = {`addr_bits{1'bz}};                      // Addr @ before 2 cycle
	past_add = {`addr_bits{1'bz}};                      // Addr @ before 1 cycle
	now_add  = {`addr_bits{1'bz}};                       // Addr @ present cycle

	tmp_data = 1'b0    ;                      // Data @ temp data Register
	pos_data = 1'b0    ;                      // Data @ temp data Register
	neg_data = 1'b0    ;                      // Data @ temp data Register
end

assign Dq = out_con ? read_temp : {`data_bits{1'bz}};
assign gb = Gb ;

////////////////////////////////
// Internal Clock Generator  //
///////////////////////////////


always @(posedge K)
	begin
	//	CLK  = ~Kb ; 
		if(Kb==0)
			begin
				CLK  = 1 ; 
			end
		if(Kb==1)
			begin
				CLK  = CLK ; 
			end
	end

always @(negedge K)
	begin
	//	CLK  = ~Kb ; 
		if(Kb==0)
			begin
				CLK  = CLK ; 
			end
		if(Kb==1)
			begin
				CLK  = 0 ; 
			end
	end

always @(posedge Kb)
	begin
	//	CLK  = K ; 
		if(K==0)
			begin
				CLK  = 0 ; 
			end
		if(K==1)
			begin
				CLK  = CLK ; 
			end
	end

always @(negedge Kb)
	begin
	//	CLK  = K ;
		if(K==0)
			begin
				CLK  = CLK ; 
			end
		if(K==1)
			begin
				CLK  = 1 ; 
			end
	end


//////////////////////
// ECHO CLK CONTROL //
//////////////////////

always @(negedge CLK)
	begin
		cq_reg  = #`tKXCH CLK ; 
		cqb_reg  = ~cq_reg ; 
	end
always @(posedge CLK)
	begin
		cq_reg  = #`tKXCH CLK ; 
		cqb_reg  = ~cq_reg ; 
	end

assign CQ = cq_reg ;
assign CQb= cqb_reg ;

////////////////////
//  Gb Control    //
////////////////////

always @(posedge Gb)
        begin
                read_temp <= #`tGHQX {`data_bits{1'bz}} ;
                out_con  <= #`tGHQX 1'b0 ;
                Gb_flag  <= #`tGHQX 1'b1 ;
        end

always @(negedge Gb)
        begin
                Gb_flag  <= #`tGLQV 1'b0 ;
                out_con  <= #`tGLQV 1'b1 ;
     //           read_temp <= #`tGLQV dout ;
        end


//////////////////////
//  Main Function   //
//////////////////////

//--- Decision operation method ---//
always @(posedge CLK) 
	begin
		if( B3==0 )  // DDR
		begin
			Operation = #`tKXCH 0 ;
		end  

		if( B3==1 )  // SDR
		begin
			Operation = #`tKXCH 1 ;
		end  
	end  
//--- The END Decision operation method ---//

//--------------------------------------------------//
//////   CONTROL DATA PIPE LINE  OPERATION      //////
//--------------------------------------------------//


always @(posedge CLK)
	begin
		if(Operation == 0)
		    begin

			past_b1 = now_b1;
			now_b1 = b1;

			past_b2 = now_b2;
			now_b2 = b2;

			past_b3 = now_b3;
			now_b3 = b3;

			last1_add = last_add;             // Addr @ last cycle
			last_add = past_add;              // Addr @ last cycle
               		 past_add = now_add;              // Addr @ past cycle
               		 now_add  = addr_buf;             // Addr @ present cycle

			if(t > 3)
               		 lbob_state[t+1]   = lbob_state[t] ;		  // LBOb @ present cycle

               		 lbob_state[4]   = lbob_state[3] ;                // LBOb @ present cycle

               		 last1_lbob  = last_lbob ;                 // LBOb @ present cycle
               		 lbob_state[3]  = last_lbob ;              // LBOb @ present cycle

               		 last_lbob  = past_lbob ;                  // LBOb @ present cycle
               		 lbob_state[2]  = past_lbob ;              // LBOb @ present cycle

               		 past_lbob  = now_lbob ;           // LBOb @ present cycle
               		 lbob_state[1]  = now_lbob ;               // LBOb @ present cycle

               		 lbob_state[0]  = lbob ;           // LBOb @ present cycle
               		 now_lbob  = lbob ;                // LBOb @ present cycle

		    end

        			b1 = B1;
        			b2 = B2;
        			b3 = B3;
                		lbob  = LBOb ;
				addr_buf  = Addr ;               // Address fetch at Addr Register
				data_buf  = Dq   ;               // Address fetch at Addr Register
	end

always @(negedge CLK)
	begin
			past_b1 = now_b1;
			now_b1 = b1;

			past_b2 = now_b2;
			now_b2 = b2;

			past_b3 = now_b3;
			now_b3 = b3;

			last1_add = last_add;             // Addr @ last cycle
			last_add = past_add;              // Addr @ last cycle
               		 past_add = now_add;              // Addr @ past cycle
               		 now_add  = addr_buf;             // Addr @ present cycle

			if(t > 3)
               		 lbob_state[t+1]   = lbob_state[t] ;		  // LBOb @ present cycle

               		 lbob_state[4]   = lbob_state[3] ;                // LBOb @ present cycle

               		 last1_lbob  = last_lbob ;                 // LBOb @ present cycle
               		 lbob_state[3]  = last_lbob ;              // LBOb @ present cycle

               		 last_lbob  = past_lbob ;                  // LBOb @ present cycle
               		 lbob_state[2]  = past_lbob ;              // LBOb @ present cycle

               		 past_lbob  = now_lbob ;           // LBOb @ present cycle
               		 lbob_state[1]  = now_lbob ;               // LBOb @ present cycle

               		 lbob_state[0]  = lbob ;           // LBOb @ present cycle
               		 now_lbob  = lbob ;                // LBOb @ present cycle

	end


//-------------------------------//
//////    DDR OPERATION     //////
//-------------------------------//

		//------  Write Logic  ------//

always @(posedge CLK or negedge CLK) 
	begin

  #0.001 ;
	if((past_b1==0 )&&(past_b2 ==0)&&(Operation ==0)&&(CLK==1))   // Single Write in DDR operation
                begin
//		$display("DDR POS Write");
		    SDR_W <=  1'b0 ;
		    SDR_R <=  1'b0 ;
                    out_con = 0 ;
                    t = 0               ;         //   Burst or Continue
                    bcnt =  past_add[1:0] ;    // A1, A0 is used burst count start address
                    n = bcnt[0] ;               // LBOB control register
                    wburst_add = past_add >> 2 ;   // value of A1, A0 is "00"

                    mem[{wburst_add,bcnt}] = Dq ;

                    t = 1               ;         //   Burst or Continue
                    out_con = 1 ;
                    tmp_data = 0 ;
		    DDR_W =  1 ;
                end

	if((DDR_W == 1 )&&(CLK==0))   // negative edge DDR Write
                begin
//		$display("DDR NEG Write");
                    tmp_data = 0 ;
		    single_W =  1 ;
		    single_R =  0 ;
                    out_con = 0 ;

               	    t = t + 1		    ; 	      //   Burst or Continue

		    if ((n==1)&&(lbob_state[t]==1))
                	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
		    else
                 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue

                    mem[{wburst_add,bcnt}] = Dq ;

                    out_con = 1 ;
		    DDR_W =  0 ;
                end

		//---  Write Burst Logic  ---//
       	if((CLK == 1)&&(single_W== 1)&&( now_b2==1)&&( now_b1==1))  // Write Burst in DDR operation
	            begin
//		$display("DDR POS BURST Write");
//			#0.01 ;
                        tmp_data = 0 ;
		        single_W =  0 ;
		        single_R =  0 ;
			out_con =0 ;

               		t = t + 1		    ; 	      //   Burst or Continue

			if ((n==1)&&(lbob_state[t]==1))
                	 	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
			else
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue

                        mem[{wburst_add,bcnt}] = Dq ;

			out_con =1 ;
			DDR_W_burst = 1 ;
        	     end

		//---  Negative edge Write Burst Logic  ---//
       	if((CLK == 0)&&( DDR_W_burst == 1 ))  // Write Burst in DDR operation
	            begin
//		$display("DDR NEG BURST Write");
                        tmp_data = 0 ;
		        single_W =  0 ;
		        single_R =  0 ;
			out_con =0 ;

               		t = t + 1		    ; 	      //   Burst or Continue

			if ((n==1)&&(lbob_state[t]==1))
                	 	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
			else
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue

                        mem[{wburst_add,bcnt}] = Dq ;

			out_con =1 ;
			DDR_W_burst = 0 ;
        	     end
                   //-- Write Logic END --//
	end



		//-------------------//
		//---  Read Logic ---//
		//-------------------//

always @(CLK ) 
	begin
        	if((CLK == 1)&&(now_b1==0)&&(now_b2==1)&&(Operation==0)) //Single Read
	          begin
//		$display("DDR POS READ" );
	            #0.001;
		    SDR_W <=  1'b0 ;
		    SDR_R <=  1'b0 ;
		    t =0 ;
		    DDR_R = 1 ;
		    bcnt = now_add[1:0] ;    // A1, A0 is used burst count start address
                    rburst_add = now_add >> 2 ;   // value of A1, A0 is "00"
                    dout = mem[{rburst_add, bcnt}] ;
	  	    //out_con <= #(`tKXCH + `tCHQV ) 1'b1 ;
                    tmp_data  <= #(`tKXCH + `tCHQV) 1'b1;

		//     if (Gb_flag == 0)
	                begin
				Gb_flag <= 1'b0 ;
                              	read_temp <= #(`tKXCH + `tCHQV) dout ;
//---  aaa
                        end 

                    read_temp <= #(`tKXCH + `tCHQV + (`tKHKH/2 - `tCHQV + `tCHQX)) {`data_bits{1'bz}};
		    tmp_data<= #(`tKXCH + `tCHQV + (`tKHKH/2 - `tCHQV + `tCHQX)) 1'b0 ;
		    t = 1 ;
                  end

        	if((CLK==0)&&(DDR_R==1)) //Single Read negative edge
	               begin
//		$display("DDR NEG READ ");
			single_W =  0 ;
			single_R =  1 ;
			DDR_R = 0 ;

			if ((n==1)&&(lbob_state[t]==1))
                	 	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
			else
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue

                	 	dout = mem[{rburst_add, bcnt}] ;
                               	tmp_data  <= #(`tKXCH + `tCHQV) 1'b1;
				//out_con <= #(`tKXCH + `tCHQV ) 1'b1 ;

//				if (Gb_flag == 0)
	                 	begin
                                	read_temp <= #(`tKXCH + `tCHQV) dout ;
                        	end 

                    		read_temp <= #(`tKXCH + `tCHQV + (`tKHKH/2 - `tCHQV + `tCHQX)) {`data_bits{1'bz}};
		    		tmp_data<= #(`tKXCH + `tCHQV + (`tKHKH/2 - `tCHQV + `tCHQX)) 1'b0 ;
                         end


        	if((CLK == 1)&&(Operation==0)&&(single_R==1)&&(now_b1==1)&&(now_b2==1))   // Read Burst
	                 begin
//		$display("DDR POS BURST READ" );
	                 #0.01;
				single_W =  0 ;
				single_R =  0 ;
				t = t + 1 ;

			if ((n==1)&&(lbob_state[t]==1))
                	 	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
			else
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue

                	 	dout = mem[{rburst_add, bcnt}] ;
                               	tmp_data  <= #(`tKXCH + `tCHQV) 1'b1;
				//out_con <= #(`tKXCH + `tCHQV ) 1'b1 ;

//				if (Gb_flag == 0)
	                 	begin
                                	read_temp <= #(`tKXCH + `tCHQV) dout;
                        	end 

                               	read_temp <= #(`tKXCH + `tCHQV + (`tKHKH/2 - `tCHQV + `tCHQX)) {`data_bits{1'bz}};
		    		tmp_data<= #(`tKXCH + `tCHQV + (`tKHKH/2 - `tCHQV + `tCHQX)) 1'b0 ;
                	 	DDR_R_burst = 1 ;  		//   Burst or Continue
        	         end


        	if((CLK == 0)&&(DDR_R_burst ==1))   // Read Burst
	                 begin
//		$display("DDR NEG BURST READ" );
                	 	DDR_R_burst = 0 ;  		//   Burst or Continue

				t = t + 1 ;

			if ((n==1)&&(lbob_state[t]==1))
                	 	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
			else
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue

                	 	dout = mem[{rburst_add, bcnt}] ;
                               	tmp_data  <= #(`tKXCH + `tCHQV) 1'b1;
				//out_con <= #(`tKXCH + `tCHQV ) 1'b1 ;

//				if (Gb_flag == 0)
	                 	begin
                                	read_temp <= #(`tKXCH + `tCHQV) dout;
                        	end 

                               	read_temp <= #(`tKXCH + `tCHQV + (`tKHKH/2 - `tCHQV + `tCHQX)) {`data_bits{1'bz}};
		    		tmp_data<= #(`tKXCH + `tCHQV + (`tKHKH/2 - `tCHQV + `tCHQX)) 1'b0 ;
                	 	t = t + 1		    ; 	      //   Burst or Continue
                	 	if( t >= 4 )
					t = 1 ;
        	         end
    	end
////-------------- DDR OPERATION  END ---------------////



//------------------------------//
/////    SDR OPERATION     //////
//----------------------------//


		//------ SDR  Write Logic  ------//

always @(posedge CLK) 
	begin
#0.01;
	if(( now_b1==0 )&&(now_b2 ==0)&&(Operation ==1))   // Single Write
                begin
//		$display("SDR POS WRITE ");
                    tmp_data = 0 ;
		    SDR_W =  1 ;
		    SDR_R =  0 ;
                    out_con = 0 ;
                    t = 0               ;         //   Burst or Continue
                    bcnt =   now_add[1:0] ;    // A1, A0 is used burst count start address
                    n = bcnt[0] ;               // LBOB control register
                    wburst_add =  now_add >> 2 ;   // value of A1, A0 is "00"

                    mem[{wburst_add,bcnt}] = data_buf ;

                    t = 1               ;         //   Burst or Continue
                    out_con = 1 ;
		    single_R <=  1'b0 ;
                end


		//---  Write Burst Logic  ---//
       	if(( Operation ==1 )&&(SDR_W== 1)&&(now_b2==1)&&(now_b1==1))  // Write Burst
	            begin
//		$display("SDR POS BURST WRITE ");
			out_con =0 ;
                        tmp_data = 0 ;

			if ((n==1)&&(lbob_state[t]==1))
                	 	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
			else
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue

                        mem[{wburst_add,bcnt}] = data_buf ;

               		t = t + 1		    ; 	      //   Burst or Continue
                        read_temp = {`data_bits{1'bz}} ;
			out_con =1 ;
        	     end
                   //-- Write Logic END --//



		//-------------------//
		//---  Read Logic ---//
		//-------------------//

        	if((now_b1==0)&&(now_b2==1)&&(Operation==1)) //Single Read
	                 begin
//		$display("SDR POS READ ");
				t =0 ;
				bcnt = now_add[1:0] ;    // A1, A0 is used burst count start address
                                rburst_add = now_add >> 2 ;   // value of A1, A0 is "00"
                	 	dout = mem[{rburst_add, bcnt}] ;
                               	tmp_data  <= #(`tKXCH + `tCHQV) 1'b1;
				//out_con <= #(`tKXCH + `tCHQV ) 1'b1 ;

//		$display("Gb Warning:SDR READ Gb = %b at %d ns",Gb, $time);

		  //   if (Gb_flag == 0)
	                begin
                               	read_temp <= #(`tKXCH + `tCHQV) dout;
                        end 
				read_temp <= #(`tKXCH +`tCHQX + `tKHKH ) {`data_bits{1'bz}} ;
				tmp_data<=  #(`tKXCH +`tCHQX + `tKHKH ) 1'b0 ;
				t =1 ;
				SDR_R =  1 ;
				SDR_W =  0 ;
                         end

        	if((Operation==1)&&(SDR_R==1)&&(now_b1==1)&&(now_b2==1))   // Read Burst
	                 begin
//		$display("SDR POS BURST READ ");

			if ((n==1)&&(lbob_state[t]==1))
	                 begin
                	 	bcnt = bcnt + 3		    ; 	      //   Burst or Continue
	                 end
			else
	                 begin
                	 	bcnt = bcnt + 1		    ; 	      //   Burst or Continue
	                 end

                	 	dout = mem[{rburst_add, bcnt}] ;
                               	tmp_data  <= #(`tKXCH + `tCHQV) 1'b1;

//		$display("Gb Warning:SDR READ BURST Gb = %d at %d ns", Gb, $time);

		    // if (Gb_flag == 0)
	                begin
                               	read_temp <= #(`tKXCH + `tCHQV) dout;
                        end 
				read_temp <= #(`tKXCH +`tCHQX + `tKHKH ) {`data_bits{1'bz}} ;
				tmp_data<=  #(`tKXCH +`tCHQX + `tKHKH ) 1'b0 ;
                	 	t = t + 1		    ; 	      //   Burst or Continue
        	         end
    	end
	
////-------------- SDR OPERATION  END ---------------////


always @(negedge out_con)
	begin
		dout = {`data_bits{1'bz}} ;
		read_temp =  dout  ;

	end

////-----------  DQ Setup/Hold timmin Check  --------////

always @(Dq)
	begin
		if((Dq >= 0)&&(tmp_data==0))
		   begin
			Dq_flag = 1 ;
		   end
		else
		   begin
			Dq_flag = 0 ;
		   end
	end

always @(posedge Dq_flag)
	begin
		current_time = $realtime ;

	 if(CLK == 0)
		begin
	 		pos_data = 1 ;
		end

	 if(CLK == 1)
		begin
	 		neg_data = 1 ;
		end
	 if(gb == 0)
		begin
		if((current_time - neg_gb) < `tGLQV)
			begin
				$display("Warning: tGLQV violation at %d ns", $time);
			end
		end
	end

always @(negedge Dq_flag)
	begin
		current_time = $realtime ;

	 if(CLK == 1)
		begin
	 		pos_data = 0 ;
		end

	 if(CLK == 0)
		begin
	 		neg_data = 0 ;
		end

	 if(gb == 1)
		begin
		if((current_time - pos_gb) < `tGHQZ)
			begin
				$display("Warning: tGHQZ violation at %d ns", $time);
			end
		end
	end


///////////////////////////////////////
//// 	/G control Timing Check   ////
/////////////////////////////////////

always @(posedge gb)
	begin
		pos_gb = $realtime ;
	end

always @(negedge gb)
	begin
		neg_gb = $realtime ;
	end

/////////////////////////////
//// 	Timing Check     ////
/////////////////////////////
    specify
        specparam   t_KC  = `tKHKH,    				// Clock Cycle Time
                    t_KH  = `tKHKL,   				// Clock High Time
                    t_KL  = `tKLKH,				// Clock Low Time
                    t_AS  = `tAVKH,  				// Address Setup Time
                    t_AH  = `tKHAX,                            	// Address Hold Time
                    t_DS  = `tDVKH, 				// Data-In Setup Time
                    t_DH  = `tKHDX,                             // Data-In Hold Time
                    t_BS   = `tBVKH,				// Chip control Signal Setup Time
                    t_BH  = `tKHBX;                            	// Chip control Signal Hold Time

        $width      ( posedge CLK, t_KH );                    	// Check Ck Width
        $width      ( negedge CLK, t_KL );
        $period     ( posedge CLK, t_KC );                    	// Check Ck Period
        $setuphold  ( posedge CLK, B1, t_BS, t_BH );     		// Check B Setup/Hold Time
        $setuphold  ( posedge CLK, B2, t_BS, t_BH );     		// Check B Setup/Hold Time
        $setuphold  ( posedge CLK, B3, t_BS, t_BH );     		// Check B Setup/Hold Time
        $setuphold  ( posedge CLK, Addr,  t_AS, t_AH );    	// Check Addr Setup/Hold Time
        $setuphold  ( posedge CLK, pos_data,  t_DS, t_DH );    	// Check Addr Setup/Hold Time
        $setuphold  ( negedge CLK, neg_data,  t_DS, t_DH );    	// Check Addr Setup/Hold Time

    endspecify

endmodule
