
`timescale 1ns/1ps

/************************************************
 ****   16M DDR RAM(K7D163671M, X36)         ****
 ****             INPUT TIMING VECTOR        ****
 ****                                        ****
 ****   SRAM DESIGN TEAM  : Byong-kwon, LEE  ****
 ************************************************/

module test;

    parameter                   add_bit = 19;
    parameter                   data_bit = 36;
    parameter                   full_clk  =  `tKHKH  ;
    parameter                   half_clk  =  `tKHKH/2  ;
    parameter                   qurd_clk  =  `tKHKH/4  ;
    parameter                   hcycle  =  `tKHKH/2 ;
    parameter                   add_valid= `tAVKH+`tKHAX ;

reg	[add_bit-1:0] addr;
reg	clk, clkb  ;
reg	clk_flag   ;
reg	gb, b1, b2, b3, lbob;
reg	[data_bit-1:0] DQ_reg;
wire    [data_bit-1:0] DQ = DQ_reg ;



integer i;

K7D163671M DDR_RAM(.Addr(addr),
	.B1(b1),
	.B2(b2),
	.B3(b3),
	.K(clk),
	.Kb(clkb),
	.Dq(DQ),
	.CQ(cq),
	.CQb(cqb),
	.Gb(gb),
	.LBOb(lbob));


initial
	begin
	    $dumpvars;
            $dumpfile("K7D163671M.dump");
	end

initial
	begin                    // YOU must be setting for pow-up condition
            addr = {add_bit{1'bz}};
	    lbob = 1'bz ;
	    clk_flag = 1'b0 ;
            b1 = 1'bz ;
            b2 = 1'bz ;
            b3 = 1'bz ;
            gb = 1'b0 ;
            clk = 1'b0;
            clkb = 1'b1;
            DQ_reg = {data_bit{1'bz}};
	end  

  //////////////////////////////////
 //   Internal DDR  SRAM Clock   //
//////////////////////////////////
/*
always       // K clock generator
    begin
	if(clk_flag ==0)
		begin
              		clk_flag = 1 ;
        		//#(half_clk+0.5) clk = ~clk;
        		#(half_clk+0.5) clkb = ~clkb;
		end
	else
		begin
        		//#half_clk clk = ~clk;
        		#half_clk clkb = ~clkb;
		end
    end

always       // Kb clock generator
    begin
        		//#half_clk clkb = ~clkb;
        		#half_clk clk = ~clk;
    end
*/


always       // Kb clock generator
    begin
        		clkb = ~clk;
        		#half_clk clk = ~clk;
    end

///////////////////////////////////////

          
task read_s; 		
    input	[add_bit-1:0] address;  
    input        lbob_1 ;

    begin
        b1 <= 0;
        b2 <= 1;
        b3 <= 1;
        lbob <= lbob_1 ;
	addr <= address;
        addr <= #half_clk {add_bit{1'bz}}; 
        lbob <= #half_clk 1'bx;
        b1  <= #half_clk 1'bz;
        b2  <= #half_clk 1'bz;
        b3  <= #half_clk 1'bz;
	#full_clk ;
    end
endtask

task read_d; 		
    input	[add_bit-1:0] address;  
    input        lbob_1 ;

    begin
        b1 <= 0;
        b2 <= 1;
        b3 <= 0;
        lbob <= lbob_1 ;
	addr <= address;
        addr <= #half_clk {add_bit{1'bz}}; 
        lbob <= #half_clk 1'bx;
        b1  <= #half_clk 1'bz;
        b2  <= #half_clk 1'bz;
        b3  <= #half_clk 1'bz;
	#full_clk ;
    end
endtask

task cont_read_s; 		
    begin
        b1 <= 1;
        b2 <= 1;
        b1  <= #half_clk 1'bz;
        b2  <= #half_clk 1'bz;
	#full_clk ;
    end
endtask

task cont_read_d;
    begin
        b1 <= 1;
        b2 <= 1;
        b1  <= #half_clk 1'bz;
        b2  <= #half_clk 1'bz;
	#full_clk ;
    end
endtask

task write_s; 		
    input	[add_bit-1:0] address;
    input	[data_bit-1:0] data;
    input        lbob_1 ;

    begin
        b1 <= 0;
        b2 <= 0;
        b3 <= 1;
	addr <= address;
        lbob <= lbob_1 ;
        b1  <= #half_clk 1'bz;
        b2  <= #half_clk 1'bz;
        b3  <= #half_clk 1'bz;
        addr <= #half_clk {add_bit{1'bz}}; 
        lbob  <= #half_clk 1'bx;
	#full_clk ;
	DQ_reg <= data;
        DQ_reg <= #(qurd_clk+0.3) {data_bit{1'bz}}; 
    end
endtask

task write_d; 		
    input	[add_bit-1:0] address;
    input	[data_bit-1:0] data;
    input	[data_bit-1:0] data1;
    input        lbob_1 ;

    begin
        b1 <= 0;
        b2 <= 0;
        b3 <= 0;
	addr <= address;
        lbob <= lbob_1 ;
        b1  <= #half_clk 1'bz;
        b2  <= #half_clk 1'bz;
        b3  <= #half_clk 1'bz;
        addr <= #half_clk {add_bit{1'bz}}; 
        lbob  <= #half_clk 1'bx;
	#half_clk ;
	DQ_reg <= #half_clk data;
        DQ_reg <= #(half_clk + qurd_clk+0.3) {data_bit{1'bz}}; 
	#half_clk ;
	DQ_reg <= #half_clk data1;
        DQ_reg <= #(half_clk + qurd_clk+0.3) {data_bit{1'bz}}; 
    end
endtask

task cont_write_s; 		
    input	[data_bit-1:0] data;

    begin
        b1 <= 1;
        b2 <= 1;
        b1  <= #half_clk 1'bz;
        b2  <= #half_clk 1'bz;
	#full_clk;
	DQ_reg <= data;
        DQ_reg <= #(qurd_clk+0.3) {data_bit{1'bz}}; 
    end
endtask

task cont_write_d; 		
    input	[data_bit-1:0] data;
    input	[data_bit-1:0] data1;

    begin
        b1 <= 1;
        b2 <= 1;
        b1  <= #half_clk 1'bz;
        b2  <= #half_clk 1'bz;
	#half_clk ;
	DQ_reg <= #half_clk data;
        DQ_reg <= #(half_clk + qurd_clk+0.3) {data_bit{1'bz}}; 
	#half_clk ;
	DQ_reg <= #half_clk data1;
        DQ_reg <= #(half_clk + qurd_clk+0.3) {data_bit{1'bz}}; 
    end
endtask

initial
    begin
         #full_clk ;
         #(qurd_clk) ;
	 write_d (19'b1100011100011100101, 36'hf, 36'h1f, 1);
	 cont_write_d ( 36'h2f, 36'h3f );
	 read_d(19'b1100011100011100101, 1 );
	 gb <=#0.01  1'b1 ;
	 gb <=#(0.85) 1'b0 ;
	 //gb <=#(0.7+0.85) 1'b0 ;
	 cont_read_d ;
         #full_clk ;

	 write_s (19'b0100011100011100101, 36'hf, 0);
	 cont_write_s ( 36'h1f );
	 cont_write_s ( 36'h2f );
	 cont_write_s ( 36'h3f );
	 read_s(19'b1100011100011100101, 0 );
	 read_s(19'b1100011100011100110, 0 );
	 read_s(19'b1100011100011100111, 0 );
	 read_s(19'b1100011100011100100, 0 );
	 read_s(19'b0100011100011100101, 0 );

	 gb <=#0.5  1'b1 ;

	 read_s(19'b0100011100011100110, 0 );
	 read_s(19'b0100011100011100111, 0 );

	 gb <= #0.3 1'b0 ;

	 read_s(19'b0100011100011100100, 0 );

         #full_clk ;
	 write_d (19'b1100011100011100101, 36'hf, 36'h1f, 1);
	 cont_write_d ( 36'h2f, 36'h3f );
	 read_d(19'b1100011100011100101, 1 );
         #full_clk ;
	 write_d (19'b0100011100011100101, 36'h4f, 36'h5f, 1);
	 cont_write_d ( 36'h6f, 36'h7f );
	 read_s(19'b0100011100011100101, 0 );
	 read_s(19'b0100011100011100110, 0 );
	 read_s(19'b0100011100011100111, 0 );
	 read_s(19'b0100011100011100100, 0 );
         #full_clk ;
	 write_d (19'b1100011100011100101, 36'hf, 36'h1f, 1);
	 cont_write_d ( 36'h2f, 36'h3f );
	 read_s(19'b0100011100011100101, 1 );
	 cont_read_s ;
	 cont_read_s ;
	 cont_read_s ;
	 read_d(19'b0100011100011100101, 0 );
	 cont_read_d ;
         #full_clk ;
	 write_s (19'b0100011100011100100, 36'hf, 0);
	 cont_write_s ( 36'h1f );
	 cont_write_s ( 36'h2f );
	 cont_write_s ( 36'h3f );
	 write_d (19'b1100011100011100100, 36'h5f, 36'h6f, 0);
	 read_d(19'b1100011100011100100, 0 );
	 //read_s(19'b1100011100011100111, 0 );
         #full_clk ;
         #full_clk ;
         #full_clk ;
         #full_clk ;
	$finish;
    end

endmodule
