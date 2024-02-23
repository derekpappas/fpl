//mux4_1
module mux4_1(mux_out, a0,a1, a2, a3, sel);
    input a0, a1, a2, a3;
    input [1:0] sel;
    output mux_out;
    
    reg mux_out;
    
    //assign mux_out=(a0 & !sel[1] & !sel[0]) | (a1 & !sel[1] & sel[0]) | (a2 & sel[1] & !sel[0]) | (a3 & sel[1] & sel[0]);
    always@(a0 or a1 or a2 or a3 or sel)
    begin
    case (sel)
        2'b 00: mux_out=a0;
        2'b 01: mux_out=a1;
        2'b 10: mux_out=a2;
        2'b 11: mux_out=a3;
        default mux_out=a0;
    endcase
end
endmodule

//test
module test_mux4_1;
    wire mux_out;
    reg a0, a1, a2, a3;
    reg [1:0] sel;
    
    mux4_1 M(mux_out, a0, a1, a2, a3, sel);
    initial begin
        a0=1'b0;
        a1=1'b 1;
        a2=1'b 1;
        a3=1'b 0;
        sel=2'b 00;
        #10;
        sel=2'b 10;
        #10 
        sel=2'b 01;
        #10
        sel=2'b 11;
    end
    always@(a0 or a1 or a2 or a3 or sel)
    $display("at t=%t a0=%b a1=%b a2=%b a3=%b sel=%b mux_out=%b", $time, a0, a1, a2, a3, sel, mux_out);
endmodule