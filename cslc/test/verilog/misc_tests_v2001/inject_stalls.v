//inject stalls
module tb;
    reg valid, stall, data_in;
    wire data_out;
    
    assign valid=!stall
    unit_a DUT(valid, stall, data_in, data_out);
endmodule