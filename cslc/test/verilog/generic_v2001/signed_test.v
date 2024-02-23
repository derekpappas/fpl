//modiffications by GabrielD at BigSurSoftware.com
module signed_test (i,a);
	input signed [7:0] i;

reg signed [63:0] data;
wire signed [7:0] vector;
input signed [31:0] a;

function signed [128:0] alu;
input w;

alu = 128'b0 + w;

endfunction

endmodule

module automatic_tf;

function automatic [63:0] factorial;
input [31:0] n; 
if (n == 1)
	factorial = 1; 
else
	factorial = n * factorial(n-1); 
endfunction


task automatic auto_task;
	input call;
	if (call) 
		auto_task(0); // automatic tasks are re-enterant
endtask


endmodule

