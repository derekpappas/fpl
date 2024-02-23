//******************************************************************************************
//  You have to use this test vector file which is able to support only 256Mbit C-Die NAND 
//  Flash Memory , packaged TBGA(CSP) and MCP
//  K9F5608U0C, 256Mbit(x8) 4nd Generation NAND FLASH TIMING VECTOR FOR PROGRAM MODE TEST.
//  Programmed By NAND Flash Memory Product Planning Team, Samsung Semiconductor Co. LTD.
//  Rev. 1.0
//******************************************************************************************


`timescale 1ns/1ps

`define PWRUP           5000     // Wait Time
`define TPROGRAM        200100   // Program Time
`define TERASE          2000100  // Erase Time
`define TREAD           10100    // Data Transfer form Cell to Register
//`define V18_OPTION      1        // 1.8V part device option

`include "./K9F5608X0C.v"

module nand_driver();
reg     [7:0]   io;
wire    [7:0]   i_o=io;
reg             ceb, cle, ale, web, reb, seb, wpb;

integer i;

K9F5608X0C      flash(	.ceb(ceb), 
			.cle(cle), 
			.ale(ale),
			.web(web), 
			.reb(reb), 
			.io(i_o),
			.wpb(wpb), 
			.rbb(rbb),
			.lockpre(lockpre)
			);

initial
begin
	$dumpvars();
	$dumpfile("test_K9F5608U0C.dump");
end

// Initialization : Standby
initial
begin
        ceb = 1;
        cle = 0;
        ale = 0;
        web = 1;
        reb = 1;
        io  = 8'hzz;
        seb = 0;
        wpb = 0;
end  



//******************************
// User Test Vector Here
//******************************

initial
begin
	#`PWRUP
        wpb = 1;

    add_latch(8'h00);  // Power-up to Read
    add_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h00);	
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h40); // Reading the 1st block's 1st page.

	#1000

    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);

	#1000

    cmd_latch(8'h00);
    ceb = 1'b0;
    serial_read(16'h210); // Continue Reading

    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h01);
    add_latch(8'h00);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); // Reading the 1st block's 2nd page.
	
        #1000

// ID Read
    cmd_latch(8'h90);
    add_latch(8'h00);
        #100
    serial_read(16'h8);
        #1000

// Reset
    cmd_latch(8'hFF);
    @(posedge rbb) #100

// ID Read
    cmd_latch(8'h90);
    add_latch(8'h00);
        #100
    serial_read(16'h8);
        #1000

// Erase 1st Block
    cmd_latch(8'h60);
    add_latch(8'h00);
    add_latch(8'h00);	
    cmd_latch(8'hD0);
        ceb = 1'b0;
    @(posedge rbb) #100
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
        ceb = 1'b1;
        #1000 

// Read 1st Page
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h00);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); // Reading the 1st block's 1st page.	
    ceb = 1'b1;
	#1000

// Program on the 1st Page
    cmd_latch(8'h80);
    add_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h00);
    data_latch(10'h210,8'h00);
    cmd_latch(8'h10);
    ceb = 1'b0;
    @(posedge rbb) #100
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
    ceb = 1'b1;
	#1000

// Read 1st Page
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h00);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); // Reading the 1st block's 1st page.	
    ceb = 1'b1;
	#1000

// Read 11th Page
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h0A);
    add_latch(8'h00);	
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); // Reading the 1st block's 11th page.	
    ceb = 1'b1;
	#1000

// Program on the 11th Page (01 plane)
    cmd_latch(8'h01);
    cmd_latch(8'h80);
    add_latch(8'h00);
    add_latch(8'h0A);
    add_latch(8'h00);
    data_latch(10'h100,8'h00);
    cmd_latch(8'h10);
    ceb = 1'b0;
    @(posedge rbb) #100
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
    ceb = 1'b1;
	#1000
// Reset
    cmd_latch(8'hFF);
    @(posedge rbb) #100

// Read 11th Page (00 plane)
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h0A);
    add_latch(8'h00);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); // Reading the 1st block's 11th page(00 plane)	
    ceb = 1'b1;
	#1000

// Reset
    cmd_latch(8'hFF);
    @(posedge rbb) #100

// Read 11th Page (01 plane)
    cmd_latch(8'h01);
    add_latch(8'h00);
    add_latch(8'h0A);
    add_latch(8'h00);	
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h120); // Reading the 1st block's 11th page(01 plane)	
    ceb = 1'b1;
	#1000

// Read 11th Page (01 plane)
    add_latch(8'h04);
    add_latch(8'h0A);
    add_latch(8'h00);	
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h120); // Reading the 1st block's 11th page(01 plane)	
    ceb = 1'b1;
	#1000

// Read 31th Page 
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h1E);
    add_latch(8'h00);	
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); // Reading the 1st block's 31th page.	
    ceb = 1'b1;
	#1000

// Program on the 31th Page (50 plane)
    cmd_latch(8'h50);
    cmd_latch(8'h80);
    add_latch(8'h11);
    add_latch(8'h1E);
    add_latch(8'h00);
    data_latch(10'h20,8'h00);
    cmd_latch(8'h10);
    ceb = 1'b0;
    @(posedge rbb) #100
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
    ceb = 1'b1;
	#1000
// Reset
    cmd_latch(8'hFF);
    @(posedge rbb) #100

// Read 31th Page (50 plane)
    cmd_latch(8'h50);
    add_latch(8'h00);
    add_latch(8'h1E);
    add_latch(8'h00);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h20);
    ceb = 1'b1;
	#1000

// Read 31th Page (50 plane)
    add_latch(8'h04);
    add_latch(8'h1E);
    add_latch(8'h00);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h20);
    ceb = 1'b1;
	#1000

// Read 31th Page (00 plane)
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h1E);
    add_latch(8'h00);	
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h211);
    ceb = 1'b1;
	#1000

// Read 31th Page 
    cmd_latch(8'h01);
    add_latch(8'h00);
    add_latch(8'h1E);
    add_latch(8'h00);	
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h121);
    ceb = 1'b1;
	#1000

//-----------
// Page Copy
//-----------

// Erase Source Block
    cmd_latch(8'h60);
    add_latch(8'hA0);
    add_latch(8'h02);	
    cmd_latch(8'hD0);
    @(posedge rbb) #100
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
        ceb = 1'b1;
        #1000 

// Reset
    cmd_latch(8'hFF);
    @(posedge rbb) #100

// Read 2nd Page in Source Block
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'hA1);
    add_latch(8'h02);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); 
    ceb = 1'b1;
	#1000

// Program on the 2nd Page in Source Block
    cmd_latch(8'h80);
    add_latch(8'h00);
    add_latch(8'hA1);
    add_latch(8'h02);
    data_latch(10'h210,8'h00);
    cmd_latch(8'h10);
    ceb = 1'b0;
    @(posedge rbb) #100
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
    ceb = 1'b1;

// Read 2nd Page in Source Block
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'hA1);
    add_latch(8'h02);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); 
    ceb = 1'b1;
	#1000

// Erase Target Block
    cmd_latch(8'h60);
    add_latch(8'hA0);
    add_latch(8'h06);	
    cmd_latch(8'hD0);
    @(posedge rbb) #100
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
        ceb = 1'b1;
        #1000 

// Read 15th Page in Target Block
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'hAE);
    add_latch(8'h06);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); 
    ceb = 1'b1;
	#1000

// Page Copy
// Read 2nd Page in Source Block
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'hA1);
    add_latch(8'h02);
    @(posedge rbb) #100
    ceb = 1'b1;

// Page Copy
    cmd_latch(8'h8A);
    add_latch(8'h00);
    add_latch(8'hAE);
    add_latch(8'h06);
    ceb = 1'b0;
    @(posedge rbb) #100
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
    ceb = 1'b1;
	#1000

// Read 15th Page in Target Block
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'hAE);
    add_latch(8'h06);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); 
    ceb = 1'b1;
	#1000

// nCEx don't care in read busy 
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'hAE);
    add_latch(8'h06);
    ceb = 1'b0;
    @(negedge rbb) #1000
    ceb = 1'b1;
    @(posedge rbb) #100
    ceb = 1'b0;
    serial_read(16'h220); // don't supply the sequential row read
    ceb = 1'b1;
	#1000

// Write Protect
    wpb = 1'b0;
    #1000;

// Erase 1st Block
    cmd_latch(8'h60);
    add_latch(8'h00);
    add_latch(8'h00);	
    cmd_latch(8'hD0);
        #`TERASE
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
        ceb = 1'b1;
        #1000 

// Read 1st Page
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'h00);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); 
    ceb = 1'b1;
	#1000



// Read Page
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'hAE);
    add_latch(8'h07);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); 
    ceb = 1'b1;
	#1000

// Program on the Page
    cmd_latch(8'h80);
    add_latch(8'h00);
    add_latch(8'hAE);
    add_latch(8'h07);
    data_latch(10'h210,8'h00);
    cmd_latch(8'h10);
    ceb = 1'b0;
        #`TPROGRAM
    cmd_latch(8'h70);    // Status Check Command 
        ceb = 1'b0;
	#18
    serial_read(16'h1);
    ceb = 1'b1;
	#1000

// re-Read Page
    cmd_latch(8'h00);
    add_latch(8'h00);
    add_latch(8'hAE);
    add_latch(8'h07);
    ceb = 1'b0;
    @(posedge rbb) #100
    serial_read(16'h210); 
    ceb = 1'b1;
	#1000



  	$finish;
end



//*****************************************************************************
//  Task Definitions
//*****************************************************************************

// Command Latch Cycle
task	cmd_latch;
	input [7:0] cmd;

	begin
	    #20
		ceb = 0; web = 1; cle = 0; ale = 0;
	    #10
		cle = 1;
	    #1
		web = 0;
		io  = cmd;
	    #26
		web = 1;
	    #11
		io  = 8'hzz;
	    #6
		cle = 0;
            #40
               ceb = 1;
	end
endtask


// Address Latch Cycle
task	add_latch;
	input [7:0] add;

	begin
            ceb = 0;
	    #20
		cle = 0; ale = 1;
		#1
		web = 0;
	    #5
		io  = add;
  		#22
		web = 1;
		#11
		io  = 8'hzz;
	    #6
		ale = 0; ceb = 0;
	end
endtask


// Data Latch Cycle
task	data_latch;
	input [15:0] cnt;
	input [7:0] data;

	begin
		for (i=0; i < cnt; i=i+1)
		begin
	    	   #20
			ceb = 0;
	    	   #1
			web = 0;
	    	   #5
			io  = data + i;
	    	   #22
			web = 1;
		   #11
			io  = 8'hzz;
		end
	end
endtask


// Serial Read Cycle
task	serial_read;
	input  [16:0]	cnt;

	begin
		cle = 0; ale = 0; web = 1;
	    	for ( i=0; i < cnt; i = i+1) 
		begin
		   #16
			reb = 0;
	    	   #46
			reb = 1;
		end
	end
endtask


// Serial Read Cycle (/CE Toggle)
task    serial_read1;
        input  [16:0]   cnt1;

        begin
                cle = 0; ale = 0; web = 1; ceb = 1;
		   #1
			reb = 0;
                for ( i=0; i < cnt1; i = i+1)
                begin
                   #26
			ceb = 0;
                   #56
			ceb = 1;
                end
        end
endtask
endmodule  
