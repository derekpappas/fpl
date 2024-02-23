//****************************************************************************************************************************
//  K9F5608U0C, K9F5608Q0C --   256Mbit(x8) 4rd Generation (C-die) Nand Flash Verilog Modeling.
//  NOTICE:
//   - This is a Verilog for NAND Flash in  CSP (TBGA , MCP)    
//   - This verilog don't supply the sequential row read operation. so, you have to address with three address cycles
//     whenever you read pages.
//   - During the R/B pin is BUSY in read mode, the /CE pin is don't care for tR.
//  Programmed By Samsung Semiconductor Co. LTD.  
//  Date   : January 27, 2004
//****************************************************************************************************************************

`timescale    1ns / 10ps
 
// A.C spec

//`define V18_OPTION 1
`ifdef V18_OPTION	//1.8V Part device case

`define tCLS    0	// CLE Setup Time
`define tCLH    10      // CLE Hold Time
`define tCS     0       // /CE Setup Time
`define tCH     10      // /CE Hold Time
`define tALS    0       // ALE Setup Time
`define tALH    10      // ALE Hold Time
`define tDS     20      // Data Setup Time1
`define tDH     10      // Data Hold Time2
`define tWP     25      // /WE Pulse Width
`define tWH     15      // /WE High Hold Time
`define tWC     45      // Write Cycle Time
`define tR  	10000  	// Data Transfer form Cell to Register
`define tCR 	100	// /CE to /RE Delay(ID read)
`define tRR 	20 	// Ready to /RE Low
`define tRP 	25 	// /RE Pulse Width 
`define tWB 	40	// /WE High to Busy(100)
`define tRC 	50	// Read  Cycle Time 
`define tREA	35	// /RE Access Time
`define tCEA    45      // /CE Access Time
`define tRHZ	30	// /RE High to Output Hi-z
`define tCHZ	20	// /CE High to Output Hi-z
`define tREH	15	// /RE High Hold Time
`define tIR	0 	// Output Hi-Z to /RE Low
`define tRB	100	// Last RE High to Busy(at sequential read)
`define tCEH	100	// /CE high Hold Time(at the last serial read)
`define tRSTO	35 	// /RE Low to Status Output
`define tCSTO	45 	// /CE Low to Status Output
`define tWHR1 	60 	// /WE High to /RE Low
`define tWHR2 	100 	// /WE High to /RE Low in Block Lock Mode
`define tREAID	35 	// /RE access time(Read ID)
`define tRST_R	5000	// Device Reset Time(Read) 
`define tRST_P	10000	// Device Reset Time(Program) 
`define tRST_E	500000	// Device Reset Time(Erase) 
`define tPROG	200000	// Program Time
`define tBERS	2000000	// Erase Time

`else
		//3.3V part device case

`define tCLS    0	// CLE Setup Time
`define tCLH    10      // CLE Hold Time
`define tCS     0       // /CE Setup Time
`define tCH     10      // /CE Hold Time
`define tALS    0       // ALE Setup Time
`define tALH    10      // ALE Hold Time
`define tDS     20      // Data Setup Time1
`define tDH     10      // Data Hold Time2
`define tWP     25      // /WE Pulse Width
`define tWH     15      // /WE High Hold Time
`define tWC     45      // Write Cycle Time
`define tR  	10000  	// Data Transfer form Cell to Register
`define tCR 	100	// /CE to /RE Delay(ID read)
`define tRR 	20 	// Ready to /RE Low
`define tRP 	25 	// /RE Pulse Width 
`define tWB 	40	// /WE High to Busy(100)
`define tRC 	50	// Read  Cycle Time 
`define tREA	30	// /RE Access Time
`define tCEA    45      // /CE Access Time
`define tRHZ	30	// /RE High to Output Hi-z
`define tCHZ	20	// /CE High to Output Hi-z
`define tREH	15	// /RE High Hold Time
`define tIR	0 	// Output Hi-Z to /RE Low
`define tRB	100	// Last RE High to Busy(at sequential read)
`define tCEH	100	// /CE high Hold Time(at the last serial read)
`define tRSTO	35 	// /RE Low to Status Output
`define tCSTO	45 	// /CE Low to Status Output
`define tWHR1 	60 	// /WE High to /RE Low
`define tWHR2 	100 	// /WE High to /RE Low in Block Lock Mode
`define tREAID	35 	// /RE access time(Read ID)
`define tRST_R	5000	// Device Reset Time(Read) 
`define tRST_P	10000	// Device Reset Time(Program) 
`define tRST_E	500000	// Device Reset Time(Erase) 
`define tPROG	200000	// Program Time
`define tBERS	2000000	// Erase Time

`endif


`ifdef V18_OPTION
`define DEVICE_CODE 8'b00110101	//1.8V ID Code : 35h
`else
`define DEVICE_CODE 8'b01110101 //3.3V ID Code : 75h
`endif



module K9F5608X0C(ceb, cle, ale, web, reb, io, wpb, rbb, lockpre);
inout	[7:0]	io;
input		cle, ale; 
input		ceb, web, reb, wpb;
input		lockpre;
output		rbb; 

////`protect
K9F5608X0C_x flash(ceb, cle, ale, web, reb, io, wpb, rbb, lockpre);

endmodule   


// **************************************
// * Main Program 
// **************************************

module	K9F5608X0C_x(ceb, cle, ale, web, reb, io, wpb, rbb, lockpre);
inout	[7:0]	io;
wire	[7:0]	io;
reg	[7:0]	out_reg;
input		cle, ale;
input		ceb, web, reb, wpb;
input		lockpre;
output		rbb;
reg		rbb;


// define parameter of device
parameter	num_page    = 65536;
parameter	page_size   = 528;
parameter 	main_size   = 512;
parameter 	last_page   = page_size*(num_page-1);
parameter	blk_size    = 32;


// define 
`define INITIAL	    0
`define ON          1
`define OFF         0
`define TRUE        1
`define FALSE       0
`define READY       1'b1
`define BUSY        1'b0
`define HIZ         8'bzzzzzzzz
`define SOLID1      8'b11111111
`define SOLID0      8'b00000000
`define MAKER_CODE  8'b11101100


`define H00         8'b00000000
`define H01         8'b00000001
`define H50         8'b01010000
`define H80         8'b10000000
`define H10         8'b00010000
`define H60         8'b01100000
`define HD0         8'b11010000
`define H70         8'b01110000
`define H90         8'b10010000
`define H8A         8'b10001010
`define HFF         8'b11111111
`define ERR         8'bxxxxxxxx
`define IDLE        8'bxxxxxxxx
`define READ        1
`define PROGRAM     2
`define ERASE       3
`define dhlee       50
`define delta       10

`define	T_ADD	    24:0		// number of row & column address bit
`define	T_BYTE      34603007:0	        // number of total byte
`define	WIDTH       7:0			// number of io bit
`define PAGE   	    527:0		// size of total word a one page
`define W_CMD	    7:0			// command(address) width


// define main cell and address
reg	[`WIDTH]    memory[`T_BYTE];    // memory cell array 
reg	[`T_ADD]    faddr;		// flash  address       


// declare register for  din/dout latch  
reg [`WIDTH]    din_reg[`PAGE];
reg [`W_CMD]    stat_reg;
reg [31:0]      tmp;


// declare register for command latch
reg	[`W_CMD]     command;
reg	[`W_CMD]     add_ptr;
reg	[`W_CMD]     com_pre;
reg	[`W_CMD]     com_com;


// declare counter
integer		spare_ad;
integer         fcol_ad;
integer         page_ad;
integer         page_ad_pre;
integer         page_ad_diff;
integer         blk_ad;
integer         cnt;
integer         offset;
integer         i, j, k;
integer         adin;
integer         dinout;
integer         idcount;
integer         dev_mode;



// declare mode register
reg             power ;
reg             ad_valid   ;
reg             com_latch  ;
reg             addr_latch ;
reg             data_latch ;
reg             standby    ;
reg             wprotect   ;
reg             csto_flag  ;
reg             pgm_success;
reg             io_setup;
reg             io_hold;


// declare variable for time check
real	        now; 
real	        ceb_fall ; 
real	        ceb_rise ; 
real	        cle_fall ; 
real	        cle_rise ; 
real	        ale_fall ; 
real	        ale_rise ; 
real	        web_fall ; 
real	        web_fallp; 
real	        web_rise ; 
real	        reb_fall ;
real            reb_fallp ; 
real	        reb_rise ;
real		rbb_fall ; 

// additional status flags
reg	Data_Read;
reg	Read_Mode;
reg	Program_Mode;
reg	Copyback_Mode;
reg	Erase_Mode;
reg	Reset_Mode;

// main active for  Nand Flash
event
	sensing,
	program,
	program1,
	erase,
	reset,
	read,
	read1,
	read2,
	reset_read,
	reset_program,
	reset_erase;


// assigne statment
assign	io[7:0] = out_reg;


// specify
specify
	$setup(io, posedge web, 20, io_setup);
	$hold(posedge web, io, 10, io_hold);
endspecify


// initialize each flag
initial	
begin
	power      = `ON;
	add_ptr    = 8'h00;
	adin       = 0;
	offset     = 0;
	idcount    = 0;
	rbb        = `READY;
	com_pre    = `H00;
	com_com    = `H00;
	pgm_success= `TRUE;

	ad_valid   = `FALSE;
	com_latch  = `FALSE;
	addr_latch = `FALSE;
	data_latch = `FALSE;
	standby    = `FALSE;
	wprotect   = `FALSE;
	csto_flag  = `FALSE;

   	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
   	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	now        = -2000000; 
	ceb_fall   = -2000000; 
	ceb_rise   = -2000000; 
	cle_fall   = -2000000; 
	cle_rise   = -2000000; 
	ale_fall   = -2000000; 
	ale_rise   = -2000000; 
	web_fall   = -2000000; 
	web_rise   = -2000000; 
	reb_fall   = -2000000;
	reb_fallp  = -2000000; 
	reb_rise   = -2000000;
	rbb_fall   = -2000000; 
	io_setup   = 1;
	io_hold    = 1;
	cnt	   = 0;
        
        for (i=0; i < 34603007; i=i+1)
          memory[i] = 8'hff;
        $readmemh ("./External_File.txt", memory);
end

always @( io_setup )
	 $display("Warning : Data Setup violation at %t", $realtime);
always @( io_hold )
	 $display("Warning : Data Hold violation at %t", $realtime);


always @( posedge ceb )
begin
	ceb_rise = $realtime;
    if( power == `ON )
	begin  
		standby = `TRUE;
		if ( ceb_rise - web_rise < `tCH)
	    		$display("Warning : tCH violation at %t", ceb_rise);

		#`tCHZ	out_reg = `HIZ ;
	end
end

always @( negedge ceb )
begin
	ceb_fall = $realtime;
	if( power == `ON )
	begin  
		standby = `FALSE;
		if ( csto_flag == `TRUE )
		begin
			#`tCSTO	out_reg[7:0] = stat_reg;
			csto_flag = `FALSE;
		end
		if ((ceb_fall > reb_fall) && (dev_mode == `READ|| com_com == `H70) && reb == 1'b0 )
		begin
  		 	Data_Read = `FALSE;
   			Read_Mode = `TRUE;
  		 	Program_Mode = `FALSE;
			Copyback_Mode = `FALSE;
   			Erase_Mode = `FALSE;
   			Reset_Mode = `FALSE;

                        -> read;
		end
	end
end


always @( posedge cle && standby == `FALSE )
begin
	cle_rise = $realtime;
	if( power == `ON )
	begin 
		if ( addr_latch == `TRUE )
			if ( cle_rise - web_rise < `tCLH)
				$display("Warning : tCLH violation at %t", cle_rise);
		if ( standby == `FALSE && ale == 1'b0 )
		begin
			com_latch  <= `TRUE;
			data_latch <= `FALSE;
			addr_latch <= `FALSE;
		end
	end
end

always @( negedge cle )
begin
	cle_fall = $realtime;
	if( power == `ON && standby == `FALSE )
	begin  
		if ( cle_fall - web_rise < `tCLH)
			$display("Warning : tCLH violation at %t", cle_fall);
		if ( standby == `FALSE && com_com != `H10 && com_com != `HD0 )
		begin
			if ( ale == 1'b0 )
			begin
				data_latch <= `TRUE;
				com_latch  <= `FALSE;
				addr_latch <= `FALSE;
			end
			if ( ale == 1'b1 && adin <=2 && rbb == `READY )
			begin
				addr_latch <= `TRUE;
				data_latch <= `FALSE;
				com_latch  <= `FALSE;
			end
		end
	end
end

always @( posedge ale )
begin
	ale_rise = $realtime;
	if( power == `ON && standby == `FALSE )
	begin 
		if ( com_latch == `TRUE )
			if ( ale_rise - web_rise < `tALH)
				$display("Warning : tALH violation at %t", ale_rise);

		if ( standby == `FALSE && com_com != `H10 && com_com != `HD0 )
		begin
			if ( cle == 1'b0 && adin <=2 && rbb == `READY )
			begin
				addr_latch <= `TRUE;
				data_latch <= `FALSE;
				com_latch  <= `FALSE;
			end
		end
	end
end


always @( negedge ale ) 
begin
	ale_fall = $realtime;
	if( power == `ON && standby == `FALSE )
	begin 
		if ( ale_fall - web_rise < `tALH)
			$display("Warning : tALH violation at %t", ale_fall);
		if ( standby == `FALSE && com_com != `H10 && com_com != `HD0 )
		begin
			if ( cle == 1'b0 )
			begin
				data_latch <= `TRUE;
				com_latch  <= `FALSE;
				addr_latch <= `FALSE;
			end
			if ( cle == 1'b1 )
			begin
				com_latch  <= `TRUE;
				addr_latch <= `FALSE;
				data_latch <= `FALSE;
			end
		end
	end
end



always @( negedge ale )
begin
        #20
        if ( cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && reb == 1'b1 && data_latch == `TRUE && com_com == `H8A && adin >= 3)
        begin
                if ( ad_valid == `TRUE )
                        Program1;
        end
end




always @( posedge web )
begin
	web_rise = $realtime;
	if( power == `ON )
	begin 
		if ( web_rise - web_fall < `tWP)
			$display("Warning : tWP violation at %t", web_rise);
		if ( web_fall - ceb_fall < `delta )
		begin
			if ( web_rise - web_fall < ( 35 + ceb_fall - web_fall ))
				$display ("ERROR : tWP time must be greater than current tWP at %t", web_rise);
		end   

		if ( cle == 1'b1 && ale == 1'b0 && ceb == 1'b0 && reb == 1'b1 && com_latch == `TRUE )
		begin
			command = io[7:0];
			com_pre = com_com;
			if ( rbb == `READY )
			begin
				case ( command )
					8'b00000000	:begin	com_com  = `H00; add_ptr = `H00; k = 0; 
								faddr[8] = 1'b0;
							 	end

					8'b01010000	:begin	com_com  = `H50; add_ptr = `H50; k = 0; dev_mode = `IDLE;
							 	end

					8'b00000001	:begin	com_com  = `H01; add_ptr = `H01; k = 0; dev_mode = `IDLE;
								faddr[8] = 1'b1;
							 	end

					8'b01100000	:begin	com_com  = `H60; dev_mode = `IDLE; end

					8'b10000000	:begin	com_com  = `H80; dinout = 0; dev_mode = `IDLE; ResetPB; 
							 	end

					8'b10001010     :begin  com_com  = `H8A; dinout = 0; dev_mode = `IDLE; ResetPB;
                                                                end

					8'b01110000	:com_com  = `H70;

					8'b10010000	:begin	com_com  = `H90; idcount = 0; end

					8'b11111111	:com_com  = `HFF;

					8'b00010000	:com_com  = `H10;

					8'b11010000	:com_com  = `HD0;

					default		:com_com  = `ERR;
				endcase
			end

			else if ( rbb == `BUSY )
			begin
				case ( command )
					8'b01110000	:com_com  = `H70;
					8'b11111111	:com_com  = `HFF;
					default		:com_com  = `ERR;
				endcase
			end
			
			if ( com_com != `H10 && com_com != `HD0 && com_com != `H70 && com_com != `HFF )
			begin
				if ( com_com == `H60 )
					adin = 1;
				else if ( com_com == `H90 )
					adin = 2;
				else if ( com_com == `H80 ) 
					adin = 0;
				else if ( com_com == `H8A )
                                        adin = 0;

				else  
					adin = 0;

				faddr = 25'b0000000000000000000000000;
                                if ( add_ptr == `H01 )
                                        faddr[8] = 1'b1;
			end

			if ( com_com == `H80 && wprotect )
			begin
				$display("Write protected: programming setup ignored at %t",$realtime);
				dev_mode = `IDLE;
			end
			else if ( com_com == `H80 && wprotect )
			begin
				$display("Write protected: erasing setup ignored at %t",$realtime);
				dev_mode = `IDLE;
			end

			else if ( com_com == `H8A && wprotect )
                        begin
                                $display("Write protected: erasing setup ignored at %t",$realtime);
                                dev_mode = `IDLE;
                        end

			else if ( com_com == `H10 && rbb == `READY )
			begin
				if ( com_pre != `H80 )
				begin
					$display("Illegal programming, program setup command must be preceded at %t",$realtime);
					pgm_success = `FALSE;
					dev_mode = `IDLE;
				end
				else if ( adin < 3 )
				begin
					$display("Illegal programming, address input must be input more 3 times at %t",$realtime);
					pgm_success = `FALSE;
					dev_mode = `IDLE;
				end
				else if ( wpb != 1'b1 || wprotect == `TRUE )
				begin
					$display("Warning : During programming, WPB must be high at %t",$realtime);
					pgm_success = `FALSE;
					dev_mode = `IDLE;
				end
				else if ( com_pre == `H80 && adin >= 3 && wpb == 1'b1 )
				begin
					Program;
				end
			end
			else if ( com_com == `HD0 && rbb == `READY )
			begin
				if ( com_pre != `H60 )
				begin
					$display("Illegal erasing, erasing setup command must be preceded at %t",$realtime);
					pgm_success = `FALSE;
					dev_mode = `IDLE;
				end
				else if ( adin < 3 )
				begin
					$display("Illegal erasing, address input must be input more 2 times at %t",$realtime);
					pgm_success = `FALSE;
					dev_mode = `IDLE;
				end
				else if ( wpb != 1'b1 || wprotect == `TRUE )
				begin
					$display("Warning : During erasing, WPB must be high at %t",$realtime);
					pgm_success = `FALSE;
					dev_mode = `IDLE;
				end
				else if ( com_pre == `H60 && adin >= 3 && wpb == 1'b1 )
				begin
					Erase;
				end
			end
                        else if ( (com_com == `HFF) && (rbb == `BUSY) )
                        begin
                                if  ( dev_mode == `READ || com_pre == `H00 || com_pre == `H01 || com_pre == `H50 )
                                        ->reset_read;
                                else if ( dev_mode == `PROGRAM  && com_com == `H8A )
                                        ->reset_program;
                                else if ( dev_mode == `ERASE )
                                        ->reset_erase;
                        end

                        else if ( (com_com == `HFF) && (rbb == `READY) )
                        begin
                                        ->reset;
                        end
		end
	
		if ( cle == 1'b0 && ale == 1'b1 && ceb == 1'b0 && reb == 1'b1 && addr_latch == `TRUE )
		begin
			adin = adin + 1;
			if ( adin == 1)
			begin
				CheckAddress;
				faddr[7:0] = io[7:0];
				if ( add_ptr == `H00 && add_ptr == `H50 && add_ptr == `H01)
				begin
					if (rbb == `BUSY)
					begin
						add_ptr  = `H00;
						com_com  = `H00;
						#1 faddr[8] = 1'b0;
						out_reg  = `HIZ;
					end
				end
			end 
			else if ( adin == 2 )
			begin
				CheckAddress;
				faddr[16:9] = io[7:0];
			end
			else if ( adin == 3 )
			begin
				CheckAddress;
				if ( com_com == `H90 )
					faddr[7:0] = io[7:0];
				else
					faddr[24:17] = io[7:0];
				if ( com_com == `H00 || com_com == `H50 || com_com == `H01 )	
				begin
					dev_mode <= `READ;
					Sensing;
				end
			end
		end
		
		else if ( cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && reb == 1'b1 && data_latch == `TRUE && com_com == `H80 && adin >= 3) 
		begin 
			if ( ad_valid == `TRUE )
				if ( dinout < page_size )
				begin
					din_reg[dinout] = io;
					dinout = dinout + 1;
				end
		end
	end
end




always @( negedge web ) 
begin
	web_fallp = web_fall;
	web_fall = $realtime;
	if( power == `ON )
	begin 
		if ( web_fall - ceb_fall < `tCS)
			$display("Warning : tCS violation at %t", web_fall);
	end

	if( power == `ON && standby == `FALSE)
	begin 
		if ( web_fall - web_fallp < `tWC)
			$display("Warning : tWC violation at %t", web_fall);
		if ( web_fall - web_rise < `tWH)
			$display("Warning : tWH violation at %t", web_fall);
		if ( web_fall - ale_rise < `tALS)
			$display("Warning : tALS violation at %t", web_fall);
		if ( web_fall - cle_rise < `tCLS)
			$display("Warning : tCLS violation at %t", web_fall);
		if ( standby == `FALSE && com_com != `H10 && com_com != `HD0 )
		begin
			if ( ceb == 1'b0 && cle == 1'b0 && ale == 1'b1 && reb == 1'b1 && adin <=2 && rbb == `READY )
			begin
				addr_latch <= `TRUE;
				com_latch  <= `FALSE;
				data_latch <= `FALSE;
			end 
			else if ( ceb == 1'b0 && cle == 1'b1 && ale == 1'b0 && reb == 1'b1 )
			begin
				com_latch  <= `TRUE;
				addr_latch <= `FALSE;
				data_latch <= `FALSE;
			end 
			else if ( ceb == 1'b0 && cle == 1'b0 && ale == 1'b0 && reb == 1'b1 )
			begin
				data_latch <= `TRUE;
				com_latch  <= `FALSE;
				addr_latch <= `FALSE;
			end 
		end
	end
end


always @( posedge reb )
begin
	reb_rise = $realtime;
	if( power == `ON && standby == `FALSE)
	begin 
		if ( reb_rise - reb_fall < `tRP)
			$display("Warning : tRP violation at %t", reb_rise);
		#`tRHZ	out_reg = `HIZ;
	end
end

always @( negedge reb )
begin 
	reb_fallp = reb_fall;
	reb_fall = $realtime;
	if (( reb_fall - ceb_fall < `delta ) && ( reb_fall - ceb_fall > 0 ))
                -> read1;

	else if ( reb_fallp == ceb_fall)
		-> read;

        else if ( reb_fall - ceb_fall >= `delta )
                -> read2;	 

end

always @( negedge rbb )
begin
	rbb_fall = $realtime;
end

always @( read )
begin 
  	Data_Read = `FALSE;
   	Read_Mode = `TRUE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	ceb_fall = $realtime;
	if( power == `ON && standby == `FALSE && com_com != `H10 && com_com != `HD0 )
	begin 
		if ( reb_fall - reb_rise < `tREH)
			$display("Warning : tREH violation at %t", reb_fall);
		if ( (com_com == `H00 || com_com == `H01) && cle == 1'b0 && ale == 1'b0 && reb == 1'b0 && web == 1'b1 )
		begin
				out_reg = `HIZ;
			if ( rbb == `BUSY )
	    			$display("Warning : Now Seeking Data. REB is available after RBB is HIGH at %t",$realtime);
			else
			begin
				Check527Byte;
					if ( offset != 527 || page_ad != last_page)
						#`tCEA	out_reg = din_reg[offset];
					if ( offset != 527 )
						cnt = cnt + 1;
/*
					else if ( offset == 527 && page_ad != last_page)
					begin
						@( posedge reb )
						begin
							if (ceb == 1'b0)
							begin
								#`tRHZ	out_reg = `HIZ;
									page_ad = page_ad + page_size;
									fcol_ad = 0;
									add_ptr = `H00;
							end
						end
					end
*/
			end
		end
		if ( com_com == `H50 && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
		begin
				out_reg = `HIZ;
			if ( rbb == `BUSY )
	    			$display("Warning : Now Seeking Data. REB is available after RBB is HIGH at %t",$realtime);
			else
			begin
				Check527Byte;
					if ( offset != 527 || page_ad != last_page)
						#`tCEA	out_reg = din_reg[offset];
					if ( offset != 527 )
						cnt = cnt + 1;
/*
					else if ( offset == 527 && page_ad != last_page)
					begin
						@( posedge reb )
						begin
							if ( ceb == 1'b0 )
							begin
								#`tRHZ	out_reg = `HIZ;
									page_ad = page_ad + page_size;
									fcol_ad = main_size; 
							end
						end
					end
*/
			end
		end
		if ( com_com == `H70 && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
		begin
				out_reg = `HIZ;
			if ( pgm_success == `TRUE )
				stat_reg[0] = 1'b0;
			else
				stat_reg[0] = 1'b1;

			stat_reg[5:1] = 5'b00000;

			if ( rbb == `READY )
				stat_reg[6] = 1'b1;
			else if ( rbb == `BUSY )
				stat_reg[6] = 1'b0;
			if ( wprotect == `TRUE )
				stat_reg[7] = 1'b0;
			else
				stat_reg[7] = 1'b1;
			if ( ceb == 1'b0 )
				#`tCSTO	out_reg[7:0] = stat_reg;
			else 
				csto_flag = `TRUE;
		end
		if ( com_com == `H90 && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
		begin
				out_reg = `HIZ;
			if (idcount%2 == 0) 
			begin
				#`tCSTO	out_reg[7:0] = `MAKER_CODE;
				idcount = idcount + 1;
			end
			else if (idcount%2 == 1) 
			begin
				#`tCSTO	out_reg[7:0] = `DEVICE_CODE;
				idcount = idcount + 1;
			end

		end
	end
end

always @( read1 )
begin
  	Data_Read = `FALSE;
   	Read_Mode = `TRUE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

        reb_fall = $realtime;
        if( power == `ON && standby == `FALSE && com_com != `H10 && com_com != `HD0 )
        begin
                if ( reb_fall - reb_rise < `tREH)
                        $display("Warning : tREH violation at %t", reb_fall);
                if ( (com_com == `H00  || com_com == `H01) && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
                begin
                                out_reg = `HIZ;
                        if ( rbb == `BUSY )
                                $display("Warning : Now Seeking Data. REB is available after RBB is HIGH at %t",$realtime);
                        else
                        begin
                                Check527Byte;
					if ( offset != 527 || page_ad != last_page)
						#(45 + ceb_fall - reb_fall) out_reg = din_reg[offset];
                                        if ( offset != 527 )
                                                cnt = cnt + 1;
/*
                                        else if ( offset == 527 && page_ad != last_page)
                                        begin
                                                @( posedge reb )
                                                begin
                                                        if (ceb == 1'b0)
                                                        begin
                                                                #`tRHZ  out_reg = `HIZ;
                                                                        page_ad = page_ad + page_size;
                                                                        fcol_ad = 0;
                                                                        add_ptr = `H00;
                                                        end
                                                end
                                        end
*/
                        end
                end
                if ( com_com == `H50 && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
                begin
                                out_reg = `HIZ;
                        if ( rbb == `BUSY )
                                $display("Warning : Now Seeking Data. REB is available after RBB is HIGH at %t",$realtime);
                        else
                        begin
                                Check527Byte;
					if ( offset != 527 || page_ad != last_page)
						#(45 + ceb_fall - reb_fall)  out_reg = din_reg[offset];
                                        if ( offset != 527 )
                                                cnt = cnt + 1;
/*
                                        else if ( offset == 527 && page_ad != last_page)
                                        begin
                                                @( posedge reb )
                                                begin
                                                        if ( ceb == 1'b0 )
                                                        begin
                                                                #`tRHZ  out_reg = `HIZ;
                                                                        page_ad = page_ad + page_size;
                                                                        fcol_ad = main_size;
                                                        end
                                                end
                                        end
*/
                        end
                end
                if ( com_com == `H70 && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
		begin
                                out_reg = `HIZ;
                        if ( pgm_success == `TRUE )
                                stat_reg[0] = 1'b0;
                        else
                                stat_reg[0] = 1'b1;

                        stat_reg[5:1] = 5'b00000;

                        if ( rbb == `READY )
                                stat_reg[6] = 1'b1;
                        else if ( rbb == `BUSY )
                                stat_reg[6] = 1'b0;
                        if ( wprotect == `TRUE )
                                stat_reg[7] = 1'b0;
                        else
                                stat_reg[7] = 1'b1;
                        if ( ceb == 1'b0 )
                                #(45 + ceb_fall - reb_fall) out_reg[7:0] = stat_reg;
                        else
                                csto_flag = `TRUE;
                end
                if ( com_com == `H90 && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
                begin
                                out_reg = `HIZ;
                        if (idcount%2 == 0)
                        begin
                                #(45 + ceb_fall - reb_fall)  out_reg = `MAKER_CODE;
                                idcount = idcount + 1;
                        end

                        else if (idcount%2 == 1)
                        begin
                                #(45 + ceb_fall - reb_fall)  out_reg = `DEVICE_CODE;
                                idcount = idcount + 1;
                        end

                end
        end
end

always @( read2 )
begin
  	Data_Read = `FALSE;
   	Read_Mode = `TRUE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

        //reb_fall = $realtime;
        if( power == `ON && standby == `FALSE && com_com != `H10 && com_com != `HD0 )
        begin
                if ( reb_fall - reb_rise < `tREH)
                        $display("Warning : tREH violation at %t", reb_fall);
                if ( (com_com == `H00  || com_com == `H01) && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
                begin
                                out_reg = `HIZ;
                        if ( rbb == `BUSY )
                                $display("Warning : Now Seeking Data. REB is available after RBB is HIGH at %t",$realtime);
                        else
                        begin
                                Check527Byte;
					if ( offset != 527 || page_ad != last_page)
						#`tREA  out_reg = din_reg[offset];
                                        if ( offset != 527 )
                                                cnt = cnt + 1;
/*
                                        else if ( offset == 527 && page_ad != last_page)
                                        begin
                                                @( posedge reb )
                                                begin
                                                        if (ceb == 1'b0)
                                                        begin
                                                                #`tRHZ  out_reg = `HIZ;
                                                                        page_ad = page_ad + page_size;
                                                                        fcol_ad = 0;
                                                                        add_ptr = `H00;
                                                        end
                                                end
                                        end
*/
                        end
                end
                if ( com_com == `H50 && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
                begin
                                out_reg = `HIZ;
                        if ( rbb == `BUSY )
                                $display("Warning : Now Seeking Data. REB is available after RBB is HIGH at %t",$realtime);
                        else
                        begin
                                Check527Byte;
					if ( offset != 527 || page_ad != last_page)
						#`tREA  out_reg = din_reg[offset];
                                        if ( offset != 527 )
                                                cnt = cnt + 1;
/*
                                        else if ( offset == 527 && page_ad != last_page)
                                        begin
                                                @( posedge reb )
                                                begin
                                                        if ( ceb == 1'b0 )
                                                        begin
                                                                #`tRHZ  out_reg = `HIZ;
                                                                        page_ad = page_ad + page_size;
                                                                        fcol_ad = main_size;
                                                        end
                                                end
                                        end
*/
                        end
                end
                if ( com_com == `H70 && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
                begin
                                out_reg = `HIZ;
                        if ( pgm_success == `TRUE )
                                stat_reg[0] = 1'b0;
                        else
                                stat_reg[0] = 1'b1;

                        stat_reg[5:1] = 5'b00000;

                        if ( rbb == `READY )
                                stat_reg[6] = 1'b1;
                        else if ( rbb == `BUSY )
                                stat_reg[6] = 1'b0;
                        if ( wprotect == `TRUE )
                                stat_reg[7] = 1'b0;
                        else
                                stat_reg[7] = 1'b1;
			if ( ceb == 1'b0 )
                                #`tRSTO out_reg[7:0] = stat_reg;
                        else
                                csto_flag = `TRUE;
                end
                if ( com_com == `H90 && cle == 1'b0 && ale == 1'b0 && ceb == 1'b0 && web == 1'b1 )
                begin
                                out_reg = `HIZ;
                        if (idcount%2 == 0)
                        begin
                                #`tRSTO  out_reg = `MAKER_CODE;
                                idcount = idcount + 1;
                        end

                        else if (idcount%2 == 1)
                        begin
                                #`tRSTO  out_reg = `DEVICE_CODE;
                                idcount = idcount + 1;
                        end

                end
        end
end
	
always @( posedge wpb ) 
begin
	if( power == `ON )
	begin  
		wprotect = `FALSE;
		$display("Warning : Write protection released at %t",$realtime);
	end
end



always @( negedge wpb ) 
begin
	if( power == `ON )
	begin
		wprotect = `TRUE;
		$display("Warning : Write protected at %t",$realtime);
		if ( (dev_mode == `PROGRAM) && (rbb == `BUSY) )
		begin
	    	$display("Warning : WPB should be high during programming at %t",$realtime);
			->reset_program;
			SetUnknownData;
		end
		else if ( dev_mode == `ERASE )
		begin
	    	$display("Warning : WPB should be high during erasing at %t",$realtime);
			->reset_erase;
			SetUnknownData;
		end
		else if ( com_com == `H80 )
		begin
	    	$display("Warning : Write protected during program setup at %t",$realtime);
			SetUnknownData;
			dev_mode = `IDLE;
			com_com = `IDLE;
		end
		else if ( com_com == `H60 )
		begin
	    	$display("Warning : Write protected during erase setup at %t",$realtime);
			SetUnknownData;
			dev_mode = `IDLE;
			com_com = `IDLE;
		end
	end
end

always @( posedge rbb ) 
begin
	if( power == `ON )
		out_reg = `HIZ;
end



//********************************
// Cell Program Execution
//********************************

always @( program ) 
begin : pgm
	#1	pgm_success = `FALSE; dev_mode = `PROGRAM;
	#`tWB	rbb = `BUSY;
	#`tPROG	rbb = `READY; 

  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	pgm_success =`TRUE;
	dev_mode = `IDLE;

	if ( wpb != 1'b0 && com_com != `HFF )
	begin
		GetAddr;
		for ( cnt=0; cnt<dinout ; cnt=cnt+1 )
		begin
			Check527Byte;
			if ( offset < page_size )
			begin
				memory[page_ad+offset] = memory[page_ad+offset] & din_reg[cnt];
			end
		end

                if ( add_ptr == `H01 )
                begin
                        add_ptr = `H00;
                     #1   faddr[8] = 1'b0;
                end
	end
end

always @( program1 )
begin : pgm1
        #1      pgm_success = `FALSE; dev_mode = `PROGRAM; offset = 0;
        #`tWB   rbb = `BUSY;
        #`tPROG rbb = `READY;

  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

        pgm_success =`TRUE;
        dev_mode = `IDLE;

        if ( wpb != 1'b0 && com_com != `HFF )
        begin
                page_ad_pre = page_ad;
                GetAddr;
                for ( cnt=0; cnt< page_size ; cnt=cnt+1 )
                begin
                        Check527Byte;
                        if ( offset < page_size )
                        begin
                                if ( page_ad_pre < page_ad )
                                begin
                                        page_ad_diff = page_ad - page_ad_pre;
                                        memory[page_ad+offset] = memory[page_ad+offset-page_ad_diff] & din_reg[cnt];
                                end
                                else if ( page_ad_pre >= page_ad )
                                begin
                                        page_ad_diff = page_ad_pre - page_ad;
                                        memory[page_ad+offset] = memory[page_ad+offset+page_ad_diff] & din_reg[cnt];
                                end
                                else
                                dev_mode = `IDLE;
                        end
                end

                if ( add_ptr == `H01 )
                begin
                        add_ptr = `H00;
                        #1 faddr[8] = 1'b0;
                end
        end
end

//********************************
// Cell Erase Execution
//********************************

always @( erase ) 
begin : era
	#1	pgm_success = `FALSE; dev_mode = `ERASE;
	#`tWB	rbb = `BUSY;
	GetAddr;
	#`tBERS	rbb = `READY; pgm_success =`TRUE;

  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	if ( wpb != 1'b0 && com_com != `HFF )
	begin
		GetAddr;
		for ( i=0; i<blk_size ; i=i+1 )
		begin
			k = i*page_size;
			#5 tmp = blk_ad + k;
			for ( j=0 ; j< page_size ; j=j+1 )
				memory[blk_ad+k+j] = `SOLID1;
		end

                if ( add_ptr == `H01 )
                begin
                        add_ptr = `H00;
                        #1 faddr[8] = 1'b0;
                end
	end
	dev_mode = `IDLE;
end


//********************************
// Cell Sensing  Execution
//********************************

always @( sensing ) 
begin : sens
	#`tWB	rbb = `BUSY;
		dinout = 0; 
		cnt = 0;
		adin = 0;
	#`tR 	rbb = `READY;

  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;


		GetAddr;

	for ( j=0 ; j< page_size ; j=j+1 )
		din_reg[j] = memory[page_ad + j];
end


//********************************
// Reset Execution
//********************************

always @( reset ) 
begin
  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `TRUE;

	dev_mode = `IDLE;
	#0		rbb = `BUSY; 
			out_reg = `HIZ; 
			pgm_success = `TRUE;
	#`tRST_R	rbb = `READY;	

  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	$display("Warning : Reset mode excuted  at %t",$realtime);
end


always @( reset_read ) 
begin
  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `TRUE;

	dev_mode = `IDLE;
	disable	sens;
	#0		rbb = `BUSY; 
			out_reg = `HIZ; 
			pgm_success = `TRUE;
			SetUnknownData;
	#`tRST_R	rbb = `READY;	

  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	$display("Warning : Reset mode excuted in serial read  at %t",$realtime);
end


always @( reset_program ) 
begin
  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `TRUE;

	dev_mode = `IDLE;
	disable	pgm;
	disable	pgm1;
	#0		rbb = `BUSY; 
			out_reg = `HIZ; 
			pgm_success = `TRUE;
			SetUnknownData;
	#`tRST_P	rbb = `READY;	

  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	$display("Warning : Reset mode excuted in program at %t",$realtime);
end


always @( reset_erase ) 
begin
  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `TRUE;

	disable	era;
	#0		rbb = `BUSY; 
			out_reg = `HIZ; 
			pgm_success = `TRUE;
			SetUnknownData;
	#`tRST_E	rbb = `READY;	

  	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
  	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	$display("Warning : Reset mode excuted in erase at %t",$realtime);
end


//********************************
// Page Buffer Reset
//********************************

task ResetPB;
begin
	for ( i=0; i < page_size; i=i+1 )
		din_reg[i] = 8'hff;
end
endtask



//********************************
// Check Address         
//********************************

task CheckAddress;
begin
	ad_valid = `TRUE;

	for( i=0; i < 8; i=i+1 )
	    if ( io[i] != 1'b1 && io[i] != 1'b0)
		begin		
	    	    $display("Warning : Illegal address at %t",$realtime);
		    ad_valid = `FALSE;
		end		
end
endtask


//********************************
// Gets Address         
//********************************

task GetAddr;
begin
 
	ad_valid = `TRUE;
        spare_ad = 0;
        fcol_ad  = 0;
        page_ad  = 0;
        blk_ad   = 0;
 
        for( i=8; i >= 0; i=i-1 )       // get first column address
        begin   
            fcol_ad = fcol_ad * 2; 
            if ( faddr[i] == 1'b1 )
                fcol_ad = fcol_ad+1;
        end
//$display("first colume %d", fcol_ad);
 

        if (add_ptr == `H50 )		// get first column address in read 2 
        begin
            for( i=3; i >= 0; i=i-1 ) 
	    	begin
				spare_ad = spare_ad * 2;
				if ( faddr[i] == 1'b1 )
                	spare_ad = spare_ad+1;
	    		end
        end 
 

        if (ad_valid == `TRUE )			// get page address
        begin
            for( i=13; i >= 9; i=i-1 ) 
	    	begin
			page_ad = page_ad * 2;
				if ( faddr[i] == 1'b1 )
               	    		page_ad = page_ad+1;
	    	end
        end 
 

        if (ad_valid == `TRUE )			// get block address
        begin
            for( i=24; i >= 14; i=i-1 ) 
	    	begin
				blk_ad = blk_ad * 2;
				if ( faddr[i] == 1'b1 )
               	    blk_ad = blk_ad+1;
	    	end
        end 
		

		blk_ad   = blk_ad * blk_size * page_size;
		page_ad  = blk_ad + (page_ad * page_size);
		spare_ad = main_size + spare_ad;
end
endtask


//********************************
// Check 527th Word
//********************************

task Check527Byte;
begin
	if ( add_ptr == `H00 || add_ptr == `H01 )
	    if ( fcol_ad+cnt < page_size ) 
			offset = fcol_ad + cnt;
	    else
			offset = page_size - 1;

	else if ( add_ptr == `H50 )
		if ( spare_ad+cnt < page_size ) 
			offset = spare_ad + cnt;
		else
			offset = page_size - 1;


	if ( dev_mode == `PROGRAM )
	begin
		if ( add_ptr == `H00 || add_ptr == `H01 )
			offset = fcol_ad+cnt;
		if ( add_ptr == `H50 )
			offset = spare_ad+cnt;
	end

end
endtask

task SetUnknownData;
begin
	if (dev_mode == `READ)
	begin
		for ( cnt=0 ; cnt< page_size ; cnt=cnt+1 )
			din_reg[cnt] = 8'bxxxxxxxx;
		fcol_ad = 0;
		cnt = 0;
	end

	if (dev_mode == `PROGRAM)
	begin
		GetAddr;
		for ( cnt=0; cnt<dinout ; cnt=cnt+1 )
		begin
			Check527Byte;
			if ( offset < page_size )
			begin
				memory[page_ad+offset] = 8'bxxxxxxxx;
			end
		end
	end
	if (dev_mode == `ERASE)
	begin
		GetAddr;
		for ( i=0; i<blk_size ; i=i+1 )
		begin
			k = i* page_size;
			for ( j=0 ; j< page_size ; j=j+1 )
				memory[blk_ad+k+j] = 8'bxxxxxxxx;
		end
	end
	
end
endtask

task Program;
begin
   	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
   	Program_Mode = `TRUE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	->program;	
end
endtask

task Program1;
begin
   	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
   	Program_Mode = `FALSE;
	Copyback_Mode = `TRUE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

        ->program1;
end
endtask

task Erase;
begin
   	Data_Read = `FALSE;
   	Read_Mode = `FALSE;
   	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `TRUE;
   	Reset_Mode = `FALSE;

	->erase;	
end
endtask

task Sensing;
begin
   	Data_Read = `FALSE;
   	Read_Mode = `TRUE;
   	Program_Mode = `FALSE;
	Copyback_Mode = `FALSE;
   	Erase_Mode = `FALSE;
   	Reset_Mode = `FALSE;

	->sensing;	
end
endtask

//`endprotect
endmodule   
