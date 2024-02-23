// Author: Fabio Somenzi <Fabio@Colorado.EDU>

module lunc (clock,reset,dataIn,dataOut);
    input	 clock;
    inout 	 reset;
    input [7:0]	 dataIn;
    output [7:0] dataOut;
    reg [7:0]	 dataOut;
    
    reg [7:0]	 regIn;
    wire [7:0]	 transformed;
    wire 	 Lcmd, Ucmd, Ncmd, Ccmd;

    initial begin
	regIn   = 0;
	dataOut = 0;
    end
    
    control	c(clock,reset,regIn,Lcmd,Ucmd,Ncmd,Ccmd);
    
    transform	t(regIn,Lcmd,Ucmd,Ncmd,Ccmd,transformed);
    
    always @ (posedge clock) begin
	if (reset) begin
	    dataOut = 0;
	    regIn = 0;
	end else begin
	    dataOut = transformed;
	    regIn = dataIn;
	end // else: !if(reset)
    end

endmodule // lunc


module control (clock,reset,in,Lcmd,Ucmd,Ncmd,Ccmd);
    input	clock;
    input 	reset;
    input [7:0]	in;
    output	Lcmd;
    output	Ucmd;
    output	Ncmd;
    output	Ccmd;

    reg		Lcmd;
    reg		Ucmd;
    reg		Ncmd;
    reg		Ccmd;

    wire	load;
    reg [7:0]	prev;

    initial begin
	Lcmd = 0;
	Ucmd = 0;
	Ncmd = 1;
	Ccmd = 0;
	prev = 0;
    end // initial begin

    always @ (posedge clock)
      if (reset)
	prev = 0;
      else
	prev = in;
    
    assign load = (prev == "\033");

    always @ (posedge clock)
      if (reset) begin
	  Ncmd = 1;
	  Lcmd = 0; Ucmd = 0; Ccmd = 0;
      end
      else if (load) begin
	  case (in)
	    "L": begin
		Lcmd = 1;
		Ucmd = 0; Ncmd = 0; Ccmd = 0;
	    end // case: "L"
	    "U": begin
		Ucmd = 1;
		Lcmd = 0; Ncmd = 0; Ccmd = 0;
	    end // case: "U"
	    "N": begin
		Ncmd = 1;
		Lcmd = 0; Ucmd = 0; Ccmd = 0;
	    end // case: "N"
	    "C": begin
		Ccmd = 1;
		Lcmd = 0; Ucmd = 0; Ccmd = 0;
	    end // case: "C"
	  endcase // _case (in)
      end // if (load)

endmodule // control


module transform (in,Lcmd,Ucmd,Ncmd,Ccmd,out);
    input [7:0]	 in;
    input	 Lcmd;
    input	 Ucmd;
    input	 Ncmd;
    input	 Ccmd;
    output [7:0] out;

    assign out = Lcmd ? toLower(in) :
	Ucmd ? toUpper(in) :
	Ncmd ? in :
	Ccmd ? changeCase(in) : 8'hxx;

    function [7:0] toLower;
	input [7:0]   in;

    begin: convToLower
	if (isUpper(in))
	    toLower = in + 8'h20;
	else
	    toLower = in;
    end // block: convToLower
    endfunction // toLower

    function [7:0] toUpper;
	input [7:0]   in;

    begin: convToUpper
	if (!isUpper(in))
	    toUpper = in - 8'h20;
	else
	    toUpper = in;
    end // block: convToUpper
    endfunction // toUpper

    function [7:0] changeCase;
	input [7:0]   in;

    begin: convChangeCase
	if (isUpper(in))
	    changeCase = in + 8'h20;
	else
	    changeCase = in - 8'h20;
    end // block: convChangeCase
    endfunction // changeCase

    function isUpper;
	input [7:0]   in;

    begin: testIsUpper
	isUpper = ~in[5];
    end // block: testIsUpper
    endfunction // isUpper

endmodule // transform
