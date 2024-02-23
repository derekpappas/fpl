//32-bit adder/substracter
module add_sub(result, op, A, B);
    input [31:0] A, B;
    input op;
    output [31:0] result;
    
    assign result=op?(A+B):(A-B);
            
endmodule

//testbench
module tb_add_sub();
    reg [31:0] A, B;
    reg op;
    wire [31:0] result;
    
    add_sub ADD_SUB(.result(result), .op(op), .A(A), .B(B));
    
    initial begin
        A=32'h0000;
        B=32'h00F0;
        op=1;
        #20;
        op=0;
        #20;
        A=32'h000A;
        B=32'h0002;
        op=1;
        #20;
        A=32'hFFFF;
        B=32'h0FF0;
        op=0;
    end
endmodule