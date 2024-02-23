
`timescale 1ns/1ps

/************************************************
 ****   16M NT RAM(K7N163201A, X32)          ****
 ****             INPUT TIMING VECTOR        ****
 ****                                        ****
 ****   SRAM DESIGN TEAM  : Byong-kwon, LEE  ****
 ************************************************/

module test;

    parameter                   add_bit = 19;
    parameter                   data_bit = 32;
    parameter                   full_clk  =  `tCYC   ;
    parameter                   half_clk  =  `tCYC/2  ;
    parameter                   qurd_clk  =  `tCYC/4  ;
    parameter                   hcycle  =  `tCYC/2 ;

reg	[add_bit-1:0] addr;
reg	web, clk, ckeb  ;
reg	adv,  oeb, cs1b, cs2, cs2b, zz, lbob;
reg	[data_bit-1:0] DQ_reg;
wire    [data_bit-1:0] DQ ; //= DQ_reg;

reg     bwa_n, bwb_n, bwc_n, bwd_n;


K7N163201A NtRAM(.Addr(addr),
	.Bwa_n(bwa_n),
	.Bwb_n(bwb_n),
	.Bwc_n(bwc_n),
	.Bwd_n(bwd_n),
	.WEb(web),
	.CKEb(ckeb),
	.CS1b(cs1b),
	.CS2(cs2),
	.CS2b(cs2b),
	.K(clk),
	.ADV(adv),
	.Dq(DQ),
	.OEb(oeb),
	.ZZ(zz),
	.LBOb(lbob));


initial
	begin
	    $dumpvars;
            $dumpfile("K7N163201A.dump");
	end

initial
	begin                    // YOU must be setting for pow-up condition
            addr = {add_bit{1'bz}};
	    web = 0 ;
	    ckeb = 0 ;
	    lbob = 0 ;
            cs1b = 0 ;
            cs2 = 1 ;
            cs2b = 0 ;
            oeb = 0 ;
            zz = 1'b0 ;
            adv = 1'bx ;
            clk = 1'b0;
            DQ_reg = {data_bit{1'bz}};
            bwa_n = 1 ;
            bwb_n = 1 ;
            bwc_n = 1 ;
            bwd_n = 1 ;
	end  

/////////////////////////////////
//    Internal NT SRAM Clock   //
/////////////////////////////////

always 
    begin
        #half_clk clk = ~clk;
    end

///////////////////////////////////////

assign DQ = DQ_reg ;
          
task read_s; 		
    input	[add_bit-1:0] address;  

    begin
        web = 1;
	addr = address;
        addr <= #(`tAS + `tAH +0.3) {add_bit{1'bz}}; 
        web  <= #(`tAS + `tAH +0.3 ) 1'bx;
    end

endtask


task cont_read; 		

    begin
        web = 1'bx;
        addr = {add_bit{1'bz}}; 
    end

endtask


task write; 		
    input	[add_bit-1:0] address;
    input	[data_bit-1:0] data;
    input        bwa  ;
    input        bwb  ;
    input        bwc  ;
    input        bwd  ;

    begin
        web = 0;
	addr = address;
	bwa_n  = bwa ;
	bwb_n  = bwb ;
	bwc_n  = bwc ;
	bwd_n  = bwd ;
        addr <= #(`tAS + `tAH +0.3) {add_bit{1'bz}}; 
	bwa_n  <= #(`tAS + `tAH  +0.3) 1'bx;
	bwb_n  <= #(`tAS + `tAH +0.3 ) 1'bx;
	bwc_n  <= #(`tAS + `tAH  +0.3) 1'bx;
	bwd_n  <= #(`tAS + `tAH +0.3 ) 1'bx;
        web  <= #(`tAS + `tAH +0.3 ) 1'bx;
	DQ_reg <= #(full_clk*2) data;
        DQ_reg <= #(full_clk*2 + `tDS + `tDH ) {data_bit{1'bz}}; 
    end
endtask

task cont_write; 		
    input	[data_bit-1:0] data;
    input        bwa  ;
    input        bwb  ;
    input        bwc  ;
    input        bwd  ;

    begin
        web = 0;
        addr = {add_bit{1'bz}}; 
	bwa_n  = bwa ;
	bwb_n  = bwb ;
	bwc_n  = bwc ;
	bwd_n  = bwd ;
	bwa_n  <= #(`tAS + `tAH +0.3) 1'bx;
	bwb_n  <= #(`tAS + `tAH +0.3) 1'bx;
	bwc_n  <= #(`tAS + `tAH  +0.3) 1'bx;
	bwd_n  <= #(`tAS + `tAH +0.3 ) 1'bx;
        web  <= #(`tWS + `tWH+0.3 ) 1'bx;
	DQ_reg <= #(full_clk*2) data;
        DQ_reg <= #(full_clk*2 + `tDS + `tDH ) {data_bit{1'bz}}; 
    end
endtask

task control; 		
    input       ckeb_1;
    input       cs1b_1;
    input       cs2_1;
    input       cs2b_1;
    input       lbob_1 ;
    input       adv_1;
    begin
        ckeb = ckeb_1;
        lbob = lbob_1 ;
        cs1b = cs1b_1;
        cs2 = cs2_1;
        cs2b = cs2b_1;
        adv = adv_1;
        ckeb <= #(`tCES + `tCEH +0.3) 1'bx  ;
        lbob  <= #(`tAS + `tAH +0.3 ) 1'bx;
        cs1b <= #(`tCSS + `tCSH +0.3) 1'bx  ;
        cs2 <= #(`tCSS + `tCSH +0.3) 1'bx  ; 
        cs2b <= #(`tCSS + `tCSH +0.3) 1'bx  ;
 	adv  <= #(`tADVS + `tADVH +0.3) 1'bx;
    end
endtask




initial
    begin
         #full_clk ;
         #(half_clk - `tAS) ;
	 write (19'b1100011100011100100, 32'hf, 0, 0, 0, 0);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

        	#full_clk ;

	 read_s(19'b1100011100011100100);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
//zz <=  1'b1 ; 

         	#full_clk ;

	 write (19'b1100011100011100101, 32'hf, 0, 0, 0, 0);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

        	#full_clk ;

	 read_s(19'b1100011100011100101);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
//zz <= #5 1'bz ; 

         	#full_clk ;

	 write (19'b1100011100011100110, 32'hf, 0, 0, 0, 0);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

//zz <=  1'b1 ; 
        	#full_clk ;

	 read_s(19'b1100011100011100110);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

         	#full_clk ;

	 write (19'b1100011100011100111, 32'hf, 0, 0, 0, 0);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
//oeb <= #5 1'b0 ; 

        	#full_clk ;
/*
	 read_s(19'b1100011100011100111);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

         	#full_clk ;

	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
         	#full_clk ;

*/
	 cont_write ( 32'h1f, 0, 0, 0, 0);
	 control(0, 1'bX, 1, 1'bX, 0, 1) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)	
//zz <= #11 1'b0 ; 
	//oeb <= #4 1'b1 ; 

         	#full_clk ;

	 cont_write ( 32'h2f, 0, 0, 0, 0);
	 control(0, 0, 1, 0, 0, 1) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

         	#full_clk ;
  
	 cont_write ( 32'h3f, 0, 0, 0, 0);
	 control(0, 0, 1, 1'bX, 0, 1) ; 	// control (ckeb ,  cs1b, cs2, cs2b, LBOb, adv)

         	#full_clk ;
/*
	 read_s(19'b1100011100011100100);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

         	#full_clk ;
*/
	 read_s(19'b1100011100011100101);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
	//oeb <= #4 1'b0 ; 
//zz <= #1 1'bz ; 

         	#full_clk ;

	 read_s(19'b1100011100011100110);
	 control(0, 1, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

         	#full_clk ;

	 read_s(19'b1100011100011100111);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

	//oeb <= #4 1'b1 ; 
         	#full_clk ;

	 cont_read ;
	 control(0, 1'bX, 1, 1'bX, 0, 1) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
//zz <= #1 1'b1 ; 

         	#full_clk ;

	 cont_read ;
	 control(0, 1'bX, 1, 1'bX, 0, 1) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

         	#full_clk ;

	 cont_read ;
	 control(0, 1'bX, 1, 1'bX, 0, 1) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
	//oeb <= #7.7 1'b0 ; 

         	#full_clk ;

	 //control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
         //#full_clk ;

	 read_s(19'b1100011100011100110);
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)

         #full_clk ;

	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
         #full_clk ;
	 control(0, 0, 1, 0, 0, 0) ; 	// control (ckeb , cs1b, cs2, cs2b, LBOb, adv)
         #full_clk ;
         #full_clk ;
	$finish;
    end

endmodule
