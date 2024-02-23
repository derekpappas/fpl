module base_iir (
	    reset,
	    clk,
	    clken,
	    x,
	    result
	    );

   //Parameter Declaration
   //Coefficients -> 10 bits
   //[a,b] = ellip(FilterOrder,3,50,300/500)
   //Biquad1
   parameter b11=-549;	//-0.5361
   parameter b12=424;	//0.4138
   parameter a10=114;	//0.1116
   parameter a11=214;	//0.2086
   parameter a12=114; 	//0.1116
   //Biquad2
   parameter b21=522;	//0.5099
   parameter b22=890;	//0.8690
   parameter a20=1024;	//1.0
   parameter a21=1458;	//1.4239
   parameter a22=1024; 	//1.0	

   parameter INPUT_WIDTH = 13;
   parameter COEF_WIDTH = 10;
   parameter DLY_WIDTH = 18;
   parameter F_BITS = 4;										// fractional bits
   parameter OUTPUT_WIDTH = 2 * DLY_WIDTH + 2;					// 38
   parameter L_BIT = COEF_WIDTH ;								// low bit 
   parameter H_BIT = L_BIT + DLY_WIDTH - 1;						// high bit

    //Port Declaration
   input clk;
   input clken;
   input reset;
   input [INPUT_WIDTH-1:0] x;
   output [OUTPUT_WIDTH-1:0] result;
  

   //Wire Declaration
   wire [OUTPUT_WIDTH-1:0] 	out_biquad1;
   wire [F_BITS-1:0] 		pzeros;
   wire [DLY_WIDTH-1:0] 	xn;
   wire [OUTPUT_WIDTH-1:0] 	result_w;
   //wire [DLY_WIDTH-1:0] 		in_biquad2;

 
   //Reg Declaration
   reg [DLY_WIDTH-1:0]      xn_reg;
   reg [OUTPUT_WIDTH-1:0] 	result;
   reg [DLY_WIDTH-1:0] 		in_biquad2;

   assign pzeros = 0;
   assign xn = {x[INPUT_WIDTH-1], x[INPUT_WIDTH-1:0], pzeros[F_BITS-1:0]};		// SBF 14.4
   //assign in_biquad2 = out_biquad1[H_BIT:L_BIT];								// SBF 14.4

   always @ (posedge clk)
     begin
         if (reset) 
            begin
				xn_reg <= 0;
				result <= 0;
				in_biquad2 <= 0;
			end
		 else if (clken)
			begin
			    xn_reg <= xn;
				result <= result_w;
				in_biquad2 <= out_biquad1[H_BIT:L_BIT];
			end
	end

   base_iir_biquad base_iir_biquad1 (
	.clk ( clk ),
	.clken ( clken ),
	.reset ( reset ),
	.x ( xn_reg ),
	.result ( out_biquad1 ));
    defparam
		base_iir_biquad1.b1 = b11,
		base_iir_biquad1.b2 = b12,
		base_iir_biquad1.a0 = a10,
		base_iir_biquad1.a1 = a11,
		base_iir_biquad1.a2 = a12;
	
	base_iir_biquad base_iir_biquad2 (
	.clk ( clk ),
	.clken ( clken ),
	.reset ( reset ),
	.x ( in_biquad2 ),
	.result ( result_w ));
    defparam
		base_iir_biquad2.b1 = b21,
		base_iir_biquad2.b2 = b22,
		base_iir_biquad2.a0 = a20,
		base_iir_biquad2.a1 = a21,
		base_iir_biquad2.a2 = a22;
			

	
endmodule