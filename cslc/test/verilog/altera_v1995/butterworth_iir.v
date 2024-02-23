module butterworth_iir (
	    reset,
	    clk,
	    clken,
	    x,
	    result
	    );

   //Parameter Declaration
   //Coefficients - 10 bits
   //FilterOrder = 4
   //[a,b] = butter(FilterOrder,300/500)
   //[SOS,G] = tf2sos(a,b)  
   //SOS = 1.000 2.000 1.000 1.000 0.3290 0.0646
   //      1.000 2.000 1.000 1.000 0.4531 0.4663
   //G = 0.1672
   //Filter coefficients and gain are represented using SBF 0.10 
   //Biquad1
   parameter b11=337;	//0.329  
   parameter b12=66;	//0.0646 
   parameter a10=1024;	//1.000  
   parameter a11=2048;	//2.000  
   parameter a12=1024; 	//1.000  
   //Biquad2
   parameter b21=464;	//0.4531
   parameter b22=478;	//0.4663
   parameter a20=1024;	//1.000
   parameter a21=2048;	//2.000
   parameter a22=1024; 	//1.000

   parameter GAIN = 171; // 0.1672

   parameter INPUT_WIDTH = 12;
   parameter COEF_WIDTH = 10;
   parameter DLY_WIDTH = 18;
   parameter F_BITS = 4;										// fractional bits
   parameter OUTPUT_WIDTH = 21;					
   parameter L_BIT = COEF_WIDTH ;								// low bit 
   parameter H_BIT = L_BIT + OUTPUT_WIDTH - 1;					// high bit

    //Port Declaration
   input clk;
   input clken;
   input reset;
   input [INPUT_WIDTH-1:0] x;
   output [OUTPUT_WIDTH-1:0] result;							//SBF 17.4
  
  
   //Wire Declaration
   wire [OUTPUT_WIDTH-1:0] 	out_biquad1;
   wire [F_BITS-1:0] 		pzeros;
   wire [DLY_WIDTH-1:0] 	xn;
   wire [OUTPUT_WIDTH-1:0] 	result_w;
   wire [COEF_WIDTH-1:0]    iir_gain;
   wire [OUTPUT_WIDTH+COEF_WIDTH-1:0]	gain_out;
  
 
   //Reg Declaration
   reg [DLY_WIDTH-1:0]      xn_reg;
   reg [OUTPUT_WIDTH-1:0] 	result;
   reg [DLY_WIDTH-1:0] 		in_biquad2;

   assign pzeros = 0;
   assign iir_gain = GAIN;
   assign xn = {x[INPUT_WIDTH-1], x[INPUT_WIDTH-1], x[INPUT_WIDTH-1:0], pzeros[F_BITS-1:0]};		// SBF 14.4

   

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
				result <= gain_out[H_BIT:L_BIT];
				in_biquad2 <= out_biquad1[DLY_WIDTH-1:0];
			end
	end

   butterworth_iir_biquad butterworth_iir_biquad1 (
	.clk ( clk ),
	.clken ( clken ),
	.reset ( reset ),
	.x ( xn_reg ),
	.result ( out_biquad1 ));
    defparam
		butterworth_iir_biquad1.b1 = b11,
		butterworth_iir_biquad1.b2 = b12;
		
	
    butterworth_iir_biquad butterworth_iir_biquad2 (
	.clk ( clk ),
	.clken ( clken ),
	.reset ( reset ),
	.x ( in_biquad2 ),
	.result ( result_w ));
    defparam
		butterworth_iir_biquad2.b1 = b21,
		butterworth_iir_biquad2.b2 = b22;
		
	gain_blk	gain_blk_inst (
	.dataa ( result_w ),
	.datab ( iir_gain ),
	.result ( gain_out )
	);

	

	
endmodule