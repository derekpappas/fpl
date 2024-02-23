//
//  Title: 	Test of do_fp_op
//  Created:	Sun Mar  7 23:46:19 1993
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  test.v,v Version $Revison$ Last Edit 1995/01/24 11:41:38
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: Used to test dp_fp_op PLI code.
//

module test ();

reg 	    clock;
reg [63:0]  fs, ft, fd;
reg [31:0]  csr, csr_res;

wire [31:0] csr_w;

integer	    Csr, Op, Csr_res;
real	    Fs, Ft, Fd;

assign csr_w = csr;

initial begin
    clock = 0;
    fs	= 64'h4024000000000000;
    ft 	= 64'h4024000000000000;
    csr = 0;
end

always begin
    #100
    clock = ~clock;
end

always @(posedge clock) begin
    Csr = csr;
    Op = 1;
    Fs = fs;
    Ft = ft;
    Fd = fd;
    $do_fp_op(csr_w, 1, fs, ft, fd, csr_res);
    $display("Debug --> fs = 0x%h", fs);
    $display("Debug --> ft = 0x%h", ft);
    $display("Debug --> fd = 0x%h", fd);

    
end
endmodule
