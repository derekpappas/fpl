module arith_shift(sh_in, sh_out);
    input [3:0] sh_in;
    output [3:0] sh_out;
    
    reg [3:0] sh_out;
    always@(sh_in)
      sh_out=sh_in>>>1;
endmodule

//tb
module shift_tb;
    wire [3:0] sh_out;
    reg [3:0] sh_in;
    
    arith_shift ASH(sh_in, sh_out);
    initial begin
        sh_in=4'b 1011;
        #5 sh_in=4'sb 1111;
        #5 sh_in=4'sb 1010;
        #5 sh_in=4'sb 1100;
    end
endmodule