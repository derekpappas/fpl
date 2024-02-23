module test_mux;
    wire m_out;
    reg a, b, sel;
    mux_c mux_test(m_out, a, b, sel);
    initial begin
        $timeformat(-9,1,"ns",6);
        a=1'b0;
        b=1'b1;
        sel=1'b0;
        #10;
        sel=1'b1;
    end
always @ (a or b or sel)
$display("at t=%t sel=%b a=%b b=%b m_out=%b", $time, sel, a, b, m_out);
endmodule    