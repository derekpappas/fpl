// This module crashes vl2mv because of the non mutually-exclusive assignments
// in function f.
module bug(a,b,o);
    input a, b;
    output o;

    function f;
	input a, b;
	begin: _f
	    if (a) f = 0;
	    if (b) f = 1;
	end
    endfunction // f

    assign o = f(a,b);

endmodule // bug
