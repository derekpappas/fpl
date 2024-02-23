////////////////////////////////////////////////////////////////////////////////
//////////////////  Testbench  ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module test;

    parameter                   addr_bits = 20;
    parameter                   data_bits = 18;
    parameter                   bwn = 2;
    parameter                   full_clk  =  `tKHKH;
    parameter                   half_clk  =  `tKHKH/2;
    parameter                   quar_clk  =  `tKHKH/4;
    parameter                   delay     =  `tKHCH;     

    reg     [data_bits - 1 : 0] D;
    reg     [data_bits - 1 : 0] Q_reg;
    reg     [addr_bits - 1 : 0] SA;
    reg                         RW_b;
    reg                         LD_b;
    reg           [bwn - 1 : 0] BW_b;
    reg                         K, K_b;
    reg                         C, C_b;
    reg                         CQ_reg, CQ_b_reg;
    reg                         DOFF_b;
  
    wire    [data_bits - 1 : 0] Q = Q_reg [data_bits - 1 : 0];
    wire    CQ = CQ_reg;
    wire    CQ_b = CQ_b_reg;

    integer 	kflag;
    integer 	kbflag;
    integer 	cflag;
    integer 	cbflag;

    real	kskew;
    real	kbskew;
    real	cskew;
    real	cbskew;

    integer	bw0;
    integer	bw1;
    integer	bw2;
    integer	bw3;
    integer	bw4;

   
    k7j321882m ddrsram (D, Q, SA, RW_b, LD_b, BW_b, K, K_b, C, C_b, CQ, CQ_b, DOFF_b);

    initial begin
        $dumpvars;
        $dumpfile("k7j321882m_R06.dump");
    end  

    initial begin
	kflag = 0;	
	kbflag = 0;
	cflag = 0;
	cbflag = 0; 

	kskew = 0;
	kbskew = 0;
	cskew = 0.3;
	cbskew = 0;

        K = 1'b1;
        K_b = 1'b0;
        C = 1'b1;
        C_b = 1'b0;
        SA = {addr_bits{1'bx}};
        RW_b = 1'bx;
        LD_b = 1'bx;
	BW_b = {bwn{1'bx}}; 
        D = {data_bits{1'bz}};
        Q_reg = {data_bits{1'bz}};
        CQ_reg = 1'bz;
	CQ_b_reg = 1'bz;
	DOFF_b = 1'b1;
    end

    always begin
        if (kbflag == 0) begin
                #(half_clk + kbskew) K_b =  ~K_b;
                kbflag = 1;
        end
        else if (kbflag == 1) begin
                #half_clk K_b =  ~K_b;
        end
    end

    always begin
        if (kflag == 0) begin
                #(half_clk + kskew) K =  ~K;
                kflag = 1;
        end
        else if (kflag == 1) begin
                #half_clk K =  ~K;
        end
    end

    wire ocm = `out_clock_fix;

    always begin
        if (cbflag == 0) begin
                #(half_clk + kbskew + cbskew) C_b =  ~C_b;
                cbflag = 1;
        end
        else if (cbflag == 1) begin
                #half_clk C_b =  ~C_b;
        end
    end

    always begin
        if (cflag == 0) begin
                #(half_clk + kskew + cskew) C =  ~C;
                cflag = 1;
        end
        else if (cflag == 1) begin
                #half_clk C =  ~C;
        end
    end
    

    // Single Byte Write 
    task write;
        
        input [addr_bits - 1 : 0] addr;
        input [bwn - 1:0] bwrite0;
        input [bwn - 1:0] bwrite1;
        input [data_bits - 1 : 0] data0;
        input [data_bits - 1 : 0] data1;

        begin
            RW_b <= #(kskew + half_clk - `tIVKH) 1'b0;   
            LD_b <= #(kskew + half_clk - `tIVKH) 1'b0;   
            SA <= #(kskew + half_clk - `tAVKH) addr;
            RW_b <= #(kskew + half_clk + `tKHIX) 1'bx;   
            LD_b <= #(kskew + half_clk + `tKHIX) 1'bx;   
            SA <= #(kskew + half_clk + `tKHAX) {addr_bits{1'bx}};
            BW_b <= #(kskew + 3 * half_clk - `tIVKH) bwrite0;
            D <=  #(kskew + 3 * half_clk - `tDVKH) data0;
            BW_b <= #(kskew + 3 * half_clk + `tKHIX) {bwn{1'bx}};
            D <=  #(kskew + 3 * half_clk + `tKHDX) {data_bits{1'bz}};
            BW_b <=  #(kbskew + 4 * half_clk - `tIVKH) bwrite1;
            D <=  #(kbskew + 4 * half_clk - `tDVKH) data1;
            BW_b <=  #(kbskew + 4 * half_clk + `tKHIX) {bwn{1'bx}};
            D <=  #(kbskew + 4 * half_clk + `tKHDX) {data_bits{1'bz}};
        end
    endtask
 
    // Single Read
    task read;
        input [addr_bits - 1 : 0] addr;
        begin
            RW_b <= #(kskew + half_clk - `tIVKH) 1'b1;
            LD_b <= #(kskew + half_clk - `tIVKH) 1'b0;
            SA <= #(kskew + half_clk - `tAVKH) addr;
            RW_b <=  #(kskew + half_clk + `tKHIX) 1'bx;
            LD_b <=  #(kskew + half_clk + `tKHIX) 1'bx;
            SA <= #(kskew + half_clk + `tKHAX) {addr_bits{1'bx}};
        end
    endtask

    // Test Vectors
    initial begin

        if (bwn == 4) begin
                bw0 = 0;
                bw1 = 14;
                bw2 = 13;
                bw3 = 11;
                bw4 = 7;
        end
        else if (bwn == 2) begin
                bw0 = 0;
                bw1 = 2;
                bw2 = 1;
        end

	#full_clk;
        #half_clk;
	// single write 
        write({(addr_bits/4){4'h1}}, bw0, bw0, {(data_bits/4){4'h1}}, {(data_bits/4){4'h2}} ); 
        #full_clk;
        #full_clk;
	// single read
        read({(addr_bits/4){4'h1}});
        #full_clk;
        #full_clk;
	// write - read(same address) - bypass
        write({(addr_bits/4){4'h2}}, bw0, bw0, {(data_bits/4){4'h3}}, {(data_bits/4){4'h4}}); 
        #full_clk;
        read({(addr_bits/4){4'h2}});
        #full_clk;
        #full_clk;
	// read - write
        read({(addr_bits/4){4'h1}});
        #full_clk;
        write({(addr_bits/4){4'h3}}, bw0, bw0, {(data_bits/4){4'h5}}, {(data_bits/4){4'h6}}); 
        #full_clk;
        #full_clk;
        read({(addr_bits/4){4'h3}});
        #full_clk;
        #full_clk;
	// byte write 
        write({(addr_bits/4){4'h3}}, bw1, bw2, {(data_bits/4){4'h0}}, {(data_bits/4){4'h0}}); 
        #full_clk;
        read({(addr_bits/4){4'h3}});
        #full_clk;
	if (data_bits == 36) begin
        	write({(addr_bits/4){4'h3}}, bw3, bw4, {(data_bits/4){4'h0}}, {(data_bits/4){4'h0}}); 
        	#full_clk;
       	 	read({(addr_bits/4){4'h3}});
        	#full_clk;
	end
        #full_clk;

	// write - write
        write({(addr_bits/4){4'h4}}, bw0, bw0, {(data_bits/4){4'h7}}, {(data_bits/4){4'h8}}); 
        #full_clk;
        write({(addr_bits/4){4'h5}}, bw0, bw0, {(data_bits/4){4'h9}}, {(data_bits/4){4'ha}}); 
        #full_clk;
        #full_clk;
        read({(addr_bits/4){4'h4}});
        #full_clk;
        #full_clk;
        read({(addr_bits/4){4'h5}});
        #full_clk;
        #full_clk;
	// read - read
        read({(addr_bits/4){4'h1}});
        #full_clk;
        read({(addr_bits/4){4'h2}});
        #full_clk;
        #full_clk;
        #full_clk;
        #full_clk;
        $finish;
    end

endmodule
