//------------------------------------------------------------------------
//   This Verilog file was developed by Altera Corporation.  It may be
// freely copied and/or distributed at no cost.  Any persons using this
// file for any purpose do so at their own risk, and are responsible for
// the results of such use.  Altera Corporation does not guarantee that
// this file is complete, correct, or fit for any particular purpose.
// NO WARRANTY OF ANY KIND IS EXPRESSED OR IMPLIED.  This notice must
// accompany any copy of this file.
//
//------------------------------------------------------------------------
// LPM Synthesizable Models 
//------------------------------------------------------------------------
// Version 1.6 (lpm 220)      Date 10/10/01
//
// Reorder parameter for consistence with VHDL package.
//   sample checking the parameter vaule to ensure correct version is used.
//   correct wrong lpm_type declaration for lpm_or
//
//------------------------------------------------------------------------
// Version 1.5 (lpm 220)      Date 12/17/99
//
// Modified LPM_ADD_SUB and LPM_MULT to accomodate LPM_WIDTH = 1.
//   Default values for LPM_WIDTH* are changed back to 1.
// Added LPM_HINT to LPM_DIVIDE.
// Rewritten LPM_FIFO_DC to output correctly.
// Modified LPM_FIFO to output 0s before first read, output correct
//   values after aclr and sclr, and output LPM_NUMWORDS mod
//   exp(2, LPM_WIDTHU) when FIFO is full.
//
//------------------------------------------------------------------------
// Version 1.4.1 (lpm 220)    Date 10/29/99
//
// Default values for LPM_WIDTH* of LPM_ADD_SUB and LPM_MULT are changed
//   from 1 to 2.
//
//------------------------------------------------------------------------
// Version 1.4 (lpm 220)      Date 10/18/99
//
// Default values for each optional inputs for ALL modules are added.
// Some LPM_PVALUE implementations were missing, and now implemented.
//
//------------------------------------------------------------------------
// Version 1.3 (lpm 220)      Date 06/23/99
//
// Corrected LPM_FIFO and LPM_FIFO_DC cout and empty/full flags.
// Implemented LPM_COUNTER cin/cout, and LPM_MODULUS is now working.
//
//------------------------------------------------------------------------
// Version 1.2 (lpm 220)      Date 06/16/99
//
// Added LPM_RAM_DP, LPM_RAM_DQ, LPM_IO, LPM_ROM, LPM_FIFO, LPM_FIFO_DC.
// Parameters and ports are added/discarded according to the spec.
//
//------------------------------------------------------------------------
// Version 1.1 (lpm 220)      Date 02/05/99
//
// Added LPM_DIVIDE module.
//
//------------------------------------------------------------------------
// Version 1.0                Date 07/09/97
//
//------------------------------------------------------------------------
// Excluded Functions:
//
//  LPM_FSM and LPM_TTABLE.
//
//------------------------------------------------------------------------
// Assumptions:
//
// 1. LPM_SVALUE, LPM_AVALUE, LPM_MODULUS, and LPM_NUMWORDS,
//    LPM_STRENGTH, LPM_DIRECTION, and LPM_PVALUE  default value is
//    string UNUSED.
//
//------------------------------------------------------------------------
// Verilog Language Issues:
//
// Two dimensional ports are not supported. Modules with two dimensional
// ports are implemented as one dimensional signal of (LPM_SIZE * LPM_WIDTH)
// bits wide.
//
//------------------------------------------------------------------------
// Synthesis Issues:
// 
// 1. LPM_COUNTER 
//
// Currently synthesis tools do not allow mixing of level and edge
// sensetive signals. To overcome that problem the "data" signal is
// removed from the clock always block of lpm_counter, however the
// synthesis result is accurate. For correct simulation add the "data"
// pin to the sensetivity list as follows:
//
//  always @(posedge clock or posedge aclr or posedge aset or 
//           posedge aload or data)
//------------------------------------------------------------------------

module lpm_constant ( result );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_cvalue = 0;
	parameter lpm_strength = "UNUSED";
	parameter lpm_type = "lpm_constant";
	parameter lpm_hint = "UNUSED";

	output [lpm_width-1:0] result;

	assign result = lpm_cvalue;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_constant") || (lpm_type !== "lpm_constant"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_constant

//------------------------------------------------------------------------

module lpm_inv ( result, data );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_type = "lpm_inv";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] data;
	output [lpm_width-1:0] result;

	reg    [lpm_width-1:0] result;

	always @(data)
	begin
		result = ~data;
	end

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_inv") || (lpm_type !== "lpm_inv"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_inv

//------------------------------------------------------------------------

module lpm_and ( result, data );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_size = 1;
	parameter lpm_type = "lpm_and";
	parameter lpm_hint = "UNUSED";

	input  [(lpm_size * lpm_width)-1:0] data;
	output [lpm_width-1:0] result;

	reg    [lpm_width-1:0] result;
	integer i, j, k;

	always @(data)
	begin
		for (i=0; i<lpm_width; i=i+1)
		begin
			result[i] = data[i];
			for (j=1; j<lpm_size; j=j+1)
			begin
				k = j * lpm_width + i;
				result[i] = result[i] & data[k];
			end
		end
	end

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_and") || (lpm_type !== "lpm_and"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_and

//------------------------------------------------------------------------

module lpm_or ( result, data );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_size = 1;
	parameter lpm_type = "lpm_or";
	parameter lpm_hint  = "UNUSED";

	input  [(lpm_size * lpm_width)-1:0] data;
	output [lpm_width-1:0] result;

	reg    [lpm_width-1:0] result;
	integer i, j, k;

	always @(data)
	begin
		for (i=0; i<lpm_width; i=i+1)
		begin
			result[i] = data[i];
			for (j=1; j<lpm_size; j=j+1)
			begin
				k = j * lpm_width + i;
				result[i] = result[i] | data[k];
			end
		end
	end

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_or") || (lpm_type !== "lpm_or"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_or

//------------------------------------------------------------------------

module lpm_xor ( result, data );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_size = 1;
	parameter lpm_type = "lpm_xor";
	parameter lpm_hint  = "UNUSED";

	input  [(lpm_size * lpm_width)-1:0] data;
	output [lpm_width-1:0] result;

	reg    [lpm_width-1:0] result;
	integer i, j, k;

	always @(data)
	begin
		for (i=0; i<lpm_width; i=i+1)
		begin
			result[i] = data[i];
			for (j=1; j<lpm_size; j=j+1)
			begin
				k = j * lpm_width + i;
				result[i] = result[i] ^ data[k];
			end
		end
	end

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_xor") || (lpm_type !== "lpm_xor"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_xor

//------------------------------------------------------------------------

module lpm_bustri ( result, tridata, data, enabledt, enabletr );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_type = "lpm_bustri";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] data;
	input  enabledt;
	input  enabletr;
	output [lpm_width-1:0] result;
	inout  [lpm_width-1:0] tridata;

	reg    [lpm_width-1:0] result;
	reg    [lpm_width-1:0] tmp_tridata;

	tri0  enabledt;
	tri0  enabletr;
	buf (i_enabledt, enabledt);
	buf (i_enabletr, enabletr);

	always @(data or tridata or i_enabletr or i_enabledt)
	begin
		if (i_enabledt == 0 && i_enabletr == 1)
		begin
			result = tridata;
			tmp_tridata = 'bz;
		end
		else if (i_enabledt == 1 && i_enabletr == 0)
		begin
			result = 'bz;
			tmp_tridata = data;
		end
		else if (i_enabledt == 1 && i_enabletr == 1)
		begin
			result = data;
			tmp_tridata = data;
		end
		else
		begin
			result = 'bz;
			tmp_tridata = 'bz;
		end
	end

	assign tridata = tmp_tridata;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_bustri") || (lpm_type !== "lpm_bustri"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_bustri

//------------------------------------------------------------------------

module lpm_mux ( result, clock, clken, data, aclr, sel );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_size = 1;
	parameter lpm_widths = 1;
	parameter lpm_pipeline = 0;
	parameter lpm_type = "lpm_mux";
	parameter lpm_hint  = "UNUSED";

	input [(lpm_size * lpm_width)-1:0] data;
	input aclr;
	input clock;
	input clken;
	input [lpm_widths-1:0] sel;
	output [lpm_width-1:0] result;

	integer i, j, m, n;
	reg [lpm_width-1:0] tmp_result;
	reg [lpm_width-1:0] tmp_result2 [lpm_pipeline:0];

	tri0 aclr;
	tri0 clock;
	tri1 clken;

	buf (i_aclr, aclr);
	buf (i_clock, clock);
	buf (i_clken, clken);

	always @(data or sel)
	begin
		tmp_result = 0;
		for (m=0; m<lpm_width; m=m+1)
		begin
			n = sel * lpm_width + m;
			tmp_result[m] = data[n];
		end
	end

	always @(posedge i_clock or posedge i_aclr)
	begin
		if (i_aclr)
		begin
			for (i = 0; i <= lpm_pipeline; i = i + 1)
				tmp_result2[i] = 'b0;
		end
		else if (i_clken == 1)
		begin
			tmp_result2[lpm_pipeline] = tmp_result;
			for (j = 0; j < lpm_pipeline; j = j +1)
				tmp_result2[j] = tmp_result2[j+1];
		end
	end

	assign result = (lpm_pipeline > 0) ? tmp_result2[0] : tmp_result;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_mux") || (lpm_type !== "lpm_mux"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_mux

//------------------------------------------------------------------------

module lpm_decode ( eq, data, enable, clock, clken, aclr );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_decodes = 1 << lpm_width;
	parameter lpm_pipeline = 0;
	parameter lpm_type = "lpm_decode";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] data;
	input  enable;
	input  clock;
	input  clken;
	input  aclr;
	output [lpm_decodes-1:0] eq;

	reg    [lpm_decodes-1:0] tmp_eq2 [lpm_pipeline:0];
	reg    [lpm_decodes-1:0] tmp_eq;
	integer i, j;

	tri0   clock;
	tri1   clken;
	tri0   aclr;
	tri1   enable;

	buf (i_clock, clock);
	buf (i_clken, clken);
	buf (i_aclr, aclr);
	buf (i_enable, enable);


	always @(data or i_enable)
	begin
		tmp_eq = 0;
		if (i_enable)
		begin
			if ((data < lpm_decodes))
			begin
				tmp_eq[data] = 1'b1;
			end
		else
			tmp_eq = 0;
		end
	end
 
	always @(posedge i_clock or posedge i_aclr)
	begin
		if (i_aclr)
		begin 
			for (i = 0; i <= lpm_pipeline; i = i + 1)
				tmp_eq2[i] = 'b0;
		end
		else if (clken == 1) 
		begin
			tmp_eq2[lpm_pipeline] = tmp_eq;
			for (j = 0; j < lpm_pipeline; j = j +1)
				tmp_eq2[j] = tmp_eq2[j+1];
		end
	end

	assign eq = (lpm_pipeline > 0) ? tmp_eq2[0] : tmp_eq;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_decode") || (lpm_type !== "lpm_decode"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_decode

//------------------------------------------------------------------------

module lpm_clshift ( result, overflow, underflow, data, direction, distance );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_widthdist = 1;
	parameter lpm_shifttype = "LOGICAL";
	parameter lpm_type = "lpm_clshift";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] data;
	input  [lpm_widthdist-1:0] distance;
	input  direction;
	output [lpm_width-1:0] result;
	output overflow;
	output underflow;

	reg    [lpm_width-1:0] ONES;
	reg    [lpm_width-1:0] result;
	reg    overflow, underflow;
	integer i;

	tri0  direction;

	buf (i_direction, direction);

//---------------------------------------------------------------//
	function [lpm_width+1:0] LogicShift;
		input [lpm_width-1:0] data;
		input [lpm_widthdist-1:0] dist;
		input direction;
		reg   [lpm_width-1:0] tmp_buf;
		reg   overflow, underflow;
				
		begin
			tmp_buf = data;
			overflow = 1'b0;
			underflow = 1'b0;
			if ((direction) && (dist > 0)) // shift right
			begin
				tmp_buf = data >> dist;
				if ((data != 0) && ((dist >= lpm_width) || (tmp_buf == 0)))
					underflow = 1'b1;
			end
			else if (dist > 0) // shift left
			begin
				tmp_buf = data << dist;
				if ((data != 0) && ((dist >= lpm_width)
					|| ((data >> (lpm_width-dist)) != 0)))
					overflow = 1'b1;
			end
			LogicShift = {overflow,underflow,tmp_buf[lpm_width-1:0]};
		end
	endfunction

//---------------------------------------------------------------//
	function [lpm_width+1:0] ArithShift;
		input [lpm_width-1:0] data;
		input [lpm_widthdist-1:0] dist;
		input direction;
		reg   [lpm_width-1:0] tmp_buf;
		reg   overflow, underflow;
		
		begin
			tmp_buf = data;
			overflow = 1'b0;
			underflow = 1'b0;

			if (direction && (dist > 0))   // shift right
			begin
				if (data[lpm_width-1] == 0) // positive number
				begin
					tmp_buf = data >> dist;
					if ((data != 0) && ((dist >= lpm_width) || (tmp_buf == 0)))
						underflow = 1'b1;
				end
				else // negative number
				begin
					tmp_buf = (data >> dist) | (ONES << (lpm_width - dist));
					if ((data != ONES) && ((dist >= lpm_width-1) || (tmp_buf == ONES)))
						underflow = 1'b1;
				end
			end
			else if (dist > 0) // shift left
			begin
				tmp_buf = data << dist;
				if (data[lpm_width-1] == 0) // positive number
				begin
					if ((data != 0) && ((dist >= lpm_width-1) 
					|| ((data >> (lpm_width-dist-1)) != 0)))
						overflow = 1'b1;
				end
				else // negative number
				begin
					if ((data != ONES) && ((dist >= lpm_width) 
					|| (((data >> (lpm_width-dist-1))|(ONES << (dist+1))) != ONES)))
						overflow = 1'b1;
				end
			end
			ArithShift = {overflow,underflow,tmp_buf[lpm_width-1:0]};
		end
	endfunction

//---------------------------------------------------------------//
	function [lpm_width-1:0] RotateShift;
		input [lpm_width-1:0] data;
		input [lpm_widthdist-1:0] dist;
		input direction;
		reg   [lpm_width-1:0] tmp_buf;
		
		begin
			tmp_buf = data;
			if ((direction) && (dist > 0)) // shift right
			begin
				tmp_buf = (data >> dist) | (data << (lpm_width - dist));
			end
			else if (dist > 0) // shift left
			begin
				tmp_buf = (data << dist) | (data >> (lpm_width - dist));
			end
			RotateShift = tmp_buf[lpm_width-1:0];
		end
	endfunction
//---------------------------------------------------------------//

	initial
	begin
		for (i=0; i < lpm_width; i=i+1)
			ONES[i] = 1'b1;
	end

	always @(data or i_direction or distance)
	begin
		// lpm_shifttype is optional and default to LOGICAL
		if ((lpm_shifttype == "LOGICAL"))
		begin
			{overflow,underflow,result} = LogicShift(data,distance,i_direction);
		end
		else if (lpm_shifttype == "ARITHMETIC")
		begin
			{overflow,underflow,result} = ArithShift(data,distance,i_direction);
		end
		else if (lpm_shifttype == "ROTATE")
		begin
			result = RotateShift(data, distance, i_direction);
			overflow = 1'b0;
			underflow = 1'b0;
		end
		else
		begin
			result = 'bx;
			overflow = 1'b0;
			underflow = 1'b0;
		end
	end

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_clshift") || (lpm_type !== "lpm_clshift"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_clshift

//------------------------------------------------------------------------

module lpm_add_sub ( result, cout, overflow,
					 add_sub, cin, dataa, datab, clock, clken, aclr );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_direction  = "UNUSED";
	parameter lpm_representation = "UNSIGNED";
	parameter lpm_pipeline = 0;
	parameter lpm_type = "lpm_add_sub";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] dataa, datab;
	input  add_sub, cin;
	input  clock;
	input  clken;
	input  aclr;
	output [lpm_width-1:0] result;
	output cout, overflow;

	reg  [lpm_width-1:0] tmp_result;
	reg  [lpm_width-1:0] tmp_result2 [lpm_pipeline:0];
	reg  [lpm_pipeline:0] tmp_cout2;
	reg  [lpm_pipeline:0] tmp_overflow2;
	reg  tmp_cout;
	reg  tmp_overflow;
	reg  [lpm_width-1:0] tmp_a, tmp_b;
	integer i, j, k, n;
	integer dataa_int, datab_int, result_int, compare, borrow; 

	tri0 aclr;
	tri0 clock;
	tri1 clken;
	tri0 cin;
	tri1 add_sub;

	buf (i_aclr, aclr);
	buf (i_clock, clock);
	buf (i_clken, clken);
	buf (i_cin, cin);
	buf (i_add_sub, add_sub);


	always @(i_cin or dataa or datab or i_add_sub)
	begin
		borrow = i_cin ? 0 : 1;
		// cout is the same for both signed and unsign representation.  
		if (lpm_direction == "ADD" || i_add_sub == 1) 
		begin
			{tmp_cout,tmp_result} = dataa + datab + i_cin;
			tmp_overflow = tmp_cout;
		end
		else if (lpm_direction == "SUB" || i_add_sub == 0) 
		begin
			// subtraction
			{tmp_overflow, tmp_result} = dataa - datab - borrow;
			tmp_cout = (dataa >= (datab+borrow))?1:0;
		end
	
		if (lpm_representation == "SIGNED")
		begin
			// convert to negative integer
			if (dataa[lpm_width-1] == 1)
			begin
				for (j = 0; j < lpm_width; j = j + 1)
					tmp_a[j] = dataa[j] ^ 1;
				dataa_int = (tmp_a) * (-1) - 1;
			end
			else
				dataa_int = dataa;

			// convert to negative integer
			if (datab[lpm_width-1] == 1)
			begin
				for (k = 0; k < lpm_width; k = k + 1)
					tmp_b[k] = datab[k] ^ 1;
				datab_int = (tmp_b) * (-1) - 1;
			end
			else
				datab_int = datab;

			// perform the addtion or subtraction operation
			if (lpm_direction == "ADD" || i_add_sub == 1)
				result_int = dataa_int + datab_int + i_cin;
			else if (lpm_direction == "SUB" || i_add_sub == 0)
				result_int = dataa_int - datab_int - borrow;
			tmp_result = result_int;

			// set the overflow
			compare = 1 << (lpm_width -1);
			if ((result_int > (compare - 1)) || (result_int < (-1)*(compare)))
				tmp_overflow = 1;
			else
				tmp_overflow = 0;
		end
	end
	

	always @(posedge i_clock or posedge i_aclr)
	begin
		if (i_aclr)
		begin
			for (i = 0; i <= lpm_pipeline; i = i + 1)
			begin
				tmp_result2[i] = 'b0;
				tmp_cout2[i] = 1'b0;
				tmp_overflow2[i] = 1'b0;
			end
		end
		else if (i_clken == 1)
		begin
			tmp_result2[lpm_pipeline] = tmp_result;
			tmp_cout2[lpm_pipeline] = tmp_cout;
			tmp_overflow2[lpm_pipeline] = tmp_overflow;
			for (n = 0; n < lpm_pipeline; n = n + 1)
			begin
				tmp_result2[n] = tmp_result2[n+1];
				tmp_cout2[n] = tmp_cout2[n+1];
				tmp_overflow2[n] = tmp_overflow2[n+1];
			end
		end
	end


	assign result = (lpm_pipeline >0) ? tmp_result2[0]:tmp_result;
	assign cout = (lpm_pipeline >0) ? tmp_cout2[0]  : tmp_cout;
	assign overflow = (lpm_pipeline >0) ? tmp_overflow2[0] : tmp_overflow;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_add_sub") || (lpm_type !== "lpm_add_sub"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_add_sub

//------------------------------------------------------------------------

module lpm_compare ( alb, aeb, agb, aleb, aneb, ageb, dataa, datab,
					 clock, clken, aclr );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_representation = "UNSIGNED";
	parameter lpm_pipeline = 0;
	parameter lpm_type = "lpm_compare";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] dataa, datab;
	input  clock;
	input  clken;
	input  aclr;
	output alb, aeb, agb, aleb, aneb, ageb;

	reg    tmp_alb, tmp_aeb, tmp_agb;
	reg    tmp_aleb, tmp_aneb, tmp_ageb;
	reg    [lpm_pipeline:0] tmp_alb2, tmp_aeb2, tmp_agb2;
	reg    [lpm_pipeline:0] tmp_aleb2, tmp_aneb2, tmp_ageb2;
	reg    [lpm_width-1:0] a_int;
	integer i, j, k, l, m, n, o, p, u, dataa_int, datab_int;

	tri0 aclr;
	tri0 clock;
	tri1 clken;

	buf (i_aclr, aclr);
	buf (i_clock, clock);
	buf (i_clken, clken);


	always @(dataa or datab)
	begin
		if (lpm_representation == "UNSIGNED") 
		begin
			dataa_int = dataa[lpm_width-1:0];
			datab_int = datab[lpm_width-1:0];
		end
		else if (lpm_representation == "SIGNED")
		begin
			// convert to negative integer
			if (dataa[lpm_width-1] == 1)
			begin
				for (j = 0; j < lpm_width; j = j + 1)
					a_int[j] = dataa[j] ^ 1;
				dataa_int = (a_int) * (-1) - 1;
			end
			else
				dataa_int = dataa;

			// convert to negative integer
			if (datab[lpm_width-1] == 1)
			begin
				for (j = 0; j < lpm_width; j = j + 1)
					a_int[j] = datab[j] ^ 1;
				datab_int = (a_int) * (-1) - 1;
			end
			else
				datab_int = datab;
		end

		tmp_alb = (dataa_int < datab_int);
		tmp_aeb = (dataa_int == datab_int);
		tmp_agb = (dataa_int > datab_int);
		tmp_aleb = (dataa_int <= datab_int);
		tmp_aneb = (dataa_int != datab_int);
		tmp_ageb = (dataa_int >= datab_int);
	end

	always @(posedge i_clock or posedge i_aclr)
	begin
		if (i_aclr)
		begin 
			for (u = 0; u <= lpm_pipeline; u = u +1)
			begin
				tmp_aeb2[u] = 'b0;
				tmp_agb2[u] = 'b0;
				tmp_alb2[u] = 'b0;
				tmp_aleb2[u] = 'b0;
				tmp_aneb2[u] = 'b0;
				tmp_ageb2[u] = 'b0;
			end
		end
		else if (i_clken == 1)
		begin
			// Assign results to registers
			tmp_alb2[lpm_pipeline] = tmp_alb;
			tmp_aeb2[lpm_pipeline] = tmp_aeb;
			tmp_agb2[lpm_pipeline] = tmp_agb;
			tmp_aleb2[lpm_pipeline] = tmp_aleb;
			tmp_aneb2[lpm_pipeline] = tmp_aneb;
			tmp_ageb2[lpm_pipeline] = tmp_ageb;

			for (k = 0; k < lpm_pipeline; k = k +1)
				tmp_alb2[k] = tmp_alb2[k+1];
			for (l = 0; l < lpm_pipeline; l = l +1)
				tmp_aeb2[l] = tmp_aeb2[l+1];
			for (m = 0; m < lpm_pipeline; m = m +1)
				tmp_agb2[m] = tmp_agb2[m+1];
			for (n = 0; n < lpm_pipeline; n = n +1)
				tmp_aleb2[n] = tmp_aleb2[n+1];
			for (o = 0; o < lpm_pipeline; o = o +1)
				tmp_aneb2[o] = tmp_aneb2[o+1];
			for (p = 0; p < lpm_pipeline; p = p +1)
				tmp_ageb2[p] = tmp_ageb2[p+1];
		end
	end

	assign alb = (lpm_pipeline > 0) ? tmp_alb2[0] : tmp_alb;
	assign aeb = (lpm_pipeline > 0) ? tmp_aeb2[0] : tmp_aeb;
	assign agb = (lpm_pipeline > 0) ? tmp_agb2[0] : tmp_agb;
	assign aleb = (lpm_pipeline > 0) ? tmp_aleb2[0] : tmp_aleb;
	assign aneb = (lpm_pipeline > 0) ? tmp_aneb2[0] : tmp_aneb;
	assign ageb = (lpm_pipeline > 0) ? tmp_ageb2[0] : tmp_ageb;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_compare") || (lpm_type !== "lpm_compare"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_compare

//------------------------------------------------------------------------

module lpm_mult ( result, dataa, datab, sum, clock, clken, aclr );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_widtha = 1;
	parameter lpm_widthb = 1;
	parameter lpm_widths = 1;
	parameter lpm_widthp = 1;
	parameter lpm_representation  = "UNSIGNED";
	parameter lpm_pipeline  = 0;
	parameter lpm_type = "lpm_mult";
	parameter lpm_hint = "UNUSED";

	input  clock;
	input  clken;
	input  aclr;
	input  [lpm_widtha-1:0] dataa;
	input  [lpm_widthb-1:0] datab;
	input  [lpm_widths-1:0] sum;
	output [lpm_widthp-1:0] result;

	// inernal reg
	reg   [lpm_widthp-1:0] tmp_result;
	reg   [lpm_widthp-1:0] tmp_result2 [lpm_pipeline:0];
	reg   [lpm_widtha-1:0] a_int;
	reg   [lpm_widthb-1:0] b_int;
	reg   [lpm_widths-1:0] s_int;
	reg   [lpm_widthp-1:0] p_reg;
	integer p_int;
	integer i, j, k, m, n, p, maxs_mn;
	integer int_dataa, int_datab, int_sum, int_result;

	tri0 aclr;
	tri0 clock;
	tri1 clken;

	buf (i_aclr, aclr);
	buf (i_clock, clock);
	buf (i_clken, clken);


	always @(dataa or datab or sum)
	begin
		if (lpm_representation == "UNSIGNED")
		begin
			int_dataa = dataa;
			int_datab = datab;
			int_sum = sum;
		end
		else if (lpm_representation == "SIGNED")
		begin
			// convert signed dataa
			if (dataa[lpm_widtha-1] == 1)
			begin
				for (i = 0; i < lpm_widtha; i = i + 1)
					a_int[i] = dataa[i] ^ 1;
				int_dataa = (a_int) * (-1) - 1;
			end
			else
				int_dataa = dataa;

			// convert signed datab
			if (datab[lpm_widthb-1] == 1)
			begin
				for (j = 0; j < lpm_widthb; j = j + 1)
					b_int[j] = datab[j] ^ 1;
				int_datab = (b_int) * (-1) - 1;
			end
			else
				int_datab = datab;

			// convert signed sum
			if (sum[lpm_widths-1] == 1)
			begin
				for (k = 0; k < lpm_widths; k = k + 1)
					s_int[k] = sum[k] ^ 1;
				int_sum = (s_int) * (-1) - 1;
			end
			else
				int_sum = sum;
		end
		else 
		begin
			int_dataa = {lpm_widtha{1'bx}};
			int_datab = {lpm_widthb{1'bx}};
			int_sum   = {lpm_widths{1'bx}};
		end

		p_int = int_dataa * int_datab + int_sum;
		maxs_mn = ((lpm_widtha+lpm_widthb)>lpm_widths)?lpm_widtha+lpm_widthb:lpm_widths;
		if (lpm_widthp >= maxs_mn)
			tmp_result = p_int;
		else
		begin
			p_reg = p_int;
			for (m = 0; m < lpm_widthp; m = m + 1)
				tmp_result[lpm_widthp-1-m] = p_reg[maxs_mn-1-m];
		end 
	end

	always @(posedge i_clock or posedge i_aclr)
	begin
	  if (i_aclr)
		begin
			for (p = 0; p <= lpm_pipeline; p = p + 1)
				tmp_result2[p] = 'b0;
		end
	  else if (i_clken == 1)
	  begin :syn_block
		tmp_result2[lpm_pipeline] = tmp_result;
		for (n = 0; n < lpm_pipeline; n = n +1)
			tmp_result2[n] = tmp_result2[n+1];
	  end
	end

  assign result = (lpm_pipeline > 0) ? tmp_result2[0] : tmp_result;

// Check for previous Parameter declaration order
initial if ((lpm_widtha === "lpm_mult") || (lpm_type !== "lpm_mult"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_mult

//------------------------------------------------------------------------

module lpm_divide ( quotient,remain, numer, denom, clock, clken, aclr );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_widthn = 1;
	parameter lpm_widthd = 1;
	//parameter lpm_widthq = 1;
	//parameter lpm_widthr = 1;
	parameter lpm_nrepresentation = "UNSIGNED";
	parameter lpm_drepresentation = "UNSIGNED";
	parameter lpm_pipeline = 0;
	parameter lpm_type = "lpm_divide";
	parameter lpm_hint = "UNUSED";

	input  clock;
	input  clken;
	input  aclr;
	input  [lpm_widthn-1:0] numer;
	input  [lpm_widthd-1:0] denom;
	output [lpm_widthn-1:0] quotient;
	output [lpm_widthd-1:0] remain;

	// inernal reg
	reg   [lpm_widthn-1:0] tmp_quotient [lpm_pipeline:0];
	reg   [lpm_widthd-1:0] tmp_remain [lpm_pipeline:0];
	reg   [lpm_widthn-1:0] ONES, ZEROS, UNKNOWN, HiZ;
	reg   [lpm_widthd-1:0] DZEROS, DUNKNOWN;
	reg   [lpm_widthn-1:0] NUNKNOWN;
	reg   [lpm_widthd-1:0] RZEROS ;
	integer i;
	integer int_numer, int_denom, int_quotient, int_remain;

	tri0 aclr;
	tri0 clock;
	tri1 clken;

	buf (i_aclr, aclr);
	buf (i_clock, clock);
	buf (i_clken, clken);


	initial
	begin

	// check if lpm_widthn > 0
	if (lpm_widthn <= 0)
		$display("%t: Error! LPM_WIDTHN must be greater than 0.\n", $time);
	// check if lpm_widthd > 0
	if (lpm_widthd <= 0)
		$display("%t: Error! LPM_WIDTHD must be greater than 0.\n", $time);
	// check if lpm_widthn > 0
		//if (lpm_widthq <= 0)
		//    $display("%t: Error! LPM_WIDTHQ must be greater than 0.\n", $time);
	// check if lpm_widthR > 0
		//if (lpm_widthr <= 0)
		//    $display("%t: Error! LPM_WIDTHR must be greater than 0.\n", $time);
	// check for valid lpm_nrep value
	if ((lpm_nrepresentation !== "SIGNED") && (lpm_nrepresentation !== "UNSIGNED"))
		$display("%t: Error! LPM_NREPRESENTATION value must be \"SIGNED\" or \"UNSIGNED\".", $time);

	// check for valid lpm_drep value
	if ((lpm_drepresentation !== "SIGNED") && (lpm_drepresentation !== "UNSIGNED"))
		$display("%t: Error! LPM_DREPRESENTATION value must be \"SIGNED\" or \"UNSIGNED\".", $time);

	// check if lpm_pipeline is > 1 and clock is not used
	if ((lpm_pipeline >=1) && (clock === 1'bz))
		$display("%t: Error! The clock pin is requied if lpm_pipeline is used\n", $time);
	else if ((lpm_pipeline == 0) && (clock !== 1'bz))
		$display("%t: Error! If the clock pin is used, lpm_pipeline must be greater than 0.\n", $time);
	
	for (i=0; i < lpm_widthn; i=i+1)
	begin
		ONES[i] = 1'b1;
		ZEROS[i] = 1'b0;
		UNKNOWN[i] = 1'bx;
		HiZ[i] = 1'bz;
	end

	for (i=0; i < lpm_widthd; i=i+1)
		DUNKNOWN[i] = 1'bx;

	for (i=0; i < lpm_widthn; i=i+1)
		NUNKNOWN[i] = 1'bx;

	for (i=0; i < lpm_widthd; i=i+1)
		RZEROS[i] = 1'b0;

	end

	always @(numer or denom)
	begin
		if (lpm_nrepresentation == "UNSIGNED")
			int_numer = numer;
		else if (lpm_nrepresentation == "SIGNED")
		begin
			// convert signed numer
			if (numer[lpm_widthn-1] == 1)
			begin
				int_numer = 0;
				for (i = 0; i < lpm_widthn - 1; i = i + 1)
					int_numer[i] = numer[i] ^ 1;
				int_numer = -(int_numer + 1);
			end
			else
				int_numer = numer;
		end
		else 
			int_numer = NUNKNOWN;

		if (lpm_drepresentation == "UNSIGNED")
			int_denom = denom;
		else if (lpm_drepresentation == "SIGNED")
		begin
			// convert signed denom
			if (denom[lpm_widthd-1] == 1)
			begin
				int_denom = 0;
				for (i = 0; i < lpm_widthd - 1; i = i + 1)
					int_denom[i] = denom[i] ^ 1;
				int_denom = -(int_denom + 1);
			end
			else
				int_denom = denom;
		end
		else 
			int_denom = DUNKNOWN;

		int_quotient = int_numer / int_denom;
		int_remain = int_numer % int_denom;

		tmp_quotient[lpm_pipeline] = int_quotient;
		tmp_remain[lpm_pipeline] = int_remain;
	end

	always @(posedge i_clock or i_aclr)
	begin :syn_block
		if (i_aclr)
		begin
			disable syn_block;
			for (i = 0; i <= lpm_pipeline; i = i + 1)
				tmp_quotient[i] = ZEROS;
			tmp_remain[i] = RZEROS;
		end
		else if (i_clken)
			for (i = 0; i < lpm_pipeline; i = i +1)
			begin
				tmp_quotient[i] = tmp_quotient[i+1];
				tmp_remain[i] = tmp_remain[i+1];
			end
	end

	assign quotient = tmp_quotient[0];
	assign remain = tmp_remain[0];

// Check for previous Parameter declaration order
initial if ((lpm_widthn === "lpm_divide") || (lpm_type !== "lpm_divide"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_divide

//------------------------------------------------------------------------

module lpm_abs ( result, overflow, data );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_type = "lpm_abs";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] data;
	output [lpm_width-1:0] result;
	output overflow;

	reg    [lpm_width-1:0] a_int;
	reg    [lpm_width-1:0] result;
	reg    overflow;
	integer i;

	always @(data)
	begin
		overflow = 0;
		if (data[lpm_width-1] == 1)
		begin
			for (i = 0; i < lpm_width; i = i + 1)
				a_int[i] = data[i] ^ 1;
			result = (a_int + 1);
			overflow = (result == ( 1<<(lpm_width -1)));
		end
		else
			result = data;
	end

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_abs") || (lpm_type !== "lpm_abs"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_abs

//------------------------------------------------------------------------

module lpm_counter ( q, data, clock, cin, cout,clk_en, cnt_en, updown,
					 aset, aclr, aload, sset, sclr, sload );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_modulus = 0;
	parameter lpm_direction = "UNUSED";
	parameter lpm_avalue = "UNUSED";
	parameter lpm_svalue = "UNUSED";
	parameter lpm_pvalue = "UNUSED";
	parameter lpm_type = "lpm_counter";
	parameter lpm_hint = "UNUSED";

	output [lpm_width-1:0] q;
	//output [lpm_modulus-1:0] eq;
	output cout;
	input  cin;
	input  [lpm_width-1:0] data;
	input  clock, clk_en, cnt_en, updown;
	input  aset, aclr, aload;
	input  sset, sclr, sload;

	reg  [lpm_width-1:0] tmp_count;
	reg  tmp_updown;
	integer tmp_modulus;

	tri1 clk_en;
	tri1 cnt_en;
	tri1 updown;
	tri0 sload;
	tri0 sset;
	tri0 sclr;
	tri0 aload;
	tri0 aset;
	tri0 aclr;
	tri0 cin;

	buf (i_clk_en, clk_en);
	buf (i_cnt_en, cnt_en);
	buf (i_updown, updown);
	buf (i_sload, sload);
	buf (i_sset, sset);
	buf (i_sclr, sclr);
	buf (i_aload, aload);
	buf (i_aset, aset);
	buf (i_aclr, aclr);
	buf (i_cin, cin);


//---------------------------------------------------------------//
	function [lpm_width-1:0] NextBin;
		input [lpm_width-1:0] count;
		
		//reg  [lpm_width-1:0] re_start;
		//reg  [lpm_width-1:0] tmp_nextbin;
		//integer up_limit;
		
		begin 
			if (tmp_updown == 1)
			begin
				if (i_cin == 1 && count == tmp_modulus-2)
					NextBin = 0;
				else
					NextBin = (count >= tmp_modulus-1) ? i_cin : count+1+i_cin;
			end
			else
			begin
				if (i_cin == 1 && count == 1)
					NextBin = tmp_modulus - 1;
				else
					NextBin = (count <= 0) ? tmp_modulus-1-i_cin : count-1-i_cin;
			end
		end 
	endfunction

//---------------------------------------------------------------//
//  function [(1<<lpm_width)-1:0] CountDecode;
//---------------------------------------------------------------//
//  function [lpm_modulus:0] CountDecode;
//      input [lpm_width-1:0] count;
//
//      integer eq_index;
//
//      begin
//          CountDecode = 0;
//          eq_index = 0;
//          if (count < lpm_modulus)
//          begin
//              eq_index = count;
//              CountDecode[eq_index] = 1'b1;
//          end
//      end
//  endfunction

//---------------------------------------------------------------//
//  function integer str_to_int;
//---------------------------------------------------------------//
	function integer str_to_int;
		input  [8*16:1] s; 

		reg [8*16:1] reg_s;
		reg [8:1] digit;
		reg [8:1] tmp;
		integer m, ivalue;
		
		begin
			ivalue = 0;
			reg_s = s;
			for (m=1; m<=16; m=m+1)
			begin 
				tmp = reg_s[128:121];
				digit = tmp & 8'b00001111;
				reg_s = reg_s << 8; 
				ivalue = ivalue * 10 + digit; 
			end
			str_to_int = ivalue;
		end
	endfunction

//---------------------------------------------------------------//

	initial
	begin
		// check if lpm_modulus < 0
		if (lpm_modulus < 0)
			$display("%t: Error! LPM_MODULUS must be greater than 0.\n", $time);
		// check if lpm_modulus > 1<<lpm_width
		if (lpm_modulus > 1<<lpm_width)
			$display("%t: Error! LPM_MODULUS must be less than or equal to 1<<LPM_WIDTH.\n", $time);

		if (lpm_direction == "UNUSED")
			tmp_updown = (i_updown == 0) ? 0 : 1;
		else
			tmp_updown = (lpm_direction == "DOWN") ? 0 : 1;

		tmp_modulus = (lpm_modulus == 0) ? (1 << lpm_width) : lpm_modulus;
		tmp_count = (lpm_pvalue == "UNUSED") ? 0 : str_to_int(lpm_pvalue);
	end

	always @(i_updown)
	begin
		if (lpm_direction == "UNUSED")
			tmp_updown = (i_updown == 0) ? 0 : 1;
		else
			$display("%t: Error! LPM_DIRECTION and UPDOWN cannot be used at the same time.\n", $time);
	end

	always @(posedge clock or posedge i_aclr or posedge i_aset or
			  posedge i_aload)
	begin :asyn_block
		if (i_aclr)
			tmp_count = 0;
		else if (i_aset)
			tmp_count = (lpm_avalue == "UNUSED") ? {lpm_width{1'b1}}
												 : str_to_int(lpm_avalue);
		else if (i_aload)
			tmp_count = data;
		else
		begin :syn_block
			if (i_clk_en)
			begin
				if (i_sclr)
					tmp_count = 0;
				else if (i_sset)
					tmp_count = (lpm_svalue == "UNUSED") ? {lpm_width{1'b1}}
														 : str_to_int(lpm_svalue);
				else if (i_sload)
					tmp_count = data;
				else if (i_cnt_en)
					tmp_count = NextBin(tmp_count);
			end
		end
	end 

	assign q =  tmp_count;
	//assign eq = CountDecode(tmp_count);
	assign cout = (((tmp_count >= tmp_modulus-1-i_cin) && tmp_updown)
				  || ((tmp_count <= i_cin) && !tmp_updown)) ? 1 : 0;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_counter") || (lpm_type !== "lpm_counter"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_counter

//------------------------------------------------------------------------

module lpm_latch ( q, data, gate, aset, aclr );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_avalue = "UNUSED";
	parameter lpm_pvalue = "UNUSED";
	parameter lpm_type = "lpm_latch";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] data;
	input  gate, aset, aclr;
	output [lpm_width-1:0] q;

	reg [lpm_width-1:0] q;

	tri0 aset;
	tri0 aclr;

	buf (i_aset, aset);
	buf (i_aclr, aclr);

//---------------------------------------------------------------//
//  function integer str_to_int;
//---------------------------------------------------------------//
	function integer str_to_int;
		input  [8*16:1] s; 
		
		reg [8*16:1] reg_s;
		reg [8:1] digit;
		reg [8:1] tmp;
		integer m , ivalue; 
		
		begin 
			ivalue = 0;
			reg_s = s;
			for (m=1; m<=16; m= m+1) 
			begin 
				tmp = reg_s[128:121];
				digit = tmp & 8'b00001111;
				reg_s = reg_s << 8; 
				ivalue = ivalue * 10 + digit; 
			end
			str_to_int = ivalue;
		end
	endfunction
//---------------------------------------------------------------//

	initial
	begin
		if (lpm_pvalue != "UNUSED")
			q = str_to_int(lpm_pvalue);
	end

	always @(data or gate or i_aclr or i_aset)
	begin
		if (i_aclr)
			q = 'b0;
		else if (i_aset)
			begin
				if (lpm_avalue == "UNUSED")
					q = {lpm_width{1'b1}};
				else    
					q = str_to_int(lpm_avalue);
			end
		else if (gate)
			q = data;
	end

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_latch") || (lpm_type !== "lpm_latch"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_latch

//------------------------------------------------------------------------

module lpm_ff ( q, data, clock, enable, aclr, aset,
				sclr, sset, aload, sload );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width  = 1;
	parameter lpm_avalue = "UNUSED";
	parameter lpm_svalue = "UNUSED";
	parameter lpm_pvalue = "UNUSED";
	parameter lpm_fftype = "DFF";
	parameter lpm_type = "lpm_ff";
	parameter lpm_hint = "UNUSED";


	input  [lpm_width-1:0] data;
	input  clock, enable;
	input  aclr, aset;
	input  sclr, sset;
	input  aload, sload ;
	output [lpm_width-1:0] q;

	reg   [lpm_width-1:0] tmp_q;
	integer i;

	tri1 enable;
	tri0 sload;
	tri0 sclr;
	tri0 sset;
	tri0 aload;
	tri0 aclr;
	tri0 aset;
	  
	buf (i_enable, enable);
	buf (i_sload, sload);
	buf (i_sclr, sclr);
	buf (i_sset, sset);
	buf (i_aload, aload);
	buf (i_aclr, aclr);
	buf (i_aset, aset);

//---------------------------------------------------------------//
//  function integer str_to_int;
//---------------------------------------------------------------//
	function integer str_to_int;
		input  [8*16:1] s; 
		
		reg [8*16:1] reg_s;
		reg [8:1]   digit;
		reg [8:1] tmp;
		integer   m , ivalue; 
		
		begin
			ivalue = 0;
			reg_s = s;
			for (m=1; m<=16; m= m+1) 
			begin 
				tmp = reg_s[128:121];
				digit = tmp & 8'b00001111;
				reg_s = reg_s << 8; 
				ivalue = ivalue * 10 + digit; 
			end
			str_to_int = ivalue;
		end
	endfunction
//---------------------------------------------------------------//

	initial
	begin
		if (lpm_pvalue != "UNUSED")
			tmp_q = str_to_int(lpm_pvalue);
	end

	always @(posedge clock or posedge i_aclr or posedge i_aset or
			  posedge i_aload)
	begin :asyn_block // Asynchronous process
		if (i_aclr)
		begin
			 tmp_q = 0;
		end
		else if (i_aset)
		begin
			if (lpm_avalue == "UNUSED")
				tmp_q = {lpm_width{1'b1}};
			else
				tmp_q = str_to_int(lpm_avalue);
		end
		else if (i_aload)
		begin
				 tmp_q = data;
		end
		else
		begin :syn_block // Synchronous process
			if (i_enable)
			begin
				if (i_sclr)
				begin
					tmp_q = 0;
				end
				else if (i_sset)
				begin
					if (lpm_svalue == "UNUSED") 
						tmp_q = {lpm_width{1'b1}}; 
					else
						tmp_q = str_to_int(lpm_svalue);
				end
				else if (i_sload)  // Load data
				begin
					tmp_q = data;
				end
				else
				begin
					if (lpm_fftype == "TFF") // toggle
					begin
						for (i = 0; i < lpm_width; i=i+1)
						begin
							if (data[i] == 1'b1) 
								tmp_q[i] = ~tmp_q[i];
						end
					end
					else 
					if (lpm_fftype == "DFF") // load data
						tmp_q = data;
				end
			end
		end
	end

	assign q = tmp_q;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_ff") || (lpm_type !== "lpm_ff"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_ff
 
//------------------------------------------------------------------------

module lpm_shiftreg ( q, shiftout, data, clock, enable, aclr, aset, 
					  sclr, sset, shiftin, load );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width  = 1;
	parameter lpm_avalue = "UNUSED";
	parameter lpm_svalue = "UNUSED";
	parameter lpm_pvalue = "UNUSED";
	parameter lpm_direction = "LEFT";
	parameter lpm_type = "lpm_shiftreg";
	parameter lpm_hint  = "UNUSED";

	input  [lpm_width-1:0] data;
	input  clock, enable;
	input  aclr, aset;
	input  sclr, sset;
	input  shiftin, load;
	output [lpm_width-1:0] q;
	output shiftout;

	reg  [lpm_width-1:0] tmp_q;
	reg  abit;
	integer i;

	wire tmp_shiftout;

	tri1 enable;
	tri1 shiftin;
	tri0 load;
	tri0 sclr;
	tri0 sset;
	tri0 aclr;
	tri0 aset;

	buf (i_enable, enable);
	buf (i_shiftin, shiftin);
	buf (i_load, load);
	buf (i_sclr, sclr);
	buf (i_sset, sset);
	buf (i_aclr, aclr);
	buf (i_aset, aset);


//---------------------------------------------------------------//
//  function integer str_to_int;
//---------------------------------------------------------------//
	function integer str_to_int;
		input  [8*16:1] s; 

		reg [8*16:1] reg_s;
		reg [8:1]   digit;
		reg [8:1] tmp;
		integer   m , ivalue; 

		begin 
			ivalue = 0;
			reg_s = s;
			for (m=1; m<=16; m= m+1) 
			begin 
				tmp = reg_s[128:121];
				digit = tmp & 8'b00001111;
				reg_s = reg_s << 8; 
				ivalue = ivalue * 10 + digit; 
			end
			str_to_int = ivalue;
		end
	endfunction
//---------------------------------------------------------------//

	initial
	begin
		if (lpm_pvalue != "UNUSED")
			tmp_q = str_to_int(lpm_pvalue);
	end

	always @(posedge clock or posedge i_aclr or posedge i_aset)
	begin :asyn_block // Asynchronous process
		if (i_aclr)
		begin
			tmp_q = 0;
		end
		else if (i_aset)
		begin
			if (lpm_avalue === "UNUSED")
				tmp_q = {lpm_width{1'b1}};
			else
				tmp_q = str_to_int(lpm_avalue);
		end
		else
		begin :syn_block // Synchronous process
			if (i_enable)
			begin
				if (i_sclr)
				begin
					tmp_q = 0;
				end
				else if (i_sset)
				begin
					if (lpm_svalue === "UNUSED")
						tmp_q = {lpm_width{1'b1}};
					else
						tmp_q = str_to_int(lpm_svalue);
				end
				else if (i_load)  
				begin
					tmp_q = data;
				end
				else if (!i_load)
				begin
					if (lpm_direction === "LEFT")
					begin
						{abit,tmp_q} = {tmp_q,i_shiftin};
					end
					else if (lpm_direction === "RIGHT")
					begin
						{tmp_q,abit} = {i_shiftin,tmp_q};
					end
				end
			end
		end
	end


	assign tmp_shiftout = (lpm_direction === "LEFT") ? tmp_q[lpm_width-1]
													 : tmp_q[0];
	assign q = tmp_q;
	assign shiftout = tmp_shiftout;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_shiftreg") || (lpm_type !== "lpm_shiftreg"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_shiftreg
 
//------------------------------------------------------------------------

module lpm_ram_dq ( q, data, inclock, outclock, we, address );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_widthad = 1;
	parameter lpm_numwords = 1 << lpm_widthad;
	parameter lpm_indata = "REGISTERED";
	parameter lpm_address_control = "REGISTERED";
	parameter lpm_outdata = "REGISTERED";
	parameter lpm_file = "UNUSED";
	parameter lpm_type = "lpm_ram_dq";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] data;
	input  [lpm_widthad-1:0] address;
	input  inclock, outclock, we;
	output [lpm_width-1:0] q;


  // internal reg 
	reg  [lpm_width-1:0] mem_data [lpm_numwords-1:0];
	reg  [lpm_width-1:0] tmp_q;
	reg  [lpm_width-1:0] pdata;
	reg  [lpm_width-1:0] in_data;
	reg  [lpm_widthad-1:0] paddress;
	reg  pwe;
	reg  [lpm_width-1:0]  ZEROS, UNKNOWN;
	reg  [8*256:1] ram_initf;
	integer i;

	tri0 inclock;
	tri0 outclock;

	buf (i_inclock, inclock);
	buf (i_outclock, outclock);

//---------------------------------------------------------------//
	function ValidAddress;
		input [lpm_widthad-1:0] paddress;

		begin
			ValidAddress = 1'b0;
			if (^paddress ==='bx)
				$display("%d:Error! Invalid address.\n", $time);
			else if (paddress >= lpm_numwords)
				$display("%d:Error! Address out of bound on RAM.\n", $time);
			else
				ValidAddress = 1'b1;
		end
  endfunction
//---------------------------------------------------------------//
		
	initial
	begin

		// Initialize the internal data register.
		pdata = 0;
		paddress = 0;
		pwe = 0;
		tmp_q = 0;

		if (lpm_width <= 0)
			$display("Error! lpm_width parameter must be greater than 0.");

		if (lpm_widthad <= 0)
			$display("Error! lpm_widthad parameter must be greater than 0.");
		// check for number of words out of bound
		if ((lpm_numwords > (1 << lpm_widthad))
			||(lpm_numwords <= (1 << (lpm_widthad-1))))
		begin
			$display("Error! lpm_numwords must equal to the ceiling of log2(lpm_widthad).");
	 
		end
	 
		if ((lpm_indata !== "REGISTERED") && (lpm_indata !== "UNREGISTERED"))
		begin
			$display("Error! lpm_indata must be REGISTERED (the default) or UNREGISTERED.");
		end
		
		if ((lpm_address_control !== "REGISTERED") && (lpm_address_control !== "UNREGISTERED"))
		begin
			$display("Error! lpm_address_control must be REGISTERED (the default) or UNREGISTERED.");
		end
		
		if ((lpm_outdata !== "REGISTERED") && (lpm_outdata !== "UNREGISTERED"))
		begin
			$display("Error! lpm_outdata must be REGISTERED (the default) or UNREGISTERED.");
		end  

		// check if lpm_indata or lpm_address_control is set to registered
		// inclock must be used.
		if (((lpm_indata === "REGISTERED") || (lpm_address_control === "REGISTERED")) && (inclock === 1'bz))
		begin
			$display("Error! inclock = 1'bz. Inclock pin must be used.\n");
		end

		// check if lpm_outdata, outclock must be used
		if ((lpm_outdata === "REGISTERED") && (outclock === 1'bz))
		begin
			$display("Error! lpm_outdata = REGISTERED, outclock = 1'bz . Outclock pin must be used.\n");
		end

		for (i=0; i < lpm_width; i=i+1)
		begin
			ZEROS[i] = 1'b0;
			UNKNOWN[i] = 1'bX;
		end 
		
		for (i = 0; i < lpm_numwords; i=i+1)
			mem_data[i] = ZEROS;

		// load data to the RAM
		if (lpm_file != "UNUSED")
		begin
			$convert_hex2ver(lpm_file, lpm_width, ram_initf);
			$readmemh(ram_initf, mem_data);
		end 

	end

		
	always @(posedge i_inclock)
	begin
		if ((lpm_indata === "REGISTERED") && (lpm_address_control === "REGISTERED"))
		begin
			paddress <= address;
			pdata <= data;
			pwe <= we;
		end
		else
		begin
			if ((lpm_indata === "REGISTERED") && (lpm_address_control === "UNREGISTERED"))
				pdata <= data;

			if ((lpm_indata === "UNREGISTERED") && (lpm_address_control === "REGISTERED"))
			begin
				paddress <= address;
				pwe <= we;
			end
		end
	end

	always @(data)
	begin
		if (lpm_indata === "UNREGISTERED")
			pdata <= data;
	end
	
	always @(address)
	begin
		if (lpm_address_control === "UNREGISTERED")
			paddress <= address;
	end
	
	always @(we)
	begin
		if (lpm_address_control === "UNREGISTERED")
			pwe <= we;
	end
	
	always @(pdata or paddress or pwe)
	begin :unregistered_inclock
		if (ValidAddress(paddress))
		begin
			if ((lpm_indata === "UNREGISTERED" && lpm_address_control === "UNREGISTERED") || (lpm_address_control === "UNREGISTERED"))
			begin
				if (pwe)
					mem_data[paddress] <= pdata;
			end

		end
		else
		begin
			if (lpm_outdata === "UNREGISTERED")
				tmp_q <= UNKNOWN;
		end
	end

	always @(posedge i_outclock)
	begin
		if (lpm_outdata === "REGISTERED")
		begin
			if (ValidAddress(paddress))
				tmp_q <= mem_data[paddress];
			else
				tmp_q <= UNKNOWN;
		end
	end
 
	always @(negedge i_inclock)
	begin
		if (lpm_address_control === "REGISTERED")
		begin
			if (pwe)
				mem_data[paddress] <= pdata;
		end
	end

	assign q = ( lpm_outdata === "UNREGISTERED" ) ? mem_data[paddress] : tmp_q;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_ram_dq") || (lpm_type !== "lpm_ram_dq"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_ram_dq
 
//------------------------------------------------------------------------

module lpm_ram_dp ( q, data, wraddress, rdaddress, rdclock, wrclock, rdclken, wrclken, rden, wren);

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_widthad = 1;
	parameter lpm_numwords = 1<< lpm_widthad;
	parameter lpm_indata = "REGISTERED";
	parameter lpm_outdata = "REGISTERED";
	parameter lpm_rdaddress_control  = "REGISTERED";
	parameter lpm_wraddress_control  = "REGISTERED";
	parameter lpm_file = "UNUSED";
	parameter lpm_type = "lpm_ram_dp";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] data;
	input  [lpm_widthad-1:0] rdaddress, wraddress;
	input  rdclock, wrclock, rdclken, wrclken, rden, wren;
	output [lpm_width-1:0] q;


	// internal reg 
	reg  [lpm_width-1:0] mem_data [lpm_numwords-1:0];
	reg  [lpm_width-1:0] tmp_q;
	reg  [lpm_width-1:0] prev_q;
	reg  [lpm_width-1:0] new_data;
	reg  [lpm_widthad-1:0] new_raddress;
	reg  [lpm_widthad-1:0] new_wraddress;
	reg  wren_event, rden_event;
	reg  [lpm_width-1:0]  ZEROS, UNKNOWN;
	reg  [8*256:1] ram_initf;
	integer i;

	tri0 rdclock;
	tri1 rdclken;
	tri1 rden;
	tri0 wrclock;
	tri1 wrclken;
			   
	buf (i_rdclock, rdclock);
	buf (i_rdclken, rdclken);
	buf (i_rden, rden);
	buf (i_wrclock, wrclock);
	buf (i_wrclken, wrclken);


//---------------------------------------------------------------//
	function ValidAddress;
		input [lpm_widthad-1:0] paddress;
	
		begin
			ValidAddress = 1'b0;
			if (^paddress ==='bx)
				$display("%d:Error! Invalid address.\n", $time);
			else if (paddress >= lpm_numwords)
				$display("%d:Error! Address out of bound on RAM.\n", $time);
			else
				ValidAddress = 1'b1;
		end
	endfunction
//---------------------------------------------------------------//
		
	initial
	begin

		// Initialize the internal data register.
		new_data = 0;
		new_raddress = 0;
		new_wraddress = 0;
		wren_event = 0;
		tmp_q = 0;

		if (lpm_width <= 0)
			$display("Error! lpm_width parameter must be greater than 0.");

		if (lpm_widthad <= 0)
			$display("Error! lpm_widthad parameter must be greater than 0.");
		// check for number of words out of bound
		if ((lpm_numwords > (1 << lpm_widthad))
			||(lpm_numwords <= (1 << (lpm_widthad-1))))
		begin
			$display("Error! lpm_numwords must equal to the ceiling of log2(lpm_widthad).");
		end
			 
		if ((lpm_indata !== "REGISTERED") && (lpm_indata !== "UNREGISTERED"))
		begin
			$display("Error! lpm_indata must be REGISTERED (the default) or UNREGISTERED.");
		end
				
		if ((lpm_rdaddress_control !== "REGISTERED") && (lpm_rdaddress_control !== "UNREGISTERED"))
		begin
			$display("Error! lpm_rdaddress_control must be REGISTERED (the default) or UNREGISTERED.");
		end
				
		if ((lpm_wraddress_control !== "REGISTERED") && (lpm_wraddress_control !== "UNREGISTERED"))
		begin
			$display("Error! lpm_wraddress_control must be REGISTERED (the default) or UNREGISTERED.");
		end
				
		if ((lpm_outdata !== "REGISTERED") && (lpm_outdata !== "UNREGISTERED"))
		begin
			$display("Error! lpm_outdata must be REGISTERED (the default) or UNREGISTERED.");
		end  

		// check if lpm_indata or lpm_wraddress_control is set to registered
		// wrclock and wrclken must be used.
		if (((lpm_indata === "REGISTERED") || (lpm_wraddress_control === "REGISTERED")) && ((wrclock === 1'bz) || (wrclken == 1'bz)))
		begin
			$display("Error! wrclock = 1'bz. wrclock and wrclken pins must be used.\n");
		end

		// check if lpm_rdaddress_control is set to registered
		// rdclock and rdclken must be used.
		if ((lpm_rdaddress_control === "REGISTERED") && ((rdclock === 1'bz) || (rdclken == 1'bz)))
		begin
			$display("Error! rdclock = 1'bz. rdclock and rdclken pins must be used.\n");
		end

		// check if lpm_outdata, rdclock must be used
		if ((lpm_outdata === "REGISTERED") && (rdclock === 1'bz))
		begin
			$display("Error! lpm_outdata = REGISTERED, rdclock = 1'bz . rdclock pnd rdclken pins must be used.\n");
		end

		for (i=0; i < lpm_width; i=i+1)
		begin
			ZEROS[i] = 1'b0;
			UNKNOWN[i] = 1'bX;
		end 
				
		for (i = 0; i < lpm_numwords; i=i+1)
			mem_data[i] = ZEROS;

		// load data to the RAM
		if (lpm_file != "UNUSED")
		begin
			$convert_hex2ver(lpm_file, lpm_width, ram_initf);
			$readmemh(ram_initf, mem_data);
		end
	end

		
	always @(posedge i_wrclock)
	begin
		if (i_wrclken)
		begin
			if ((lpm_indata === "REGISTERED") && (lpm_wraddress_control === "REGISTERED"))
			begin
				new_wraddress <= wraddress;
				new_data <= data;
				wren_event <= wren;
			end
			else
			begin
				if ((lpm_indata === "REGISTERED") && (lpm_wraddress_control === "UNREGISTERED"))
					new_data <= data;

				if ((lpm_indata === "UNREGISTERED") && (lpm_wraddress_control === "REGISTERED"))
				begin
					new_wraddress <= wraddress;
					wren_event <= wren;
				end
			end
		end
	end


	always @(data)
	begin
		if (lpm_indata === "UNREGISTERED")
			new_data <= data;
	end
	
	always @(wraddress)
	begin
		if (lpm_wraddress_control === "UNREGISTERED")
			new_wraddress <= wraddress;
	end

	always @(rdaddress)
	begin
		if (lpm_rdaddress_control === "UNREGISTERED")
			new_raddress <= rdaddress;
	end
	
	always @(wren)
	begin
		if (lpm_wraddress_control === "UNREGISTERED")
			wren_event <= wren;
	end

	always @(i_rden)
	begin
		if (lpm_rdaddress_control === "UNREGISTERED")
			rden_event <= i_rden;
	end
	
	always @(new_data or new_wraddress or wren_event)
	begin 
		if (ValidAddress(new_wraddress))
		begin
			if ((wren_event) && (i_wrclken))
				mem_data[new_wraddress] <= new_data;
		end
		else
		begin
			if (lpm_outdata === "UNREGISTERED")
				tmp_q <= UNKNOWN;
		end
	end

	always @(posedge i_rdclock)
	begin
		if (lpm_rdaddress_control == "REGISTERED")
			if (i_rdclken)
			begin
				new_raddress <= rdaddress;
				rden_event <= i_rden;
			end
		if (lpm_outdata === "REGISTERED")
		begin
			if ((i_rdclken) && (rden_event))
			begin
				if (ValidAddress(new_raddress))
				begin
					tmp_q <= mem_data[new_raddress];
				end
				else
					tmp_q <= UNKNOWN;
			end
		end
	end
 
	//assign q = ( lpm_outdata === "UNREGISTERED" ) ? mem_data[new_raddress] : tmp_q;

	always @(mem_data[new_raddress] or tmp_q or i_rden)
	begin
		if (i_rden || lpm_outdata === "REGISTERED")
			prev_q <= ( lpm_outdata === "UNREGISTERED" ) ? mem_data[new_raddress] : tmp_q;
	end

	assign q = prev_q;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_ram_dp") || (lpm_type !== "lpm_ram_dp"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_ram_dp

//------------------------------------------------------------------------

module lpm_ram_io ( dio, inclock, outclock, we, memenab, outenab, address );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_widthad = 1;
	parameter lpm_numwords = 1<< lpm_widthad;
	parameter lpm_indata = "REGISTERED";
	parameter lpm_address_control = "REGISTERED";
	parameter lpm_outdata = "REGISTERED";
	parameter lpm_file = "UNUSED";
	parameter lpm_type = "lpm_ram_io";
	parameter lpm_hint = "UNUSED";

	input  [lpm_widthad-1:0] address;
	input  inclock, outclock, we;
	input  memenab;
	input  outenab;
	inout  [lpm_width-1:0] dio;


	// inernal reg 
	reg  [lpm_width-1:0] mem_data [lpm_numwords-1:0];
	reg  [lpm_width-1:0] tmp_io;
	reg  [lpm_width-1:0] tmp_q;
	reg  [lpm_width-1:0] pdio;
	reg  [lpm_widthad-1:0] paddress;
	reg  pwe;
	reg  [lpm_width-1:0] ZEROS, UNKNOWN, HiZ;
	reg  [8*256:1] ram_initf;
	integer i;

	tri0 inclock;
	tri0 outclock;
	  
	buf (i_inclock, inclock);
	buf (i_outclock, outclock);


//---------------------------------------------------------------//
	function ValidAddress;
		input [lpm_widthad-1:0] paddress;
		
		begin
			ValidAddress = 1'b0;
			if (^paddress ==='bx)
				$display("%d:Error: Invalid address.", $time);
			else if (paddress >= lpm_numwords)
				$display("%d:Error: Address out of bound on RAM.", $time);
			else
				ValidAddress = 1'b1;
		end
	endfunction
//---------------------------------------------------------------//
		
	initial
	begin

		if (lpm_width <= 0)
			$display("Error! lpm_width parameter must be greater than 0.");

		if (lpm_widthad <= 0)
			$display("Error! lpm_widthad parameter must be greater than 0.");

		// check for number of words out of bound
		if ((lpm_numwords > (1 << lpm_widthad))
			||(lpm_numwords <= (1 << (lpm_widthad-1))))
		begin
			$display("Error! lpm_numwords must equal to the ceiling of log2(lpm_widthad).");
		end

		if ((lpm_indata !== "REGISTERED") && (lpm_indata !== "UNREGISTERED")) 
		begin
			$display("Error! lpm_indata must be REGISTERED (the default) or UNREGISTERED.");
		end
			
		if ((lpm_address_control !== "REGISTERED") && (lpm_address_control !== "UNREGISTERED")) 
		begin
			$display("Error! lpm_address_control must be REGISTERED (the default) or UNREGISTERED.");
		end
			
		if ((lpm_outdata !== "REGISTERED") && (lpm_outdata !== "UNREGISTERED")) 
		begin
			$display("Error! lpm_outdata must be REGISTERED (the default) or UNREGISTERED.");
		end
			

		// check if lpm_indata or lpm_address_control is set to registered
		// inclock must be used.
		if (((lpm_indata === "REGISTERED") || (lpm_address_control === "REGISTERED")) && (inclock === 1'bz))
		begin
			$display("Error! inclock = 1'bz.  Inclock pin must be used.\n");
		end
		 
		// check if lpm_outdata, outclock must be used
		if ((lpm_outdata === "REGISTERED") && (outclock === 1'bz))
		begin
			$display("Error! lpm_outdata is REGISTERED, outclock = 1'bz.  Outclock pin must be used.\n");  
		end
		 
		for (i=0; i < lpm_width; i=i+1)
		begin
			ZEROS[i] = 1'b0;
			UNKNOWN[i] = 1'bX;
			HiZ[i] = 1'bZ;
		end 
			
		for (i = 0; i < lpm_numwords; i=i+1)
			mem_data[i] = ZEROS;

		// Initialize input/output 
		pdio = 0;
		paddress = 0;
		tmp_io = 0;
		tmp_q = 0;

		// load data to the RAM
		if (lpm_file != "UNUSED")
		begin
			$convert_hex2ver(lpm_file, lpm_width, ram_initf);
			$readmemh(ram_initf, mem_data);
		end
	end


	always @(dio)
	begin
		if (lpm_indata === "UNREGISTERED")
			pdio <=  dio;
	end
		
	always @(address)
	begin
		if (lpm_address_control === "UNREGISTERED")
			paddress <=  address;
	end
		
		
	always @(we)
	begin
		if (lpm_address_control === "UNREGISTERED")
			pwe <=  we;
	end
	
	always @(posedge i_inclock)
	begin
		if (lpm_indata === "REGISTERED")
			pdio <=  dio;

		if (lpm_address_control === "REGISTERED")
		begin
			paddress <=  address;
			pwe <=  we;
		end
	end

	always @(pdio or paddress or pwe or memenab)
	begin :block_a
		if (ValidAddress(paddress))
		begin
			if ((lpm_indata === "UNREGISTERED" && lpm_address_control === "UNREGISTERED") || (lpm_address_control === "UNREGISTERED"))
			begin
				if (pwe && memenab)
				mem_data[paddress] <= pdio;
			end

			if (lpm_outdata === "UNREGISTERED")
			begin
				tmp_q <= mem_data[paddress];
				tmp_q <= mem_data[paddress];
			end
		end
		else
		begin
			if (lpm_outdata === "UNREGISTERED")
				tmp_q <= UNKNOWN;
		end
	end

	always @(negedge i_inclock)
	begin
		if (lpm_address_control === "REGISTERED")
		begin
			if (pwe && memenab)
			mem_data[paddress] <= pdio;
		end
	end
	always @(posedge i_outclock)
	begin
		if (lpm_outdata === "REGISTERED")
		begin
			tmp_q <= mem_data[paddress];
		end
	end

	always @(memenab or outenab or tmp_q)
	begin
		if (memenab && outenab)
			tmp_io <= tmp_q;
		else if (!memenab || (memenab && !outenab))
			tmp_io <= HiZ;
	end
 
	assign dio =  tmp_io;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_ram_io") || (lpm_type !== "lpm_ram_io"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_ram_io
 
//------------------------------------------------------------------------

module lpm_rom ( q, inclock, outclock, memenab, address );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_widthad = 1;
	parameter lpm_numwords = 1<< lpm_widthad;
	parameter lpm_address_control = "REGISTERED";
	parameter lpm_outdata = "REGISTERED";
	parameter lpm_file = "rom.hex";
	parameter lpm_type = "lpm_rom";
	parameter lpm_hint = "UNUSED";

	input  [lpm_widthad-1:0] address;
	input  inclock, outclock;
	input  memenab;
	output [lpm_width-1:0] q;

	// inernal reg 
	reg  [lpm_width-1:0] mem_data [lpm_numwords-1:0];
	reg  [lpm_widthad-1:0] paddress;
	reg  [lpm_width-1:0] tmp_q;
	reg  [lpm_width-1:0] tmp_q_reg;
	reg  [lpm_width-1:0] ZEROS, UNKNOWN, HiZ;
	reg  [8*256:1] rom_initf;
	integer i;

	tri0 inclock;
	tri0 outclock;
	tri1 memenab;

	buf (i_inclock, inclock);
	buf (i_outclock, outclock);
	buf (i_memenab, memenab);


//---------------------------------------------------------------//
	function ValidAddress;
		input [lpm_widthad-1:0] address;
		begin
			ValidAddress = 1'b0;
			if (^address =='bx)
				$display("%d:Error: Invalid address.", $time);
			else if (address >= lpm_numwords)
				$display("%d:Error: Address out of bound on ROM.", $time);
			else
				ValidAddress = 1'b1;
		end
	endfunction
//---------------------------------------------------------------//
		
	initial     
	begin
		// Initialize output
		tmp_q = 0;
		tmp_q_reg = 0;
		paddress = 0;
 
		if (lpm_file === "")
			$display("Error! rom module must have data file for initialization\n.");
 
		if (lpm_width <= 0)
			$display("Error! lpm_width parameter must be greater than 0.");
	 
		if (lpm_widthad <= 0)
			$display("Error! lpm_widthad parameter must be greater than 0.");
		 
		 
		// check for number of words out of bound
		if ((lpm_numwords > (1 << lpm_widthad))
			||(lpm_numwords <= (1 << (lpm_widthad-1))))
		begin
			$display("Error! lpm_numwords must equal to the ceiling of log2(lpm_widthad).");
		end   

		if ((lpm_address_control !== "REGISTERED") && (lpm_address_control !== "UNREGISTERED"))
		begin
			$display("Error! lpm_address_control must be REGISTERED (the default) or UNREGISTERED.");
		end

		if ((lpm_outdata !== "REGISTERED") && (lpm_outdata !== "UNREGISTERED"))
		begin
			$display("Error! lpm_outdata must be REGISTERED (the default) or UNREGISTERED.");
		end

		// check if lpm_address_control is set to registered
		// inclock must be used.
		if ((lpm_address_control === "REGISTERED") && (inclock === 1'bz))
		begin
			$display("Error! inclock = 1'bz.  Inclock pin must be used.\n");
		end  

		// check if lpm_outdata, outclock must be used
		if ((lpm_outdata === "REGISTERED") && (outclock === 1'bz))
		begin
			$display("Error! lpm_outdata is REGISTERED, outclock = 1'bz.  Outclock must be used.\n");
		end
		 
		for (i=0; i < lpm_width; i=i+1)
		begin
			ZEROS[i] = 1'b0;
			UNKNOWN[i] = 1'bX;
			HiZ[i] = 1'bZ;
		end 
			
		for (i = 0; i < lpm_numwords; i=i+1)
			mem_data[i] = ZEROS;

		// load data to the ROM
		if (lpm_file != "")
		begin
			$convert_hex2ver(lpm_file, lpm_width, rom_initf);
			$readmemh(rom_initf, mem_data);
		end
	end

	always @(posedge i_inclock)
	begin
		if (lpm_address_control === "REGISTERED")
			paddress <=  address;
	end
 
	always @(address)
	begin
		if (lpm_address_control === "UNREGISTERED")
				paddress <=  address;
	end

				   
	always @(paddress)
	begin 
		if (ValidAddress(paddress))
		begin
			if (lpm_outdata === "UNREGISTERED")
				tmp_q_reg <=  mem_data[paddress];
		end
		else
		begin
			if (lpm_outdata === "UNREGISTERED")
				tmp_q_reg <= UNKNOWN;
		end
	end

	always @(posedge i_outclock)
	begin
		if (lpm_outdata === "REGISTERED")
		begin
			if (ValidAddress(paddress))
				tmp_q_reg <=  mem_data[paddress];
			else
				tmp_q_reg <= UNKNOWN;
		end
	end
 
	
	always @(i_memenab or tmp_q_reg)
	begin
		if (i_memenab)
			tmp_q <= tmp_q_reg;
		else if (!i_memenab)
			tmp_q <= HiZ;
	end
	 
	assign q = tmp_q;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_rom") || (lpm_type !== "lpm_rom"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_rom
 
//------------------------------------------------------------------------

module lpm_fifo (data, clock, wrreq, rdreq, aclr, sclr, q, usedw, full, empty);

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width  = 1;
	parameter lpm_widthu  = 1;
	parameter lpm_numwords = 2;
	parameter lpm_showahead = "OFF";
	parameter lpm_type = "lpm_fifo";
	parameter lpm_hint = "UNUSED";

	input [lpm_width-1:0] data;
	input clock;
	input wrreq;
	input rdreq;
	input aclr;
	input sclr;
	output [lpm_width-1:0] q;
	output [lpm_widthu-1:0] usedw;
	output full;
	output empty;


	// internal reg
	reg [lpm_width-1:0] mem_data [lpm_numwords-1:0];
	reg [lpm_width-1:0] tmp_q;
	reg [lpm_width-1:0] ZEROS;
	reg [lpm_widthu+1:0] count_id;
	reg [lpm_widthu-1:0] write_id;
	reg [lpm_widthu-1:0] read_id;
	reg empty_flag;
	reg full_flag;
	integer i;

	tri0 aclr;
	tri0 sclr;

	buf (i_aclr, aclr);
	buf (i_sclr, sclr);

	initial
	begin
  
		if (lpm_width <= 0)
			$display("Error! lpm_width must be greater than 0.");

		if (lpm_numwords <= 1)
			$display("Error! lpm_numwords must be greater than or equal to 2.");

		// check for number of words out of bound
		if ((lpm_widthu !=1) && (lpm_numwords > (1 << lpm_widthu)))
			$display("Error! lpm_numwords MUST equal to the ceiling of log2(lpm_widthu).");

		if (lpm_numwords <= (1 << (lpm_widthu-1)))
		begin
			$display("Error! lpm_widthu is too big for the specified lpm_numwords.");
		end

		for (i=0; i < lpm_width; i=i+1)
			ZEROS[i] = 1'b0;

		for (i = 0; i < lpm_numwords; i=i+1)
			mem_data[i] = ZEROS;

		full_flag = 0;
		empty_flag = 1;
		read_id = 0;
		write_id = 0;
		count_id = 0;
		tmp_q = ZEROS;
	end

	always @(posedge clock or i_aclr)
	begin
		if (i_aclr)
		begin
			tmp_q = ZEROS;
			full_flag = 0;
			empty_flag = 1;
			read_id = 0;
			write_id = 0;
			count_id = 0;
			if (lpm_showahead == "ON")
				tmp_q = mem_data[0];
		end
		else if (clock)
		begin
			if (i_sclr)
			begin
				tmp_q = mem_data[read_id];
				full_flag = 0;
				empty_flag = 1;
				read_id = 0;
				write_id = 0;
				count_id = 0;
				if (lpm_showahead == "ON")
					tmp_q = mem_data[0];
			end
			else
			begin
				// both WRITE and READ
				if ((wrreq && !full_flag) && (rdreq && !empty_flag))
				begin
					mem_data[write_id] = data;
					if (write_id >= lpm_numwords-1)
						write_id = 0;
					else
						write_id = write_id + 1;

					tmp_q = mem_data[read_id];
					if (read_id >= lpm_numwords-1)
						read_id = 0;
					else
						read_id = read_id + 1;
					if (lpm_showahead == "ON")
						tmp_q = mem_data[read_id];
				end

				// WRITE
				else if (wrreq && !full_flag)
				begin
					mem_data[write_id] = data;
					if (lpm_showahead == "ON")
						tmp_q = mem_data[read_id];
					count_id = count_id + 1;
					empty_flag = 0;
					if (count_id >= lpm_numwords)
					begin
						full_flag = 1;
						count_id = lpm_numwords;
					end
					if (write_id >= lpm_numwords-1)
						write_id = 0;
					else
						write_id = write_id + 1;
				end
							
				// READ
				else if (rdreq && !empty_flag)
				begin
					tmp_q = mem_data[read_id];
					count_id = count_id - 1;
					full_flag = 0;
					if (count_id <= 0)
					begin
						empty_flag = 1;
						count_id = 0;
					end
					if (read_id >= lpm_numwords-1)
						read_id = 0;
					else
						read_id = read_id + 1;
					if (lpm_showahead == "ON")
						tmp_q = mem_data[read_id];
				end
			end
		end
	end

	assign q = tmp_q;
	assign full = full_flag;
	assign empty = empty_flag;
	assign usedw = count_id;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_fifo") || (lpm_type !== "lpm_fifo"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_fifo

//------------------------------------------------------------------------

module lpm_fifo_dc ( data, rdclock, wrclock, aclr, rdreq, wrreq, rdfull, wrfull, rdempty, wrempty, rdusedw, wrusedw, q );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_widthu = 1;
	parameter lpm_numwords = 2;
	parameter lpm_showahead = "OFF";
	parameter lpm_type = "lpm_fifo_dc";
	parameter lpm_hint = "UNUSED";

	input [lpm_width-1:0] data;
	input rdclock;
	input wrclock;
	input wrreq;
	input rdreq;
	input aclr;
	output rdfull;
	output wrfull;
	output rdempty;
	output wrempty;
	output [lpm_width-1:0] q;
	output [lpm_widthu-1:0] rdusedw;
	output [lpm_widthu-1:0] wrusedw;
	  

	// internal reg
	reg [lpm_width-1:0] mem_data [lpm_numwords-1:0];
	reg pipe_wrptr [0:5];       // [0:RDPTR_DP];
	reg pipe_rdptr [0:5];       // [0:WRPTR_DP];
	reg pipe_rdusedw [0:1];     // [0:RDUSEDW_DP];
	reg pipe_wrusedw [0:1];     // [0:WRUSEDW_DP];

	reg [lpm_width-1:0] i_q;
	reg i_rdempty;
	reg i_wrempty;
	reg i_rdfull;
	reg i_wrfull;
	reg x_rdempty;
	reg x_wrfull;
	integer i_rdptr;
	integer i_wrptr;
	integer i_rdusedw;
	integer i_wrusedw;
	integer x_rdptr;
	integer x_wrptr;

	reg [lpm_width-1:0] ZEROS;
	integer RDPTR_DP;
	integer WRPTR_DP;
	integer RDUSEDW_DP;
	integer WRUSEDW_DP;
	integer FULL_RISEEARLY;
	integer i;

	tri0 aclr;
	buf (i_aclr, aclr);


	initial
	begin
  
		if (lpm_width <= 0)
			$display("Error! lpm_width must be greater than 0.");

		if (lpm_numwords <= 1)
			$display("Error! lpm_numwords must be greater than or equal to 2.");

		// check for number of words out of bound
		if ((lpm_widthu !=1) && (lpm_numwords > (1 << lpm_widthu)))
			$display("Error! lpm_numwords MUST equal to the ceiling of log2(lpm_widthu).");

		if (lpm_numwords <= (1 << (lpm_widthu-1)))
			$display("Error! lpm_widthu is too big for the specified lpm_numwords.");
			
		for (i=0; i<lpm_width; i=i+1)
			ZEROS[i] = 1'b0;

		// MEMORY INITIALIZATION
		for (i=0; i<lpm_numwords; i=i+1)
			mem_data[i] = ZEROS;

		// INITERNAL VARIABLES INIT
		i_q = ZEROS;
		i_rdptr = 0;
		i_wrptr = 0;
		i_rdempty = 1;
		i_wrempty = 1;
		i_rdfull = 0;
		i_wrfull = 0;
		i_rdusedw = 0;
		i_wrusedw = 0;

		// CONSTANTS
		RDPTR_DP = 5;
		WRPTR_DP = 5;
		RDUSEDW_DP = 1;
		WRUSEDW_DP = 1;
		FULL_RISEEARLY = 2;

		// CLEAR PIPELINES
		for (i=0; i<RDPTR_DP; i=i+1)
			pipe_wrptr[i] = 0;
		for (i=0; i<WRPTR_DP; i=i+1)
			pipe_rdptr[i] = 0;
		for (i=0; i<RDUSEDW_DP; i=i+1)
			pipe_rdusedw[i] = 0;
		for (i=0; i<WRUSEDW_DP; i=i+1)
			pipe_wrusedw[i] = 0;

	end

	always @(i_aclr)
	begin
		if (i_aclr)
		begin
			i_q = ZEROS;
			i_rdptr = 0;
			i_wrptr = 0;
			i_rdempty = 1;
			i_wrempty = 1;
			i_rdfull = 0;
			i_wrfull = 0;
			if (lpm_showahead == "ON")
				i_q = mem_data[0];
			
			// CLEAR PIPELINES
			for (i=0; i<RDPTR_DP; i=i+1)
				pipe_wrptr[i] = 0;
			for (i=0; i<WRPTR_DP; i=i+1)
				pipe_rdptr[i] = 0;
			for (i=0; i<RDUSEDW_DP; i=i+1)
				pipe_rdusedw[i] = 0;
			for (i=0; i<WRUSEDW_DP; i=i+1)
				pipe_wrusedw[i] = 0;
		end
	end

	always @(posedge wrclock)
	begin
		if (!i_aclr)
		begin
			// SET FLAGS
			x_wrfull = i_wrfull;
			if (i_wrusedw >= lpm_numwords-1-FULL_RISEEARLY)
				i_wrfull = 1;
			else
				i_wrfull = 0;
			
			if ((i_wrusedw <= 0) && (i_rdptr == i_wrptr))
				i_wrempty = 1;

			x_wrptr = i_wrptr;
			if (wrreq && !x_wrfull)  // && ! wrreq'event
			begin
				// WRITE DATA
				mem_data[i_wrptr] = data;

				// SET FLAGS
				i_wrempty = 0;

				// INC WRPTR
				if (i_wrptr >= lpm_numwords-1)
					i_wrptr = 0;
				else
					i_wrptr = i_wrptr + 1;
			end

			// DELAY RDPTR FOR WRUSEDW
			pipe_rdptr[WRPTR_DP] = i_rdptr;
			for (i=0; i<WRPTR_DP; i=i+1)
				pipe_rdptr[i] = pipe_rdptr[i+1];
			if (x_wrptr >= pipe_rdptr[0])
				pipe_wrusedw[WRUSEDW_DP] = x_wrptr - pipe_rdptr[0];
			else
				pipe_wrusedw[WRUSEDW_DP] = lpm_numwords + x_wrptr - pipe_rdptr[0];

			// DELAY WRUSEDW
			for (i=0; i<WRUSEDW_DP; i=i+1)
				pipe_wrusedw[i] = pipe_wrusedw[i+1];
			i_wrusedw = pipe_wrusedw[0];
		end
	end

	always @(posedge rdclock)
	begin    
		if (!i_aclr)
		begin
			// SET FLAGS
			x_rdempty = i_rdempty;
			if (i_rdusedw >= lpm_numwords-1-FULL_RISEEARLY)
				i_rdfull = 1;
			else
				i_rdfull = 0;

			if (i_rdptr == i_wrptr)
				i_rdempty = 1;
			else if (i_rdempty && (i_rdusedw > 0))
				i_rdempty = 0;

			// Q SHOWAHEAD
			if (lpm_showahead == "ON" && i_rdptr != i_wrptr)
				i_q = mem_data[i_rdptr];

			x_rdptr = i_rdptr;
			if (rdreq && !x_rdempty)  // && ! rdreq'event
			begin
				// READ DATA
				i_q = mem_data[i_rdptr];
				if (lpm_showahead == "ON")
				begin
					if (i_rdptr == i_wrptr)
						i_q = ZEROS;
					else
					begin
						if (i_rdptr >= lpm_numwords-1)
							i_q = mem_data[0];
						else
							i_q = mem_data[i_rdptr+1];
					end
				end

				// SET FLAGS
				if ((i_rdptr == lpm_numwords-1 && i_wrptr == 0) ||
					(i_rdptr+1 == i_wrptr))
					i_rdempty = 1;

				// INC RDPTR
				if (i_rdptr >= lpm_numwords-1)
					i_rdptr = 0;
				else
					i_rdptr = i_rdptr + 1;
			
			end
			// DELAY WRPTR FOR RDUSEDW
			pipe_wrptr[RDPTR_DP] = i_wrptr;
			for (i=0; i<RDPTR_DP; i=i+1)
				pipe_wrptr[i] = pipe_wrptr[i+1];
			if (pipe_wrptr[0] >= x_rdptr)
				pipe_rdusedw[RDUSEDW_DP] = pipe_wrptr[0] - x_rdptr;
			else
				pipe_rdusedw[RDUSEDW_DP] = lpm_numwords + pipe_wrptr[0] - x_rdptr;

			// DELAY RDUSEDW
			for (i=0; i<RDUSEDW_DP; i=i+1)
				pipe_rdusedw[i] = pipe_rdusedw[i+1];
			i_rdusedw = pipe_rdusedw[0];
		end
	end
			 
	assign q = i_q;
	assign wrfull = i_wrfull;
	assign wrempty = i_wrempty;
	assign rdfull = i_rdfull;
	assign rdempty = i_rdempty;
	assign wrusedw = i_wrusedw;
	assign rdusedw = i_rdusedw;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_fifo_dc") || (lpm_type !== "lpm_fifo_dc"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_fifo_dc

//------------------------------------------------------------------------

module lpm_inpad ( result, pad );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_type = "lpm_inpad";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] pad;
	output [lpm_width-1:0] result;

	reg    [lpm_width-1:0] result;

	always @(pad)
	begin
		result = pad;
	end

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_inpad") || (lpm_type !== "lpm_inpad"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_inpad

//------------------------------------------------------------------------

module lpm_outpad ( data, pad );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_type = "lpm_outpad";
	parameter lpm_hint = "UNUSED";

	input [lpm_width-1:0] data;
	output  [lpm_width-1:0] pad;

	reg   [lpm_width-1:0] pad;

	always @(data)
	begin
		pad = data;
	end

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_outpad") || (lpm_type !== "lpm_outpad"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_outpad

//------------------------------------------------------------------------

module lpm_bipad ( result, pad, data, enable );

// NOTE: Parameters must be declared in the same order as the Properties
//       are specified in the Cell Specification document.
	parameter lpm_width = 1;
	parameter lpm_type = "lpm_bipad";
	parameter lpm_hint = "UNUSED";

	input  [lpm_width-1:0] data;
	input  enable;
	inout  [lpm_width-1:0] pad;
	output [lpm_width-1:0] result;

	reg    [lpm_width-1:0] tmp_pad;
	reg    [lpm_width-1:0] result;

	always @(data or pad or enable)
	begin
		if (enable == 1)
		begin
			tmp_pad = data;
			result = 'bz;
		end
		else if (enable == 0)
		begin
			result = pad;
			tmp_pad = 'bz;
		end
	end

	assign pad = tmp_pad;

// Check for previous Parameter declaration order
initial if ((lpm_width === "lpm_bipad") || (lpm_type !== "lpm_bipad"))
  begin
    $display ("LPM 220 Version 1.6 Parameter Order changed; update instantiation");
    $finish;
  end
endmodule // lpm_bipad