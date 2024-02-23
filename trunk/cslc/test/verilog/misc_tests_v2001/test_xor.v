module XOR;
    reg a,b;
    initial begin
        a=0;
        b=0;
        #5;
        a=0;
        b=1;
        #5;
        a=1;
        b=0;
        #5;
        a=1;
        b=1;
    end
    always@(a,b) begin
       $display("a xor b =", !(a ^ b));
    end
endmodule