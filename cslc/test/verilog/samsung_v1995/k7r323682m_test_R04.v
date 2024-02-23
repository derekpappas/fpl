////////////////////////////////////////////////////////////////////////////////
//////////////////  Testbench  ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module test;

    parameter                   addr_bits = 19;
    parameter                   data_bits = 36;
    parameter                   bn = 4;
    parameter                   full_clk  =  `tKHKH;
    parameter                   half_clk  =  `tKHKH/2;
    parameter                   quar_clk  =  `tKHKH/4;
    parameter                   delay     =  `tKHCH;     

    reg     [data_bits - 1 : 0] D;
    reg     [data_bits - 1 : 0] Q_reg;
    reg     [addr_bits - 1 : 0] SA;
    reg                         R_b;
    reg                         W_b;
    reg            [bn - 1 : 0] BW_b;
    reg                         K, K_b;
    reg                         C, C_b;
    //reg                         CQ_reg, CQ_b_reg;
    reg                         DOFF_b;
  
    wire    [data_bits - 1 : 0] Q = Q_reg [data_bits - 1 : 0];
   
    integer	kflag;
    integer	kbflag;
    real	kskew;
    real	kbskew;
    real	cskew;
    real	cbskew;

    k7r323682m qdrsram (D, Q, SA, R_b, W_b, BW_b, K, K_b, C, C_b, CQ, CQ_b, DOFF_b);

    initial begin
        $dumpvars;
        $dumpfile("k7r323682m_R04.dump");
    end  

    initial begin
        K = 1'b1;
        K_b = 1'b0;
        C = 1'b1;
        C_b = 1'b0;
        D = {data_bits{1'bz}};
        Q_reg = {data_bits{1'bz}};
	kflag = 0;
	kbflag = 0;
	kskew = 0;
	kbskew = 0.3;
	cskew = 0;
	cbskew = 0;
    end

    wire ocm = `out_clock_fix;

    always begin
        if (kbflag == 0) begin
                #(half_clk+kbskew) K_b =  ~K_b;
                kbflag = 1;
        end
        else if (kbflag == 1) begin
                #half_clk K_b =  ~K_b;
        end
    end

    always begin
        if (kflag == 0) begin
                #(half_clk+kskew) K =  ~K;
                kflag = 1;
        end
        else if (kflag == 1) begin
                #half_clk K =  ~K;
        end
    end
    
    always @ (K) begin
       	if(ocm == 0) begin    
           	#(cskew) C = K;
       	end
	else if(ocm == 1) begin
		C = 1'b1;
	end
    end

    always @ (K_b) begin
       	if(ocm == 0) begin    
           	#(cbskew) C_b = K_b;
       	end
	else if(ocm == 1) begin
		C_b = 1'b1;
	end
    end

    // Single Byte Write 
    task write;
        
        input [addr_bits - 1 : 0] addr;
        input [bn-1:0] bwrite0;
        input [bn-1:0] bwrite1;
        input [data_bits - 1 : 0] data0;
        input [data_bits - 1 : 0] data1;

        begin
            W_b <= #(kskew + half_clk - `tIVKH) 1'b0;   
            W_b <= #(kskew + half_clk + `tKHIX) 1'bx;   

            BW_b <= #(kskew + 1 * half_clk - `tIVKH) bwrite0;
            BW_b <= #(kskew + 1 * half_clk + `tKHIX) {bn{1'bx}};
            D <=  #(kskew + 1 * half_clk - `tDVKH) data0;
            D <=  #(kskew + 1 * half_clk + `tKHDX) {data_bits{1'bz}};

            SA <= #(kbskew + 2 * half_clk - `tAVKH) addr;
            SA <= #(kbskew + 2 * half_clk + `tKHAX) {addr_bits{1'bx}};

            BW_b <= #(kbskew + 2 * half_clk - `tIVKH) bwrite1;
            BW_b <= #(kbskew + 2 * half_clk + `tKHIX) {bn{1'bx}};
            D <=  #(kbskew + 2 * half_clk - `tDVKH) data1;
            D <=  #(kbskew + 2 * half_clk + `tKHDX) {data_bits{1'bz}};
            BW_b <=  #(kbskew + 2 * half_clk) bwrite1;

        end
    endtask
 
    // Single Read
    task read;
        input [addr_bits - 1 : 0] addr;
        begin
            R_b <= #(kskew + half_clk - `tIVKH) 1'b0;
            R_b <= #(kskew + half_clk + `tKHIX) 1'bx;
            SA <= #(kskew + half_clk - `tAVKH) addr;
            SA <= #(kskew + half_clk + `tKHAX) {addr_bits{1'bx}};
        end
    endtask

    // Test Vectors
    initial begin
        #half_clk;
        #full_clk;

	//Single write 
        write({(addr_bits/4){4'h1}}, {bn{1'b0}}, {bn{1'b0}}, {(data_bits/4){4'h1}}, {(data_bits/4){4'h2}});
        #full_clk;
        #full_clk;

	//Single read 
        read({(addr_bits/4){4'h1}});
        #full_clk;
        #full_clk;

	//Write - Read
        write({(addr_bits/4){4'h2}}, {bn{1'b0}}, {bn{1'b0}}, {(data_bits/4){4'h3}}, {(data_bits/4){4'h4}});
        #full_clk;
        read({(addr_bits/4){4'h2}});
        #full_clk;
        #full_clk;

	//Read - Write
        read({(addr_bits/4){4'h1}});
        #full_clk;
        write({(addr_bits/4){4'h3}}, {bn{1'b0}}, {bn{1'b0}}, {(data_bits/4){4'h5}}, {(data_bits/4){4'h6}});
        #full_clk;
        #full_clk;
        read({(addr_bits/4){4'h3}});
        #full_clk;
        #full_clk;

	//Byte writE
	if (bn == 4) begin
        	write({(addr_bits/4){4'h3}}, 4'b1110, 4'b1101, {(data_bits/4){4'h0}}, {(data_bits/4){4'h0}});
        	#full_clk;
        	#full_clk;
        	write({(addr_bits/4){4'h3}}, 4'b1011, 4'b0111, {(data_bits/4){4'h0}}, {(data_bits/4){4'h0}});
        	#full_clk;
        	#full_clk;
	end
	else if (bn == 2) begin
        	write({(addr_bits/4){4'h3}}, 2'b10, 2'b01, {(data_bits/4){4'h0}}, {(data_bits/4){4'h0}});
        	#full_clk;
        	#full_clk;
	end
       	write({(addr_bits/4){4'h3}}, {bn{1'b1}}, {bn{1'b1}}, {(data_bits/4){4'hf}}, {(data_bits/4){4'hf}});
       	#full_clk;
       	#full_clk;
        read({(addr_bits/4){4'h3}});
        #full_clk;
        #full_clk;

	//Write - Write 
        write({(addr_bits/4){4'h4}}, {bn{1'b0}}, {bn{1'b0}}, {(data_bits/4){4'h7}}, {(data_bits/4){4'h8}});
        #full_clk;
        write({(addr_bits/4){4'h5}}, {bn{1'b0}}, {bn{1'b0}}, {(data_bits/4){4'h9}}, {(data_bits/4){4'ha}});
        #full_clk;
        #full_clk;
        read({(addr_bits/4){4'h4}});
        #full_clk;
        #full_clk;
        read({(addr_bits/4){4'h5}});
        #full_clk;
        #full_clk;

	//Read - Read
        read({(addr_bits/4){4'h1}});
        #full_clk;
        read({(addr_bits/4){4'h2}});
        #full_clk;
        #full_clk;

	//Wrie & Read 
        write({(addr_bits/4){4'h4}}, {bn{1'b0}}, {bn{1'b0}}, {(data_bits/4){4'hf}}, {(data_bits/4){4'hf}});
        read({(addr_bits/4){4'h4}});
        #full_clk;
        #full_clk;
        read({(addr_bits/4){4'h4}});
        #full_clk;
        #full_clk;
        write({(addr_bits/4){4'h1}}, {bn{1'b0}}, {bn{1'b0}}, {(data_bits/4){4'h0}}, {(data_bits/4){4'h0}});
        read({(addr_bits/4){4'h2}});
        #full_clk;
        #full_clk;
        read({(addr_bits/4){4'h1}});
        #full_clk;
        #full_clk;
        #full_clk;
        #full_clk;
        #full_clk;
        #full_clk;
        #full_clk;
        $finish;
    end

endmodule
