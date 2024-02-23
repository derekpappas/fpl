module signed_;
    reg signed [7: 0] S;
    initial begin
        S=8'sh FF;
    $display("S=%d", S);
    end
    
endmodule