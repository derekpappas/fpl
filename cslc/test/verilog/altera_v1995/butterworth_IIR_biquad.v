module butterworth_iir_biquad (
	    reset,
	    clk,
	    clken,
	    x,
	    result,
	    feedback_fp,
	    feedback,
	    wn
	    );

   //Parameter Declaration
   //Coefficients - 10 bits
   //[a,b] = butter(FilterOrder,300/500)
   //[SOS,G] = tf2sos(a,b)  
   //SOS = 1.000 2.000 1.000 1.000 0.3695 0.1958
   //G = 0.3913
   parameter b1=378;	//0.3695
   parameter b2=201;	//0.1958
   parameter a0=1024;	//1.000
   parameter a1=2048;	//2.000
   parameter a2=1024; 	//1.000
   parameter INPUT_WIDTH = 18;
   parameter COEF_WIDTH = 10;
   parameter DLY_WIDTH = 18;
   parameter OUTPUT_WIDTH = 21;	
   parameter FEEDBACK_WIDTH = 2 * DLY_WIDTH + 1;
   parameter L_BIT = COEF_WIDTH;								// low bit 
   parameter H_BIT = L_BIT + DLY_WIDTH - 1;						// high bit

    //Port Declaration
   input clk;
   input clken;
   input reset;
   input [INPUT_WIDTH-1:0] x;
   output [OUTPUT_WIDTH-1:0] result;
   output [FEEDBACK_WIDTH-1:0] feedback_fp;
   output [DLY_WIDTH-1:0] wn, feedback;


   //Wire Declaration
   wire [DLY_WIDTH-1:0] coef_b1, coef_b2;
   wire [DLY_WIDTH-1:0] wn;
   wire [DLY_WIDTH-1:0] feedback;
   wire [FEEDBACK_WIDTH-1:0] feedback_fp;
   wire [DLY_WIDTH+1:0] wn_shift, wn1_shift, ff_adder1_res;
   wire [DLY_WIDTH+2:0] tmp_wn_add, wn2_shift;
   wire					wn_shift_sb, wn1_shift_sb, wn2_shift_sb;

   //Register Declaration
   reg [DLY_WIDTH-1:0] ff_reg1, ff_reg2;
   

   assign coef_b1 = -b1;										// SBF 8.10
   assign coef_b2 = -b2;										// SBF 8.10
   assign feedback = feedback_fp[H_BIT:L_BIT];					// SBF 14.4

   assign wn_shift_sb = wn[DLY_WIDTH-1];
   assign wn1_shift_sb = ff_reg1[DLY_WIDTH-1];
   assign wn2_shift_sb = ff_reg2[DLY_WIDTH-1];
   assign wn_shift = { wn_shift_sb, wn_shift_sb, wn[DLY_WIDTH-1:0] };	// SBF 16.4
   assign wn1_shift = { wn1_shift_sb, ff_reg1[DLY_WIDTH-1:0], 1'b0 };	// SBF 16.4
   assign tmp_wn_add = { ff_adder1_res[DLY_WIDTH+1], ff_adder1_res[DLY_WIDTH+1:0] };   	// SBF 17.4
   assign wn2_shift = { wn2_shift_sb, wn2_shift_sb, wn2_shift_sb, ff_reg2[DLY_WIDTH-1:0] }; // SBF 17.4
   

   always @ (posedge clk)
    begin
        if (reset)
          begin
	 		ff_reg1 <= 0;
			ff_reg2 <= 0;
		  end
	    else if (clken)
	      begin
			ff_reg1 <= wn;
			ff_reg2 <= ff_reg1;
		  end
    end
      
   two_mult_add	two_mult_add_inst (
	.clock0 ( clk ),
	.dataa_0 ( wn ),
	.aclr3 ( reset ),
	.datab_0 ( coef_b1 ),
	.datab_1 ( coef_b2 ),
	.ena0 ( clken ),
	.result ( feedback_fp )
	);


   fb_adder	fb_adder_inst (
	.dataa ( x ),
	.datab ( feedback ),
	.result ( wn ),
	.cout ( ),
	.overflow (  )
	);
	
	ff_adder1	ff_adder1_inst (
	.dataa ( wn_shift ),
	.datab ( wn1_shift ),
	.result ( ff_adder1_res ),
	.cout (  ),
	.overflow (  )
	);

    ff_adder2	ff_adder2_inst (
	.dataa ( tmp_wn_add ),
	.datab ( wn2_shift ),
	.clock ( clk ),
	.aclr ( reset ),
	.clken ( clken ),
	.result ( result ),
	.cout (  ),
	.overflow (  )
	);


endmodule