module M(a);
    input a;
    wire [1:0] b;
    assign b=a+1;
    
endmodule

module MM();
    reg a;
    
    M m(a);
    
    initial begin
       a=0;
       #5;
       a=1;
       #5;
       a=0;
    end
    always@(a) begin
        $display("m.b = %b", m.b);
    end
    
endmodule