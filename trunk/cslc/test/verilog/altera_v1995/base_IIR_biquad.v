module base_iir_biquad (
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
   //[a,b] = ellip(FilterOrder,3,50,300/500)
   parameter b1=219;	//0.2138
   parameter b2=463;	//0.4518
   parameter a0=303;	//0.2958
   parameter a1=602;	//0.5876
   parameter a2=303; 	//0.2958
   parameter INPUT_WIDTH = 18;
   parameter COEF_WIDTH = 10;
   parameter DLY_WIDTH = 18;
   parameter OUTPUT_WIDTH = 2 * DLY_WIDTH + 2;				
   parameter L_BIT = COEF_WIDTH;								// low bit 
   parameter H_BIT = L_BIT + DLY_WIDTH - 1;						// high bit

    //Port Declaration
   input clk;
   input clken;
   input reset;
   input [INPUT_WIDTH-1:0] x;
   output [OUTPUT_WIDTH-1:0] result;
   output [OUTPUT_WIDTH-2:0] feedback_fp;
   output [DLY_WIDTH-1:0] wn, feedback;


   //Wire Declaration
   wire [DLY_WIDTH-1:0] coef_b1, coef_b2, coef_a0, coef_a1, coef_a2;
   wire [DLY_WIDTH-1:0] wn;
   wire [DLY_WIDTH-1:0] feedback;
   wire [OUTPUT_WIDTH-2:0] feedback_fp;
  
   

   assign coef_b1 = -b1;										// SBF 8.10
   assign coef_b2 = -b2;										// SBF 8.10
   assign coef_a0 = a0;											// SBF 8.10
   assign coef_a1 = a1;											// SBF 8.10
   assign coef_a2 = a2;										    // SBF 8.10
   assign feedback = feedback_fp[H_BIT:L_BIT];					// SBF 14.4

   four_mult_add	four_mult_add_inst (
	.clock0 ( clk ),
	.aclr3 ( reset ),
	.ena0 ( clken ),
	.dataa_0 (wn ),
	.dataa_2 ( wn ),
	.datab_0 ( coef_a1 ),
	.datab_1 ( coef_a2 ),
	.datab_2 ( coef_a0 ),
	.result ( result )											// SBF 24.14
	);

   two_mult_add	two_mult_add_inst (
	.clock0 ( clk ),
	.dataa_0 ( wn ),
	.aclr3 ( reset ),
	.datab_0 ( coef_b1 ),
	.datab_1 ( coef_b2 ),
	.ena0 ( clken ),
	.result ( feedback_fp )
	);

   adder	adder_inst (
	.dataa ( x ),
	.datab ( feedback ),
	//.clock ( clk ),
	//.aclr ( reset ),
	//.clken ( clken ),
	.result ( wn ),
	.cout ( ),
	.overflow (  )
	);
	

endmodule