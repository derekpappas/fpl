module operator();
    reg [3: 0]iesire;
    reg [3:0] temp;
    
    initial begin
       iesire = 4'b111;
       temp = &10; 
       $display("temp(d) = %d temp(b)= %b", temp, temp); 
    end
    
endmodule

module test_op();
    operator operator();
endmodule