module test_param();
    parameter p1=10;
    parameter p2=p1;
    
    initial begin
        $display("p2=%d", p2);
    end
endmodule