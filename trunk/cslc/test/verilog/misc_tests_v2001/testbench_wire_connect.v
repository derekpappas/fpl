module tb_wire_connect;
wire [4:0] p;
reg r;
send s0(p);
m mm(r);
initial begin
    p = 5'b00001;
    #10;
    p = 5'b00010;
    #10;
    p = 5'b00011;
    #10;
    p = 5'b00100;
    #10;
    p = 5'b00101;
    #10;
    p = 5'b00110;
    #10;
    p = 5'b00111;
    #10;
    p = 5'b01000;
    #10;
    p = 5'b01001;
    #10;
    p = 5'b01010;
    #10;
    p = 5'b10101;
    #10;
    p = 5'b01110;
end
always@(p)
#1 $display("At t=%t p=%b r=%b", $time, p, r);
endmodule