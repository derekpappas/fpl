module cnt(out,in_out,trist_out);
    parameter init = 3'b0;
    reg clk;
    reg ck;
    output [2:0] out;
    reg [2:0] out;
    inout in_out;
    output trist_out;
    //trireg trist_out;
    initial begin
        ;
        clk = 0;
        out = init;
        assign ck=1;
    end
    always #1 clk = ~clk;
    always @(posedge clk) begin
        out = out +1;
        assign ck = 0;
    end
endmodule