////////////////////////////////////////////////////////////////////////////////
//////////////////  Testbench for SB  ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module test;

	parameter                   addr_bits = 19;
	parameter                   data_bits = 32;

	parameter                   full_clk  =  `tCYC;
	parameter                   half_clk  =  `tCYC/2;
	parameter                   quar_clk  =  `tCYC/4;

	reg           [addr_bits - 1 : 0]     A;
        reg                                   Adv_n;
        reg                                   Adsp_n;
        reg                                   Adsc_n;
        reg                                   Clk;
        reg                                   Cs1_n;
        reg                                   Cs2;
        reg                                   Cs2_n;
        reg           [3 : 0]                 We_n;
        reg                                   Oe_n;
        reg                                   Gw_n;
        reg                                   Bw_n;
        reg                                   Zz;
        reg                                   Lbo_n;
        reg           [data_bits - 1 : 0]     Dq_reg;
  
	wire    [data_bits - 1 : 0] DQ = Dq_reg [data_bits - 1 : 0];
   
	k7b163225a qdrsram (A, Adv_n, Adsp_n, Adsc_n, Clk, Cs1_n, Cs2, Cs2_n, We_n, Oe_n, Gw_n, Bw_n, Zz, Lbo_n, DQ);

	initial begin
		$dumpvars;
		$dumpfile("k7b163225a_R03.dump");
	end  

	initial begin
		A = {addr_bits{1'bx}};
		Adv_n = 1'bx;
		Adsp_n = 1'bx;
		Adsc_n = 1'bx;
		Clk = 1'b0;
		Cs1_n = 1'bx;
		Cs2 = 1'bx;
		Cs2_n = 1'bx;
		We_n = 4'bxxxx;
		Oe_n = 1'b0;
		Gw_n = 1'bx;
		Bw_n = 1'bx;
		Zz = 1'b0;
		Lbo_n = 1'b1;
		Dq_reg = {data_bits{1'bz}} ;
	end

	always begin
		#half_clk Clk = ~Clk;
	end

	// Single Write ( ADSC_N controlled )
	task write;
		input [addr_bits - 1 : 0] addr;
                input       global_wr;
		input       bwrite_en;
		input [3:0] write_en;
		input [data_bits - 1 : 0] data;
	begin
		A <= addr;
                Adsp_n <= 1'b1;
                Adsc_n <= 1'b0;
                Cs1_n <= 1'b0;
                Cs2 <= 1'b1;
                Cs2_n <= 1'b0;
                We_n <= write_en;
                Gw_n <= global_wr;
                Bw_n <= bwrite_en;
		Dq_reg <= data;

	 	Adsp_n <= #half_clk 1'bx;	
	 	Adsc_n <= #half_clk 1'bx;
	 	Cs1_n <= #half_clk 1'bx;
	 	Cs2 <= #half_clk 1'bx;
	 	Cs2_n <= #half_clk 1'bx;
	 	We_n <= #half_clk 4'bxxxx;
	 	Gw_n <= #half_clk 1'bx;
	 	Bw_n <= #half_clk 1'bx;
	 	Dq_reg <= #half_clk {data_bits{1'bz}};
        end
	endtask

	// Continue Write1
	task cont_write1;	
                input       global_wr;
                input       bwrite_en;
                input [3:0] write_en;
                input [data_bits - 1 : 0] data;
        begin
                Adsp_n <= 1'b1;
                Adsc_n <= 1'b1;
		Adv_n <= 1'b0;
                We_n <= write_en;
                Gw_n <= global_wr;
                Bw_n <= bwrite_en;
                Dq_reg <= data;

                Adsp_n <= #half_clk 1'bx;           
                Adsc_n <= #half_clk 1'bx;
		Adv_n <= #half_clk 1'bx;      
                We_n <= #half_clk 4'bxxxx;
                Gw_n <= #half_clk 1'bx;
                Bw_n <= #half_clk 1'bx;
                Dq_reg <= #half_clk {data_bits{1'bz}};
        end
        endtask

	// Continue Write2
        task cont_write2;
                input       global_wr;
                input       bwrite_en;
                input [3:0] write_en;
                input [data_bits - 1 : 0] data;
        begin
                Cs1_n <= 1'b1;
                Adsc_n <= 1'b1;
                Adv_n <= 1'b0;
                We_n <= write_en;
                Gw_n <= global_wr;
                Bw_n <= bwrite_en;
                Dq_reg <= data;

                Cs1_n <= #half_clk 1'bx;
                Adsc_n <= #half_clk 1'bx;
                Adv_n <= #half_clk 1'bx; 
                We_n <= #half_clk 4'bxxxx;
                Gw_n <= #half_clk 1'bx;
                Bw_n <= #half_clk 1'bx;
                Dq_reg <= #half_clk {data_bits{1'bz}};
        end
        endtask
 
	// Single read1 (ADSP_N controlled)
	task read1;
		input [addr_bits - 1 : 0] addr;
	begin
		A <= addr;
		Adsp_n <= 1'b0;
                Cs1_n <= 1'b0;
                Cs2 <= 1'b1;
                Cs2_n <= 1'b0;

		Adsp_n <= #half_clk 1'bx;
		Cs1_n <= #half_clk 1'bx;
		Cs2 <= #half_clk 1'bx;
		Cs2_n <= #half_clk 1'bx;
	end
	endtask

	// Single read2 (ADSC_N controlled)
        task read2;
                input [addr_bits - 1 : 0] addr;
        begin
                A <= addr;
                Adsp_n <= 1'b1;
                Adsc_n <= 1'b0;
                Cs1_n <= 1'b0;
                Cs2 <= 1'b1;
                Cs2_n <= 1'b0;
                Gw_n <= 1'b1;

                Adsp_n <= #half_clk 1'bx;
                Cs1_n <= #half_clk 1'bx;
                Cs2 <= #half_clk 1'bx;
                Cs2_n <= #half_clk 1'bx;
                Gw_n <= #half_clk 1'bx;
        end
        endtask

	// Continue read1
 	task cont_read1; 
        begin
                Adsp_n <= 1'b1;
                Adsc_n <= 1'b1;
                Adv_n <= 1'b0;
                Gw_n <= 1'b1;

                Adsp_n <= #half_clk 1'bx;
                Adsc_n <= #half_clk 1'bx;
		Adv_n <= #half_clk 1'bx;
		Gw_n <= #half_clk 1'bx;
        end
        endtask

	// Continue read2
        task cont_read2;
        begin
                Cs1_n <= 1'b1;
                Adsc_n <= 1'b1;
                Adv_n <= 1'b0;
                Gw_n <= 1'b1;

                Cs1_n <= #half_clk 1'bx;
                Adsc_n <= #half_clk 1'bx;
                Adv_n <= #half_clk 1'bx;
                Gw_n <= #half_clk 1'bx;
        end
        endtask

	// Suspend Write1
        task sus_write1;
                input       global_wr;
                input       bwrite_en;
                input [3:0] write_en;
                input [data_bits - 1 : 0] data;
        begin
                Adsp_n <= 1'b1;
                Adsc_n <= 1'b1;
                Adv_n <= 1'b1;
                We_n <= write_en;
                Gw_n <= global_wr;
                Bw_n <= bwrite_en;
                Dq_reg <= data;

                Adsp_n <= #half_clk 1'bx;
                Adsc_n <= #half_clk 1'bx;
                Adv_n <= #half_clk 1'bx;
                We_n <= #half_clk 4'bxxxx;
                Gw_n <= #half_clk 1'bx;
                Bw_n <= #half_clk 1'bx;
                Dq_reg <= #half_clk {data_bits{1'bz}};
        end
        endtask	
	
	// Suspend Write2
        task sus_write2;
                input       global_wr;
                input       bwrite_en;
                input [3:0] write_en;
                input [data_bits - 1 : 0] data;
        begin
                Cs1_n <= 1'b1;
                Adsc_n <= 1'b1;
                Adv_n <= 1'b1;
                We_n <= write_en;
                Gw_n <= global_wr;
                Bw_n <= bwrite_en;
                Dq_reg <= data;

                Cs1_n <= #half_clk 1'bx;
                Adsc_n <= #half_clk 1'bx;
                Adv_n <= #half_clk 1'bx;
                We_n <= #half_clk 4'bxxxx;
                Gw_n <= #half_clk 1'bx;
                Bw_n <= #half_clk 1'bx;
                Dq_reg <= #half_clk {data_bits{1'bz}};
        end
        endtask

        // Suspend read1
        task sus_read1;
        begin
                Adsp_n <= 1'b1;
                Adsc_n <= 1'b1;
                Adv_n <= 1'b1;
                Gw_n <= 1'b1;

                Adsp_n <= #half_clk 1'bx;
                Adsc_n <= #half_clk 1'bx;
                Adv_n <= #half_clk 1'bx;
                Gw_n <= #half_clk 1'bx;
        end
        endtask

        // Continue read2
        task sus_read2;
        begin
                Adsp_n <= 1'b1;
                Adsc_n <= 1'b1;
                Adv_n <= 1'b1;
                Gw_n <= 1'b1;

                Cs1_n <= #half_clk 1'bx;
                Adsp_n <= #half_clk 1'bx;
                Adsc_n <= #half_clk 1'bx;
                Adv_n <= #half_clk 1'bx;
                Gw_n <= #half_clk 1'bx;
        end
        endtask

	// Test Vectors
	initial begin
		#full_clk;
		#full_clk;
		#full_clk;
		#quar_clk;
		Oe_n = 1'b1;
		write(19'h00000, 1'b1, 1'b0, 4'b0000, 32'h00000000); 
		#full_clk;
		write(19'h01111, 1'b1, 1'b0, 4'b0000, 32'h11111111); 
		#full_clk;
		cont_write1(1'b1, 1'b0, 4'b0000, 32'h22222222); 
		#full_clk;
		cont_write2(1'b1, 1'b0, 4'b0000, 32'h33333333); 
		#full_clk;
		cont_write1(1'b1, 1'b0, 4'b0000, 32'h44444444); 
		#full_clk;
		cont_write2(1'b1, 1'b0, 4'b0000, 32'h55555555); 
		#full_clk;
		sus_write1(1'b1, 1'b0, 4'b0000, 32'h66666666); 
		#full_clk;
		sus_write2(1'b1, 1'b0, 4'b0000, 32'h77777777); 
		#full_clk;
		Oe_n = 1'b0;
		read1(19'h00000);
		#full_clk;
		read2(19'h01111);
		#half_clk;
		#half_clk;
		cont_read1;
		#full_clk;
		cont_read2;
		#full_clk;
		cont_read1;
		#full_clk;
		cont_read2;
		#full_clk;
		sus_read1;
		#full_clk;
		sus_read2;
		#full_clk;
		sus_read2;
		#full_clk;
		#full_clk;
		#full_clk;
		#full_clk;
		#full_clk;
		$finish;
	end

endmodule
