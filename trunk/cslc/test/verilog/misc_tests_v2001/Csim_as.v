module arch_state_gen (as_out);
    parameter WIDTH=4;
    
    output [WIDTH-1:0]as_out;
    reg [WIDTH-1:0]as_out;
    
    initial begin
       $Csim_as_gen;
    end 
endmodule