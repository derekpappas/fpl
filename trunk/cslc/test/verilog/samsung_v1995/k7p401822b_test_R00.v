////////////////////////////////////////////////////////////////////////////////
//////////////////  Testbench for SP  ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module test;

	parameter                   addr_bits = 18;
	parameter                   data_bits = 18;

	parameter                   full_clk  =  `tKHKH;
	parameter                   half_clk  =  `tKHKH/2;
	parameter                   quar_clk  =  `tKHKH/4;

        reg           	[addr_bits - 1 : 0]     SA;
        reg                                   	SS_n;
        reg                                   	SW_n;
        reg           	[1 : 0]                 SBW_n;
        reg                                   	G_n;
        reg                                   	ZZ;
        reg                                   	K;
        reg                                   	K_n;
        reg           	[data_bits - 1 : 0]     Dq_reg;
  
	wire    	[data_bits - 1 : 0] 	DQ = Dq_reg [data_bits - 1 : 0];

	real					kskew;
	real					kbskew;
	integer					kflag;
	integer					kbflag;
   
k7p401822b sram_sp(DQ, SA, SS_n, SW_n, SBW_n, G_n, ZZ, K, K_n);

	initial begin
		$dumpvars;
		$dumpfile("k7p401822b_R00.dump");
	end  

	initial begin
		ZZ = 1'b0;
		K = 1'b0;
		K_n = 1'b1;

		SA = {addr_bits{1'bx}};
		SS_n = 1'b1;
		SW_n = 1'bx;
		SBW_n = 2'b11;
		G_n = 1'b0;

		Dq_reg = {data_bits{1'bz}} ;

        	kflag = 0;
	        kbflag = 0;

	        kskew = 0;
      		kbskew = 0.3;
	end

	always begin
		if (kbflag == 0) begin
			#(half_clk + kbskew) K_n =  ~K_n;
			kbflag = 1;
		end
		else if (kbflag == 1) begin
			#half_clk K_n =  ~K_n;
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

	task 	write;
		input [addr_bits - 1 : 0] 	addr;
		input [1:0] 			bw;
		input [data_bits - 1 : 0] 	data;
	begin
            	SS_n <= #(kskew + half_clk - `tSVKH) 1'b0;
            	SS_n <= #(kskew + half_clk + `tKHSX) 1'b1;

            	SW_n <= #(kskew + half_clk - `tWVKH) 1'b0;
            	SW_n <= #(kskew + half_clk + `tKHWX) 1'bx;

            	SA <= #(kskew + half_clk - `tAVKH) addr;
            	SA <= #(kskew + half_clk + `tKHAX) {addr_bits{1'bx}};

            	SBW_n <= #(kskew + half_clk - `tWVKH) bw;
            	SBW_n <= #(kskew + half_clk + `tKHWX) {2{1'b1}};

            	Dq_reg <= #(kskew + 3*half_clk - `tDVKH) data;
            	Dq_reg <= #(kskew + 3*half_clk + `tKHDX) {36{1'bz}};
	end
	endtask

	task read;	
                input [addr_bits - 1 : 0]       addr;
        begin
            	SS_n <= #(kskew + half_clk - `tSVKH) 1'b0;
            	SS_n <= #(kskew + half_clk + `tKHSX) 1'b1;

            	SW_n <= #(kskew + half_clk - `tWVKH) 1'b1;
            	SW_n <= #(kskew + half_clk + `tKHWX) 1'bx;

            	SA <= #(kskew + half_clk - `tAVKH) addr;
            	SA <= #(kskew + half_clk + `tKHAX) {addr_bits{1'bx}};
	
        end
        endtask

	initial begin

		#full_clk;
		#full_clk;
		#full_clk;
		write(20'h00000, 2'b00, {6{3'b000}}); 
		#full_clk;
		write(20'h00001, 2'b00, {6{3'b001}}); 
		#full_clk;
		write(20'h00002, 2'b00, {6{3'b011}}); 
		#full_clk;
		write(20'h00003, 2'b00, {6{3'b111}}); 
		#full_clk;
                write(20'h00000, 2'b00, {6{3'b111}}); 
                #full_clk;
                write(20'h00001, 2'b01, {6{3'b111}}); 
                #full_clk;
                write(20'h00002, 2'b10, {6{3'b111}}); 
                #full_clk;
                write(20'h00003, 2'b11, {6{3'b111}}); 
                #full_clk;
		read(20'h0000);
                #full_clk;
		read(20'h0001);
                #full_clk;
		read(20'h0002);
                #full_clk;
		read(20'h0003);
                #(2*full_clk);
		write(20'h00000, 2'b00, {6{3'b000}}); 
		#full_clk;
		write(20'h00001, 2'b00, {6{3'b001}}); 
		#full_clk;
		read(20'h0000);
		#full_clk;
		#full_clk;
		#full_clk;
		$finish;
	end

endmodule
