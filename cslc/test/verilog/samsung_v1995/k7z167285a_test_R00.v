
`timescale 1ns/1ps

/************************************************
 ****   16M Sigma RAM(K7Z167285A, X72)       ****
 ****             INPUT TIMING VECTOR        ****
 ****                                        ****
 ****   SRAM DESIGN TEAM  : Byong-kwon, LEE  ****
 ************************************************/

module test;

    parameter                   add_bit = 18;
    parameter                   data_bit = 72;
    parameter                   full_clk  =  `tKHKH  ;
    parameter                   half_clk  =  `tKHKH/2  ;
    parameter                   qurd_clk  =  `tKHKH/4  ;
    parameter                   hcycle  =  `tKHKH/2 ;

reg	[add_bit-1:0] addr;
reg	web, e1b, clk  ;
reg	adv,  sdb, ep2, ep3, e2, e3;
reg	[data_bit-1:0] DQ_reg;
wire    [data_bit-1:0] DQ = DQ_reg ; // [data_bit-1:0];
wire    cq1 ;
wire    cq2 ;
wire    cq1b;
wire    cq2b;
//reg    cq1 ;
//reg    cq2 ;
//reg    cq1b;
//reg    cq2b;

reg     bwa_n, bwb_n, bwc_n, bwd_n, bwe_n, bwf_n, bwg_n, bwh_n;


integer i;

K7Z167285A i1(.Addr(addr),
	.Bwa_n(bwa_n),
	.Bwb_n(bwb_n),
	.Bwc_n(bwc_n),
	.Bwd_n(bwd_n),
	.Bwe_n(bwe_n),
	.Bwf_n(bwf_n),
	.Bwg_n(bwg_n),
	.Bwh_n(bwh_n),
	.WEb(web),
	.SDb(sdb),
	.E1b(e1b),
	.E2(e2),
	.E3(e3),
	.EP2(ep2),
	.EP3(ep3),
	.CLK(clk),
	.ADV(adv),
	.Dq(DQ),
        .CQ1(cq1),
        .CQ1b(cq1b),
	.CQ2(cq2),
	.CQ2b(cq2b));


initial
	begin
	    $dumpvars;
            $dumpfile("K7Z1672857A.dump");
	end

initial
	begin                    // YOU must be setting for pow-up condition
            addr = {add_bit{1'bz}};
            e1b = 0;
            ep2 = 0;
            ep3 = 0;
            e2  = 0;
            e3  = 0;
            adv = 1'bx;
            sdb = 1;
            clk = 1'b0;
            DQ_reg = {data_bit{1'bz}};
            bwa_n = 1 ;
            bwb_n = 1 ;
            bwc_n = 1 ; 
            bwd_n = 1 ; 
            bwe_n = 1 ;
            bwf_n = 1 ;
            bwg_n = 1 ;
            bwh_n = 1 ;
	end  

////////////////////////////////////
//    Internal Sigma SRAM Clock   //
////////////////////////////////////

always 
    begin
        #half_clk clk = ~clk;
    end

///////////////////////////////////////

          
task read_s; 		
    input	[add_bit-1:0] address;  
    input        e_2  ;
    input        e_3  ;

    begin
        e1b = 0;
	adv= 0;
        web = 1;
	addr = address;
	e2 = e_2;
	e3 = e_3;
	ep2 = 0;
	ep3 = 0;
        #half_clk;
        addr = {add_bit{1'bz}}; 
        e1b = 1'bx;
	adv= 1'bx;
        web = 1'bx;
	e2 = 1'bx;
	e3 = 1'bx;
        #half_clk;
        
    end

endtask

task cont_read; 		
    input        e_2  ;
    input        e_3  ;

    begin
	e2 = e_2;
	e3 = e_3;
	ep2 = 0;
	ep3 = 0;
        addr = {add_bit{1'bz}}; 
	e1b = 1'bx;
 	adv = 1'b1;
        web = 1'bx;
        #half_clk;
        adv <= 1'bx; 
        #half_clk;
    end

endtask

task write; 		
    input	[add_bit-1:0] address;
    input	[data_bit-1:0] data;
    input        e_2  ;
    input        e_3  ;
    input        bwa  ;
    input        bwb  ;
    input        bwc  ;
    input        bwd  ;
    input        bwe  ;
    input        bwf  ;
    input        bwg  ;
    input        bwh  ;

    begin
        e1b = 0;
	addr = address;
        adv = 0;
	e2 = e_2;
	e3 = e_3;
	ep2 = 0;
	ep3 = 0;
        web = 0;
	bwa_n  = bwa ;
	bwb_n  = bwb ;
	bwc_n  = bwc ;
	bwd_n  = bwd ;
	bwe_n  = bwe ;
	bwf_n  = bwf ;
	bwg_n  = bwg ;
	bwh_n  = bwh ;
        #half_clk;
	bwa_n  = 1'bx;
	bwb_n  = 1'bx;
	bwc_n  = 1'bx;
	bwd_n  = 1'bx;
	bwe_n  = 1'bx;
	bwf_n  = 1'bx;
	bwg_n  = 1'bx;
	bwh_n  = 1'bx;
	e2 = 1'bx;
	e3 = 1'bx;
        addr = {add_bit{1'bz}}; 
	e1b = 1'bx;
 	adv = 1'bx;
        web = 1'bx;
        #half_clk;
	DQ_reg <= #(full_clk + qurd_clk - `tDVKH ) data;
        DQ_reg <= #(full_clk  + qurd_clk + `tKHDX ) {data_bit{1'bz}}; 
    end
endtask


task cont_write; 		
    input	[data_bit-1:0] data;
    input        e_2  ;
    input        e_3  ;
    input        bwa  ;
    input        bwb  ;
    input        bwc  ;
    input        bwd  ;
    input        bwe  ;
    input        bwf  ;
    input        bwg  ;
    input        bwh  ;

    begin
        adv = 1;
	e2 = e_2;
	e3 = e_3;
	ep2 = 0;
	ep3 = 0;
        web = 1'bx;
	e1b = 1'bx;
        addr = {add_bit{1'bz}}; 
	bwa_n  = bwa ;
	bwb_n  = bwb ;
	bwc_n  = bwc ;
	bwd_n  = bwd ;
	bwe_n  = bwe ;
	bwf_n  = bwf ;
	bwg_n  = bwg ;
	bwh_n  = bwh ;
        #half_clk;
        adv = 1'bx; 
	bwa_n  = 1'bx;
	bwb_n  = 1'bx;
	bwc_n  = 1'bx;
	bwd_n  = 1'bx;
	bwe_n  = 1'bx;
	bwf_n  = 1'bx;
	bwg_n  = 1'bx;
	bwh_n  = 1'bx;
        #half_clk;
	DQ_reg <= #(full_clk*1 + qurd_clk - `tDVKH ) data;
        DQ_reg <= #(full_clk*1  + qurd_clk + `tKHDX) {data_bit{1'bz}}; 
    end
endtask

task deselect; 		
    input        e_2  ;
    input        e_3  ;
    begin
        adv = 0;
	e2 = e_2;
	e3 = e_3;
	ep2 = 0;
	ep3 = 0;
        web = 1'bx;
	e1b = 1;
        #half_clk;
	e1b = 1'bx;
 	adv = 1'bx;
        web = 1'bx;
        #half_clk;
    end
endtask




initial
    begin
         #full_clk ;
         #qurd_clk ;
	 write (18'b111000111000111001, 72'h000000000000000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 read_s(18'b111000111000111001, 0, 0 );
	 deselect (0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 deselect (0, 0 );
	 deselect (0, 0 );
	 deselect (0, 0 );
	 deselect (0, 0 );
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
/*
	 write (18'b111000111000111001, 72'hfffffffffffffffff0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1);
			   cont_write ( 72'hfffffffffffffffff0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1);
			   cont_write ( 72'hfffffffffffffffff0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1);
			   cont_write ( 72'hfffffffffffffffff0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffffffff0f, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1);
			   cont_write ( 72'hffffffffffffffff0f, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1);
			   cont_write ( 72'hffffffffffffffff0f, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1);
			   cont_write ( 72'hffffffffffffffff0f, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hfffffffffffffff0ff, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1);
			   cont_write ( 72'hfffffffffffffff0ff, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1);
			   cont_write ( 72'hfffffffffffffff0ff, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1);
			   cont_write ( 72'hfffffffffffffff0ff, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffffff0fff, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1);
			   cont_write ( 72'hffffffffffffff0fff, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1);
			   cont_write ( 72'hffffffffffffff0fff, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1);
			   cont_write ( 72'hffffffffffffff0fff, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hfffffffffffff0ffff, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1);
			   cont_write ( 72'hfffffffffffff0ffff, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1);
			   cont_write ( 72'hfffffffffffff0ffff, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1);
			   cont_write ( 72'hfffffffffffff0ffff, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffff0fffff, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1);
			   cont_write ( 72'hffffffffffff0fffff, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1);
			   cont_write ( 72'hffffffffffff0fffff, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1);
			   cont_write ( 72'hffffffffffff0fffff, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			   cont_write ( 72'hffffffffffffffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
	 write (18'b111000111000111001, 72'hfffffffffff0ffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
			   cont_write ( 72'hfffffffffff0ffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
			   cont_write ( 72'hfffffffffff0ffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
			   cont_write ( 72'hfffffffffff0ffffff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
	 read_s(18'b111000111000111001, 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
			   cont_read  ( 0, 0 );
*/
	 write (18'b111000111000111001, 72'h1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 read_s  (18'b111000111000111001, 0, 0 );
	 write (18'b111000111000111001, 72'h1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	 read_s  (18'b111000111000111001, 0, 0 );
	 read_s  (18'b111000111000111001, 0, 0 );
	 deselect (0, 0 );
	 deselect (0, 0 );
         #half_clk ;
         #full_clk ;
         #full_clk ;
         #full_clk ;
         #full_clk ;
         #full_clk ;
         #full_clk ;
         #full_clk ;
         #full_clk ;
	$finish;
    end

endmodule
